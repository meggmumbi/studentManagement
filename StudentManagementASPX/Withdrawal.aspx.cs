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
                foreach (var students in studentNumb)
                {
                    studentNo.Text = students.Student_No;
                }
                
                //var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo.Text);
                //regNo.DataSource = registrationNo;
                //regNo.DataTextField = "Course_ID";
                //regNo.DataValueField = "Registration_No";
                //regNo.DataBind();
                //regNo.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var exmcycle = nav.ExamCycle;
                examCycle.DataSource = exmcycle;
                examCycle.DataTextField = "examCycle";
                examCycle.DataValueField = "examCycle";
                examCycle.DataBind();
                examCycle.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var ExamCenters = nav.ExamCenters;
                examCenter.DataSource = ExamCenters;
                examCenter.DataTextField = "Name";
                examCenter.DataValueField = "Code";
                examCenter.DataBind();
                examCenter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var DeffermentReasons = nav.withdrawalreasons.Where(r => r.Reason_Category == "Withdrawal");
                withdrawal.DataSource = DeffermentReasons;
                withdrawal.DataTextField = "Description";
                withdrawal.DataValueField = "Code";
                withdrawal.DataBind();
                withdrawal.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var currenctH = nav.currency;
                currency.DataSource = currenctH;
                currency.DataTextField = "Code";
                currency.DataValueField = "Code";
                currency.DataBind();

                string RegNos = Request.QueryString["RegNo"];
                regNos.Text = RegNos;



            }
        }

        //protected void regNo_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string examRegNo = regNos.SelectedValue.Trim();
        //    var nav = Config.ReturnNav();

        //    var examinationId = nav.ExaminationAccounts.Where(r => r.Registration_No == examRegNo);
        //    foreach (var myexamID in examinationId)
        //    {
        //        courseId.Text = myexamID.Course_ID;
        //    }
        //}

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                
                String StudentNo = studentNo.Text.Trim();
               // DateTime applicationDate = Convert.ToDateTime(Date.Text);
                String regNUmber = regNos.Text.Trim();
                string examid = courseId.Text.Trim();
                String withdrawalReason = withdrawal.SelectedValue.Trim();
                string examCycles = examCycle.SelectedValue.Trim();
                string examCenters = examCenter.SelectedValue.Trim();
                //DateTime myOrderDate = new DateTime();
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
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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
        
        protected void addItem_Click(object sender, EventArgs e)
        {
            try
            {
                // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
                int tbookingType = Convert.ToInt32(deffermentType.SelectedValue.Trim());
                String tpart = String.IsNullOrEmpty(part.SelectedValue.Trim()) ? "" : part.SelectedValue.Trim();
                String tsection = String.IsNullOrEmpty(section.SelectedValue.Trim()) ? "" : section.SelectedValue.Trim();
                String tpaper = String.IsNullOrEmpty(paper.SelectedValue.Trim()) ? "" : paper.SelectedValue.Trim();
                String course = courseId.Text.Trim();


                Boolean error = false;



                String applicationNo = Request.QueryString["applicationNo"];
                // Convert.ToString(Session["employeeNo"]),
                //Nav Funtion

                String status = new Config().ObjNav().CreateWithdrawalLine(tbookingType, tpart, tsection, tpaper, course, applicationNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {

                    // Response.Redirect("Withdrawal.aspx?step=2&&applicationNo=" + applicationNo);
                    Div7.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    Div7.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
               

            }
            catch (Exception n)
            {
                Div7.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("Withdrawal.aspx?step=1");
        }

        protected void deffermentType_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadType();
        }

        public void loadType()
        {
            try
            {
                var nav = Config.ReturnNav();
                string examId = Request.QueryString["courseid"];
                var itemtype = "";
                var typ = Convert.ToInt32(deffermentType.SelectedValue);

                switch (typ)
                {

                    case 0:
                        itemtype = "Paper";

                        var paper = nav.parts.Where(r => r.Course == examId).ToList();
                        part.DataSource = paper;
                        part.DataTextField = "Code";
                        part.DataValueField = "Code";
                        part.DataBind();
                        part.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                        return;

                    case 1:
                        itemtype = "Section";
                        var GL = nav.parts.Where(r => r.Course == examId).ToList();
                        part.DataSource = GL;
                        part.DataTextField = "Code";
                        part.DataValueField = "Code";
                        part.DataBind();
                        part.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                        return;

                  

                    case 2:
                        itemtype = "Part";
                        var parts = nav.parts.Where(r => r.Course == examId).ToList();
                        part.DataSource = parts;
                        part.DataTextField = "Code";
                        part.DataValueField = "Code";
                        part.DataBind();
                        part.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                        return;

                    default:
                        break;
                }


            }
            catch (Exception)
            {

            }
        }

        protected void section_SelectedIndexChanged(object sender, EventArgs e)
        {
            string parts = part.SelectedValue.Trim();
            string examId = Request.QueryString["courseid"];
            string sectionId = section.SelectedValue.Trim();
            var nav = Config.ReturnNav();

            var papers = nav.Papers.Where(r => r.Course == examId && r.Level == parts && r.Section == sectionId);
            paper.DataSource = papers;
            paper.DataTextField = "Code";
            paper.DataValueField = "Code";
            paper.DataBind();
            paper.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
        }

        protected void paper_SelectedIndexChanged(object sender, EventArgs e)
        {
            string parts = part.SelectedValue.Trim();
            string examId = Request.QueryString["courseid"];
            string sectionId = section.SelectedValue.Trim();

            var nav = Config.ReturnNav();

            var papers = nav.Papers.Where(r => r.Course == examId && r.Level == parts && r.Section == sectionId && r.Code == paper.SelectedValue);

            foreach (var paperz in papers)
            {
                description.Text = paperz.Description;
            }
        }

        protected void part_SelectedIndexChanged(object sender, EventArgs e)
        {
            string parts = part.SelectedValue.Trim();
            string examId = Request.QueryString["courseid"];
            var nav = Config.ReturnNav();

            var sections = nav.Papersz.Where(r => r.Course == examId && r.Levels == parts);
            paper.DataSource = sections;
            paper.DataTextField = "Description";
            paper.DataValueField = "Code";
            paper.DataBind();
            section.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
        }

        protected void next_Click1(object sender, EventArgs e)
        {
            try
            {

                String StudentNo = studentNo.Text.Trim();
              //  DateTime applicationDate = Convert.ToDateTime(Date.Text);
                String regNUmber = regNos.Text.Trim();
                string examid = courseId.Text.Trim();
                String withdrawalReason = withdrawal.SelectedValue.Trim();
                string examCycles = examCycle.SelectedValue.Trim();
                string examCenters = examCenter.SelectedValue.Trim();
                //DateTime myOrderDate = new DateTime();
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
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

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

        protected void savewithdrawal_Click(object sender, EventArgs e)
        {
            try
            {

                String StudentNo = studentNo.Text.Trim();
                //DateTime applicationDate = Convert.ToDateTime(Date.Text);
                String regNUmber = regNos.Text.Trim();
                string examid = courseId.Text.Trim();
                string courrseID = Request.QueryString["courseid"];
                String withdrawalReason = withdrawal.SelectedValue.Trim();
                string examCycles = examCycle.SelectedValue.Trim();
                string examCenters = examCenter.SelectedValue.Trim();
                //DateTime myOrderDate = new DateTime();
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
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("Withdrawal.aspx?step=3&&courseId=" + courrseID + "&&applicationNo=" + applicationNo);

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

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string InsertDocuments(List<DocumentsModel> finance)
        {
            string tapplicationNo = "";

            string tbrowsedDocument = "";


            string results_0 = (dynamic)null;


            try
            {

                //Check for NULL.
                if (finance == null)
                    finance = new List<DocumentsModel>();

                //Loop and insert records.
                foreach (DocumentsModel oneitem in finance)
                {
                    tbrowsedDocument = oneitem.browsedDoc;
                    tapplicationNo = oneitem.applicationNo;


                    if (string.IsNullOrWhiteSpace(tapplicationNo))
                    {
                        results_0 = "Application Number is Null";
                        return results_0;
                    }

                    bool fileuploadSuccess = false;
                    string sUrl = ConfigurationManager.AppSettings["S_URL"];
                    string defaultlibraryname = "Student%20Portal/";
                    string customlibraryname = "KASNEB/Withdrawal";
                    string sharepointLibrary = defaultlibraryname + customlibraryname;
                    // String leaveNo = Request.QueryString["applicationNo"];
                    String leaveNo = tapplicationNo;

                    Boolean error = false;
                    String message = "";
                    string username = ConfigurationManager.AppSettings["S_USERNAME"];
                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    bool bbConnected = Config.Connect(sUrl, username, password, domainname);
                    try
                    {
                        if (bbConnected)
                        {
                            FileInfo fi = new FileInfo(oneitem.browsedDoc);

                            //string fileName0 = Path.GetFileName(financedetail.browsedDoc.FileName);
                            //string ext0 = _getFileextension(financedetail.browsedDoc);
                            string fileName0 = fi.Name;
                            string ext0 = fi.Extension;
                            if (fi.Extension == ".png" || fi.Extension == ".PNG")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }
                            if (fi.Extension == ".jpeg" || fi.Extension == ".JPEG")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }
                            if (fi.Extension == ".jplg" || fi.Extension == ".JPLG")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }
                            if (error)
                            {
                                results_0 = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            else
                            {

                                string savedF0 = leaveNo + "_" + fileName0;


                                Uri uri = new Uri(sUrl);
                                string sSpSiteRelativeUrl = uri.AbsolutePath;
                                string uploadfilename = leaveNo + "_" + fileName0;
                                byte[] byteArray = Encoding.ASCII.GetBytes(oneitem.browsedDoc);
                                MemoryStream DocStream = new MemoryStream(byteArray);
                                Stream uploadfileContent = DocStream;

                                var sDocName = UploadWithdrawal(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddWithdrawalSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                    string[] info = status.Split('*');
                                    if (info[0] == "success")
                                    {
                                        results_0 = info[0];
                                    }
                                    else
                                    {
                                        results_0 = info[1];
                                    }

                                }
                                else
                                {
                                    results_0 = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                                }

                            }
                        }
                        else
                        {
                            results_0 = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }
                    }
                    catch (Exception ex)
                    {
                        results_0 =
                                        "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }





                }
            }
            catch (Exception ex)
            {
                results_0 = ex.Message;
            }
            //results_0 = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            return results_0;


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
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Withdrawal.aspx?step=3&&applicationNo=" + applicationNo);
        }

        protected void attachdoc_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("withdrawalSummery.aspx?applicationNo=" + applicationNo);
        }

        protected void prevstep1_Click(object sender, EventArgs e)
        {
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Withdrawal.aspx?step=1&&applicationNo=" + applicationNo);
        }
    }
}