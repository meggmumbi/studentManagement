<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="StudentManagementASPX.profile" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <section class="content">
        <div class="box box-default">
            <div class="row">
                <div id="examcenterz" runat="server"></div>
                <div class="box-body">
                <div class="col-md-3">
                    <!-- /.box-header -->
                   
                        <!-- Profile Image -->
                        <!-- Profile Image -->
                        <div class="box box-primary">
                            <div class="box-body box-profile">
                                <%  string IdNumber = Convert.ToString(Session["idNumber"]);
                                    var path = "~/images/" + IdNumber + ".jpg";
                                    string servpath = Server.MapPath(path);
                                    System.IO.FileInfo file = new System.IO.FileInfo(servpath);

                                    if (file.Exists.Equals(false))
                                    {%>
                                <img class="img-responsive img-circle" src="images/profile.jpg" alt="User profile picture">
                                <%--  <br />--%>

                                <%}
                                    else 
                                    {
                                        FileUpload1.Enabled = false;
                                   
                                     %>

                                <asp:Image runat="server" ImageUrl='<%# "../images/" + idnumber.Text + ".jpg" %>' ID="imgviews" CssClass="img-responsive img-circle" alt="User profile picture" />
                                <% }%>
                                <p>Passport Requirements</p>
                                <ul class="list-group list-group-unbordered">
                                    <li>JPG Image Only</li>

                                    <li>Size: 45mm x 35mm</li>

                                    <li>Color: Full color</li>
                                    <li>Full face, centered</li>
                                    <li>Background: White</li>
                                    <li>Smile: Neutral</li>
                                    <li>Eyes: Open</li>
                                    <li>Headgear: Non allowed</li>
                                </ul>

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
                  
               </div>
                <!-- /.col -->
                <div class="col-md-8">
                    <div class="nav-tabs-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#activity" data-toggle="tab">Personal Information</a></li>

                        </ul>
                        <div class="tab-content">
                            <div class="active tab-pane" id="activity">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        Personal Information
                                      <span class="pull-right"><i class="fa fa-chevron-left">profile</i> <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
                                    </div>

                                    <div class="panel-body">
                                        <div runat="server" id="Div4"></div>
                                        <section class="content">
                                            <div class="box box-default">
                                                <div class="box-header with-border">
                                                    <h3 class="box-title">Personal Details</h3>

                                                </div>
                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <div id="Div5" runat="server"></div>
                                                    <div id="Div6" runat="server"></div>
                                                    <div runat="server" id="Div8"></div>
                                                    <br />


                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="firstName">First name</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="firstName" ReadOnly></asp:TextBox>
                                                        </div>
                                                        <!-- /.form-group -->


                                                        <div class="form-group">
                                                            <label for="lastname">Last Name</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="lastName" ReadOnly></asp:TextBox>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="postal">Postal Code<span class="text-danger">*</span></label>
                                                            <asp:DropDownList runat="server" CssClass="form-control" ID="postals" OnSelectedIndexChanged="postal_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                                                        </div>

                                                        <div class="form-group">
                                                            <label for="county">City</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="city"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="postalAddres">Address 2</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="address2"></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="county">Country<span class="text-danger">*</span></label>
                                                            <asp:DropDownList runat="server" CssClass="form-control" ID="DropDownList1"></asp:DropDownList>
                                                        </div>



                                                    </div>


                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label for="middlename">Middle name</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="middlename" ReadOnly></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="idnumber">ID/Passport Number</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" MaxLength="11" ID="idnumber" ReadOnly></asp:TextBox>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="email address">Email address</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="email" ReadOnly></asp:TextBox>
                                                        </div>
                                                        <!-- /.form-group -->
                                                        <div class="form-group">
                                                            <label for="phoneNumber">Phone Number</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" TextMode="Number" ID="phoneNumber"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="postalAddres">Address</label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="address"></asp:TextBox>
                                                        </div>

                                                        <div class="form-group" style="display: none">
                                                            <label for="county">County<span class="text-danger">*</span></label>
                                                            <asp:TextBox runat="server" CssClass="form-control" ID="countys" ReadOnly></asp:TextBox>
                                                        </div>


                                                        <!-- /.form-group -->
                                                    </div>
                                                    <!-- /.col -->



                                                </div>
                                                <center>
                                                    
                                                 <asp:Button runat="server" class="btn btn-primary"  Text="Submit personal details" ID="saveDetails" OnClick="saveDetails_Click1" ></asp:Button>
                                                <asp:Button runat="server" class="btn btn-primary" Text="Edit personal details" ID="editbutton" OnClick="editbutton_Click" Visible="false"></asp:Button>     
                                                        
                                          </center>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </div>


                            <!-- /.tab-pane -->
                            <div class="tab-pane" id="timeline">
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        Personal Information
                                      <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
                                    </div>
                                    <div class="panel-body">
                                        <div runat="server" id="Div1"></div>
                                        <section class="content">
                                            <div class="box box-default">
                                                <div class="box-header with-border">
                                                    <h3 class="box-title">--Next of kin Details--</h3>

                                                </div>
                                                <!-- /.box-header -->
                                                <div class="box-body">
                                                    <div id="Div2" runat="server"></div>
                                                    <div id="Div3" runat="server"></div>
                                                    <div runat="server" id="Div7"></div>
                                                    <br />

                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">

                                                                <label>Relationship<span class="text-danger">*</span></label>
                                                                <asp:TextBox runat="server" ID="rkin" CssClass="form-control select2">
                                          
                                                                </asp:TextBox>
                                                            </div>

                                                            <!-- /.form-group -->

                                                            <div class="form-group">
                                                                <label for="exampleInputEmail1">FullName<span class="text-danger">*</span></label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="kinName"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="city">Email</label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="kinEmail"></asp:TextBox>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="city">Phone</label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="kinPhone" TextMode="Number"></asp:TextBox>
                                                            </div>

                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label>Educational Level<span class="text-danger">*</span></label>
                                                                <asp:TextBox runat="server" data-live-search="true" ID="educationallevel" class="form-control">
                                                                </asp:TextBox>
                                                            </div>

                                                            <!-- /.form-group -->

                                                            <div class="form-group">
                                                                <label for="exampleInputEmail1">Source of information<span class="text-danger">*</span></label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="examCylcet"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="exampleInputEmail1">How did you know about kasneb<span class="text-danger">*</span></label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="informationt"></asp:TextBox>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="city">Examination ID</label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="courseIDTEXT" Enabled="false"></asp:TextBox>
                                                            </div>

                                                        </div>

                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="city">Examination Description</label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="courseTextBox" Enabled="false"></asp:TextBox>
                                                            </div>

                                                            <div class="form-group">
                                                                <label for="exampleInputEmail1">Examination Center<span class="text-danger">*</span></label>
                                                                <asp:TextBox runat="server" CssClass="form-control" ID="examCentert"></asp:TextBox>
                                                            </div>

                                                            <div class="form-group">
                                                                <label>Disabled?</label>
                                                                <asp:TextBox runat="server" ID="disabledts" CssClass="form-control select2">                                       
                                                                </asp:TextBox>
                                                            </div>


                                                        </div>


                                                    </div>
                                                </div>
                                            </div>
                                        </section>
                                    </div>
                                </div>
                            </div>
                            <!-- /.tab-pane -->

                            <div class="tab-pane" id="settings">
                                <div class="box">
                                    <div class="box-header">
                                        <h3 class="box-title">Examinations Registered</h3>
                                    </div>
                                    <!-- /.box-header -->
                                    <div class="box-body">
                                        <table id="example1" class="table table-bordered table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Application No:</th>
                                                    <th>Student No.</th>
                                                    <th>Student Name</th>
                                                    <th>Student IdNo</th>
                                                    <th>Examination Description</th>
                                                    <th>Highest Qualification</th>

                                                    <%-- <th>Receipt</th>--%>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    var nav = Config.ReturnNav();
                                                    string studentNumber = Convert.ToString(Session["studentNo"]);
                                                    var programs = nav.StudentProcessing.Where(r => r.Student_No == studentNumber && r.Document_Type == "Registration" && r.Posted == true);
                                                    foreach (var program in programs)
                                                    {

                                                %>
                                                <tr>
                                                    <td><%=program.No %></td>
                                                    <td><%=program.Student_No %></td>
                                                    <td><%=program.Student_Name %></td>
                                                    <td><%=program.ID_Number_Passport_No %></td>
                                                    <td><%=program.Examination_Description %></td>
                                                    <td><%=program.Highest_Academic_Qualification %></td>



                                                </tr>
                                                <%
                                                    }
                                                %>
                                            </tbody>

                                        </table>
                                    </div>

                                </div>


                            </div>

                        </div>


                    </div>
                </div>

            </div>
            </div>
        </div>

    </section>

</asp:Content>
