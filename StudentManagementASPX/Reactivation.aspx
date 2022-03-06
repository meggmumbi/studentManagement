<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reactivation.aspx.cs" Inherits="StudentManagementASPX.Reactivation" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="assets/css/sweetalert2.all.js"></script>
    <script>
        function success() {
            Swal.fire(
                'Reactivation Failed. Accept Our terms and conditions'


            )
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
     <%
        int step = 4;
        try
        {
            var nav = Config.ReturnNav();
            step = Convert.ToInt32(Request.QueryString["step"]);
            if (step > 4 || step < 1)
            {
                step = 1;
            }
        }
        catch (Exception)
        {
            step = 1;
        }
        if (step == 1)
        {
    %>
    <div class="row" style="width: 100%; margin: auto;">
        <div class="panel panel-default">
            <div class="panel-heading">
                Reactivation
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
            </div>

            <div class="panel-body">

                <div class="content container-fluid">
                    <div class="row">
                        <div class="card">
                            <div class="card-header text-center" data-background-color="darkgreen">
                                <h5 class="title"><i>Welcome to Student portal</i></h5>
                            </div>
                        </div>
                    </div>
                    <p>
                        This Portal enable a student to access services related to kasneb Examinations.

                    </p>
                    <h5><u>Examination Accounts</u></h5>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered" style="width: 100%" id="example4">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Registration No</th>
                                            <th>Registration Date</th>
                                            <th>Student Name</th>
                                            <th>Examination Id</th>
                                            <th>Examination</th>
                                            <th>Renewal Pending</th>
                                            <th>Renewal Amount</th>
                                            <th>Reactivation Amount</th>
                                            <th></th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% 

                                            string IdNumber = Convert.ToString(Session["idNumber"]);
                                            var nav = Config.ReturnNav();
                                            string studentNo = Convert.ToString(Session["studentNo"]);
                                            //string courseId = Request.QueryString["courseId"];
                                            var details = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Re_Activation_Amount > 0).ToList();
                                            //string university = Convert.ToString(Session["UniversityCode"]);
                                            int programesCounter = 0;
                                            foreach (var detail in details)
                                            {
                                                programesCounter++;
                                        %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.Registration_No %></td>
                                            <td><%=Convert.ToDateTime(detail.Registration_Date).ToString("dd/MM/yyyy") %></td>
                                            <td><%=detail.Name %></td>
                                            <td><%=detail.Course_ID %></td>
                                            <td><%=detail.Course_Description %></td>
                                            <td><%=detail.Renewal_Pending %></td>
                                            <td><%=detail.Renewal_Amount %></td>
                                            <td><%=detail.Re_Activation_Amount %></td>

                                            <td><a href="Renewal.aspx?step=3&&applicationNo=<%=detail.Registration_No%>" class="btn btn-success"><i class="fa fa-plus"></i>Make Renewal Payment</a></td>


                                        </tr>
                                        <%  
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <%--             <div id="feedback" runat="server"></div>
                <div runat="server" id="documentsfeedback"></div>
                <div runat="server" id="linesFeedback"></div>


                <div class="row">
                    <div class="com-md-4 col-lg-4">
                        <label>Student Name</label>
                        <asp:TextBox CssClass="form-control" ID="custName" runat="server" Enabled="false" />
                    </div>
                    <div class="com-md-4 col-lg-4" hidden>
                        <label>Student Number</label>
                        <asp:TextBox CssClass="form-control" ID="StudentNo" runat="server" Enabled="false" />
                    </div>
                    <div class="com-md-4 col-lg-4">
                        <label>Invoice Number</label>
                        <asp:DropDownList ID="invoiceNumber" runat="server" CssClass="form-control select2" OnSelectedIndexChanged="invoiceNumber_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>

                    </div>
                </div>
                <br />
                <div class="form-group">
                    <iframe runat="server" class="col-sm-12 col-xs-12 col-md-10 col-lg-10" height="500px" id="p9form" style="margin-top: 10px;"></iframe>
                </div>
            </div>
            <div class="panel-footer">

                <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="renew" OnClick="renew_Click" />

                <div class="clearfix"></div>
            </div>

        </div>
    </div>



    <div class="panel-footer">
        <%--    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="addICTHelpDeskRequest"  OnClientClick="if(this.value === 'Saving...') { return false; } else { this.value = 'Saving...'; }" />
                <span class="clearfix"></span>
            </div>
        </div>
        --%>
     <%
         }
         else if (step == 2)
         {
     %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            Reactivation Application
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 1 of 2 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div id="submit" runat="server"></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="#">Reactivation </a></li>
                        <li class="breadcrumb-item active">Dashboard</li>
                    </ol>
                </div>
            </div>
            <div id="ictFeedback" runat="server"></div>
            <div runat="server" id="Div1"></div>
            <div class="row">
                <div class="col-md-6 col-lg-6">

                    <div class="form-group">
                        <strong>Examination Id:</strong>
                        <asp:DropDownList runat="server" ID="regNo" CssClass="form-control" placeholder="Description" TextMode="MultiLine" />
                    </div>




                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" ID="amount" CssClass="form-control" placeholder="Description" />
                    </div>

                </div>
            </div>
                     <asp:Button runat="server" CssClass="btn btn-success pull-left" Text="Add Reactivation Line" ID="addICTHelpDeskRequest" OnClick="sendApproval_Click" OnClientClick="if(this.value === 'Saving...') { return false; } else { this.value = 'Saving...'; }" />

              <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Application No</th>
                                <th>Examination </th>
                                <th>Amount</th>
                               <th></th>
                                <th></th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav = Config.ReturnNav();
                                String applicationNo = Request.QueryString["applicationNo"];

                                var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo && r.Document_Type=="Re-Activation");
                                foreach (var line in studentProcessingLine)
                                {
                            %>
                            <tr>

                                <td><% =line.Booking_Header_No %></td>
                                <td><% =line.Course_Id %></td>                             
                                <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                                <td>
                                    <label class="btn btn-danger" onclick="removeLine('<% =line.Description %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                                <%--<td><a href="BookingInvoice.aspx?applicationNo=<%=line.Booking_Header_No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Invoice</a></td>--%>
                                <td><a href="Reactivation.aspx?step=3&&studentNo=<%=line.Student_No%>&&applicationNo=<%=line.Booking_Header_No %>&&courseId=<%=line.Course_Id%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>
                            </tr>
                            <% 
                                }
                            %>
                        </tbody>
                    </table>

        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" id="previous" OnClick="previous_Click" />
              <asp:Button runat="server" CssClass="btn btn-success pull-right" Visible="false" Text="Next" id="nextAttach" OnClick="nextAttach_Click" />

            <span class="clearfix"></span>
        </div>
    </div>
     <%
        }
        else if (step == 3)
        {
    %>
    <div class="panel-default setup-content" id="step-10">
        <div class="panel-heading">
            Mandatory Documents
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>

        </div>
        <div id="completefeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li  style="background-color: gray">
                    <a href="#tab_1_documents" data-toggle="tab">
                        <p style="color: black">Required Reactivation Documents</p>
                    </a>
                </li>
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_attach" data-toggle="tab">
                        <p style="color: black">Attach Document </p>
                    </a>
                </li>
                <%--         <li style="background-color:gray">
                    <a href="#tab_1_attached" data-toggle="tab"><p style="color:black">Attached Document </p></a>
                </li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade " id="tab_1_documents">
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>You are required to submit scanned copies of the following sets of documents, as part of your Reactivation process. Click on the Attach Documents Link, when ready to attach the supporting documents.</p>

                        </div>
                        <div class="col-md-12">
                            <asp:TextBox runat="server" ID="template" CssClass="form-control" Visible="false"></asp:TextBox>
                            <div class="table-responsive">
                                <table class="table table-striped custom-table datatable" id="">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Document Type</th>
                                            <th>Document Type</th>
                                            <th>Description</th>
                                            <th>Requirement Type</th>

                                    </thead>
                                    <tbody>
                                        <% 
                                            var nav1 = Config.ReturnNav();
                                           // string studentNo = Convert.ToString(Session["studentNo"]);
                                            string courseId = Request.QueryString["courseId"];
                                            var details = nav1.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Reactive" && r.Examiantion_ID == courseId);
                                            //string university = Convert.ToString(Session["UniversityCode"]);
                                            int programesCounter = 0;
                                            foreach (var detail in details)
                                            {
                                                programesCounter++;
                                        %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.Examination_Document_Type %></td>
                                            <td><%=detail.Examination_Document %></td>
                                            <td><%=detail.Description %></td>
                                            <td><%=detail.Requirement_Type %></td>



                                            <%--<td><a href="ExistingStudents.aspx?step=2&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.No %>&&courseId=<%=Request.QueryString["courseId"]; %>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>--%>
                                        </tr>
                                        <%  
                                            } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade active in" id="tab_1_attach">
                    <div id="keydocumentsuploadfeedback" style="display: none" data-dismiss="alert"></div>
                    <!-- The global progress bar -->
                    <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>This Section enables you to upload scanned copies of the supporting documents required as part of this Reactivation process.</p>
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
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control" ID="uploadsDoc"></asp:FileUpload>
                                    </div>
                                </div>
                                </div>
                            <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="fileuploads" OnClick="fileuploads_Click"/>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <th>Download</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try
                                        {
                                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Student Processing Header/";
                                            String applicationNo = Request.QueryString["applicationNo"].Trim();
                                            applicationNo = applicationNo.Replace('/', '_');
                                            applicationNo = applicationNo.Replace(':', '_');
                                            String documentDirectory = filesFolder + applicationNo + "/";
                                            if (Directory.Exists(documentDirectory))
                                            {
                                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                {
                                                    String url = documentDirectory;
                                    %>
                                    <tr>
                                        <td><% =file.Replace(documentDirectory, "") %></td>

                                        <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteOrganizationFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                    </tr>
                                    <%
                                                }
                                            }
                                        }
                                        catch (Exception)
                                        {

                                        }%>
                                </tbody>
                            </table>

                        </div>


                    </div>
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="prev" OnClick="prev_Click"/>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click"/>
                </div>

            </div>

        </div>
    </div>


    <%
        }
        else if (step == 4)
        {
    %>


    <div class="panel panel-default">
        <div class="panel-heading">
            Declaration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 4 of 4<i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
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
                        <h5>I <b><% =Session["StudentName"] %></b>  hereby declare that to the best of my knowledge all the information I have provided on this form and all supporting documents are true and correct and l agree to abide by the Examination Rules and Regulations and Code of Conduct and Ethics for kasneb students.</h5>

                    </div>
                    <div class="col-lg-12">

                        <asp:CheckBox runat="server" ID="declaration" />
                        <label class="font-noraml" for="acceptTerms">I agree with the Terms and Conditions.</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="text-center padding-15">
                    <center>
                       <%-- <asp:Button runat="server" class="btn btn-primary btn_submitregistration_Details" id="btn_submitregistration_Details" type="button" onclick=""> </asp:Button>--%>
                        <asp:Button runat="server" Text="Submit Registration" ID="submitRegistration" CssClass="btn btn-primary" OnClick="submitRegistration_Click"/>
                    </center>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed_Click1"/>

            <div class="clearfix"></div>
        </div>
    </div>

    <%
        }
    %>
</asp:Content>
