<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="InstitutionRegisterStudents.aspx.cs" Inherits="StudentManagementASPX.InstitutionRegisterStudents" %>

<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%
        const int maxStep = 2;
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


    <div class="panel panel-primary" style="width:80%; margin: 0 auto">
        <div class="panel-heading">
            Institution Registration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>
               <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">General details </h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div5" runat="server"></div>
                        <div id="Div6" runat="server"></div>
                        <div runat="server" id="Div7"></div>
                      
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                    <div class="form-group">
                        <label>Document Type:</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="docType" required >
                             <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="0">Registration</asp:ListItem>
                            <asp:ListItem Value="1">Booking</asp:ListItem>   
                             <asp:ListItem Value="2">Exemption</asp:ListItem>  
                            <asp:ListItem Value="3">Withdrawal</asp:ListItem>  
                            <asp:ListItem Value="4">Defferment</asp:ListItem>  
                            </asp:DropDownList>
                    </div>
                </div>

                
                    <div class="form-group">
                        <label>Institution Name :</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="institution" required />
                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="institution" ErrorMessage="Please select institution!" ForeColor="Red" />
                    </div>
             
            </div>

            <div class="col-md-6">             
                             

               
                    <div class="form-group">
                        <label>Currency Code:</label>
                        <asp:DropDownList CssClass="form-control" runat="server" ID="currency" Placeholder="Name" required />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="currency" ErrorMessage="Please select currency!" ForeColor="Red" />
                    </div>
               
                            </div>
                            </div>
                        </div>
        </div>
                   </section>
            <center>
                <asp:Button runat="server" CssClass="btn btn-primary " Text="Next" ID="next" OnClick="next_Click" />
            </center>
             <table id="example2" class="table table-bordered table-striped dataTable">
               <thead>
                   <tr>
                       <th>#</th>
                       <th>Application No</th>
                       <th>Institution Name</th>
                       <th>Document type</th>
                       
                       <th>Edit</th>
                       <th>Proceed</th>

                   </tr>
               </thead>
               <tbody>
                   <% 
                   
                       string institutionNo = Convert.ToString(Session["institution"]);
                       
                      
                       var details = nav.BulkProcessHeader.Where(r => r.Institution_No == institutionNo  && r.Document_Type=="Registration");
                       //string university = Convert.ToString(Session["UniversityCode"]);
                       int programesCounter = 0;
                       foreach (var detail in details)
                       {
                           programesCounter++;
                   %>
                   <tr>
                       <td><%=programesCounter %></td>
                       <td><%=detail.No %></td>
                       <td><%=detail.Institution_Name %></td>
                       <td><%=detail.Document_Type %></td>
                       
                        <td class="btn btn-success"><i class="fa fa-eye">Edit</i></td>
                       <td><a href="InstitutionRegisterStudents.aspx?step=2&&applicationNo=<%=detail.No%>" class="btn btn-success"><i class="fa fa-eye"></i>proceed</a></td>
                   </tr>
                   <%  
                       } %>
               </tbody>
        </table>
            </div>
        <div class="panel-footer">
           
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
           Exemptions
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="Div1"></div>
  <section class="content">
        <div class="box box-default">
            <div class="box-header with-border">
                <h3 class="box-title">Student Registration</h3>

            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <div id="Div2" runat="server"></div>
            <div id="Div3" runat="server"></div>
            <div runat="server" id="Div4"></div>
                <br />
                <br />               
                <br />
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="firstName">First name<span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="firstName" required></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="middlename">Middle name<span class="text-danger">*</span> </label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="middlename"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <!-- /.col -->

                        <div class="form-group">
                            <label for="lastname">Last Name</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="lastName"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="idnumber">ID/Passport Number<span class="text-danger">*</span></label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="idnumber"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                    </div>
                    <!-- /.col -->

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="email address">Email address</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="email"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="phoneNumber">Phone Number</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="phoneNumber"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <!-- /.col -->

                        <div class="form-group">
                            <label for="postalAddres">Address</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="address"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="county">County<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="county"></asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                    </div>
                    <!-- /.col -->

                    <div class="col-md-3">
                        <div class="form-group">
                            <label for="postal">Postal address<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="postal" OnSelectedIndexChanged="postal_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="city">City\Town</label>
                            <asp:TextBox runat="server" CssClass="form-control" ID="city"></asp:TextBox>
                        </div>
                        <!-- /.form-group -->
                        <!-- /.col -->

                        <div class="form-group">
                            <label>Gender <span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" class="form-control select2" Style="width: 100%;" ID="txtgender" name="txtgender">
                                <asp:ListItem Value="0">--Select Gender--</asp:ListItem>
                                <asp:ListItem Value="1">Male</asp:ListItem>
                                <asp:ListItem Value="2">Female</asp:ListItem>
                                <asp:ListItem Value="3">Others</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label>Date of Birth:</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <asp:TextBox runat="server" CssClass="form-control" ID="dob"></asp:TextBox>
                            </div>
                            <!-- /.input group -->
                        </div>
                        <!-- /.form-group -->
                        <!-- /.col -->
                        <!-- /.row -->
                    </div>

                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Educational Level<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" data-live-search="true" ID="txteducationallevel" class="form-control select2" Style="width: 100%;"/>
                                
                          
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="exampleInputEmail1">Examination Cycle<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="examCylce"></asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                        <!-- /.col -->

                        <div class="form-group">
                            <label for="exampleInputEmail1">Examination Description<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="exam"></asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                        <div class="form-group">
                            <label for="exampleInputEmail1">Examination Center<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="examCenter"></asp:DropDownList>
                        </div>
                        <!-- /.form-group -->
                    </div>
                    </div>
                    <div class="row">
                   <%-- <div class="col-md-3">--%>
                      <%--   <div class="form-group">
                            <label for="exampleInputEmail1">Exam Project<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="examProject"></asp:DropDownList>
                        </div>--%>
                        <div class="col-sm-3">
                        <div class="form-group">
                            <label>Disabled?</label>
                            <asp:DropDownList runat="server" ID="disabled" CssClass="form-control select2">
                                <asp:ListItem Value="1">No</asp:ListItem>
                                <asp:ListItem Value="2">Yes</asp:ListItem>
                            </asp:DropDownList>                          
                        </div>
                            </div>
                        <div class="col-sm-3">
                          <div class="form-group">
                            <label for="exampleInputEmail1">Currency<span class="text-danger">*</span></label>
                            <asp:DropDownList runat="server" CssClass="form-control" ID="currencyLine"></asp:DropDownList>
                        </div>
                    </div>
                    <div id="hidden_div" style="display: none">
                        <div class="col-sm-3">
                            <div class="form-group">
                                <label class="control-label">Disability Certificate No.<span class="text-danger">*</span></label>                                
                                <asp:TextBox runat="server" CssClass="form-control" ID="txtdisabilitycertificateNumber"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                </div>
                <center>
                <asp:Button runat="server" class="btn btn-primary" id="btn_personalinformations" name="btn_personalinformations" Text="Save Details" OnClick="btn_personalinformations_Click"></asp:Button>

               
            </center>
          
        </div>
            </div>
    </section>

       
             <table class="table table-bordered table-striped dataTable">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Application Number</th>
                    <th>Student Name</th>
                    <th>Examination Description</th>
                    <th>Description</th>                    
                    <th>Proceed</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    String applicationNo = Request.QueryString["applicationNo"];

                  
                    var details = nav.BulkProcessLines.Where(r => r.Bulk_Header_No == applicationNo && r.Document_Type=="Registration");
                   
                    int programesCounter = 0;
                    foreach (var detail in details)
                    {
                        programesCounter++;
                %>
                <tr>
                    <td><%=programesCounter %></td>
                    <td><%=detail.Bulk_Header_No %></td>
                    <td><%=detail.Student_Name %></td>
                    <td><%=detail.Course_Description %></td>
                    <td><%=detail.Description %></td>

                   
                    <td><a href="PrivateStudentBooking.aspx?applicationNo=<%=detail.Bulk_Header_No%>" class="btn btn-success"><i class="fa fa-eye"></i>Generate Invoice</a></td>
                </tr>
                <%  
                    } %>
            </tbody>
        </table>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous"/>
          <%--  <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" OnClick="Unnamed1_Click" />--%>

            <div class="clearfix"></div>
        </div>
    </div>
    <%} %>




</asp:Content>
