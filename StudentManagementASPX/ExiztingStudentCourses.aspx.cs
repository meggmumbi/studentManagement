using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class ExiztingStudentCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var courses = nav.ExamSittingCycle.Where(r => r.Sitting_Status == "Active");
                int counter = 0;
                foreach (var Coursez in courses)
                {
                    Cycle.Text = Coursez.Sitting_Cycle;
                    projectCode.Text = Coursez.Examination_Project_ID;

                }
            }
        }

        protected void Next_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {

                Response.Redirect("StudentRegistration.aspx");
            }
            else if (Session["studentNo"] != null)
            {
                Response.Redirect("ExistingStudents.aspx");
            }

        }
        }
}