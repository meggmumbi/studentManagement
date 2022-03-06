using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Renewal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string name = Convert.ToString(Session["StudentName"]);
                // custName.Text = name;
                decimal balance = 0;
                decimal Applicationamount = 0;
                decimal totalAmount;
                decimal ReactvationAmount = 0;
                string studentNumb = Convert.ToString(Session["idNumber"]);
                var nav = Config.ReturnNav();

                int renewalAmounts = 0;
                decimal amount=  1600;
                RenewalYr.Text = Convert.ToString(renewalAmounts);
                RenAmount.Text = Convert.ToString(amount);
             
                string cust = Convert.ToString(Session["StudentNo"]);
                InvoiceNo.Text = Request.QueryString["applicationNo"];
               string applicationNo = Request.QueryString["applicationNo"];




                string studentN = Convert.ToString(Session["studentNo"]);
                
                var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentN).ToList();
                foreach (var regNumbers in registrationNo)
                {

                    regNos.Text = regNumbers.Registration_No;

                }

                
                var templates = nav.DocumentsTemplate.Where(r => r.Blocked == false);
                string regnumber = regNos.Text;
                var examinationAccounts = nav.ExaminationAccounts.Where(x => x.Registration_No == regnumber && x.Renewal_Amount>0);
                foreach (var Ren in examinationAccounts)
                {
                    renewalAmount.Text = Convert.ToString(Ren.Renewal_Amount);
                    reACtivation.Text = Convert.ToString(Ren.Re_Activation_Amount);
                    renPends.Text = Convert.ToString(Ren.Renewal_Pending);
                    int x = Convert.ToInt32(Ren.Renewal_Amount);
                    int y = Convert.ToInt32(Ren.Re_Activation_Amount);

                    totalAmount = (x + y);
                    ReactvationAmount = Convert.ToDecimal(Ren.Re_Activation_Amount); ;
                    //Amount.Text = Convert.ToString(totalAmount);
                    //AmountInstructions.InnerText = Convert.ToString(totalAmount);
                    //totalAmounts.InnerText = Convert.ToString(totalAmount);
                    totalAmt.Text = Convert.ToString(totalAmount);
                    RenReact.Text = Convert.ToString(totalAmount);


                }
                var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Student_No == studentN && r.Document_Type == "Renewal").ToList();
                if (studentProcessing.Count > 0)
                {
                    foreach (var descript in studentProcessing)
                    {

                        Applicationamount = Convert.ToDecimal(descript.Renewal_Amount);
                    }

                }
                var customer = nav.Instcustomers.Where(r => r.ID_No == studentNumb).ToList();
                if (customer.Count > 0)
                {
                    foreach (var custBalance in customer)
                    {
                        balance = Convert.ToDecimal(custBalance.Balance_LCY);
                    }
                }
                //Applicationamount = myHiddenId.Value== "" ? 0 : Convert.ToDecimal(myHiddenId.Value);

                totalAmount = balance + Applicationamount;
                Amount.Text = Convert.ToString(totalAmount);
                AmountInstructions.InnerText = Convert.ToString(totalAmount);
                AmountInstructionsManual.InnerText = Convert.ToString(totalAmount);
                //RenReact.Text = Convert.ToString(totalAmount);
                //totalAmounts.InnerText =totalAmt.Text;
                //foreach (var templ in templates)
                //{
                //    template.Text = templ.Code;
                //}

                //string courseId = Request.QueryString["courseId"];
                //var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Renewal" && r.Examiantion_ID == courseId);
                //DocType.DataSource = details;
                //DocType.DataTextField = "Examination_Document";
                //DocType.DataValueField = "Examination_Document_Type";
                //DocType.DataBind();
                //DocType.Items.Insert(0, new ListItem("--select--", ""));

            }
        }

        protected void generate_Click(object sender, EventArgs e)
        {
            //feedback.InnerHtml = "";

            //Boolean Error = false;

            //try
            //{

            //}

            //catch (Exception)
            //{
            //    Error = true;
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}

            //try
            //{

            //}
            //catch (Exception)
            //{
            //    Error = true;
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
            //if (!Error)
            //{
            //    try
            //    {

            //        String studentNumber = invoiceNumber.Text.Trim();
            //        String invoiceNo = invoiceNumber.SelectedValue.Trim();
            //        String status = new Config().ObjNav().PrintInvoiceBooking(invoiceNo, studentNumber);
            //        String[] info = status.Split('*');
            //        if (info[0] == "success")
            //        {
            //            p9form.Attributes.Add("src", ResolveUrl(info[1]));
            //        }
            //        else
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //    }
            //    catch (Exception t)
            //    {
            //        feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }

            //}
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            //string applicationNo = Request.QueryString["applicationNo"];
            //string studentNo = invoiceNumber.Text.Trim();

            //Response.Redirect("pendingPaymentBooking.aspx?applicationNo=" + applicationNo + "&&studentNo=" + studentNo);
        }

        protected void invoiceNumber_SelectedIndexChanged(object sender, EventArgs e)
        {
            //feedback.InnerHtml = "";

            //Boolean Error = false;

            //try
            //{

            //}

            //catch (Exception)
            //{
            //    Error = true;
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}

            //try
            //{

            //}
            //catch (Exception)
            //{
            //    Error = true;
            //    feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
            //if (!Error)
            //{
            //    try
            //    {
                    
            //        String invoiceNo = invoiceNumber.Text.Trim();
            //        String studentNumber = Convert.ToString(Session["StudentNo"]);
            //        String status = new Config().ObjNav().PrintInvoiceBooking(invoiceNo, studentNumber);
            //        String[] info = status.Split('*');
            //        if (info[0] == "success")
            //        {
            //            p9form.Attributes.Add("src", ResolveUrl(info[1]));
            //        }
            //        else
            //        {
            //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }
            //    }
            //    catch (Exception t)
            //    {
            //        feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }

            //}
        }

        protected void renew_Click(object sender, EventArgs e)
        {
            try
            {
                decimal amount=0;
                String StudentNumb = Convert.ToString(Session["studentNo"]);
                string regnos = regNos.Text;

                string amt = totalAmt.Text.Trim();

                //DateTime myOrderDate = new DateTime();
                Boolean error = false;
                String message = "";
                if ((string.IsNullOrEmpty(amt)))
                {
                    error = true;
                    message = "Please enter the number of years you are applying for renewal";
                }
                amount = amt== "" ? 0 : Convert.ToDecimal(amt);
                if (error)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }


                else
                {
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
                    String status = new Config().ObjNav().CreateRenewal(applicationNo, StudentNumb, regnos, amount);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        if (newApplicationNo)
                        {
                            applicationNo = info[2];

                        }
                        Response.Redirect("RenewalInvoice.aspx?applicationNo=" + applicationNo);
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }

                }
            }

            catch (Exception m)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Renewal.aspx?step=1&&applicationNo=" + applicationNo);
        }

        protected void sendApproval_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());
               
            //    String regNumber = String.IsNullOrEmpty(regNo.SelectedValue.Trim()) ? "" : regNo.SelectedValue.Trim();
               
            //    decimal tamount =Convert.ToDecimal(amount.Text.Trim());


            //    Boolean error = false;


            //    string studentNo = Convert.ToString(Session["StudentNo"]);
            //    String applicationNo = Request.QueryString["applicationNo"];
            //    // Convert.ToString(Session["employeeNo"]),
            //    //Nav Funtion

            //    String status = new Config().ObjNav().CreateRenewalLine(applicationNo,regNumber, tamount,studentNo);
            //    String[] info = status.Split('*');
            //    if (info[0] == "success")
            //    {

            //        // Response.Redirect("Withdrawal.aspx?step=2&&applicationNo=" + applicationNo);
            //        feedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //    else
            //    {
            //        feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }


            //}
            //catch (Exception n)
            //{
            //    feedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //}
        }

        protected void fileuploads_Click(object sender, EventArgs e)
        {
            //String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Student Processing Header/";

            //if (uploadsDoc.HasFile)
            //{
            //    try
            //    {
            //        if (Directory.Exists(filesFolder))
            //        {
            //            String extension = System.IO.Path.GetExtension(uploadsDoc.FileName);
            //            if (new Config().IsAllowedExtension(extension))
            //            {
            //                String applicationNo = Request.QueryString["applicationNo"];
            //                applicationNo = applicationNo.Replace('/', '_');
            //                applicationNo = applicationNo.Replace(':', '_');
            //                String documentDirectory = filesFolder + applicationNo + "/";
            //                Boolean createDirectory = true;
            //                try
            //                {
            //                    if (!Directory.Exists(documentDirectory))
            //                    {
            //                        Directory.CreateDirectory(documentDirectory);
            //                    }
            //                }
            //                catch (Exception)
            //                {
            //                    createDirectory = false;
            //                    linesFeedback.InnerHtml =
            //                                                    "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
            //                                                    "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                }
            //                if (createDirectory)
            //                {
            //                    string filename = documentDirectory + uploadsDoc.FileName;
            //                    if (File.Exists(filename))
            //                    {
            //                        linesFeedback.InnerHtml =
            //                                                           "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //                    }
            //                    else
            //                    {
            //                        uploadsDoc.SaveAs(filename);
            //                        if (File.Exists(filename))
            //                        {
            //                            linesFeedback.InnerHtml =
            //                                "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                        else
            //                        {
            //                            linesFeedback.InnerHtml =
            //                                "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //                        }
            //                    }
            //                }
            //            }
            //            else
            //            {
            //                linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //            }

            //        }
            //        else
            //        {
            //            linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //        }

            //    }
            //    catch (Exception ex)
            //    {
            //        linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

            //    }
            //}
            //else
            //{
            //    linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //}
        }

        protected void prev_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Renewal.aspx?step=2&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }

        protected void next_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Renewal.aspx?step=4&&courseId=" + courseId + "&&studentNo=" + studentNo);
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
                    var detailz = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Submitted == true && r.Payment_Created == true).ToList();
                    if (detailz.Count > 0)
                    {

                        response = ("You have already paid for the Booking. You can now view your timetable");
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




                            details = JsonConvert.DeserializeObject<Stkresult>(result);



                            if (details.ResponseCode == "0")
                            {

                                response = (details.ResponseDescription + "." + " " + "Please enter your MPESA PIN.");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-success'>" + response + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                string responses = new Config().ObjNav().FnConfirmPayments(applicationNo);
                                //string response = "";

                                String[] info = responses.Split('*');
                                if (info[0] == "success")
                                {

                                    PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                    Response.Redirect("Dashboard.aspx");

                                }
                                else
                                {
                                    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                }
                                Response.Redirect("Dashboard.aspx");

                            }
                            else
                            {
                                response = (details.ResponseDescription + ". " + "" + "Please Use the Manual Mpesa Payment Process");
                                PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + response + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
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



















            //try
            //{



            //    string tphoneNumber = PhoneNumberPay.Text.Trim();
            //    decimal tAmount = Convert.ToDecimal(Amount.Text.Trim());
            //    Boolean error = false;
            //    String message = "";

            //    if (string.IsNullOrEmpty(tphoneNumber))
            //    {
            //        error = true;
            //        message = "Please enter Phone Number used to pay";
            //    }



            //    String applicationNo = Request.QueryString["applicationNo"];




            //    string response = new Config().ObjNav().FnConfirmPayment(applicationNo,tphoneNumber,tAmount);
            //    //string response = "";

            //    String[] info = response.Split('*');
            //    if (info[0] == "success")
            //    {

            //        PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            //    }
            //    else
            //    {
            //        PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    }
            //}
            //catch (Exception m)
            //{
            //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            //    //MessageBox.Show(m.Message);
            //    // ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + m.Message + "');", true);
            //}
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

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Renewal.aspx?step=3&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }
    }
}