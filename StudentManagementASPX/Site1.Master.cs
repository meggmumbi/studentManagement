using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty((string)Session["idNumber"]))
            {

                Response.Redirect("Login.aspx");


            }
            else if (Session["idNumber"] != null)
            {
                imgviews.DataBind();
                Image1.DataBind();
                Image2.DataBind();

              if(Session["studentNo"] != null) { 
                var nav = Config.ReturnNav();
                string studentNos = Convert.ToString(Session["studentNo"]);
                var registrationNo = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNos && r.Status=="Active").ToList();
                    foreach (var regNumbers in registrationNo)
                    {

                        regNo.InnerText = regNumbers.Registration_No;
                    }
               }

            }

        }
    }
}