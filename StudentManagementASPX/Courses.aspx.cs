using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //string courseModal = courseCode.Text.Trim();
                //test.Text = courseModal;
            }
        }

        protected void Next_Click(object sender, EventArgs e)
        {
            Response.Redirect("registrationInstructions.aspx");
        }
    }
}