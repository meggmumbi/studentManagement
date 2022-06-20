using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class DiffermentPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    string applicationNo = Request.QueryString["applicationNo"];
                    string InvoiceNo = Request.QueryString["invoiceNo"];
                    string studentNo = Convert.ToString(Session["studentNo"]);
                    string status = new Config().ObjNav().DeffermentInvoice(applicationNo);
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        p9form.Attributes.Add("src", ResolveUrl(info[1]));
                    }
                    else
                    {
                        feedback.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] +
                                             "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
                catch (Exception t)
                {
                    feedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                         "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
            }

        }

        protected void PaymentMode_Click(object sender, EventArgs e)
        {
            string applicationNo = Request.QueryString["applicationNo"];
            Response.Redirect("Defferment.aspx?step=4&&applicationNo=" + applicationNo);

        }
    
    }
}