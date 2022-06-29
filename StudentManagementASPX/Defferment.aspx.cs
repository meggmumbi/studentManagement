using Microsoft.SharePoint.Client;
using Newtonsoft.Json;
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
    public partial class Defferment : System.Web.UI.Page
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
                if (templates.Count > 0) { 

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


                examCenter.DataSource = exmcycle.Where(r => r.Sitting_Status == "Active" && r.Closed == false);
                examCenter.DataTextField = "examCycle";
                examCenter.DataValueField = "examCycle";
                examCenter.DataBind();
                examCenter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                var DeffermentReasons = nav.withdrawalreasons.Where(r => r.Reason_Category == "Defferement");
                withdrawal.DataSource = DeffermentReasons;
                withdrawal.DataTextField = "Description";
                withdrawal.DataValueField = "Code";
                withdrawal.DataBind();
                withdrawal.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                String applicationNo = Request.QueryString["applicationNo"];
                string studentNo = Convert.ToString(Session["studentNo"]);
                var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Student_No== studentNo).ToList();
                if (studentProcessing.Count > 0)
                {
                    foreach (var descript in studentProcessing)
                    {
                        regNo.SelectedValue = descript.Student_Reg_No;
                        withdrawal.SelectedValue = descript.Withdrawal_Code;
                        examCycle.SelectedValue = descript.Examination_Sitting;
                        examCenter.SelectedValue = descript.Prefered_Examination_Sitting;
                        Amount.Text = Convert.ToString(descript.Administrative_Fees);
                        AmountInstructions.InnerText = Convert.ToString(descript.Administrative_Fees);
                        AmountInstructionsManual.InnerText = Convert.ToString(descript.Administrative_Fees);
                    }
                }
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

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {
                
                String StudentNo = Convert.ToString(Session["studentNo"]);
                string courseid = Request.QueryString["courseid"];
                //DateTime applicationDate = Convert.ToDateTime(Date.Text);
                String regNUmber = regNo.SelectedValue.Trim();
                string examid = courseId.Text.Trim();
                String withdrawalReason = withdrawal.SelectedValue.Trim();
                string examCycles = examCycle.SelectedValue.Trim();
                string preferredExamcenter = examCenter.SelectedValue.Trim();
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
                String status = new Config().ObjNav().CreateDefferment(applicationNo,  StudentNo, regNUmber,withdrawalReason,examCycles,preferredExamcenter);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newApplicationNo)
                    {
                        applicationNo = info[2];

                    }
                    //Response.Redirect("Defferment.aspx?step=2&&applicationNo=" + applicationNo);
                    generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Response.Redirect("Defferment.aspx?step=2&&courseId=" + info[3] + "&&applicationNo=" + applicationNo+"&&reason="+ withdrawalReason);
                    
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
            string courseId = Request.QueryString["courseId"];
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Defferment.aspx?step=1&&applicationNo=" + applicationNo + "&&courseId=" + courseId);
          
        }

       

        protected void part_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string parts = part.SelectedValue.Trim();
            //string examId = Request.QueryString["courseid"];
            //var nav = Config.ReturnNav();

            //var sections = nav.sections.Where(r => r.Course == examId && r.Part == parts);
            //section.DataSource = sections;
            //section.DataTextField = "Code";
            //section.DataValueField = "Code";
            //section.DataBind();
            //section.Items.Insert(0, new ListItem("--select--", ""));
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
                    string customlibraryname = "KASNEB/Deferment";
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

                                var sDocName = UploadDeferment(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddDefermentSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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



        public static string UploadDeferment(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            //leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "KASNEB/Deferment";
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


        public void UploadDocuments_Click(object sender, EventArgs e)
        {

            try
            {
                string ApplicationNo = Request.QueryString["applicationNo"].Trim();
                bool fileuploadSuccess = false;
                string sUrl = ConfigurationManager.AppSettings["S_URL"];
                // string serverName = ConfigurationManager.AppSettings["S_URL"];
                string defaultlibraryname = "Student%20Portal/";
                string customlibraryname = "KASNEB/Deferment";
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

                                var sDocName = UploadDeferment(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

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
                    var parentFolderName = @"Student%20Portal/KASNEB/Deferment/";
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
        protected void prevstep1_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Defferment.aspx?step=2&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void step3_Click(object sender, EventArgs e)
        {
            string reason = Request.QueryString["reason"];
            string courseId = Request.QueryString["courseId"];
            String applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Defferment.aspx?step=3&&applicationNo=" + applicationNo+ "&&courseId="+ courseId+ "&&reason="+ reason);
        }
        protected void attachdoc_Click(object sender, EventArgs e)
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

                    attach.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('DeffermentApplications.aspx') }, 5000);", true);

                }
                    else
                    {
                    attach.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            
        }
        protected void makePayments_Click(object sender, EventArgs e)
        {
            try
            {
                string applicationNumber = accreditationnumber.Text.Trim();
                applicationNumber = applicationNumber.Replace('/', '_');
                applicationNumber = applicationNumber.Replace(':', '_');
                string path1 = Config.FilesLocation() + "Registration Payments/";
                string str1 = Convert.ToString(applicationNumber);
                string folderName = path1 + str1 + "/";
                bool paymentsDocUploaded = false;
                try
                {
                    if (paymentdocument.HasFile)
                    {
                        string extension = System.IO.Path.GetExtension(paymentdocument.FileName);
                        if (new Config().IsAllowedExtension(extension))
                        {
                            string filename = "PaymentDocument" + extension;
                            if (!Directory.Exists(folderName))
                            {
                                Directory.CreateDirectory(folderName);
                            }
                            if (System.IO.File.Exists(folderName + filename))
                            {
                                System.IO.File.Delete(folderName + filename);
                            }
                            paymentdocument.SaveAs(folderName + filename);
                            if (System.IO.File.Exists(folderName + filename))
                            {
                                paymentsDocUploaded = true;
                            }
                        }
                        else
                        {
                            PaymentsMpesa.InnerHtml = ("The file extension of the payment document is not allowed");
                        }

                    }
                }
                catch (Exception)
                {
                    PaymentsMpesa.InnerHtml = ("The Payments Details Could Not Be Captured Kindly Contact the System Administrator");
                }

                string applicationnumber = accreditationnumber.Text.Trim();
                string paymentreference = paymentsref.Text.Trim();
                string mode = paymentsM.SelectedValue.Trim();
                string status = new Config().ObjNav().ConfirmPaymentsStudentBooking(applicationnumber, paymentsDocUploaded, paymentreference, "", mode);
                string[] info = status.Split('*');
                PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            catch (Exception y)
            {
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
        protected void SubmitPayment_Click(object sender, EventArgs e)
        {
            var response = "";
            try
            {
                using (var client = new WebClient())
                {



                    EnableTrustedHosts();



                    client.Headers.Add("Content-Type", "application/json");




                    string tphoneNumber = PhoneNumberPay.Text.Trim();
                    decimal tAmount = Convert.ToDecimal(Amount.Text.Trim());
                    Boolean error = false;
                    String message = "";

                    if (string.IsNullOrEmpty(tphoneNumber))
                    {
                        error = true;
                        message = "Please enter Phone Number used to pay";
                    }
                    string _mobileNumber = CleanNumber(tphoneNumber);

                    // trim any leading zeros
                    _mobileNumber = _mobileNumber.TrimStart(new char[] { '0' });


                    // add country code if they haven't entered it
                    //If we need to handle with multiple Country codes we have to place a list here,Currently added +64 as per document.
                    if (!_mobileNumber.StartsWith("254"))
                    {
                        _mobileNumber = "254" + _mobileNumber;
                    }





                    String applicationNo = Request.QueryString["applicationNo"];

                    //  string account = idno;  //id number

                    var nav = Config.ReturnNav();
                    var detailz = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == applicationNo).ToList();
                    if (detailz.Count > 0)
                    {

                        response = ("You have already paid for the exemption. Please wait for processing of your application");
                        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {


                        var vm = new { accountnumber = applicationNo, transactionreference = applicationNo, amount = tAmount, transactiondescription = "Paybill Deposit", businessnumber = "204777", Telephone = _mobileNumber };



                        var dataString = JsonConvert.SerializeObject(vm);



                        try
                        {
                            string result = "";
                            result = client.UploadString("https://mobile.kasneb.or.ke:8222/api/stkpush", "POST", dataString);



                            Stkresult details = null;




                            details = JsonConvert.DeserializeObject<Stkresult>(result.ToString());



                            if (details.ResponseCode == "0")
                            {

                                response = (details.ResponseDescription + "." + " " + "You have initiated payment using MPESA. Please enter your MPESA PIN when prompted.");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                         
                            }
                            else
                            {
                                response = (details.ResponseDescription + ". " + "" + "Please Use the Manual Mpesa Payment Process");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                        }
                        catch (Exception ex)
                        {
                            response = ex.Message;
                            PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                    }

                }

            }
            catch (Exception ex)
            {
                response = ex.Message;
                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            
        }
        public static void EnableTrustedHosts()
        {
            System.Net.ServicePointManager.ServerCertificateValidationCallback =
                 ((sender, certificate, chain, sslPolicyErrors) => true);
        }
        public partial class Stkresult
        {
            public string MerchantRequestID { get; set; }
            public string CheckoutRequestID { get; set; }
            public string ResponseCode { get; set; }
            public string ResponseDescription { get; set; }
            public string CustomerMessage { get; set; }
        }
        public string CleanNumber(string phone)
        {
            Regex digitsOnly = new Regex(@"[^\d]");
            return digitsOnly.Replace(phone, "");
        }
    }
}