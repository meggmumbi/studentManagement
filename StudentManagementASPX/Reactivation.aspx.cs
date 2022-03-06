using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Reactivation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string name = Convert.ToString(Session["StudentName"]);
               

                string studentNumb = Convert.ToString(Session["idNumber"]);
                var nav = Config.ReturnNav();
                var studentNumber = nav.StudentProcessing.Where(r => r.Student_No == studentNumb && r.Document_Type == "Registration");
            

               

                string studentN = Convert.ToString(Session["studentNo"]);
                var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentN);
                regNo.DataSource = registrationNo;
                regNo.DataTextField = "Course_ID";
                regNo.DataValueField = "Registration_No";
                regNo.DataBind();
                regNo.Items.Insert(0, new ListItem("--select--", ""));

                var templates = nav.DocumentsTemplate.Where(r => r.Blocked == false);
                foreach (var templ in templates)
                {
                    template.Text = templ.Code;
                }

                string courseId = Request.QueryString["courseId"];
                var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Reactive" && r.Examiantion_ID == courseId);
                DocType.DataSource = details;
                DocType.DataTextField = "Examination_Document";
                DocType.DataValueField = "Examination_Document_Type";
                DocType.DataBind();
                DocType.Items.Insert(0, new ListItem("--select--", ""));

            }
        }

        //protected void generate_Click(object sender, EventArgs e)
        //{
        //    feedback.InnerHtml = "";

        //    Boolean Error = false;

        //    try
        //    {

        //    }

        //    catch (Exception)
        //    {
        //        Error = true;
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }

        //    try
        //    {

        //    }
        //    catch (Exception)
        //    {
        //        Error = true;
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //    if (!Error)
        //    {
        //        try
        //        {

        //            String studentNumber = invoiceNumber.Text.Trim();
        //            String invoiceNo = invoiceNumber.SelectedValue.Trim();
        //            String status = new Config().ObjNav().PrintInvoiceBooking(invoiceNo, studentNumber);
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                p9form.Attributes.Add("src", ResolveUrl(info[1]));
        //            }
        //            else
        //            {
        //                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //        catch (Exception t)
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //        }

        //    }
        //}

        //protected void Unnamed_Click(object sender, EventArgs e)
        //{
        //    string applicationNo = Request.QueryString["applicationNo"];
        //    string studentNo = invoiceNumber.Text.Trim();

        //    Response.Redirect("pendingPaymentBooking.aspx?applicationNo=" + applicationNo + "&&studentNo=" + studentNo);
        //}

        //protected void invoiceNumber_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    feedback.InnerHtml = "";

        //    Boolean Error = false;

        //    try
        //    {

        //    }

        //    catch (Exception)
        //    {
        //        Error = true;
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }

        //    try
        //    {

        //    }
        //    catch (Exception)
        //    {
        //        Error = true;
        //        feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //    if (!Error)
        //    {
        //        try
        //        {

        //            String invoiceNo = invoiceNumber.Text.Trim();
        //            String studentNumber = Convert.ToString(Session["StudentNo"]);
        //            String status = new Config().ObjNav().PrintInvoiceBooking(invoiceNo, studentNumber);
        //            String[] info = status.Split('*');
        //            if (info[0] == "success")
        //            {
        //                p9form.Attributes.Add("src", ResolveUrl(info[1]));
        //            }
        //            else
        //            {
        //                feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }
        //        }
        //        catch (Exception t)
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //        }

        //    }
        //}

        //protected void renew_Click(object sender, EventArgs e)
        //{
        //    try
        //    {

        //        String StudentNumb = StudentNo.Text.Trim();

        //        //DateTime myOrderDate = new DateTime();
        //        Boolean error = false;
        //        String message = "";


        //        /*
        //        Session["employeeNo"] = user.employeeNo;
        //        */
        //        String applicationNo = "";
        //        Boolean newApplicationNo = false;
        //        try
        //        {

        //            //applicationNo = Request.QueryString["applicationNo"];
        //            if (String.IsNullOrEmpty(applicationNo))
        //            {
        //                applicationNo = "";
        //                newApplicationNo = true;
        //            }
        //        }
        //        catch (Exception)
        //        {

        //            applicationNo = "";
        //            newApplicationNo = true;
        //        }
        //        String status = new Config().ObjNav().CreateReactivation(applicationNo, StudentNumb);
        //        String[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {
        //            if (newApplicationNo)
        //            {
        //                applicationNo = info[2];

        //            }
        //            Response.Redirect("Reactivation.aspx?step=2&&applicationNo=" + applicationNo);
        //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //        }
        //        else
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }

        //    }

        //    catch (Exception m)
        //    {
        //        feedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        //protected void previous_Click(object sender, EventArgs e)
        //{
        //    string applicationNo = Request.QueryString["applicationNo"];
        //    Response.Redirect("Reactivation.aspx?step=1&&applicationNo=" + applicationNo);
        //}

        //protected void sendApproval_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        // int tItemType = Convert.ToInt32(itemType.SelectedValue.Trim());

        //        String regNumber = String.IsNullOrEmpty(regNo.SelectedValue.Trim()) ? "" : regNo.SelectedValue.Trim();

        //        decimal tamount = Convert.ToDecimal(amount.Text.Trim());


        //        Boolean error = false;


        //        string studentNo = Convert.ToString(Session["StudentNo"]);
        //        String applicationNo = Request.QueryString["applicationNo"];
        //        // Convert.ToString(Session["employeeNo"]),
        //        //Nav Funtion

        //        String status = new Config().ObjNav().CreateReactivationLine(applicationNo, regNumber, tamount, studentNo);
        //        String[] info = status.Split('*');
        //        if (info[0] == "success")
        //        {

        //            // Response.Redirect("Withdrawal.aspx?step=2&&applicationNo=" + applicationNo);
        //            feedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //        }
        //        else
        //        {
        //            feedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //        }


        //    }
        //    catch (Exception n)
        //    {
        //        feedback.InnerHtml = "<div class='alert alert-danger'>" + n.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //    }
        //}

        //protected void fileuploads_Click(object sender, EventArgs e)
        //{
        //    String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Student Processing Header/";

        //    if (uploadsDoc.HasFile)
        //    {
        //        try
        //        {
        //            if (Directory.Exists(filesFolder))
        //            {
        //                String extension = System.IO.Path.GetExtension(uploadsDoc.FileName);
        //                if (new Config().IsAllowedExtension(extension))
        //                {
        //                    String applicationNo = Request.QueryString["applicationNo"];
        //                    applicationNo = applicationNo.Replace('/', '_');
        //                    applicationNo = applicationNo.Replace(':', '_');
        //                    String documentDirectory = filesFolder + applicationNo + "/";
        //                    Boolean createDirectory = true;
        //                    try
        //                    {
        //                        if (!Directory.Exists(documentDirectory))
        //                        {
        //                            Directory.CreateDirectory(documentDirectory);
        //                        }
        //                    }
        //                    catch (Exception)
        //                    {
        //                        createDirectory = false;
        //                        linesFeedback.InnerHtml =
        //                                                        "<div class='alert alert-danger'>We could not create a directory for your documents. Please try again" +
        //                                                        "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //                    }
        //                    if (createDirectory)
        //                    {
        //                        string filename = documentDirectory + uploadsDoc.FileName;
        //                        if (File.Exists(filename))
        //                        {
        //                            linesFeedback.InnerHtml =
        //                                                               "<div class='alert alert-danger'>A document with the given name already exists. Please delete it before uploading the new document or rename the new document<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //                        }
        //                        else
        //                        {
        //                            uploadsDoc.SaveAs(filename);
        //                            if (File.Exists(filename))
        //                            {
        //                                linesFeedback.InnerHtml =
        //                                    "<div class='alert alert-success'>The document was successfully uploaded. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                            }
        //                            else
        //                            {
        //                                linesFeedback.InnerHtml =
        //                                    "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                            }
        //                        }
        //                    }
        //                }
        //                else
        //                {
        //                    linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document's file extension is not allowed. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //                }

        //            }
        //            else
        //            {
        //                linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document's root folder defined does not exist in the server. Please contact support. <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
        //            }

        //        }
        //        catch (Exception ex)
        //        {
        //            linesFeedback.InnerHtml = "<div class='alert alert-danger'>The document could not be uploaded. Please try again <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

        //        }
        //    }
        //    else
        //    {
        //        linesFeedback.InnerHtml = "<div class='alert alert-danger'>Please select the document to upload. (or the document is empty) <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";


        //    }
        //}

        protected void prev_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Reactivation.aspx?step=2&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }

        protected void next_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Reactivation.aspx?step=4&&courseId=" + courseId + "&&studentNo=" + studentNo);
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

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Reactivation.aspx?step=3&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }

        protected void nextAttach_Click(object sender, EventArgs e)
        {
            string courseId = Request.QueryString["courseId"];
            string studentNo = Convert.ToString(Session["studentNo"]);

            Response.Redirect("Reactivation.aspx?step=3&&courseId=" + courseId + "&&studentNo=" + studentNo);
        }
    }
}