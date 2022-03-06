using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace StudentManagementASPX
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {

            
            if (Session["studentNo"] != null)
            {

                var nav = Config.ReturnNav();
                string idNo = Convert.ToString(Session["idNumber"]);
                var students = nav.Instcustomers.Where(r => r.ID_No == idNo);


                var postalAddress = nav.postcodes;
                postals.DataSource = postalAddress;
                postals.DataTextField = "Code";
                postals.DataValueField = "Code";
                postals.DataBind();
                postals.Items.Insert(0, new ListItem("--select--", ""));

                //var counties = nav.counties;
                //county.DataSource = counties;
                //county.DataTextField = "Description";
                //county.DataValueField = "Code";
                //county.DataBind();
                //county.Items.Insert(0, new ListItem("--select--", ""));

                var country = nav.Countries;
                DropDownList1.DataSource = country;
                DropDownList1.DataTextField = "Name";
                DropDownList1.DataValueField = "Code";
                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, new ListItem("--select--", ""));
             
                phoneNumber.Text = Convert.ToString(Session["PhoneNumber"]);
                email.Text = Convert.ToString(Session["EmailAddress"]);
                idnumber.Text = Convert.ToString(Session["idNumber"]);
                firstName.Text = Convert.ToString(Session["firstName"]);
                middlename.Text = Convert.ToString(Session["MiddleName"]);
                lastName.Text = Convert.ToString(Session["LastName"]);


                    foreach (var student in students)
                    {

                        address.Text = student.Address;
                        address2.Text = student.Address_2;
                        countys.Text = student.County;
                        postals.SelectedValue = student.Post_Code;
                        city.Text = student.City;
                        DropDownList1.SelectedValue = student.Country_Region_Code;




                    }
                    imgviews.DataBind();
            }
            }


        }

        protected void saveDetails_Click(object sender, EventArgs e)
        {

        }

        protected void editbutton_Click(object sender, EventArgs e)
        {
            city.Enabled = true;
            address.Enabled = true;
            address2.Enabled = true;                       
            DropDownList1.Enabled = true;
            phoneNumber.Enabled = true;
            email.Enabled = true;
            saveDetails.Visible = true;
            editbutton.Visible = false;
        }
        protected void postal_SelectedIndexChanged(object sender, EventArgs e)
        {
            var nav = Config.ReturnNav();
            string postalCode = postals.SelectedValue;
            var cities = nav.postcodes.Where(r => r.Code == postalCode);
            foreach (var myCity in cities)
            {
                city.Text = myCity.City;
            }


        }

        protected void saveDetails_Click1(object sender, EventArgs e)
        {
            try
            {
             

                string taddress = address.Text.Trim();
                string taddress2 = address2.Text.Trim();
                string tcity = city.Text;
                string tpostCode = postals.SelectedValue.Trim();
                string tcountry = DropDownList1.SelectedValue.Trim();
                string tphoneNumber = phoneNumber.Text.Trim();
                string temail = email.Text;
              
                String tIdNumber = Convert.ToString(Session["idNumber"]);
                string regNo = "";                
                Boolean error = false;
                String message = "";



                if (error)
                {
                    examcenterz.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
                else
                {


                    var nav = new Config().ObjNav();
                    String status = nav.FnEditProfile(tIdNumber, taddress, taddress2, tcity, tpostCode, tcountry, tphoneNumber, temail, "");
                    String[] info = status.Split('*');
                    if (info[0] == "success")
                    {
                        examcenterz.InnerHtml = "<div class='alert alert-" + info[0] + "'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                    else
                    {
                        examcenterz.InnerHtml = "<div class='alert alert-danger'>" + info[1] + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                    }
                }
            }
            catch (Exception t)
            {
                examcenterz.InnerHtml = "<div class='alert alert-danger'>" + t.Message + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
        }
        protected void uploadphoto_Click(object sender, EventArgs e)
        {


            //murkomen
            string IdNumber = Convert.ToString(Session["idNumber"]);
            string accreditationNo = IdNumber;
            accreditationNo = accreditationNo.Replace('/', '_');
            accreditationNo = accreditationNo.Replace(':', '_');
            string path1 = Config.FilesLocation() + "Student Processing Header/";
            string str1 = Convert.ToString(accreditationNo);
            string folderName = path1 + str1 + "/";
            string message = "";
            Boolean error = false;

            string extension = System.IO.Path.GetExtension(FileUpload1.FileName);
            if (extension == ".png" || extension == ".PNG")
            {
                error = true;
                message = "Please Select a jpg image";

            }
            if (extension == ".jpeg" || extension == ".JPEG")
            {
                error = true;
                message = "Please Select a JPG image";

            }
            if (extension == ".jplg" || extension == ".JPLG")
            {
                error = true;
                message = "Please Select a JPG image";

            }
            if (error)
            {
                examcenterz.InnerHtml = "<div class='alert alert-danger'>" + message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
            }
            else
            {

                try
                {
                    if (FileUpload1.HasFile == false)
                    {
                        examcenterz.InnerHtml = "Kindly upload profile photo before you proceed!";
                    }
                    if (FileUpload1.HasFile)
                    {
                        extension = System.IO.Path.GetExtension(FileUpload1.FileName);


                        //if (extension == ".jpg" || extension == ".JPG")
                        //{
                        string filename1 = accreditationNo + extension;

                        string fullPath = Server.MapPath("~/images/") + "\\" + filename1;

                        if (System.IO.File.Exists(fullPath))
                        {
                            System.IO.File.Delete(fullPath);
                        }


                        FileUpload1.PostedFile.SaveAs(fullPath);


                        //FileUpload1.SaveAs("~/images/" + Path.GetFileName(FileUpload1.FileName));

                        if (!Directory.Exists(folderName))
                        {
                            Directory.CreateDirectory(folderName);
                        }
                        if (System.IO.File.Exists(folderName + filename1))
                        {
                            System.IO.File.Delete(folderName + filename1);


                        }
                        FileUpload1.SaveAs(folderName + filename1);
                        try
                        {
                            string response = new Config().ObjNav().FnUploadProfilePhotoprofile(IdNumber);
                            String[] info = response.Split('*');
                            if (info[0] == "success")
                            {

                                examcenterz.InnerHtml = "<div class='alert alert-success'>" +info[1]+"<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";

                            }
                            else
                            {
                                examcenterz.InnerHtml = "<div class='alert alert-danger'>" + info[1] + "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }
                            

                        }
                        catch (Exception ex)
                        {
                            examcenterz.InnerHtml = "<div class='alert alert-danger'>" + ex.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                        }
                       
                        
                    }


                }
                catch (Exception m)
                {
                    examcenterz.InnerHtml = "<div class='alert alert-danger'>" + m.Message + " <a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                }
            }
        }
    }
}