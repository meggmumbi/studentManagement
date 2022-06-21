using Microsoft.SharePoint.Client;
using StudentManagementASPX.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Withdrawal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {



                var nav = Config.ReturnNav();
                string IdNumber = Convert.ToString(Session["idNumber"]);

                var studentNumb = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber);


                var studentNumber = Convert.ToString(Session["studentNo"]);
                var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNumber);
                regNo.DataSource = registrationNo;
                regNo.DataTextField = "Course_ID";
                regNo.DataValueField = "Registration_No";
                regNo.DataBind();
                regNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var coursesId = Request.QueryString["courseId"];
                var templates = nav.DocumentsTemplate.Where(r => r.Blocked == false && r.Course_ID == coursesId).ToList();
                if (templates.Count > 0)
                {

                    foreach (var templ in templates)
                    {
                        template.Text = templ.Code;
                    }

                }

                var exmcycle = nav.ExamCycle;
                examCycle.DataSource = exmcycle;
                examCycle.DataTextField = "examCycle";
                examCycle.DataValueField = "examCycle";
                examCycle.DataBind();
                examCycle.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                var DeffermentReasons = nav.withdrawalreasons.Where(r => r.Reason_Category == "Withdrawal");
                withdrawal.DataSource = DeffermentReasons;
                withdrawal.DataTextField = "Description";
                withdrawal.DataValueField = "Code";
                withdrawal.DataBind();
                withdrawal.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                String applicationNo = Request.QueryString["applicationNo"];
                string studentNo = Convert.ToString(Session["studentNo"]);
                var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Student_No == studentNo).ToList();
                if (studentProcessing.Count > 0)
                {
                    foreach (var descript in studentProcessing)
                    {
                        regNo.SelectedValue = descript.Student_Reg_No;
                        withdrawal.SelectedValue = descript.Withdrawal_Code;
                        examCycle.SelectedValue = descript.Examination_Sitting;
                       
                    }
                }
            }
        }
        protected void next_Click(object sender, EventArgs e)
        {
            try
            {

                String StudentNo = studentNo.Text.Trim();
                string courseid = Request.QueryString["courseid"];
                //DateTime applicationDate = Convert.ToDateTime(Date.Text);
                String regNUmber = regNo.SelectedValue.Trim();
                string examid = courseId.Text.Trim();
                String withdrawalReason = withdrawal.SelectedValue.Trim();
                string examCycles = examCycle.SelectedValue.Trim();
               
                Boolean error = false;
                String message = "";


                /*
                Session["employeeNo"] = user.employeeNo;
                */
                String applicationNo = "";
                Boolean newApplicationNo = false;
                try
                {

                    applicationNo = Request.QueryString["applicationNo"];
                    if (String.IsNullOrEmpty(applicationNo))
                    {
                        applicationNo = "";
                        newApplicationNo = true;
                    }
                }
                catch (Exception)
                {

                    applicationNo = "";
                    newApplicationNo = true;
                }
                String status = new Config().ObjNav().CreateWithdrawal(applicationNo, StudentNo, regNUmber, withdrawalReason, examCycles);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newApplicationNo)
                    {
                        applicationNo = info[2];

                    }
                    // Response.Redirect("Withdrawal.aspx?step=2&&applicationNo=" + applicationNo);
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("Withdrawal.aspx?step=2&&courseId=" + info[3] + "&&applicationNo=" + applicationNo+"&&cycle="+ examCycles);

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }

            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        
     

        protected void previous_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Withdrawal.aspx?step=1&&applicationNo="+ applicationNo);
        }
        

        public static string UploadWithdrawal(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            //leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "KASNEB/Withdrawal";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "Student Portal";
                if (!FolderExists(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName))
                    CreateFolder(Config.SPClientContext.Web, listTitle, parent_folderName + "/" + subFolderName);

                if (Config.SPWeb != null)
                {
                    var sFileUrl = string.Format("{0}/{1}/{2}", sSpSiteRelativeUrl, filelocation, sFileName);
                    Microsoft.SharePoint.Client.File.SaveBinaryDirect(Config.SPClientContext, sFileUrl, fs, true);
                    Config.SPClientContext.ExecuteQuery();
                    sDocName = sFileName;
                }
            }

            catch (Exception)
            {
                sDocName = string.Empty;
            }
            return sDocName;
        }

        public static bool FolderExists(Web web, string listTitle, string folderUrl)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folders = list.GetItems(CamlQuery.CreateAllFoldersQuery());
            web.Context.Load(list.RootFolder);
            web.Context.Load(folders);
            web.Context.ExecuteQuery();
            var folderRelativeUrl = string.Format("{0}/{1}", list.RootFolder.ServerRelativeUrl, folderUrl);
            return Enumerable.Any(folders, folderItem => (string)folderItem["FileRef"] == folderRelativeUrl);
        }

        private static void CreateFolder(Web web, string listTitle, string folderName)
        {
            var list = web.Lists.GetByTitle(listTitle);
            var folderCreateInfo = new ListItemCreationInformation
            {
                UnderlyingObjectType = FileSystemObjectType.Folder,
                LeafName = folderName
            };
            var folderItem = list.AddItem(folderCreateInfo);
            folderItem.Update();
            web.Context.ExecuteQuery();
        }

        protected void deleteFile_Click(object sender, EventArgs e)
        {

            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"Student%20Portal/KASNEB/Withdrawal/";
                    var leaveNo = Request.QueryString["applicationNo"];

                    foreach (char c in password)
                    { secret.AppendChar(c); }
                    try
                    {
                        ctx.Credentials = new NetworkCredential(account, secret, domainname);
                        ctx.Load(ctx.Web);
                        ctx.ExecuteQuery();

                        Uri uri = new Uri(sharepointUrl);
                        string sSpSiteRelativeUrl = uri.AbsolutePath;

                        string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + fileName.Text;

                        var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
                        ctx.Load(file, f => f.Exists);
                        file.DeleteObject();
                        ctx.ExecuteQuery();

                        if (!file.Exists)
                            throw new FileNotFoundException();
                        completefeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        completefeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                completefeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }



        }

        protected void step3_Click(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            DateTime today = DateTime.Today;
            var cycle = Request.QueryString["cycle"];
            var exmcycle = nav.ExamCycle.Where(r=>r.Exam_End_Date>=today && r.examCycle==cycle).ToList();
            if (exmcycle.Count > 0)
            {
                submitApp.Visible = true;
                step3.Visible = false;


            }
            else
            {
                string courseid = Request.QueryString["courseid"];
                String applicationNo = Request.QueryString["applicationNo"];
                Response.Redirect("Withdrawal.aspx?step=3&&applicationNo=" + applicationNo+ "&&courseid="+courseid);
            }
            
        }

        protected void attachdoc_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("withdrawalSummery.aspx?applicationNo=" + applicationNo);
        }

        protected void prevstep1_Click(object sender, EventArgs e)
        {
            string courseid = Request.QueryString["courseid"];
            var cycle = Request.QueryString["cycle"];
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Withdrawal.aspx?step=2&&applicationNo=" + applicationNo + "&&cycle=" + cycle+ "&&courseid=" + courseid);
        }
        public void UploadDocuments_Click(object sender, EventArgs e)
        {

            try
            {
                string ApplicationNo = Request.QueryString["applicationNo"].Trim();
                bool fileuploadSuccess = false;
                string sUrl = ConfigurationManager.AppSettings["S_URL"];
                // string serverName = ConfigurationManager.AppSettings["S_URL"];
                string defaultlibraryname = "Student%20Portal/";
                string customlibraryname = "KASNEB/Withdrawal";
                string sharepointLibrary = defaultlibraryname + customlibraryname;
                String leaveNo = ApplicationNo;
                Boolean error = false;
                String message = "";
                string username = ConfigurationManager.AppSettings["S_USERNAME"];
                string password = ConfigurationManager.AppSettings["S_PWD"];
                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];

                if (uploadfile.HasFile == false)
                {
                    error = true;
                    message = "Please select file to upload";
                }
                if (error == true)
                {
                    attach.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {

                    bool bbConnected = Config.Connect(sUrl, username, password, domainname);
                    try
                    {
                        if (bbConnected)
                        {

                            string extension = Path.GetExtension(uploadfile.FileName);
                            string fileName0 = uploadfile.FileName;
                            string ext0 = Path.GetExtension(uploadfile.FileName);
                            if (extension == ".png" || extension == ".PNG")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }
                            if (extension == ".jpeg" || extension == ".JPEG")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }
                            if (extension == ".jplg" || extension == ".JPLG")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }

                            if (error)
                            {
                                attach.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            else
                            {

                                string savedF0 = leaveNo + "_" + fileName0;


                                Uri uri = new Uri(sUrl);
                                string sSpSiteRelativeUrl = uri.AbsolutePath;
                                string uploadfilename = leaveNo + "_" + fileName0;
                                Stream uploadfileContent = uploadfile.FileContent;

                                var sDocName = UploadWithdrawal(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddDefermentSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                    string[] info = status.Split('*');
                                    if (info[0] == "success")
                                    {
                                        attach.InnerHtml = "<div class='alert alert-success'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }
                                    else
                                    {
                                        attach.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    }

                                }
                                else
                                {
                                    attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }


                            }
                        }
                        else
                        {
                            attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }
                    }

                    catch (Exception ex)
                    {
                        attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }
        protected void regNo_SelectedIndexChanged(object sender, EventArgs e)
        {
            string examRegNo = regNo.SelectedValue.Trim();
            var nav = Config.ReturnNav();

            var examinationId = nav.ExaminationAccounts.Where(r => r.Registration_No == examRegNo);
            foreach (var myexamID in examinationId)
            {
                courseId.Text = myexamID.Course_ID;
            }
        }
        protected void delete_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            var nav1 = Config.ReturnNav();
            string message = "";
            var studentProcessingLine = nav1.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo && r.Type == "Withdrawal").ToList();

            if (studentProcessingLine.Count > 3)
            {


                try
                {
                    string tentryNumber = removeFuelNumber.Text.Trim();

                    var nav = new Config().ObjNav();
                    String status = nav.RemoveExaminationPaper(applicationNo, tentryNumber);
                    String[] info = status.Split('*');
                    Div1.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                catch (Exception t)
                {
                    Div1.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            else
            {
                message = "You cannot have less than three papers";
                Div1.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        

        }
    }
}