using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class exemptionsApplications : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["idNumber"]))
            {

                if (string.IsNullOrEmpty((string)Session["studentNo"]))
                {
                    // ScriptManager.RegisterStartupScript(this, this.GetType(), "showalert", "register(); window.location='" + Request.ApplicationPath + "registrationInstructions.aspx';", true);
                    Div1.InnerHtml = "<div class='alert alert-danger'> Please Register for a kasneb Course.<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }

            else if (Session["studentNo"] != null)
            {

            }
        }
    }
}