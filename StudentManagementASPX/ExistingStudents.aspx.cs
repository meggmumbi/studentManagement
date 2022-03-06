using Microsoft.SharePoint.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class ExistingStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                var nav = Config.ReturnNav();

                //var ExamCycles = nav.ExamCycle;
                //examCylce.DataSource = ExamCycles;
                //examCylce.DataTextField = "examCycle";
                //examCylce.DataValueField = "examCycle";
                //examCylce.DataBind();
                //examCylce.Items.Insert(0, new ListItem("--select--", ""));

                var course_id = Request.QueryString["courseId"];
                examCode.Text = course_id;

                var cycle = Request.QueryString["cycle"];
                examCylces.Text = cycle;

                var projectCode = Request.QueryString["projectCode"];
                project.Text = projectCode;
                //var examid = nav.course;
                //exam.DataSource = examid;
                //exam.DataTextField = "Description";
                //exam.DataValueField = "Code";
                //exam.DataBind();
                //exam.Items.Insert(0, new ListItem("--select--", ""));


                var examcenters = nav.ExamCenters;
                examCenter.DataSource = examcenters;
                examCenter.DataTextField = "Name";
                examCenter.DataValueField = "Code";
                examCenter.DataBind();
                examCenter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                
                var trainingInst = nav.Instcustomers.Where(r=>r.Customer_Type=="Institution");
                currency.DataSource = trainingInst;
                currency.DataTextField = "Name";
                currency.DataValueField = "No";
                currency.DataBind();
                currency.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                string studentNo = Convert.ToString(Session["studentNo"]);
                studentNumber.Text = studentNo;




                var coursesId = Request.QueryString["courseId"];
                var templates = nav.DocumentsTemplate.Where(r => r.Blocked==false && r.Course_ID== coursesId);
                foreach (var templ in templates)
                {
                    template.Text = templ.Code;
                }

                string courseId = Request.QueryString["courseId"];
                var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Registration" && r.Examiantion_ID == courseId);
                DocType.DataSource = details;
                DocType.DataTextField = "Examination_Document";
                DocType.DataValueField = "Examination_Document_Type";
                DocType.DataBind();
                DocType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                String applicationNo = Request.QueryString["applicationNo"];
                var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Student_No== studentNo && r.Examination_ID== coursesId).ToList();
                if (studentProcessing.Count > 0)
                {
                    foreach (var descript in studentProcessing)
                    {
                        currency.SelectedValue = descript.Training_Institution_Code;
                        project.Text = descript.Examination_Project_Code;
                        examCylces.Text = descript.Examination_Sitting;
                        examCode.Text = descript.Examination_ID;
                    }
                }
                imgviews.DataBind();

            }
        }

        protected void btn_personalinformations_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean error = false;
                string message = "";

                string ttrainingInstitution = currency.SelectedValue.Trim();
                string tproject = project.Text.Trim();                
                string texamcycle = examCylces.Text.Trim();               
                string texam = examCode.Text.Trim();
               // string texamCenter = examCenter.SelectedValue.Trim();
                string tstudentNo = studentNumber.Text.Trim();

                //if (string.IsNullOrEmpty(ttrainingInstitution))
                //{
                //    error = true;
                //    message = "Please enter Training Institution ";

                //}

                if (string.IsNullOrEmpty(tproject))
                {
                    error = true;
                    message = "Select a course to enroll";

                }

          
               
                if (string.IsNullOrEmpty(texam))
                {
                    error = true;
                    message = "Select a course to enroll";
                }
             





                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    /*
                    Session["UniversityCode"]);
                    Session["employeeNo"] = user.employeeNo;
                    */
                    String applicationNo = "";
                    Boolean newapplicationNo = false;
                    try
                    {

                        applicationNo = Request.QueryString["applicationNo"];
                        if (String.IsNullOrEmpty(applicationNo))
                        {
                            applicationNo = "";
                            newapplicationNo = true;
                        }
                    }
                    catch (Exception)
                    {

                        applicationNo = "";
                        newapplicationNo = true;
                    }
                   
                    
                    string response = new Config().ObjNav().FnExistingStudent(applicationNo, texam, tstudentNo, ttrainingInstitution, tproject);

                    String[] info = response.Split('*');
                    if (info[0] == "success")
                    {
                        if (newapplicationNo)
                        {
                            applicationNo = info[2];

                        }
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        string courseid = Request.QueryString["courseId"];
                        Response.Redirect("ExistingStudents.aspx?step=2&&courseid=" + courseid + "&&applicationNo=" + applicationNo);
                    }
                    else
                    {
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("ExistingStudents.aspx?step=2&&applicationNo="+ courseId + "&&studentNo="+ studentNo);
        }

        protected void previous_Click(object sender, EventArgs e)
        {

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
                string customlibraryname = "KASNEB/ExistingStudentRegistration";
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
                            Path.GetExtension(uploadfile.FileName);
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

                                var sDocName = UploadExistingStudent(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddRegistrationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                    string[] info = status.Split('*');
                                    if (info[0] == "success")
                                    {
                                        attach.InnerHtml = "<div class='alert alert-success'>" + info[0] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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

        //protected void uploadDocument_Click(object sender, EventArgs e)
        //{

        //    bool fileuploadSuccess = false;
        //    string sUrl = ConfigurationManager.AppSettings["S_URL"];
        //    string defaultlibraryname = "Student%20Portal/";
        //    string customlibraryname = "KASNEB/ExistingStudentRegistration";
        //    string sharepointLibrary = defaultlibraryname + customlibraryname;
        //    String leaveNo = Request.QueryString["applicationNo"];

        //    string username = ConfigurationManager.AppSettings["S_USERNAME"];
        //    string password = ConfigurationManager.AppSettings["S_PWD"];
        //    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];

        //    bool bbConnected = Config.Connect(sUrl, username, password, domainname);

        //    try
        //    {
        //        if (bbConnected)
        //        {
        //            Path.GetExtension(uploadfile.FileName);
        //            string extension = Path.GetExtension(uploadfile.FileName);
        //            string fileName0 = uploadfile.FileName;
        //            string ext0 = Path.GetExtension(uploadfile.FileName);
        //            if (extension == ".png" || extension == ".PNG")
        //            {
        //                error = true;
        //                message = "Please attach a pdf document only";

        //            }
        //            if (extension == ".jpeg" || extension == ".JPEG")
        //            {
        //                error = true;
        //                message = "Please attach a pdf document only";

        //            }
        //            if (extension == ".jplg" || extension == ".JPLG")
        //            {
        //                error = true;
        //                message = "Please attach a pdf document only";

        //            }

        //            if (error)
        //            {
        //                attach.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //            else
        //            {

               
        //            Uri uri = new Uri(sUrl);
        //            string sSpSiteRelativeUrl = uri.AbsolutePath;
        //            string uploadfilename = leaveNo + "_" + document.FileName;
        //            Stream uploadfileContent = document.FileContent;

        //            var sDocName = UploadExistingStudent(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

        //            string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

        //            if (!string.IsNullOrEmpty(sDocName))
        //            {
        //                var status = new Config().ObjNav().AddRegistrationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
        //                string[] info = status.Split('*');
        //                if (info[0] == "success")
        //                {
        //                    attach.InnerHtml = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                }
        //                else
        //                {
        //                    attach.InnerHtml =
        //                        "<div class='alert alert-danger'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                }

        //            }
        //            else
        //            {
        //                attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //            }


        //        }
        //        else
        //        {
        //            attach.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        attach.InnerHtml =
        //                        "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //    }




        //}

        public string UploadExistingStudent(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "KASNEB/ExistingStudentRegistration";
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
                    var parentFolderName = @"Student%20Portal/KASNEB/ExistingStudentRegistration/";
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
                        attach.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                attach.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }



        }

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            Response.Redirect("ExistingStudents.aspx?step=1");
        }

        protected void Unnamed_Click2(object sender, EventArgs e)
        {

            Response.Redirect("ExistingStudents.aspx?step=3");
        }

        protected void Unnamed_Click3(object sender, EventArgs e)
        {
            string studentNo = Request.QueryString["studentNo"];
            string courseid = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExistingStudents.aspx?step=2&&studentNo=" + studentNo + "&&courseid=" + courseid + "&&applicationNo=" + applicationNo);
        }

        protected void submitRegistration_Click(object sender, EventArgs e)
        {

            if (declaration.Checked == true)
            {

                try
                {
                    String tapplicationNo = Request.QueryString["applicationNo"];

                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tapplicationNo))
                    {
                        error = true;
                        message = "An application with the given applcationNo does not exist";
                    }

                    String status = new Config().ObjNav().FnSubmitApplication(tapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        Payment.Visible = true;
                    }
                    else
                    {
                        submit.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    submit.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "success();", true);
            }

        }

        protected void next_Click(object sender, EventArgs e)
        {
            string studentNo = Request.QueryString["studentNo"];
            string courseid = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExistingStudents.aspx?step=3&&studentNo=" + studentNo + "&&courseid="+ courseid+ "&&applicationNo=" + applicationNo);
        }

        protected void previous_Click1(object sender, EventArgs e)
        {
            string studentNo = Request.QueryString["studentNo"];
            string courseid = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("ExistingStudents.aspx?step=1&&studentNo=" + studentNo + "&&courseid=" + courseid + "&&applicationNo=" + applicationNo);
        }
        protected void Payment_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("PaymentInvoice.aspx?applicationNo=" + applicationNo);
        }
        protected void next_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];

            Response.Redirect("ExistingStudents.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }
        protected void uploadphoto_Click(object sender, EventArgs e)
        {


            //murkomen
            string IdNumber = Convert.ToString(Session["idNumber"]);
            string accreditationNo = IdNumber;
            accreditationNo = accreditationNo.Replace('/', '_');
            accreditationNo = accreditationNo.Replace(':', '_');
            string path1 = Config.FilesLocation() + "Student Processing Header/";
            string str1 = Convert.ToString(accreditationNo);
            string folderName = path1 + str1 + "/";
            string message = "";
            Boolean error = false;

            string extension = System.IO.Path.GetExtension(FileUpload1.FileName);
            if (extension == ".png" || extension == ".PNG")
            {
                error = true;
                message = "Please Select a jpg image";

            }
            if (extension == ".jpeg" || extension == ".JPEG")
            {
                error = true;
                message = "Please Select a JPG image";

            }
            if (extension == ".jplg" || extension == ".JPLG")
            {
                error = true;
                message = "Please Select a JPG image";

            }
            if (error)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

                try
                {
                    if (FileUpload1.HasFile == false)
                    {
                        linesFeedback.InnerHtml = "Kindly upload profile photo before you proceed!";
                    }
                    if (FileUpload1.HasFile)
                    {
                        extension = System.IO.Path.GetExtension(FileUpload1.FileName);


                        //if (extension == ".jpg" || extension == ".JPG")
                        //{
                        string filename1 = accreditationNo + extension;

                        string fullPath = Server.MapPath("~/images/") + "\\" + filename1;

                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }


                        FileUpload1.PostedFile.SaveAs(fullPath);


                        //FileUpload1.SaveAs("~/images/" + Path.GetFileName(FileUpload1.FileName));

                        if (!Directory.Exists(folderName))
                        {
                            Directory.CreateDirectory(folderName);
                        }
                        if (System.IO.File.Exists(folderName + filename1))
                        {
                            System.IO.File.Delete(folderName + filename1);


                        }
                        FileUpload1.SaveAs(folderName + filename1);

                        //}
                        //else if (extension != ".png" || extension != ".PNG")
                        //{
                        //    string Message = "Please Upload a Png image Only";
                        //    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        //}


                    }


                }
                catch (Exception m)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }
    }
}