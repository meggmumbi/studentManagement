using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class pendingPaymentBooking : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var payment = nav.paymentMode;
                paymentsM.DataSource = payment;
                paymentsM.DataTextField = "Code";
                paymentsM.DataValueField = "Code";
                paymentsM.DataBind();

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
                            if (File.Exists(folderName + filename))
                            {
                                File.Delete(folderName + filename);
                            }
                            paymentdocument.SaveAs(folderName + filename);
                            if (File.Exists(folderName + filename))
                            {
                                paymentsDocUploaded = true;
                            }
                        }
                        else
                        {
                            feedback.InnerHtml = ("The file extension of the payment document is not allowed");
                        }

                    }
                }
                catch (Exception)
                {
                    feedback.InnerHtml = ("The Payments Details Could Not Be Captured Kindly Contact the System Administrator");
                }
                string studentNo = studentNUmber.Text.Trim();
                string applicationnumber = accreditationnumber.Text.Trim();
                string paymentreference = paymentsref.Text.Trim();
                string mode = paymentsM.SelectedValue.Trim();
                string status = new Config().ObjNav().ConfirmPaymentsStudentBooking(applicationnumber, paymentsDocUploaded, paymentreference, studentNo, mode);
                string[] info = status.Split('*');
                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


            }
            catch (Exception y)
            {
                feedback.InnerHtml = "<div class='alert alert-danger'>" + y.Message + "</div>";
            }
        }
    }
}