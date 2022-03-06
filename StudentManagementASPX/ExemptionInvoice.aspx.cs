using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class ExemptionInvoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string name = Convert.ToString(Session["StudentName"]);
                String applicationNo = Request.QueryString["applicationNo"];
                accreditationnumber.Text = applicationNo;
                var nav = Config.ReturnNav();
                var studentProcessing = nav.StudentProcessing.Where(r => r.No == applicationNo);
                foreach (var descript in studentProcessing)
                {
                    Amount.Text = Convert.ToString(descript.Exemption_Amount);
                    AmountInstructions.InnerText = Convert.ToString(descript.Exemption_Amount);
                    AmountInstructionsManual.InnerText = Convert.ToString(descript.Exemption_Amount);
                }

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

                                //string responses = new Config().ObjNav().FnConfirmPayments(applicationNo);
                                ////string response = "";

                                //String[] info = responses.Split('*');
                                //if (info[0] == "success")
                                //{

                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //    Response.Redirect("Dashboard.aspx");

                                //}
                                //else
                                //{
                                //    PaymentsMpesa.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                //}



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
    }
}