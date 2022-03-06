<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentRegistration.aspx.cs" Inherits="StudentManagementASPX.StudentRegistration" %>

<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="assets/css/sweetalert2.all.js"></script>
    <script>
        function success() {
            Swal.fire(
                'Registration submission failed. Please accept the terms and conditions '


            )
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();

        });
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    document.getElementById('<%=imgviews.ClientID%>').src = e.target.result;
                    //$('#imgviews').attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
                }
            }


    </script>
    <script>
        function setImage() {
            try {
                var imgObj = document.getElementById('<%=imgviews.ClientID%>');

                var base64Data = localStorage.getItem("myImageData");
                imgObj.src = "data:image/png;base64," + base64Data;
            }
            catch (e) { }
        }
    </script>

    <script type="text/javascript">
        $(function () {
            $("#disabled").change(function () {
                if ($(this).val() == "2") {
                    $("#hidden_div").show();
                } else {
                    $("#hidden_div").hide();
                }
            });
        });
    </script>




</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%
        const int maxStep = 6;
        var nav = Config.ReturnNav();
        String appplication = "";


        int myStep = 1;
        try
        {
            myStep = Convert.ToInt32(Request.QueryString["step"]);
            if (myStep > maxStep || myStep < 1)
            {
                myStep = 1;
            }
        }
        catch (Exception)
        {
            myStep = 1;
        }
    %>
    <%
        if (myStep == 1)

        {
    %>
    <section class="content-header">
        <h1>
            <small>Registration</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="Dashboard.aspx"><i class="fa fa-dashboard"></i>Home</a></li>
            <li class="active">Examination Registration</li>
        </ol>
    </section>

    <div class="panel panel-default">
        <asp:ScriptManager ID="ScriptManger1" runat="Server" />

        <div class="panel-heading">
            Student Registration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of 5<i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="Div4" runat="server"></div>
            <div id="Div5" runat="server"></div>
            <div runat="server" id="Div6"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Student Registration</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="generalFeedback" runat="server"></div>
                        <div id="feedback" runat="server"></div>
                        <div runat="server" id="linesFeedback"></div>
                        <br />
                        <br />
                        <div class="row">

                            <div class="col-md-4">

                                <!-- Profile Image -->
                                <div class="box box-primary">
                                    <div class="box-body box-profile">
                                        <%  string IdNumber = Convert.ToString(Session["idNumber"]);
                                            var path = "~/images/" + IdNumber + ".jpg";
                                            string servpath = Server.MapPath(path);
                                            FileInfo file = new FileInfo(servpath);

                                            if (file.Exists.Equals(false))
                                            {%>


                                        <img class="img-responsive img-circle" src="images/profile.jpg" alt="User profile picture">
                                        <br />

                                        <%}
                                            else
                                            {
                                                 FileUpload1.Enabled = false;
                                        %>
                                        <br />
                                        <br />
                                        <asp:Image runat="server" ImageUrl='<%# "../images/" + idnumber.Text + ".jpg" %>' ID="imgviews" CssClass="img-responsive img-circle" alt="User profile picture" />


                                        <% }%>









                                        <br />
                                        <p>Passport Requirements</p>
                                        <br />
                                        <ol type="1">
                                            <li>JPG Image Only</li>

                                            <li>Size: 45mm x 35mm</li>

                                            <li>Color: Full color</li>
                                            <li>Full face, centered</li>
                                            <li>Background: White</li>
                                            <li>Smile: Neutral</li>
                                            <li>Eyes: Open</li>
                                            <li>Headgear: Non allowed</li>
                                        </ol>
                                        <br />
                                        <div class="row">

                                            <div class="form-group">

                                                <asp:FileUpload onchange="readURL(this);" class="form-control" ID="FileUpload1" runat="server" Enabled="true" />


                                                <br />
                                                <asp:Button runat="server" class="btn btn-primary" ID="uploadphoto" name="btn_personalinformations" Text="Upload" OnClick="uploadphoto_Click"></asp:Button>

                                            </div>
                                        </div>


                                    </div>
                                    <!-- /.box-body -->
                                </div>
                                <!-- /.box -->

                                <!-- About Me Box -->

                                <!-- /.box -->
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="firstName">First name<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="firstName"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" EnableClientScript="false" ControlToValidate="firstName" ErrorMessage="The first Name field cannot be empty!" Text="*" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="lastname">Last Name</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="lastName"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="middlename">Middle name</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="middlename"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Gender <span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" class="form-control select2" Style="width: 100%;" ID="txtgender" name="txtgender">
                                        <asp:ListItem>--Select Gender--</asp:ListItem>
                                        <asp:ListItem Value="1">Male</asp:ListItem>
                                        <asp:ListItem Value="2">Female</asp:ListItem>
                                        <%--<asp:ListItem Value="2">Others</asp:ListItem>--%>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="phoneNumber">Phone Number</label>
                                    <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="phoneNumber" ReadOnly></asp:TextBox>
                                    
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="idnumber">ID/Passport/Birth certificate Number<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" MaxLength="11" ID="idnumber" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="email address">Email address</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="email" Enabled="false"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label>Date of Birth :</label><i>(dd/mm/yyyy)</i>
                                    <asp:TextBox CssClass="form-control datepicker" runat="server" ID="txtDOB"></asp:TextBox>
                                    <asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidateDOB" ControlToValidate="txtDOB" ErrorMessage="" ForeColor="Red" />
                                </div>
                            </div>



                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="county">Country<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" CssClass="form-control select2" ID="DropDownList1" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                </div>

                            </div>

                            <div id="LocalAddress" runat="server" visible="false">

                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="county">County<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="county"></asp:DropDownList>
                                    </div>

                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="postal">Postal Code<span class="text-danger">*</span></label>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="postal" OnSelectedIndexChanged="postal_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                                    </div>

                                </div>
                                <div class="col-md-4">

                                    <div class="form-group">
                                        <label for="city">City\Town</label>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="city" Enabled="false"></asp:TextBox>
                                    </div>

                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="postalAddres">Physical Address</label>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="address"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="postalAddres">Postal Address</label>
                                        <asp:TextBox runat="server" CssClass="form-control" ID="postalAddress"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <div style="display: none">
                                <asp:TextBox runat="server" CssClass="form-control" ID="appNo"></asp:TextBox>
                                <asp:TextBox runat="server" CssClass="form-control" ID="project" Enabled="false"></asp:TextBox>
                                <asp:TextBox runat="server" CssClass="form-control" ID="ExamCode" Enabled="false"></asp:TextBox>
                            </div>








                            <!-- /.form-group -->
                            <!-- /.col -->
                            <!-- /.row -->
                        </div>






                    </div>

                </div>

            </section>


            <%--   <center>
                <asp:Button runat="server" class="btn btn-primary" id="Button1" name="btn_personalinformations" Text="Save Details" OnClick="next_Click"></asp:Button>

               
            </center>--%>
            <%--        <div class="table-responsive">




                <table class="table table-bordered table-striped dataTable" id="example4">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Student Name</th>
                            <th>Passport No</th>
                            <th>Address</th>
                            <th>Examination Id</th>
                            <th>Edit</th>
                            <th>Proceed</th>

                        </tr>
                    </thead>
                    <tbody>
                        <% 

                            string IdNumberz = Convert.ToString(Session["idNumber"]);
                            var application = appNo.Text;
                            string courseId = Request.QueryString["courseId"];
                            var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumberz && r.studentType == "New" && r.Document_Type == "Registration" && r.submitted == false && r.Course_ID == courseId);
                            //string university = Convert.ToString(Session["UniversityCode"]);
                            int programesCounter = 0;
                            foreach (var detail in details)
                            {
                                programesCounter++;
                        %>
                        <tr>
                            <td><%=programesCounter %></td>
                            <td><%=detail.No %></td>
                            <td><%=detail.Student_Name %></td>
                            <td><%=detail.ID_Number_Passport_No %></td>
                            <td><%=detail.Address %></td>
                            <td><%=detail.Course_ID %></td>
                            <td>
                                <label class="btn btn-success" onclick="editItem('<%=detail.No %>','<%=detail.Phone_No %>','<%=detail.Gender %>','<%=detail.Date_of_Birth %>','<%=detail.Address%>');"><i class="fa fa-edit">Edit</i></label></td>

                            <td><a href="StudentRegistration.aspx?step=2&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-arrow"></i>proceed</a></td>
                        </tr>
                        <%  
                            } %>
                    </tbody>
                </table>
            </div>--%>
        </div>


        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextExamDetails" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>

    </div>

    <%
        }
        else if (myStep == 2)
        {
    %>

    <div class="panel panel-primary">
        <div class="panel-heading">
            Registration
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of <%= maxStep %> <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="Div1"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Additional Details</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div2" runat="server"></div>
                        <div id="Div3" runat="server"></div>
                        <div runat="server" id="nextofkin"></div>
                        <br />

                        <p><strong>--Additional Information--</strong></p>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="city">Examination ID</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="courseIDTEXT" Enabled="false"></asp:TextBox>
                                </div>
                            </div>


                            <!-- /.form-group -->
                            <div class="col-md-6">
                                <div class="form-group" style="display: none">
                                    <label for="exampleInputEmail1">Examination sitting<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="examCylce"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Your Educational Level<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" data-live-search="true" ID="txteducationallevel" class="form-control select2" Style="width: 100%;"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="city">Examination</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="courseTextBox" Enabled="false"></asp:TextBox>
                                </div>

                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="currency">Training Institution you are taking the kasneb course from</label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="currency"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">How did you know about kasneb<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="information"></asp:DropDownList>
                                </div>
                            </div>

                            <div class="form-group" style="display: none">
                                <label for="exampleInputEmail1">Examination Center<span class="text-danger">*</span></label>
                                <asp:DropDownList runat="server" CssClass="form-control" ID="examCenter"></asp:DropDownList>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Physically Challenged?<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" ID="disabledchallenge" CssClass="form-control select2">
                                        <asp:ListItem>--select--</asp:ListItem>
                                        <asp:ListItem Value="1">No</asp:ListItem>
                                        <asp:ListItem Value="2">Yes</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <div id="hidden_div" style="display: none">

                                <div class="form-group">
                                    <label class="control-label">Work Type<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="WorkType"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <br />
                        <p><strong>--Next of kin Details--</strong></p>
                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Full Name<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="kinName"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">

                                    <label>Relationship<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" ID="kin" CssClass="form-control select2">
                                        <asp:ListItem>--select--</asp:ListItem>
                                        <asp:ListItem Value="0">Parent</asp:ListItem>
                                        <asp:ListItem Value="1">Guardian</asp:ListItem>
                                        <asp:ListItem Value="2">Sibling</asp:ListItem>
                                        <asp:ListItem Value="3">Spouse</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <!-- /.form-group -->

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="city">Email</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="kinEmail"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="kinEmail" ErrorMessage="Invalid Email Format" ForeColor="Red"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="city">Phone<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="kinPhone" TextMode="Number"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="kinPhone" ErrorMessage="Please Enter a valid Phone Number" ForeColor="Red" ValidationExpression="[0-9]{10}"></asp:RegularExpressionValidator>
                                </div>

                            </div>
                        </div>




                    </div>
                </div>
            </section>


            <center>
                <asp:Button runat="server" class="btn btn-primary" id="btn_personalinformations" name="btn_personalinformations" Text="Save Details" OnClick="btn_personalinformations_Click"></asp:Button>

               
            </center>
            <%-- <div class="table-responsive">
                <table class="table table-bordered table-striped dataTable" id="example3">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Examination Description</th>
                            <th>Educational Level</th>
                            <th>Next Of kin Full Name</th>
                            <%--<th>Proceed</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            String applicationNo = Request.QueryString["applicationNo"];
                            string id = Convert.ToString(Session["idNumber"]);
                            var details = nav.StudentProcessing.Where(r => r.No == applicationNo && r.Highest_Academic_Qualification != "" && r.submitted == false && r.Contact_Full_Name != "");
                            //string university = Convert.ToString(Session["UniversityCode"]);
                            int programesCounter = 0;
                            foreach (var detail in details)
                            {
                                if (detail.Highest_Academic_Qualification != "" && detail.Contact_Full_Name != "")
                                {
                                    programesCounter++;
                        %>
                        <tr>
                            <td><%=programesCounter %></td>
                            <td><%=detail.No %></td>
                            <td><%=detail.Course_Description %></td>
                            <td><%=detail.Highest_Academic_Qualification %></td>
                            <td><%=detail.Contact_Full_Name %></td>


                            <%
                                if (detail.Disabled == true)
                                {
                            %>
                            <td><a href="StudentRegistration.aspx?step=3&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.No %>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>
                            <%}

                                else if (detail.Disabled == false)
                                { %>
                            <td><a href="StudentRegistration.aspx?step=4&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.No %>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>
                            <%} %>
                        </tr>
                        <%  
                                }
                            } %>
                    </tbody>
                </table>
            </div>--%>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="AdditionalNext" OnClick="AdditionalNext_Click" />

            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
        else if (myStep == 3)
        {
    %>


    <div class="panel panel-primary">
        <div class="panel-heading">
            Registration
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of <%= maxStep %> <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="Div8" runat="server"></div>
            <div id="Div9" runat="server"></div>
            <div runat="server" id="Div10"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Person with Disability</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div11" runat="server"></div>
                        <div id="upload" runat="server"></div>
                        <div runat="server" id="challenge"></div>

                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group">
                                    <strong>Physical challenge:</strong>
                                    <asp:DropDownList runat="server" ID="disabilitytype" CssClass="form-control select2" OnSelectedIndexChanged="disabilitytype_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>

                                </div>

                                <div class="form-group">
                                    <strong>Description:</strong>
                                    <asp:TextBox runat="server" ID="disabilitdescription" CssClass="form-control" Enabled="false" />
                                </div>


                                <div class="form-group">
                                    <label class="control-label">NCPW Certificate No.<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="TextBox1"></asp:TextBox>
                                </div>
                            </div>





                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                <div class="form-group">
                                    <strong>NCPWD certificate <i>(pdf only)</i></strong>
                                    <asp:FileUpload runat="server" CssClass="form-control" ID="FileUpload"></asp:FileUpload>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Only PDF files are allowed!" ValidationExpression="^.*\.(pdf|PDF)$" ControlToValidate="FileUpload" CssClass="text-red"></asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="UploadCertificate" OnClick="UploadCertificate_Click" />
                                </div>
                            </div>

                            <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead>
                                            <tr>
                                                <th>Document Title</th>
                                                <%-- <th>Download</th>--%>
                                                <th>Delete</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <%
                                                List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                                try
                                                {%>
                                            <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                                {
                                                    // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                                    String leaveNo = Request.QueryString["applicationNo"];
                                                    string password = ConfigurationManager.AppSettings["S_PWD"];
                                                    string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                                    string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                                    var secret = new SecureString();



                                                    foreach (char c in password)
                                                    {
                                                        secret.AppendChar(c);
                                                    }

                                                    ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                                    ctx.Load(ctx.Web);
                                                    ctx.ExecuteQuery();
                                                    List list = ctx.Web.Lists.GetByTitle("Student Portal");

                                                    //Get Unique rfiNumber
                                                    string uniqueLeaveNumber = leaveNo;

                                                    ctx.Load(list);
                                                    ctx.Load(list.RootFolder);
                                                    ctx.Load(list.RootFolder.Folders);
                                                    ctx.Load(list.RootFolder.Files);
                                                    ctx.ExecuteQuery();

                                                    FolderCollection allFolders = list.RootFolder.Folders;
                                                    foreach (Folder folder in allFolders)
                                                    {
                                                        if (folder.Name == "KASNEB")
                                                        {
                                                            ctx.Load(folder.Folders);
                                                            ctx.ExecuteQuery();
                                                            var uniquerfiNumberFolders = folder.Folders;

                                                            foreach (Folder folders in uniquerfiNumberFolders)
                                                            {
                                                                if (folders.Name == "DisabilityCertificate")
                                                                {
                                                                    ctx.Load(folders.Folders);
                                                                    ctx.ExecuteQuery();
                                                                    var uniquevendorNumberSubFolders = folders.Folders;

                                                                    foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                                    {
                                                                        if (vendornumber.Name == uniqueLeaveNumber)
                                                                        {
                                                                            ctx.Load(vendornumber.Files);
                                                                            ctx.ExecuteQuery();

                                                                            FileCollection vendornumberFiles = vendornumber.Files;
                                                                            foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                            {%>
                                            <% ctx.ExecuteQuery();
                                                alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                                alldocuments.ToList();
                                            %>


                                            <% }%>

                                            <%
                                                foreach (var item in alldocuments)
                                                {%>
                                            <tr>
                                                <td><% =item.FileName %></td>
                                                <td>
                                                    <label class="btn btn-danger" onclick="deleteFiless('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                            </tr>
                                            <% }
                                            %>

                                            <%  }

                                                                        }


                                                                    }
                                                                }

                                                            }
                                                        }

                                                    }

                                                }
                                                catch (Exception t)
                                                {

                                                    attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                                      "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                                }

                                            %>
                                        </tbody>

                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row">


                            <div class="col-lg-6 col-sm-6">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" CssClass="btn btn-success btn-block" Text="Add" ID="adddisability" OnClick="adddisability_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <div class="table-responsive">
                <table id="example1" class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Physical challenge type</th>
                            <th>Physical challenge description</th>

                        </tr>
                    </thead>
                    <tbody>
                        <%
                            String applicationNo = Request.QueryString["applicationNo"];
                            String courseid = Request.QueryString["courseid"];
                            var exemptionLines = nav.DisabilityEntries.Where(r => r.Student_No == applicationNo).ToList();
                            foreach (var line in exemptionLines)
                            {
                        %>
                        <tr>

                            <td><% =line.Student_No %></td>
                            <td><% =line.Disability_Type %></td>
                            <td><% =line.Disability_Name %></td>





                        </tr>
                        <% 
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Button2" OnClick="Button2_Click" />
            <%
                if (alldocuments.Count > 0 && exemptionLines.Count > 0)
                {
                    invoice.Visible = true;
                }%>

            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="invoice" OnClick="invoice_Click" Visible="false" />


            <div class="clearfix"></div>
        </div>
    </div>




    <%
        }
        else if (myStep == 4)
        {
    %>
    <div class="panel-default setup-content" id="step-10">
        <div class="panel-heading">
            Mandatory Documents
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of <%= maxStep %> <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>

        </div>
        <div runat="server" id="attach"></div>
        <div id="completefeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_documents" data-toggle="tab">
                        <p style="color: black">Registration Document Attachments</p>
                    </a>
                </li>
                <%--   <li style="background-color: gray">
                    <a href="#tab_1_attach" data-toggle="tab">
                        <p style="color: black">Attach Document </p>
                    </a>
                </li>--%>
                <%--         <li style="background-color:gray">
                    <a href="#tab_1_attached" data-toggle="tab"><p style="color:black">Attached Document </p></a>
                </li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_1_documents">
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>Submit scanned copies of the following sets of documents, as part of your Registration process. (Allowed Extensions. Pdf only) </p>

                        </div>
                        <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                            <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                        </div>
                        <div class="col-md-12">
                            <div runat="server"  id="documentsfeedback"></div>
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" id="txtapplicationNo" class="txtapplicationNo" />
                            <asp:TextBox runat="server" ID="template" CssClass="form-control" Visible="false"></asp:TextBox>
                            <div class="table-responsive">
                                <table class="table table-striped custom-table datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Document Type</th>
                                            <th>Description</th>
                                            <th>Requirement Type</th>
                                            <th>Attach Document</th>
                                        </tr>

                                    </thead>
                                    <tbody>
                                        <% 
                                            string courseId = Request.QueryString["courseId"];
                                            var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Registration" && r.Examiantion_ID == courseId).ToList();
                                            int programesCounter = 0;
                                            int counter = 0;
                                            foreach (var detail in details)
                                            {

                                                counter++;
                                                programesCounter++;
                                        %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.Examination_Document_Type %></td>
                                            <td><%=detail.Description %></td>
                                            <td><%=detail.Requirement_Type %></td>
                                            <td>
                                               <label class="btn btn-success" onclick="studentattachdocuments('<%=detail.Entry_No %>');">Attach Document</label>
                                            </td>
                                        </tr>
                                        <%  
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                            <%--<div class="panel-footer">
                                <br />
                                <input type="button" id="btnSavePrequalifiedDocuments" class="btn btn-success pull-left btnSavePrequalifiedDocuments" name="btnSavePrequalifiedDocuments" value="Submit Documents" />
                            </div>--%>
                            <br />
                            <br />
                            <div class="box-header">
                                <h3 class="box-title">Attached Documents</h3>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped" id="example7">
                                    <thead>
                                        <tr>
                                            <th>Document Title</th>
                                            <%--<th>Download</th>--%>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%
                                            List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                            try
                                            {%>
                                        <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                            {
                                                // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                                String leaveNo = Request.QueryString["applicationNo"];
                                                string password = ConfigurationManager.AppSettings["S_PWD"];
                                                string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                                string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                                var secret = new SecureString();



                                                foreach (char c in password)
                                                {
                                                    secret.AppendChar(c);
                                                }

                                                ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                                ctx.Load(ctx.Web);
                                                ctx.ExecuteQuery();
                                                List list = ctx.Web.Lists.GetByTitle("KASNEB ESS");

                                                //Get Unique rfiNumber
                                                string uniqueLeaveNumber = leaveNo;

                                                ctx.Load(list);
                                                ctx.Load(list.RootFolder);
                                                ctx.Load(list.RootFolder.Folders);
                                                ctx.Load(list.RootFolder.Files);
                                                ctx.ExecuteQuery();

                                                FolderCollection allFolders = list.RootFolder.Folders;
                                                foreach (Folder folder in allFolders)
                                                {
                                                    if (folder.Name == "StudentPortal")
                                                    {
                                                        ctx.Load(folder.Folders);
                                                        ctx.ExecuteQuery();
                                                        var uniquerfiNumberFolders = folder.Folders;

                                                        foreach (Folder folders in uniquerfiNumberFolders)
                                                        {
                                                            if (folders.Name == "Registration")
                                                            {
                                                                ctx.Load(folders.Folders);
                                                                ctx.ExecuteQuery();
                                                                var uniquevendorNumberSubFolders = folders.Folders;

                                                                foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                                {
                                                                    if (vendornumber.Name == uniqueLeaveNumber)
                                                                    {
                                                                        ctx.Load(vendornumber.Files);
                                                                        ctx.ExecuteQuery();

                                                                        FileCollection vendornumberFiles = vendornumber.Files;
                                                                        foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                        {%>
                                        <% ctx.ExecuteQuery();
                                            alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                            alldocuments.ToList();
                                        %>


                                        <% }%>

                                        <%
                                            foreach (var item in alldocuments)
                                            {%>
                                        <tr>
                                            <td><% =item.FileName %></td>
                                            <td>
                                                <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                        </tr>
                                        <% }
                                        %>

                                        <%  }

                                                                    }


                                                                }
                                                            }

                                                        }
                                                    }

                                                }

                                            }
                                            catch (Exception t)
                                            {

                                                attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                                  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }

                                        %>
                                    </tbody>

                                </table>
                            </div>
                        </div>
                    </div>
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click1" />
                    <%
                        if (alldocuments.Count == details.Count)
                        {
                            nextDocs.Visible = true;
                        }

                    %>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextDocs" OnClick="next_Click1" Visible="false" />
                </div>

                <div class="tab-pane" id="tab_1_attach">
                    <div id="keydocumentsuploadfeedback" style="display: none" data-dismiss="alert"></div>
                    <!-- The global progress bar -->
                    <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>
                                Submit scanned copies of the following sets of documents, as part of your Registration process.
                            This Section enables you to upload scanned copies of the supporting documents as part of this Registration process.
                            </p>
                        </div>
                        <div class="panel-body col-lg-12">
                            <div id="Div14" runat="server"></div>

                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Document Type:</strong>
                                        <asp:DropDownList runat="server" CssClass="form-control" ID="DocType"></asp:DropDownList>
                                    </div>
                                </div>
                                <%--    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                                    </div>
                                </div>--%>
                            </div>
                            <%--     <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                                    </div>
                                </div>
                            </div>--%>
                            <%--  <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <th>Download</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                        try
                                        {%>
                                    <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                        {
                                            // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                            String leaveNo = Request.QueryString["applicationNo"];
                                            string password = ConfigurationManager.AppSettings["S_PWD"];
                                            string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                            var secret = new SecureString();



                                            foreach (char c in password)
                                            {
                                                secret.AppendChar(c);
                                            }

                                            ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                            ctx.Load(ctx.Web);
                                            ctx.ExecuteQuery();
                                            List list = ctx.Web.Lists.GetByTitle("Student Portal");

                                            //Get Unique rfiNumber
                                            string uniqueLeaveNumber = leaveNo;

                                            ctx.Load(list);
                                            ctx.Load(list.RootFolder);
                                            ctx.Load(list.RootFolder.Folders);
                                            ctx.Load(list.RootFolder.Files);
                                            ctx.ExecuteQuery();

                                            FolderCollection allFolders = list.RootFolder.Folders;
                                            foreach (Folder folder in allFolders)
                                            {
                                                if (folder.Name == "KASNEB")
                                                {
                                                    ctx.Load(folder.Folders);
                                                    ctx.ExecuteQuery();
                                                    var uniquerfiNumberFolders = folder.Folders;

                                                    foreach (Folder folders in uniquerfiNumberFolders)
                                                    {
                                                        if (folders.Name == "Registration")
                                                        {
                                                            ctx.Load(folders.Folders);
                                                            ctx.ExecuteQuery();
                                                            var uniquevendorNumberSubFolders = folders.Folders;

                                                            foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                            {
                                                                if (vendornumber.Name == uniqueLeaveNumber)
                                                                {
                                                                    ctx.Load(vendornumber.Files);
                                                                    ctx.ExecuteQuery();

                                                                    FileCollection vendornumberFiles = vendornumber.Files;
                                                                    foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                    {%>
                                    <% ctx.ExecuteQuery();
                                        alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                    %>


                                    <% }%>

                                    <%
                                        foreach (var item in alldocuments)
                                        {%>
                                    <tr>
                                        <td><% =item.FileName %></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                    </tr>
                                    <% }
                                    %>

                                    <%  }

                                                                }


                                                            }
                                                        }

                                                    }
                                                }

                                            }

                                        }
                                        catch (Exception t)
                                        {

                                            attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }

                                    %>
                                </tbody>

                            </table>--%>
                        </div>


                    </div>
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="prev" OnClick="previous_Click1" />


                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click1" />
                </div>

            </div>

        </div>
    </div>


    <%
        }
        else if (myStep == 5)
        {
    %>


    <div class="panel panel-default">
        <div class="panel-heading">
            Declaration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 5 of <%= maxStep %><i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div id="submit" runat="server"></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard </a></li>
                        <li class="breadcrumb-item active">Examination Registration</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <h5>I <b><% =Session["StudentName"] %></b>  hereby declare that to the best of my knowledge all the information I have provided in this application and all supporting documents are true and correct and l agree to abide by the Examination Rules and Regulations and Code of Conduct and Ethics for kasneb students.</h5>

                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                            <p class="pull-left" style="font-size: 15px"><a href="downloads/Code-of-Conduct-Ethics-for-KASNEB-Students.pdf"><i class="fa fa-file-pdf-o"></i>Terms and Conditions</a></p>
                            <br />
                            <br />
                            <asp:CheckBox runat="server" ID="declaration" />
                            <label class="font-noraml" for="acceptTerms">I agree with the Terms and Conditions.</label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="text-center padding-15">
                    <center>
                       <%-- <asp:Button runat="server" class="btn btn-primary btn_submitregistration_Details" id="btn_submitregistration_Details" type="button" onclick=""> </asp:Button>--%>
                        <asp:Button runat="server" Text="Submit Registration" ID="submitRegistration" CssClass="btn btn-primary saveresponce" OnClick="submitRegistration_Click" Visible="true" />
                    </center>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="SubmitPrevious" OnClick="Unnamed_Click" Visible="true" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Visible="false" Text="Proceed to Payment" ID="Payment" OnClick="Payment_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%
        }
        else if (myStep == 6)
        {
    %>


    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-primary">

            <div class="panel-heading">
                <i class="icon-file"></i>
                Payment
            </div>
            <!-- /widget-header -->
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-6">
                        <ol class="breadcrumb float-sm-right">
                            <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                            <li class="breadcrumb-item active">Payment </li>
                        </ol>
                    </div>
                </div>
                <div id="PaymentsMpesa" runat="server"></div>

                <br />
                <div class="row">

                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="tab_1_1" style="width: 100%">
                            <div class="row">
                                <div id="openTenderfeedback" runat="server"></div>
                                <div class="col-md-12">

                                    <section class="accordion-section clearfix mt-3" aria-label="Question Accordions">
                                        <div class="container">

                                            <h3>Payment </h3>
                                            <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                                <div class="panel panel-default">
                                                    <div class="panel-heading p-3 mb-3" role="tab" id="heading0">
                                                        <h3 class="panel-title">
                                                            <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse0" aria-expanded="true" aria-controls="collapse0">Mpesa
                                                            </a>
                                                        </h3>
                                                    </div>
                                                    <div role="tabpanel" aria-labelledby="heading0">
                                                        <div class="panel-body px-3 mb4">
                                                        <div class="container">
                                                            <div class="row">
                                                                <div class="col-xs-12">                                                                    
                                                                   <h3><strong>Payment Instructions</strong></h3>                                                                        
                                                                                
                                                                  
                                                                        <div>
                                                                            <div class="panel-body">
                                                                                <div class="panel-body px-3 mb-4">
                                                                                   
                                                                                   <center><img class="imgMpesa" src="assets/img/stkMpesa.png" />
                                                                                     <p></p><h4><strong>Please ensure you have the following ready to make payment</strong></h4></center> 
                                                                                    <ol type="1">
                                                                                       <li>Enough funds in your Mpesa account.</li>
                                                                                        <li>The Correct Mpesa pin code.</li>
                                                                                        <li>Use a Safaricom sim not older than 3 years</li>
                                                                                        <li>Account No. <strong><%=Request.QueryString["applicationNo"] %> </strong></li>
                                                                                        <li>Amount <strong>
                                                                                            <p runat="server" style="display: inline" id="AmountInstructions"></p>
                                                                                        </strong></li>
                                                                                        <li>Make sure you have the phone you are making payment with.</li>
                                                                                        <li>You will be prompted to enter your Mpesa Pin to complete the payment</li>
                                                                                    </ol>
                                                                                    <p style="text-align:center">NB: You have to wait for the Mpesa Pop Up message to confirm your payment. Should you wish to retry your transaction please wait for a period of 3 minutes.
                                                                                    </p>
                                                                                    <div class="panel-footer">
                                                                                        <label class="btn btn-success" onclick="makePayments('<%=Request.QueryString["applicationNo"]%>')"><i class="fa fa-money"></i>Pay Now</label>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                                    <div class="panel panel-default">
                                                                        <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                                                                            <h3 class="panel-title">
                                                                                <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">Manual Payment Instructions (Pay Later)
                                                                                </a>
                                                                            </h3>
                                                                        </div>
                                                                        <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                                                                            <div class="panel-body px-3 mb-4">
                                                                                <div>
                                                                                    <div class="panel-body">
                                                                                 <div class="panel-body px-3 mb-4">
                                                                                    
                                                                                     <img src="assets/img/paybill-number.jpg" style="width: 150px; height: 90px" />
                                                                                     <div class="col-lg-12">
                                                                                         <div class="form-group">                                                                                                                                                                                       <br />
                                                                                             <asp:CheckBox runat="server" ID="CheckBox1" />
                                                                                             <label class="font-noraml" for="acceptTerms">Pay Later.</label>
                                                                                         </div>
                                                                                     </div>
                                                                                     <ol type="1">
                                                                                         <li>Go to MPESA</li>
                                                                                         <li>Lipa na Mpesa</li>
                                                                                         <li>Paybill Option</li>
                                                                                         <li>Paybill No: <strong>204777</strong></li>
                                                                                         <li>Account No. <strong><%=Request.QueryString["applicationNo"] %> </strong></li>
                                                                                         <li>Amount <strong>
                                                                                             <p runat="server" style="display: inline" id="AmountInstructionsManual"></p>
                                                                                         </strong></li>
                                                                                         <li>Make sure you have the phone you are making payment with.</li>
                                                                                         <li>You will be prompted to enter your Mpesa Pin to complete the payment</li>
                                                                                     </ol>

                                                                                 </div>
                                                                             </div>
                                                                         </div>


                                                                </div>
                                                            </div>
                                                        </div>
                                                                   
                                                           
                                                <div class="panel panel-default" style="display: none">
                                                    <div class="panel-heading p-3 mb-3" role="tab" id="heading2">
                                                        <h3 class="panel-title">
                                                            <a class="collapsed" role="button" title="" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="true" aria-controls="collapse2">Other Modes of Payment

                                                            </a>
                                                        </h3>
                                                    </div>
                                                    <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                                                        <div class="panel-body px-3 mb-4">
                                                            <div id="modalPay" role="dialog">

                                                                <div class="row">
                                                                    <div class="panel-heading">
                                                                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                                        <h4 class="modal-title">Confirm Examination registration Payment</h4>
                                                                    </div>
                                                                    <div class="panel-body">

                                                                        <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                                                                        <div class="form-group">
                                                                            <strong>Application Number:</strong>
                                                                            <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" />

                                                                        </div>

                                                                        <div class="form-group">
                                                                            <strong>Payment Mode:</strong>
                                                                            <asp:DropDownList runat="server" CssClass="form-control" ID="paymentsM" />
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <strong>Payment Document:</strong>
                                                                            <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                                                                            <%-- <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />--%>
                                                                            <div class="form-group">
                                                                                <strong>Payment Reference Number:</strong>
                                                                                <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                                                                            </div>
                                                                        </div>

                                                                    </div>
                                                                    <div class="panel-footer">
                                                                        <%-- <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>--%>
                                                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="makePayments_Click" EnableViewState="true" />
                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                </div>
                                            </div>
                 
                                    </section>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>



        </div>
    </div>
    <div class="clearfix"></div>




    <%} %>


    <script type="text/javascript">


        $('#txtDOB').datepicker({
            autoclose: true
        })

        function ValidateDOB(sender, args) {

            var dateString = document.getElementById(sender.controltovalidate).value;
            var regex = /(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$/;

            //Check whether valid dd/MM/yyyy Date Format.
            if (regex.test(dateString)) {
                var parts = dateString.split("/");
                var dtDOB = new Date(parts[1] + "/" + parts[0] + "/" + parts[2]);
                var dtCurrent = new Date();
                sender.innerHTML = "Eligibility 16 years ONLY."
                if (dtCurrent.getFullYear() - dtDOB.getFullYear() < 16) {
                    args.IsValid = false;
                    return;
                }

                if (dtCurrent.getFullYear() - dtDOB.getFullYear() == 16) {

                    //CD: 11/06/2018 and DB: 15/07/2000. Will turned 18 on 15/07/2018.
                    if (dtCurrent.getMonth() < dtDOB.getMonth()) {
                        args.IsValid = false;
                        return;
                    }
                    if (dtCurrent.getMonth() == dtDOB.getMonth()) {
                        //CD: 11/06/2018 and DB: 15/06/2000. Will turned 18 on 15/06/2018.
                        if (dtCurrent.getDate() < dtDOB.getDate()) {
                            args.IsValid = false;
                            return;
                        }
                    }
                }
                args.IsValid = true;
            } else {
                sender.innerHTML = "Enter date in dd/MM/yyyy format ONLY."
                args.IsValid = false;
            }
        }
    </script>

    <script>
        function showDiv(divId, element) {
            document.getElementById(divId).style.display = element.value == 2 ? 'block' : 'none';
        }
    </script>
    <script>
        function editItem(No, editphoneno, Gender, Dob, physicalAddress) {
            document.getElementById("MainContent_originalItemNo").value = No;
            document.getElementById("MainContent_EditPhoneNo").value = editphoneno;
            document.getElementById("MainContent_editGender").value = Gender;
            document.getElementById("MainContent_editDob").value = Dob;
            document.getElementById("MainContent_editPhysical").value = physicalAddress;

            $("#editItemModel").modal();
        }
    </script>
    <script>

        function deleteOrganizationFile(filename2) {
            document.getElementById("filetoDeleteName").innerText = filename2;
            document.getElementById("MainContent_filename2").value = filename2;
            $("#deleteOrganizationFileModal").modal();
        }
    </script>



    <div id="deleteOrganizationFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="filename2" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteorganization" OnClick="deleteorganization_Click" />
                </div>
            </div>

        </div>
    </div>



    <script src="Adminlte/bower_components/jquery/dist/jquery.min.js"></script>

    <script>
        function makePayments(no) {
            document.getElementById("MainContent_ApplicationNo").value = no;

            $("#MakepaymentsModal").modal();
        }
    </script>
    <div id="editItemModel" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div runat="server" id="teamFeedback"></div>
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit Registration Details</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="originalItemNo" type="hidden" />
                    <div class="form-group">
                        <strong>Phone Number</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="EditPhoneNo" />
                    </div>

                    <div class="form-group">
                        <label>Gender <span class="text-danger">*</span></label>
                        <asp:DropDownList runat="server" class="form-control select2" Style="width: 100%;" ID="editGender" name="editGender">
                            <asp:ListItem>--Select Gender--</asp:ListItem>
                            <asp:ListItem Value="1">Male</asp:ListItem>
                            <asp:ListItem Value="2">Female</asp:ListItem>
                            <%-- <asp:ListItem Value="2">Others</asp:ListItem>--%>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group">
                        <strong>Date of Birth :</strong>
                        <asp:TextBox runat="server" TextMode="Date" CssClass="form-control" ID="editDob" />
                    </div>
                    <div class="form-group">
                        <strong>Physical Address:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="editPhysical" />
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" ID="EditDetails" Text="Edit Details" OnClick="EditDetails_Click" />

                </div>
            </div>

        </div>
    </div>
    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Registration Payments</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox3" type="hidden" />
                    <div class="form-group">
                        <strong>Invoice Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="ApplicationNo" placeholder="Invoice Number" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Amount"  ReadOnly="true"/>
                    </div>
                    <div class="form-group">
                        <strong>Phone Number:</strong>
                        <asp:TextBox runat="server" TextMode="Number" CssClass="form-control" ID="PhoneNumberPay" />
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payment" ID="SubmitPayment" OnClick="SubmitPayment_Click" />
                </div>
            </div>

        </div>
    </div>
     <div id="DocumentsAttach" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attach the Document</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                      <strong>Upload Document</strong><span class="text-danger" style="font-size:25px">*</span>
                          <asp:FileUpload runat="server" CssClass="form-control" ID="uploadfile" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button1" OnClick="UploadDocuments_Click" />
                </div>
            </div>

        </div>
    </div>
       <script type="text/javascript">
           function studentattachdocuments(entryNo) {
            $("#DocumentsAttach").modal();
        }
    </script>
    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteNames").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>

    <script>

        function deleteFiless(fileName) {
            document.getElementById("filetoDeleteNamess").innerText = fileName;
            document.getElementById("MainContent_deletedisability").value = fileName;
            $("#deleteFileModalss").modal();
        }
    </script>

    <div id="deleteFileModalss" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteNamess"></strong>?</p>
                    <asp:TextBox runat="server" ID="deletedisability" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" ID="deleteDisabilityFile" OnClick="deleteDisabilityFile_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteNames"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>

