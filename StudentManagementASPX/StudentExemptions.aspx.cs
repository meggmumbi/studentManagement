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
using System.Web.Script.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class StudentExemptions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
               
               
              
                    var nav = Config.ReturnNav();

                    string student = Request.QueryString["student"];
                    studentNo.Text = student;

                    string IdNumber = Convert.ToString(Session["idNumber"]);

                    var studentNumb = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber);
                    foreach (var students in studentNumb)
                    {
                        studentNo.Text = students.Student_No;

                    }
                    var courses = Request.QueryString["courseid"];
                    courseId.Text = courses;
                   


                    


                   

                var coursesId = Request.QueryString["courseId"];
                var templates = nav.DocumentsTemplate.Where(r => r.Blocked == false && r.Course_ID == coursesId).ToList();
                foreach (var templ in templates)
                {
                    template.Text = templ.Code;
                }

                string course = Request.QueryString["courseId"];
                var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examiantion_ID == course && r.Examination_Process== "Exemption");
                DocType.DataSource = details;
                DocType.DataTextField = "Examination_Document";
                DocType.DataValueField = "Examination_Document_Type";
                DocType.DataBind();
                DocType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                String applicationNo = Request.QueryString["applicationNo"];
                var Exemtion = nav.ExemptionQualification.Where(r => r.Document_No == applicationNo).ToList();
                if (Exemtion.Count>0)
                {
                    NextExemption.Visible = true;

                }
                else
                {
                    NextExemption.Visible = false;
                }
              




            }
        }

        protected void exemptionType_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadItems();
        }

        public void loadItems()
        {
            

               
            
        }

        protected void addItem_Click(object sender, EventArgs e)
        {

            //try
            //{
            //    int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
            //    int tItemCategory = Convert.ToInt32(exemptionType.Text.Trim());
            //    String tItem = String.IsNullOrEmpty(item.SelectedValue.Trim()) ? "" : item.SelectedValue.Trim();
            //    string tcourseId = Request.QueryString["courseId"];
            //    String Currency = currency.SelectedValue.Trim();


            //    Boolean error = false;



            //    String applicationNo = Request.QueryString["applicationNo"];
            //    Convert.ToString(Session["employeeNo"]),
            //        Nav Funtion

            //        String status = new Config().ObjNav().CreateExemptionLine(tItemCategory, tItem, tcourseId, applicationNo);
            //    String[] info = status.Split('*');
            //    try adding the line
            //        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //    catch (Exception n)
            //    {
            //        linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }



            }

        //protected void regNo_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    //string examRegNo = regNo.SelectedValue.Trim();
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
                
                string StudentNo = studentNo.Text.Trim();                
                int QualificationType = Convert.ToInt32(qualificationtype.SelectedValue.Trim());
                string quaficationdescription = qualificationDecsription.SelectedValue.Trim();
                string  applicationNo = Request.QueryString["applicationNo"];

                if (QualificationType == 2)
                {                   
                    string QualCode = qualificationDecsription.SelectedValue.TrimEnd();
                    string studentNos = Convert.ToString(Session["studentNo"]);
                    string message = "";
                    var nav = Config.ReturnNav();
                    var examAccounts = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNos && r.Course_ID == QualCode && r.Status != "Active").ToList();
                    if (examAccounts.Count == 0)
                    {
                        message = "You have not completed the selected kasneb examination therefore not elligible for an exemption";
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {

                        String status = new Config().ObjNav().CreateExemptionQualifications(applicationNo, QualificationType, quaficationdescription);
                        String[] info = status.Split('*');
                        if (info[0] == "success")
                        {

                            generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            NextExemption.Visible = true;
                            
                        }
                        else
                        {
                            generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }
                }
                else
                {
                    String status = new Config().ObjNav().CreateExemptionQualifications(applicationNo, QualificationType, quaficationdescription);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {



                        generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        NextExemption.Visible = true;


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

        protected void previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudentExemptions.aspx?step=1");
        }

        protected void qualificationtype_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadQualifications();
        }

        public void loadQualifications()
        {
            try
            {
                var nav = Config.ReturnNav();               
                var itemtype = "";
                var typ = Convert.ToInt32(qualificationtype.SelectedValue);

                switch (typ)
                {

                    case 0:
                        itemtype = "Degree";
                        var GL = nav.ExemptionsQualifications.Where(r => r.Qualification_Type == "Degree").ToList();
                        qualificationDecsription.DataSource = GL;
                        qualificationDecsription.DataTextField = "Qualification";
                        qualificationDecsription.DataValueField = "Code";
                        qualificationDecsription.DataBind();
                        qualificationDecsription.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                        return;

                    case 1:
                        itemtype = "Diploma";

                        var itm = nav.ExemptionsQualifications.Where(r => r.Qualification_Type == "Diploma").ToList();
                        qualificationDecsription.DataSource = itm;
                        qualificationDecsription.DataTextField = "Qualification";
                        qualificationDecsription.DataValueField = "Code";
                        qualificationDecsription.DataBind();
                        qualificationDecsription.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                        return;

                    case 2:
                        itemtype = "Course";

                        var courses = nav.Courses.ToList();
                        qualificationDecsription.DataSource = courses;
                        qualificationDecsription.DataTextField = "Description";
                        qualificationDecsription.DataValueField = "Code";
                        qualificationDecsription.DataBind();
                        qualificationDecsription.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                        return;


                    default:
                        break;
                }


            }
            catch (Exception)
            {

            }
        }

        protected void invoice_Click(object sender, EventArgs e)
        {
            Response.Redirect("ExemptionInvoice.aspx");
        }

        protected void previous_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("StudentExemptions.aspx?step=1&&courseId=" + courseId +  "&&applicationNo=" + applicationNo);
        }

        protected void invoice_Click1(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            String applicationNo = Request.QueryString["applicationNo"];
            var details = nav.ExemptionQualification.Where(r => r.Document_No == applicationNo).ToList();
            foreach(var qualification in details)
            {

                if(qualification.Qualification_Type== "Course")
                {
                    Response.Redirect("StudentExemptions.aspx?step=4&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }
                //else if(qualification.Qualification_Type == "Course" && qualification.Qualification_Type== "Degree") 
                //{
                //    Response.Redirect("StudentExemptions.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                //}
                else
                {
                    Response.Redirect("StudentExemptions.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }



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
                    HttpPostedFileBase tfile = oneitem.files;


                    if (string.IsNullOrWhiteSpace(tapplicationNo))
                    {
                        results_0 = "Application Number is Null";
                        return results_0;
                    }

                    bool fileuploadSuccess = false;
                    string sUrl = ConfigurationManager.AppSettings["S_URL"];
                    string defaultlibraryname = "Student%20Portal/";
                    string customlibraryname = "KASNEB/Exception";
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

                            long size = fi.Length;

                            string fileName0 = Path.GetFileName(fi.Name);
                            //string ext0 = _getFileextension(financedetail.browsedDoc);
                           // string fileName0 = fi.FullName;
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
                            if (fi.Extension == ".doc" || fi.Extension == ".DOC")
                            {
                                error = true;
                                message = "Please attach a pdf document only";

                            }
                            if (fi.Extension == ".docx" || fi.Extension == ".DOCX")
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
                                string uploadfilename = leaveNo + "_" + oneitem.browsedDoc;

                                FileStream fs = fi.Open(FileMode.OpenOrCreate, FileAccess.Read, FileShare.Read);
                                StreamReader sr = new StreamReader(fs);

                                //HttpPostedFileBase files = new HttpPostedFileBase();
                                //Stream str = files.InputStream;
                                //BinaryReader Br = new BinaryReader(str);
                                //Byte[] FileDet = Br.ReadBytes((Int32)str.Length);
                                //Use ReadToEnd method to read all the content from file
                                Stream str = tfile.InputStream;
                                BinaryReader Br = new BinaryReader(str);
                                Byte[] FileDet = Br.ReadBytes((Int32)str.Length);


                                string fileContent = sr.ReadToEnd();

                                byte[] byteArray = Encoding.ASCII.GetBytes(fileContent);
                                MemoryStream DocStream = new MemoryStream(FileDet);
                                Stream uploadfileContent = DocStream;

                                var sDocName = UploadExceptions(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddExemptionSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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

        public void UploadDocuments_Click(object sender, EventArgs e)
        {

            try
            {
                string ApplicationNo = Request.QueryString["applicationNo"].Trim();
                bool fileuploadSuccess = false;
                string sUrl = ConfigurationManager.AppSettings["S_URL"];
                // string serverName = ConfigurationManager.AppSettings["S_URL"];
                string defaultlibraryname = "Student%20Portal/";
                string customlibraryname = "KASNEB/Exception";
                string sharepointLibrary = defaultlibraryname + customlibraryname;
                String leaveNo = ApplicationNo;
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
                            completefeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                        else
                        {

                            string savedF0 = leaveNo + "_" + fileName0;


                            Uri uri = new Uri(sUrl);
                            string sSpSiteRelativeUrl = uri.AbsolutePath;
                            string uploadfilename = leaveNo + "_" + fileName0;
                            Stream uploadfileContent = uploadfile.FileContent;

                            var sDocName = UploadExceptions(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                            string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                            if (!string.IsNullOrEmpty(sDocName))
                            {
                                var status = new Config().ObjNav().AddExemptionSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                                string[] info = status.Split('*');
                                if (info[0] == "success")
                                {
                                    completefeedback.InnerHtml = "<div class='alert alert-success'>" + info[0] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                else
                                {
                                    completefeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }

                            }
                            else
                            {
                                completefeedback.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }


                        }
                    }
                    else
                    {
                        completefeedback.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                }
                catch (Exception ex)
                {
                    completefeedback.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                completefeedback.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        public static string UploadExceptions(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            //leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "KASNEB/Exception";
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
                    var parentFolderName = @"Student%20Portal/KASNEB/Exception/";
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

        protected void prev_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            var applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("StudentExemptions.aspx?step=2&&courseId=" + courseId  + "&&applicationNo=" + applicationNo);
        }

        protected void next_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            var applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("StudentExemptions.aspx?step=4&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            var applicationNo = Request.QueryString["applicationNo"];
            var nav = Config.ReturnNav();
            var details = nav.ExemptionQualification.Where(r => r.Document_No == applicationNo).ToList();
            foreach (var qualification in details)
            {

                if (qualification.Qualification_Type == "Course")
                {
                    Response.Redirect("StudentExemptions.aspx?step=2&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }
                else
                {
                    Response.Redirect("StudentExemptions.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }
                
            }
            
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

                    String status = new Config().ObjNav().FnSubmitExeptionApplication(tapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                       // Response.Redirect("Dashboard.aspx");
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
            else if (declaration.Checked == false)
            {
                var message = "Please accept our Terms and Conditions";
                submit.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void delete_Click(object sender, EventArgs e)
        {
            try
            {
                int tentryNumber = Convert.ToInt32(removeFuelNumber.Text.Trim());
                String applicationNo = Request.QueryString["applicationNo"];
                var nav = new Config().ObjNav();
                String status = nav.RemoveExemptionPaper(applicationNo, tentryNumber);
                String[] info = status.Split('*');
                feedbackPaper.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                feedbackPaper.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void NextExemption_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            string applicationNo = Request.QueryString["applicationNo"];
            try
            {
                String status = new Config().ObjNav().FnDisplayPapers(applicationNo);
                if (status == "")
                {
                    Response.Redirect("StudentExemptions.aspx?step=2&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }
                else
                {

                }
            }
            catch (Exception t)
            {
                string m = t.Message;


            }

           

           // ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "reloadPage();", true);
           
        }

        protected void DeleteQual_Click(object sender, EventArgs e)
        {
            try
            {
                int tentryNumber = Convert.ToInt32(QualificationNo.Text.Trim());
                String applicationNo = Request.QueryString["applicationNo"];
                var nav = new Config().ObjNav();
                String status = nav.RemoveQualificationPaper(applicationNo, tentryNumber);
                String[] info = status.Split('*');
                feedbackPaper.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            catch (Exception t)
            {
                feedbackPaper.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void qualificationDecsription_SelectedIndexChanged(object sender, EventArgs e)
        {
            int qualtype = Convert.ToInt32(qualificationtype.SelectedValue.Trim());
            if (qualtype == 2)
            {
                string QualCode = qualificationDecsription.SelectedValue.Trim();
                string studentNo = Convert.ToString(Session["studentNo"]);
                string message = "";
                var nav = Config.ReturnNav();
                var examAccounts = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Course_ID == QualCode && r.Status != "Active").ToList();
                if (examAccounts.Count == 0)
                {
                    message = "You have not completed the selected kasneb examination therefore not elligible for an exemption";
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }

        }
    }
}