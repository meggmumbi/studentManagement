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
    public partial class StudentRegistration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {


                string courseId = Request.QueryString["courseId"];
                decimal balance = 0;
                decimal Applicationamount=0;
                decimal totalAmount;
                var nav = Config.ReturnNav();
                var counties = nav.counties;
                county.DataSource = counties;
                county.DataTextField = "Description";
                county.DataValueField = "Code";
                county.DataBind();
                county.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                var postalAddress = nav.postcodes;
                postal.DataSource = postalAddress;
                postal.DataTextField = "Code";
                postal.DataValueField = "Code";
                postal.DataBind();
                postal.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));


                var ExamCycles = nav.ExamCycle;
                examCylce.DataSource = ExamCycles;
                examCylce.DataTextField = "examCycle";
                examCylce.DataValueField = "examCycle";
                examCylce.DataBind();
                examCylce.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));



                var payment = nav.paymentMode;
                paymentsM.DataSource = payment;
                paymentsM.DataTextField = "Code";
                paymentsM.DataValueField = "Code";
                paymentsM.DataBind();
                paymentsM.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var examcenters = nav.ExamCenters;
                examCenter.DataSource = examcenters;
                examCenter.DataTextField = "Name";
                examCenter.DataValueField = "Code";
                examCenter.DataBind();
                examCenter.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var qualification = nav.studentQualifications;
                txteducationallevel.DataSource = qualification;
                txteducationallevel.DataTextField = "Qualification_Description";
                txteducationallevel.DataValueField = "Code";
                txteducationallevel.DataBind();
                txteducationallevel.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var info = nav.sourceInformation;
                information.DataSource = info;
                information.DataTextField = "Description";
                information.DataValueField = "Code";
                information.DataBind();
                information.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var trainingInst = nav.Instcustomers.Where(r => r.Customer_Type == "Institution");
                currency.DataSource = trainingInst;
                currency.DataTextField = "Name";
                currency.DataValueField = "No";
                currency.DataBind();
                currency.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                var projectCode = Request.QueryString["projectCode"];

                var courses = nav.ExamCourses.Where(r => r.Job_No == projectCode);
                ExamCodes.DataSource = courses;
                ExamCodes.DataTextField = "Description";
                ExamCodes.DataValueField = "Job_Task_No";
                ExamCodes.DataBind();
                ExamCodes.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));
                





                string studentNo = Convert.ToString(Session["studentNo"]);
                string emailAdd = Convert.ToString(Session["EmailAddress"]);
                email.Text = emailAdd;

                string IdNumber = Convert.ToString(Session["idNumber"]);
                idnumber.Text = IdNumber;


                string firsname = Convert.ToString(Session["firstName"]);
                firstName.Text = firsname;
                string MiddleName = Convert.ToString(Session["MiddleName"]);
                middlename.Text = MiddleName;
                string lastname = Convert.ToString(Session["LastName"]);
                lastName.Text = lastname;

                string phneNumber = Convert.ToString(Session["phoneNumber"]);
                phoneNumber.Text = phneNumber;

               
                project.Text = projectCode;


                var phisicalChallenge = nav.studentdisability;
                disabilitytype.DataSource = phisicalChallenge;
                disabilitytype.DataTextField = "Description";
                disabilitytype.DataValueField = "Code";
                disabilitytype.DataBind();
                disabilitytype.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var country = nav.Countries;
                DropDownList1.DataSource = country;
                DropDownList1.DataTextField = "Name";
                DropDownList1.DataValueField = "Code";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                var coursesId = Request.QueryString["courseId"];
                var templates = nav.DocumentsTemplate.Where(r => r.Blocked == false && r.Course_ID == coursesId);
                foreach (var templ in templates)
                {
                    template.Text = templ.Code;
                }

                var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Registration" && r.Examiantion_ID == courseId);
                DocType.DataSource = details;
                DocType.DataTextField = "Examination_Document";
                DocType.DataValueField = "Examination_Document_Type";
                DocType.DataBind();
                DocType.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--select--", ""));

                String applicationNo = Request.QueryString["applicationNo"];
                accreditationnumber.Text = applicationNo;
                // String courseId = Request.QueryString["courseId"];
               
                ExamCodes.SelectedValue = courseId;
                var courseDesc = nav.ExamCourses.Where(r => r.Examination_Code == courseId);
                foreach (var description in courseDesc)
                {
                    courseTextBox.Text = description.Description;
                }
                var exemptionLines = nav.DisabilityEntries.Where(r => r.Student_No == applicationNo);
                foreach (var line in exemptionLines)
                {

                    disabilitytype.SelectedItem.Text = line.Disability_Type;
                    disabilitdescription.Text = line.Disability_Name;

                }

                DropDownList1.SelectedValue = "KE";
                if (DropDownList1.SelectedValue == "KE")
                {
                    LocalAddress.Visible = true;
                }

                var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo && r.ID_Number_Passport_No == IdNumber && r.Examination_ID == courseId).ToList();

                if (studentProcessing.Count > 0)
                {
                    foreach (var descript in studentProcessing)
                    {

                        Applicationamount = Convert.ToDecimal(descript.Application_Amount);

                        var country_Re = descript.Country_Region_Code;
                        DropDownList1.SelectedValue = country_Re;
                        if (country_Re == "KE")
                        {
                            LocalAddress.Visible = true;
                        }
                        var countys = descript.County;
                        county.SelectedValue = countys;
                        postal.SelectedValue = descript.Post_Code;
                        city.Text = descript.City;
                        address.Text = descript.Address;
                        //phoneNumber.Text = descript.Phone_No;
                        examCylce.SelectedValue = descript.Examination_Sitting;
                        txteducationallevel.SelectedValue = descript.Highest_Academic_QCode;
                        currency.SelectedValue = descript.Training_Institution_Code;
                        information.SelectedValue = descript.Source_of_Information;
                        examCenter.SelectedValue = descript.Examination_Center_Code;
                        WorkType.Text = descript.Fee_Type;
                        kinName.Text = descript.Contact_Full_Name;
                        kinEmail.Text = descript.Contact_Email;
                        kinPhone.Text = descript.Contact_Phone_No;
                        examinationz.Text = descript.Examination_ID;
                        courseTextBox.Text = descript.Examination_Description;
                        if (descript.Disabled == true)
                        {
                            disabledchallenge.SelectedValue = "2";
                        }
                        else if (descript.Disabled == false)
                        {
                            disabledchallenge.SelectedValue = "1";
                        }
                        txtDOB.Text = Convert.ToDateTime(descript.Date_of_Birth).ToString("dd/MM/yyyy");
                        var gender = descript.Gender;
                        if (gender == "Female")
                        {
                            txtgender.SelectedValue = "2";

                        }
                        if (gender == "Male")
                        {
                            txtgender.SelectedValue = "1";

                        }

                        var nextOfKinRel = descript.Contact_Relationship;
                        if (nextOfKinRel == "Parent")
                        {
                            kin.SelectedValue = "0";

                        }
                        if (nextOfKinRel == "Guardian")
                        {
                            kin.SelectedValue = "1";

                        }
                        if (nextOfKinRel == "Sibling")
                        {
                            kin.SelectedValue = "2";

                        }
                        if (nextOfKinRel == "Spouse")
                        {
                            kin.SelectedValue = "3";

                        }
                        var nextofkinDetails = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Highest_Academic_QCode != "" && r.Contact_Full_Name != "" &&r.Examination_ID !="").ToList();
                        if (nextofkinDetails.Count > 0)
                        {
                            AdditionalNext.Visible = true;
                        }
                        else
                        {
                            AdditionalNext.Visible = false;
                        }

                    }
                }
                var customer = nav.Instcustomers.Where(r => r.ID_No == IdNumber).ToList();
                if (customer.Count > 0)
                {
                    foreach (var custBalance in customer)
                    {
                        balance = Convert.ToDecimal(custBalance.Balance_LCY);
                    }
                }
                totalAmount = balance + Applicationamount;
                Amount.Text = Convert.ToString(Applicationamount);
                AmountInstructions.InnerText = Convert.ToString(Applicationamount);
                AmountInstructionsManual.InnerText = Convert.ToString(Applicationamount);



                imgviews.DataBind();

                
            }
        }

        protected void ReadUploadedImage()
        {
           
        }

        protected void postal_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postal.SelectedValue);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
            }


        }

        protected void btn_personalinformations_Click(object sender, EventArgs e)
        {
            try
            {

                string education = txteducationallevel.SelectedValue.Trim();
               // string texam = course.SelectedValue.Trim();
                // string texamCycle = examCylce.SelectedValue.Trim();
                //string tExamCenter = examCenter.SelectedValue.Trim();
                string tDisabled = disabledchallenge.SelectedValue.Trim();
                //  string tdisabledcert = txtdisabilitycertificateNumber.Text.Trim();
                string tinformation = information.SelectedValue.Trim();
                int tkin = Convert.ToInt32(kin.SelectedValue.Trim());
                string trainingInstitution = currency.SelectedValue.Trim();
                string tkinName = kinName.Text.Trim();
                string tkinEmail = kinEmail.Text.Trim();
                string tkinPhone = kinPhone.Text.Trim();
                Boolean error = false;
                String message = "";




                if (string.IsNullOrEmpty(education))
                {
                    error = true;
                    message = "Select Education Level";
                }
                if (string.IsNullOrEmpty(Convert.ToString(tkin)))
                {
                    error = true;
                    message = "Select The relation of the next of kin";
                }
                if (string.IsNullOrEmpty(tkinName))
                {
                    error = true;
                    message = "Please enter the the next of kin name";
                }

                if (string.IsNullOrEmpty(tkinPhone))
                {
                    error = true;
                    message = "Please enter the the next of kin Phone Number";
                }
            
                //if (string.IsNullOrEmpty(tExamCenter))
                //{
                //    error = true;
                //    message = "Select Exam Center";
                //}
                if (string.IsNullOrEmpty(tinformation))
                {
                    error = true;
                    message = "Select source of iformation";
                }
                if (string.IsNullOrEmpty(education))
                {
                    error = true;
                    message = "Select Your Educational Level";
                }


                String applicationNo = Request.QueryString["applicationNo"];




                string response = new Config().ObjNav().FnApplicantProfileRegistrationLines(applicationNo, tDisabled, "", education, tinformation, tkin, tkinName, tkinEmail, tkinPhone, trainingInstitution);

                String[] info = response.Split('*');
                if (info[0] == "success")
                {

                    nextofkin.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    Session["courseId"] = info[2];
                    AdditionalNext.Visible = true;

                }
                else
                {
                    nextofkin.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
            catch (Exception m)
            {
                nextofkin.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                //MessageBox.Show(m.Message);
                // ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + m.Message + "');", true);
            }
        }

        protected void next_Click(object sender, EventArgs e)
        {
            try
            {

                //string filepath = Config.FilesLocation() + "Student Processing Header/";
               // string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                //FileUpload1.SaveAs(Server.MapPath(filepath + filename));
                //filepath = Config.FilesLocation() + "Student Processing Header/" + filename;


                string tfname = firstName.Text.Trim();
                string tmiddelname = middlename.Text.Trim();
                string tlastName = lastName.Text.Trim();
                string tIdNumber = idnumber.Text.Trim();
                string temail = email.Text.Trim();
                string tphoneNumber = phoneNumber.Text.Trim();
                string taddress = address.Text.Trim();
                string tcounty = county.SelectedValue.Trim();
                string tcountry = DropDownList1.SelectedValue.Trim();
                string tpostal = postal.SelectedValue.Trim();
                string tcity = city.Text.Trim();
                string projectCode = project.Text;
                string courseId = ExamCodes.SelectedValue;
                string tpostalAddress = postalAddress.Text;
                int gender = Convert.ToInt32(txtgender.SelectedValue.Trim());
                string tDOB = txtDOB.Text.Trim();
                DateTime dateofbirth;
                CultureInfo usCulture = new CultureInfo("es-ES");
                dateofbirth = DateTime.Parse(tDOB, usCulture.DateTimeFormat);

                Boolean error = false;
                String message = "";

                tphoneNumber = Regex.Replace(tphoneNumber, @"/^[^ 1 - 9A - Z] +|\s / gm", "");

                if (tphoneNumber.Length == 15)
                {
                    error = true;
                    message = "Id Number Cannot Exceed 25";
                }
                if (tIdNumber.Length == 25)
                {
                    error = true;
                    message = "Id Number Cannot Exceed 25";
                }

                if (string.IsNullOrEmpty(tfname))
                {
                    error = true;
                    message = "Enter firstName";

                }
                if (string.IsNullOrEmpty(courseId))
                {
                    error = true;
                    message = "Please selet Examination it cannot be empty";

                }

                if (string.IsNullOrEmpty(Convert.ToString(gender)))
                {
                    error = true;
                    message = "Select Your Gender";

                }
                if (string.IsNullOrEmpty(tcountry))
                {
                    error = true;
                    message = "Select Country";

                }

                if (string.IsNullOrEmpty(tpostal))
                {
                    tpostal = "";

                }
                if (string.IsNullOrEmpty(Convert.ToString(dateofbirth)))
                {
                    error = true;
                    message = "Please Enter Your Date of Birth";

                }

                string IdNumber = Convert.ToString(Session["idNumber"]);
                var path = "~/images/" + IdNumber+".jpg";                
                string servpath = Server.MapPath(path);
                FileInfo file = new FileInfo(servpath);
                
                if (file.Exists.Equals(false))
                {
                    error = true;
                    message = "Please Upload Your Passport Photo";//faz algo
                }
               
                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    
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
                    //UploadImage();

                    string response = new Config().ObjNav().FnApplicantProfileRegistration(applicationNo, tlastName, tfname, tmiddelname, gender, tIdNumber, dateofbirth, tcounty, taddress,
                        tpostal, temail, tcity, tphoneNumber, "", projectCode, courseId, tcountry);

                    String[] info = response.Split('*');
                    if (info[0] == "success")
                    {
                        if (newapplicationNo)
                        {
                            applicationNo = info[2];
                            appNo.Text = applicationNo;

                        }


                        generalFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        string projectCodes = Request.QueryString["projectCode"];
                        Response.Redirect("StudentRegistration.aspx?step=2&&applicationNo=" + applicationNo + "&&courseId=" + courseId+ "&&projectCode="+projectCodes);

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

        protected void UploadImage()
        {

            //murkomen
            string IdNumber = Convert.ToString(Session["idNumber"]);
            string accreditationNo = IdNumber;
            accreditationNo = accreditationNo.Replace('/', '_');
            accreditationNo = accreditationNo.Replace(':', '_');
            string path1 = Config.FilesLocation() + "Student Processing Header/";
            string str1 = Convert.ToString(accreditationNo);
            string folderName = path1 + str1 + "/";

            try
            {
                if (FileUpload1.HasFile == false)
                {
                    linesFeedback.InnerHtml = "Kindly upload profile photo before you proceed!";
                }
                if (FileUpload1.HasFile)
                {
                    string extension = System.IO.Path.GetExtension(FileUpload1.FileName);


                    if (extension == ".jpg" || extension == ".JPG")
                    {
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




                        //D:\C#projects\Clients\KASNEB\studentMurkomen\studentmanagementv1\StudentManagementASPX\images\


                        //murkomen
                    }
                    else if (extension != ".png" || extension != ".PNG")
                    {
                        string Message = "Please Upload a Png image Only";
                        generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            string applicationNo = Request.QueryString["applicationNo"];
            string projectCodes = Request.QueryString["projectCode"];
            Response.Redirect("StudentRegistration.aspx?step=1&&courseId=" + courseId + "&&applicationNo=" + applicationNo+ "&&projectCode="+projectCodes);

            // Response.Redirect("StudentRegistration.aspx?step=1");
        }

        protected void nextExamDetails_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            String applicationNo = appNo.Text.Trim();
            Response.Redirect("StudentRegistration.aspx?step=2&&applicationNo=" + applicationNo + "&&courseId=" + courseId);
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
                    string defaultlibraryname = "KASNEB%20ESS/";
                    string customlibraryname = "StudentPortal/Registration";
                    string sharepointLibrary = defaultlibraryname + customlibraryname;
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

                                var sDocName = UploadRegistration(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddRegistrationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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
                string defaultlibraryname = "KASNEB%20ESS/";
                string customlibraryname = "StudentPortal/Registration";
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

                                var sDocName = UploadRegistration(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                                string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                                if (!string.IsNullOrEmpty(sDocName))
                                {
                                    var status = new Config().ObjNav().AddRegistrationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
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
        //protected void uploadDocument_Click(object sender, EventArgs e)
        //{

        //    bool fileuploadSuccess = false;
        //    string sUrl = ConfigurationManager.AppSettings["S_URL"];
        //    string defaultlibraryname = "Student%20Portal/";
        //    string customlibraryname = "KASNEB/Registration";
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
        //            Uri uri = new Uri(sUrl);
        //            string sSpSiteRelativeUrl = uri.AbsolutePath;
        //            string uploadfilename = leaveNo + "_" + document.FileName;
        //            Stream uploadfileContent = document.FileContent;

        //            var sDocName = UploadRegistration(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

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





        //  }


        protected void UploadCertificate_Click(object sender, EventArgs e)
        {

            bool fileuploadSuccess = false;
            string sUrl = ConfigurationManager.AppSettings["S_URL"];
            string defaultlibraryname = "Student%20Portal/";
            string customlibraryname = "KASNEB/DisabilityCertificate";
            string sharepointLibrary = defaultlibraryname + customlibraryname;
            String leaveNo = Request.QueryString["applicationNo"];
            Boolean error = false;
            String message = "";

            string username = ConfigurationManager.AppSettings["S_USERNAME"];
            string password = ConfigurationManager.AppSettings["S_PWD"];
            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
            if (FileUpload.HasFile == false)
            {
                error = true;
                message = "Please select file to upload";
            }
            if (error == true)
            {
                challenge.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

            
            bool bbConnected = Config.Connect(sUrl, username, password, domainname);



            try
            {
                if (bbConnected)
                {
                    Uri uri = new Uri(sUrl);
                    string sSpSiteRelativeUrl = uri.AbsolutePath;
                    FileInfo fi = new FileInfo(FileUpload.FileName);

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
                        challenge.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {

                        string uploadfilename = leaveNo + "_" + FileUpload.FileName;
                        Stream uploadfileContent = FileUpload.FileContent;



                        var sDocName = UploadDisabilityCertificate(uploadfileContent, uploadfilename, sSpSiteRelativeUrl, sharepointLibrary, leaveNo);

                        string sharepointlink = sUrl + sharepointLibrary + "/" + leaveNo + "/" + uploadfilename;

                        if (!string.IsNullOrEmpty(sDocName))
                        {
                            var status = new Config().ObjNav().AddRegistrationSharepointLinks(leaveNo, uploadfilename, sharepointlink);
                            string[] info = status.Split('*');
                            if (info[0] == "success")
                            {
                                challenge.InnerHtml = "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            else
                            {
                                challenge.InnerHtml =
                                    "<div class='alert alert-danger'>'" + info[1] + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }

                        }
                        else
                        {
                            challenge.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        }

                    }
                }
                else
                {
                    challenge.InnerHtml = "<div class='alert alert-danger'>Sorry, There was an Error Connecting to the Electronic Document Management System. Kindly Contact ICT for more Information<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }
            catch (Exception ex)
            {
                challenge.InnerHtml =
                                "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }






        }

        public string UploadDisabilityCertificate(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "KASNEB/DisabilityCertificate";
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

        public static string UploadRegistration(Stream fs, string sFileName, string sSpSiteRelativeUrl, string sLibraryName, string leaveNo)
        {
            string sDocName = string.Empty;
            // leaveNo = Request.QueryString["applicationNo"];

            string parent_folderName = "StudentPortal/Registration";
            string subFolderName = leaveNo;
            string filelocation = sLibraryName + "/" + subFolderName;
            try
            {
                // if a folder doesn't exists, create it
                var listTitle = "KASNEB ESS";
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
                    var parentFolderName = @"KASNEB%20ESS/StudentPortal/Registration/";
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

        protected void next_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string applicationNo = Request.QueryString["applicationNo"];

            Response.Redirect("StudentRegistration.aspx?step=5&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void previous_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            string applicationNo = Request.QueryString["applicationNo"];

            var nav = Config.ReturnNav();
            var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo);
            foreach (var descript in studentProcessing)
            {

                if (descript.Disabled == true)
                {
                    Response.Redirect("StudentRegistration.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
                }


                else
                {
                    Response.Redirect("StudentRegistration.aspx?step=2&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
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

                    String status = new Config().ObjNav().FnSubmitApplication(tapplicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {

                        submit.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                        submitRegistration.Visible = false;
                        SubmitPrevious.Visible = false;
                        var nav = Config.ReturnNav();
                        var detailz = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == tapplicationNo).ToList();
                        if (detailz.Count > 0)
                        {
                            Payment.Visible = false;
                        }
                        else
                        {
                            Payment.Visible = true;
                        }
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


        protected void Unnamed_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            string applicationNo = Request.QueryString["applicationNo"];


            Response.Redirect("StudentRegistration.aspx?step=4&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void adddisability_Click(object sender, EventArgs e)
        {

            try
            {


                var applicationNo = Request.QueryString["applicationNo"];
                string tDisabilitytype = disabilitytype.SelectedValue.Trim();
                string tdisabilityDescription = disabilitdescription.Text.Trim();
                string certNo = string.IsNullOrEmpty(TextBox1.Text).ToString();



                string response = new Config().ObjNav().FnAddDisability(applicationNo, tDisabilitytype, tdisabilityDescription);

                String[] info = response.Split('*');
                if (info[0] == "success")
                {

                    challenge.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


                }
            }

            catch (Exception m)
            {
                challenge.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }



        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("StudentRegistration.aspx?step=2&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void invoice_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            //string studentNo = Convert.ToString(Session["studentNo"]);
            string applicationNo = Request.QueryString["applicationNo"];

            Response.Redirect("StudentRegistration.aspx?step=4&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
        }

        protected void disabilitytype_SelectedIndexChanged(object sender, EventArgs e)
        {
            var type = disabilitytype.SelectedValue.Trim();
            var nav = Config.ReturnNav();
            var physicalChallenge = nav.studentdisability.Where(r => r.Code == type);
            foreach (var challenge in physicalChallenge)
            {
                disabilitdescription.Text = challenge.Description;
                //courseId.Text = myexamID.Course_ID;
            }
        }


        protected void deleteorganization_Click(object sender, EventArgs e)
        {
            try
            {
                String tFileName = filename2.Text.Trim();
                String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Student Processing Header/";
                String applicationNo = Request.QueryString["applicationNo"];
                applicationNo = applicationNo.Replace('/', '_');
                applicationNo = applicationNo.Replace(':', '_');
                String documentDirectory = filesFolder + applicationNo + "/";
                String myFile = documentDirectory + tFileName;
                if (System.IO.File.Exists(myFile))
                {
                    System.IO.File.Delete(myFile);
                    if (System.IO.File.Exists(myFile))
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-danger'>The file could not be deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        linesFeedback.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>A file with the given name does not exist in the server <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }



            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            }
        }

        protected void Payment_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("PaymentInvoice.aspx?applicationNo=" + applicationNo);
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
                string status = new Config().ObjNav().ConfirmPaymentStudentRegistration(applicationnumber, paymentsDocUploaded, paymentreference, "", mode);
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
                    if (_mobileNumber.Length != 10)
                    {
                        error = true;
                        message = "Please enter A valid Phone Number Number";


                    }

                    if (error)
                    {
                        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                    String applicationNo = Request.QueryString["applicationNo"];
                    var nav = Config.ReturnNav();
                    
                    var detailz = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == applicationNo).ToList();
                    if (detailz.Count > 0)
                    {

                        response = ("You have already paid for the Registartion. please wait for the processing of your application.");
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

                                response = (details.ResponseDescription + "." + " " + "You have initiated payment using MPESA. Please enter your MPESA PIN when prompted");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);

                                //string responses = new Config().ObjNav().FnConfirmPayments(applicationNo);
                                ////string response = "";

                                //String[] info = responses.Split('*');
                                //if (info[0] == "success")
                                //{

                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //    ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "redirectJS", "setTimeout(function() { window.location.replace('Dashboard.aspx') }, 5000);", true);
                                //    // Response.Redirect("Dashboard.aspx");

                                //}
                                //else
                                //{
                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //}


                            }
                            else
                            {
                                response = (details.ResponseDescription + "." + "" + "Please Use the Manual Mpesa Payment Process");
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


        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            String kenyaCountry = DropDownList1.SelectedValue.Trim();
            if (kenyaCountry == "KE")
            {
                LocalAddress.Visible = true;
            }
            else
            {
                LocalAddress.Visible = false;
            }
            //updPanel1.Update();
        }

        protected void AdditionalNext_Click(object sender, EventArgs e)
        {

            string isDisabled = disabledchallenge.SelectedValue.Trim();

            if (isDisabled == "1")
            {


                string courseId = Convert.ToString(Session["courseId"]);

                if (string.IsNullOrEmpty(courseId))
                {
                    courseId = Request.QueryString["courseId"];
                }

                string studentNo = Convert.ToString(Session["studentNo"]);
                var applicationNo = Request.QueryString["applicationNo"];
                Response.Redirect("StudentRegistration.aspx?step=4&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
            }
            else if (isDisabled == "2")
            {
                string courseId = Convert.ToString(Session["courseId"]);
                if (string.IsNullOrEmpty(courseId))
                {
                    courseId = Request.QueryString["courseId"];
                }
                string studentNo = Convert.ToString(Session["studentNo"]);
                var applicationNo = Request.QueryString["applicationNo"];
                Response.Redirect("StudentRegistration.aspx?step=3&&courseId=" + courseId + "&&applicationNo=" + applicationNo);
            }
            else
            {
                string m = "Please select";
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

        }

        protected void EditDetails_Click(object sender, EventArgs e)
        {
            try
            {
                string phone = EditPhoneNo.Text.Trim();
                int gender = Convert.ToInt32(editGender.Text.Trim());
                string physical = editPhysical.Text;
                string tDOB = editDob.Text.Trim();
                DateTime dateofbirth = Convert.ToDateTime(tDOB);
                String applicationNo = originalItemNo.Text.Trim();

                String status = new Config().ObjNav().EditRegistrationApplication(applicationNo, gender, dateofbirth, physical, phone);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }
            catch (Exception m)
            {
                linesFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void deleteDisabilityFile_Click(object sender, EventArgs e)
        {
            var sharepointUrl = ConfigurationManager.AppSettings["S_URL"]; try
            {
                using (ClientContext ctx = new ClientContext(sharepointUrl))
                {

                    string password = ConfigurationManager.AppSettings["S_PWD"];
                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                    var secret = new SecureString();
                    var parentFolderName = @"Student%20Portal/KASNEB/DisabilityCertificate/";
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

                        string filePath = sSpSiteRelativeUrl + parentFolderName + leaveNo + "/" + deletedisability.Text;

                        var file = ctx.Web.GetFileByServerRelativeUrl(filePath);
                        ctx.Load(file, f => f.Exists);
                        file.DeleteObject();
                        ctx.ExecuteQuery();

                        if (!file.Exists)
                            throw new FileNotFoundException();
                        challenge.InnerHtml = "<div class='alert alert-success'>The file was successfully deleted <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    catch (Exception ex)
                    {
                        // ignored
                        challenge.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "'<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }

            }
            catch (Exception ex)
            {
                challenge.InnerHtml = "<div class='alert alert-danger'>'" + ex.Message + "' <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                //throw;
            }

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
