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
    public partial class VacancyDescription : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var vacancyNo = Request.QueryString["innovationNumber"];
                var today = DateTime.Today;
                var innovations = nav.CrmVacancies.Where(r => r.Vacancy_No == vacancyNo && r.Application_End_Date >= today);
                foreach (var innovation in innovations)
                {
                    noticeNo.Text = innovation.Vacancy_No;
                    innovationDescription.Text = innovation.Position;
                    category.Text = Convert.ToString(innovation.No_of_Openings);
                    department.Text = Convert.ToString(innovation.Estimate_Annual_Salary);
                    submissionstartDate.Text = innovation.Employment_Type;
                    submissionEndDate.Text = Convert.ToDateTime(innovation.Application_End_Date).ToString("dd/MM/yyyyy");
                    executiveSummery.Text = innovation.Employer;
                    region.Text = innovation.Region;
                    comments.Text = innovation.Comments;
                }
            }
        }

        protected void confirm_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "register(); window.location='" + Request.ApplicationPath + "registrationInstructions.aspx';", true);
                submit.InnerHtml = "<div class='alert alert-danger'> You must be a student registered with kasneb.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else if (Session["studentNo"] != null)
            {
                try
                {

                    String tvacancyId = removeFuelWorkType.Text;
                    var studentNumber = Convert.ToString(Session["studentNo"]);

                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tvacancyId))
                    {
                        error = true;
                        message = "An application with the given applcationNo does not exist";
                    }



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
                     String status = new Config().ObjNav().FnApplyJob(applicationNo, studentNumber, tvacancyId);
                    //String status = "";
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newApplicationNo)
                        {
                            applicationNo = info[2];

                        }
                        //Response.Redirect("Defferment.aspx?step=2&&applicationNo=" + applicationNo);
                        submit.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        submit.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }

                catch (Exception m)
                {
                    submit.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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


                    if (string.IsNullOrWhiteSpace(tapplicationNo))
                    {
                        results_0 = "Application Number is Null";
                        return results_0;
                    }

                    bool fileuploadSuccess = false;
                    string sUrl = ConfigurationManager.AppSettings["S_URL"];
                    string defaultlibraryname = "Student%20Portal/";
                    string customlibraryname = "KASNEB/CrmVacancy";
                    string sharepointLibrary = defaultlibraryname + customlibraryname;
                    // String leaveNo = Request.QueryString["applicationNo"];
                    String leaveNo = tapplicationNo;

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
                            string savedF0 = leaveNo + "_" + fileName0 + ext0;


                            Uri uri = new Uri(sUrl);
                            string sSpSiteRelativeUrl = uri.AbsolutePath;
                            string uploadfilename = leaveNo + "_" + fileName0;
                            byte[] byteArray = Encoding.ASCII.GetBytes(oneitem.browsedDoc);
                            MemoryStream DocStream = new MemoryStream(byteArray);
                            Stream uploadfileContent = DocStream;

                            var sDocName = UploadVcancy(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                            string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                            if (!string.IsNullOrEmpty(sDocName))
                            {
                                var status = new Config().ObjNav().AddVacancySharepointLinks(leaveNo, uploadfilename, sharepointlink);
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

        public static string UploadVcancy(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            //leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "KASNEB/CrmVacancy";
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
                    var parentFolderName = @"Student%20Portal/KASNEB/CrmVacancy/";
                    var leaveNo = Request.QueryString["innovationNumber"];

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
    }
}