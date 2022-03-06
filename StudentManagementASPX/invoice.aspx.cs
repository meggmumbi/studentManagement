using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class invoice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                string name = Convert.ToString(Session["StudentName"]);
                custName.Text = name;

                string student = Convert.ToString(Session["studentNo"]);
                invoiceNumber.Text = student;
            }
        }

        protected void generate_Click(object sender, EventArgs e)
        {
            feedback.InnerHtml = "";

            Boolean Error = false;

            try
            {

            }

            catch (Exception)
            {
                Error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid start date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }

            try
            {

            }
            catch (Exception)
            {
                Error = true;
                feedback.InnerHtml = "<div class='alert alert-danger'>Please provide a valid end date<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            if (!Error)
            {
                try
                {

                    String studentNumber = invoiceNumber.Text.Trim();
                    string applicationNo = Request.QueryString["applicationNo"];
                    String status = new Config().ObjNav().PrintInvoice(studentNumber, applicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        p9form.Attributes.Add("src", ResolveUrl(info[1]));
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }

            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"];
            string studentNo = Request.QueryString["studentNo"];

            Response.Redirect("pendingPayment.aspx?applicationNo=" + applicationNo + "&&studentNo=" + studentNo);
        }
    }
}