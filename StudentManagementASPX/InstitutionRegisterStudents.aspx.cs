using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class InstitutionRegisterStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var nav = Config.ReturnNav();
                var institutions = nav.Instcustomers;
                institution.DataSource = institutions;
                institution.DataTextField = "Name";
                institution.DataValueField = "No";
                institution.DataBind();
                institution.Items.Insert(0, new ListItem("--select--", ""));
               

                var currenctHead = nav.currency;
                currency.DataSource = currenctHead;
                currency.DataTextField = "Code";
                currency.DataValueField = "Code";
                currency.DataBind();
                currency.Items.Insert(0, new ListItem("--select--", ""));

                var currenctLines = nav.currency;
                currencyLine.DataSource = currenctLines;
                currencyLine.DataTextField = "Code";
                currencyLine.DataValueField = "Code";
                currencyLine.DataBind();
                currencyLine.Items.Insert(0, new ListItem("--select--", ""));
                

                var counties = nav.counties;
                county.DataSource = counties;
                county.DataTextField = "Description";
                county.DataValueField = "Code";
                county.DataBind();
                county.Items.Insert(0, new ListItem("--select--", ""));


                var postalAddress = nav.postcodes;
                postal.DataSource = postalAddress;
                postal.DataTextField = "Code";
                postal.DataValueField = "Code";
                postal.DataBind();
                postal.Items.Insert(0, new ListItem("--select--", ""));

                var ExamCycles = nav.ExamCycle;
                examCylce.DataSource = ExamCycles;
                examCylce.DataTextField = "examCycle";
                examCylce.DataValueField = "examCycle";
                examCylce.DataBind();
                examCylce.Items.Insert(0, new ListItem("--select--", ""));

                //var paper = nav.exapPaper;
                //exam.DataSource = paper;
                //exam.DataTextField = "Description";
                //exam.DataValueField = "Job_Task_No";
                //exam.DataBind();
                //exam.Items.Insert(0, new ListItem("--select--", ""));

                var examcenters = nav.ExamCenters;
                examCenter.DataSource = examcenters;
                examCenter.DataTextField = "Name";
                examCenter.DataValueField = "Code";
                examCenter.DataBind();
                examCenter.Items.Insert(0, new ListItem("--select--", ""));

                var qualifications = nav.qualification;
                txteducationallevel.DataSource = qualifications;
                txteducationallevel.DataTextField = "Code";
                txteducationallevel.DataValueField = "Code";
                txteducationallevel.DataBind();
                txteducationallevel.Items.Insert(0, new ListItem("--select--", ""));

            }
        }
        protected void postal_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            var cities = nav.postcodes.Where(r => r.Code == postal.SelectedValue);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
            }

        }

        protected void btn_personalinformations_Click(object sender, EventArgs e)
        {
            try
            {
                string tfname = firstName.Text.Trim();
                string tmiddelname = middlename.Text.Trim();
                string tlastName = lastName.Text.Trim();
                string tIdNumber = idnumber.Text.Trim();
                string temail = email.Text.Trim();
                string tphoneNumber = phoneNumber.Text.Trim();
                string taddress = address.Text.Trim();
                string tcounty = county.SelectedValue.Trim();
                string tpostal = postal.SelectedValue.Trim();
                string tcity = city.Text.Trim();
                int gender = Convert.ToInt32(txtgender.SelectedValue.Trim());
                string tDOB = dob.Text.Trim();
                string education = txteducationallevel.SelectedValue.Trim();
                string texam = exam.SelectedValue.Trim();
                string texamCycle = examCylce.SelectedValue.Trim();
                string tExamCenter = examCenter.SelectedValue.Trim();
                string tDisabled = disabled.SelectedValue.Trim();
                string tdisabledcert = txtdisabilitycertificateNumber.Text.Trim();
                string tcurrency = currencyLine.SelectedValue.Trim();
                //string tproject = examProject.SelectedValue.Trim();
                DateTime dateofbirth;
                CultureInfo usCulture = new CultureInfo("es-ES");
                dateofbirth = DateTime.Parse(tDOB, usCulture.DateTimeFormat);
                Boolean error = false;
                String message = "";

                if (error)
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {
                   
                 

                      string  applicationNo = Request.QueryString["applicationNo"];

                    //string userCode = Convert.ToString(Session["Code"]);
                    //string password = Convert.ToString(Session["Password"]);
                    string response =new Config().ObjNav().FnInstitutionStudentRegistration(applicationNo, tlastName, tfname, tmiddelname, gender, tIdNumber, dateofbirth, tcounty, taddress, tDisabled,
                        tpostal, temail, tcity, tExamCenter, texam, tphoneNumber, education, texamCycle, tcurrency);

                    String[] info = response.Split('*');
                    
                      
                        linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                 

                }
            }
            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }

        protected void previous_Click(object sender, EventArgs e)
        {
            Response.Redirect("InstitutionRegisterStudents.aspx?step=1");
        }

        protected void next_Click(object sender, EventArgs e)
        {

            try
            {
              

                // String Worktype = worktype.Text.Trim();
                int documentType = Convert.ToInt32(docType.SelectedValue.Trim());
                String tinstitution = institution.SelectedValue.Trim();
                
                
                string currencys = currency.SelectedValue.Trim();
               
                //DateTime myOrderDate = new DateTime();
                Boolean error = false;
                String message = "";


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
                String status = new Config().ObjNav().InstitutionRegistartionHeader(documentType, tinstitution, currencys, applicationNo);
                String[] info = status.Split('*');
                if (info[0] == "success")
                {
                    if (newApplicationNo)
                    {
                        applicationNo = info[2];
                        var nav = Config.ReturnNav();
                        var bulk = nav.BulkProcessHeader.Where(r=>r.No== applicationNo);
                        foreach (var bulks in bulk)
                        {
                            Session["institution"] = bulks.Institution_No;
                        }

                    }
                    //Response.Redirect("ExamBooking.aspx?step=2&&applicationNo=" + applicationNo);
                    linesFeedback.InnerHtml = "<div class='alert alert-" + info[0] + " '>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                }
                else
                {
                    generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }

            }

            catch (Exception m)
            {
                generalFeedback.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }




        }
    }
}