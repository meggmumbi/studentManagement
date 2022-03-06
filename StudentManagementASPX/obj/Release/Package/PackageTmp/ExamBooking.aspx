<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExamBooking.aspx.cs" Inherits="StudentManagementASPX.Service_References.ExamBooking" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="assets/css/sweetalert2.all.js"></script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <%
        const int maxStep = 5;
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


    <div class="panel panel-primary">
        <div class="panel-heading">
            Student Booking<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Examination Booking</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div2" runat="server"></div>
                        <div id="Div3" runat="server"></div>
                        <div runat="server" id="Div4"></div>

                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group" hidden>
                                    <label>Student No:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="studentNo" ReadOnly />
                                </div>

                                <div class="form-group">
                                    <label>Registration No:</label>
                                    <asp:Textbox CssClass="form-control" runat="server" ID="regNos" Placeholder="reg no" ReadOnly />
                                </div>

                                
                                <div class="form-group">
                                    <label>Examination Sitting:</label>
                                    <asp:DropDownList CssClass="form-control select2" runat="server" ID="examCycle" />
                                </div>

                                <div class="form-group" style="display: none">
                                    <label>Examination description:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="courseDescription" />
                                    <asp:TextBox CssClass="form-control" runat="server" ID="courseId" />
                                </div>                          

                                 <p class="col-md-offset-3">--Renewal && Reactivation Information --</p>       
                                  <div class="form-group">
                                    <label> Renewal Amount:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="renewalAmount" ReadOnly />
                                </div>
                                <div class="form-group">
                                    <label>Reactivation Amount:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="reACtivation" ReadOnly />
                                </div>
                            </div>
                                              

                            <div class="col-md-6">
                              
                                <div class="form-group" style="display: none">
                                    <label>Exam centre:</label>
                                    <asp:DropDownList CssClass="form-control select2" runat="server" ID="examCenter" Placeholder="Name" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </div>
        <div class="panel-footer">
            <%
                string regnumber = regNos.Text;
                var examinationAccounts = nav.ExaminationAccounts.Where(x => x.Registration_No == regnumber && x.Status == "Active" && x.Renewal_Amount > 0 ).ToList();
                if (examinationAccounts.Count == 0)
                {%>
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextExamDetails" OnClick="next_Click" />
            <%}
                else if (examinationAccounts.Count > 0)
                {%>
              <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Proceed to Renew" ID="renew" OnClick="renew_Click" />

             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Renew and Book" ID="Button1" OnClick="next_Click" />

            <%  }
            %>

            <div class="clearfix"></div>
        </div>

    </div>


    <%
        }
        else if (myStep == 2)
        {
    %>

    <div class="panel panel-primary setup-content" id="step-2">
        <div class="panel-heading">
            <strong>Examination Papers <i>(Please select Examination level you wish to apply for the examination <%=Request.QueryString["courseid"]%>).</i></strong>
        </div>

        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                        <li class="breadcrumb-item active">Examination Booking </li>
                    </ol>
                </div>
            </div>
             <div runat="server" id="response" />
            <%

                string courseId = Request.QueryString["courseid"];
                string StudentNumber = Convert.ToString(Session["studentNo"]);

                var examBookingEntries = nav.ExamBookingEntries.Where(r => r.Stud_Cust_No == StudentNumber && r.Examination == courseId).ToList();

                int level = 1;
                if (courseId == "ATD" || courseId == "CAMS")
                {
            %>
            <div class="row">
                <div class="card">
                    <div class="card-header text-center" data-background-color="darkgreen">
                        <h5 class="title"><i>Examination Papers</i></h5>
                    </div>
                </div>
            </div>

            <h5><strong><u>Booked Papers</u></strong></h5>
            <br />
            <div runat="server" id="Div1" />
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <div runat="server" id="Div7"></div>
                        <table id="example1" class="table table-bordered table-striped PerformanceTargetsTable">
                            <thead>
                                <tr>
                                    <th></th>

                                    <th>Examination Level</th>
                                    <th>Examination Paper</th>
                                    <th>Examination</th>
                                    <th>Amount</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String applicationNo = Request.QueryString["applicationNo"];
                                    int y = 0;
                                    var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo && r.Type == "Booking");
                                    foreach (var line in studentProcessingLine)
                                    {
                                        y++;
                                %>
                                <tr>
                                    <td><%=y %></td>
                                    <td><% =line.Part %></td>
                                    <td><% =line.Paper %></td>
                                    <td><% =line.Description %></td>
                                    <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>
                                </tr>

                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <% }
                else

                { %>
    

            <div class="row">
                <div class="card">
                    <div class="card-header text-center" data-background-color="darkgreen">
                        <h5 class="title"><i>Examination Papers</i></h5>
                    </div>
                </div>
            </div>

            <h5><strong><u>Booked Papers</u></strong></h5>
            <br />
                      <div class="row">
                <div class="col-md-12 col-lg-12">

                    <asp:Button CssClass="btn btn-success" runat="server" ID="reload" Text="Reload Papers" OnClick="reload_Click"></asp:Button>

                </div>
            </div>
            <br />
            <div runat="server" id="examBooking" />
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <div runat="server" id="Div5"></div>
                        <table id="example1" class="table table-bordered table-striped PerformanceTargetsTable">
                            <thead>
                                <tr>
                                    <th>#</th>

                                    <th>Examination Level</th>
                                    <th>Examination Paper</th>
                                    <th>Examination</th>
                                    <th>Amount</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String applicationNo = Request.QueryString["applicationNo"];
                                    int x = 0;
                                    var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Booking_Header_No == applicationNo && r.Type == "Booking").ToList();
                                    foreach (var line in studentProcessingLine)
                                    {
                                        x++;
                                %>
                                <tr>
                                    <td><%=x %></td>
                                    <td><% =line.Part %></td>
                                    <td><% =line.Paper %></td>
                                    <td><% =line.Description %></td>
                                    <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                                    <td>                                    
                                         <Label class="btn btn-danger" id="button" onclick="removeLine('<%=line.Description %>','<%=line.Paper %>');"><i class="fa fa-trash"></i>Delete</Label></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <%}%>



            <div class="panel-footer">
                <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click1" />
                <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-circle-o-right" Text="Next" ID="nextbutton" OnClick="nextbutton_Click" />

                <div class="clearfix"></div>
            </div>
        </div>
    </div>

    <%
    }
    else if (myStep == 3)
    {
    %>

    <div class="panel panel-default" style="width: 80%; margin: 0 auto">
        <asp:ScriptManager ID="ScriptManger1" runat="Server" />
        <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="panel-heading">
                    <strong>Examination centre.<i> (Please select the Examination centre that you would wish to take your examination from)</i></strong>
                </div>


                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="Dashboard.aspx">DashBoard </a></li>
                                <li class="breadcrumb-item active">Examination centres </li>
                            </ol>
                        </div>
                    </div>
                    <div id="examcenterz" runat="server"></div>
                    <div class="row" style="justify-content: center">
                        <div class="col-md-6 offset-3" style="float: none; margin: auto;">
                            <div class="form-group">
                                <strong>Examination Region:</strong>
                                <asp:DropDownList runat="server" ID="region" OnSelectedIndexChanged="region_SelectedIndexChanged" CssClass="form-control select2" AutoPostBack="true" />
                            </div>

                            <div class="form-group">
                                <strong>Examination Zone:</strong>
                                <asp:DropDownList runat="server" ID="zone" OnSelectedIndexChanged="Zone_SelectedIndexChanged" CssClass="form-control select2" AutoPostBack="true"/>
                            </div>


                            <div class="form-group">
                                <strong>Examination centre:</strong>
                                <asp:DropDownList runat="server" ID="examinationCenter" CssClass="form-control select2"/>
                            </div>
                        </div>
                    </div>
                </div>

                <center>
                    <asp:Button runat="server" class="btn btn-primary" ID="examceters" Text="Select Center" OnClick="examcenters_Click"></asp:Button>
                </center>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="Previousclick" OnClick="Previousclick_Click" />
                    <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-circle-o-right" Text="Next" ID="nextclick" OnClick="nextclick_Click" Visible="false" />

                    <div class="clearfix"></div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <%
        }
        else if (myStep == 4)
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
                        <li class="breadcrumb-item active">Exam Booking</li>
                    </ol>
                </div>
            </div>
            <div runat="server" id="submit" />
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <h5>I <b><% =Session["StudentName"] %></b>  hereby declare that l agree to abide by the Examination Rules and Regulations and Code of Conduct and Ethics for kasneb students.</h5>

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
                        <asp:Button runat="server" Text="Submit Exam Booking" ID="submitRegistration" CssClass="btn btn-primary" OnClick="submitRegistration_Click"/>
                    </center>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Visible="false" Text="Proceed to Payment" ID="Payment" OnClick="Payment_Click" />
            <div class="clearfix"></div>
        </div>
    </div>
    <%
        }
        else if (myStep == 5)
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
            </div>            
                <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Examination Booking Payment</strong></h3>
                </div>
            </div>
        </div>
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
    </div>
    <div class="clearfix"></div>







    <%} %>


    <!-- JS -->
    <div id="plogsActivities" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">List of All Examinations Papers </h4>
                </div>
                <div class="modal-body">

                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <strong>Level :</strong>
                                    <asp:TextBox runat="server" ID="ExamPapers" CssClass="form-control select2 ExamPapers" />
                                </div>

                                <div class="form-group" style="display: none">
                                    <strong>ApplicationNo </strong>
                                    <asp:TextBox runat="server" ID="ApplicationNo" CssClass="form-control select2 ApplicationNo" />

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div runat="server" id="generalfeedbacks"></div>
                            <input type="hidden" value="<% =Convert.ToString(Session["AllLevel"]) %>" id="txtLevel" />
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" id="txtAppNo" />
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped selectedprequalificationsWorks" id="example3">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Code</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <% 
                                            string examId = Request.QueryString["courseid"];
                                            string studentNo = Convert.ToString(Session["studentNo"]);
                                            string parts = ExamPapers.Text;
                                            var program = nav.ExamBookingEntries.Where(r => r.Stud_Cust_No == studentNo && r.Part == parts).ToList();
                                            var exemptionEntries = nav.ExemptionEntries.Where(r => r.Stud_Cust_No == studentNo && r.Course_Id == examId).ToList();
                                            if (exemptionEntries.Count == 0 && program.Count == 0)
                                            {
                                                var papers = nav.Papers.Where(r => r.Course == examId && r.Level == parts);
                                                foreach (var nbpaperz in papers)

                                                {
                                        %>
                                        <tr>
                                            <td>
                                                <input type="checkbox" id="worksselected" name="worksselected" class="checkboxes" value="<% =nbpaperz.Code %>" /></td>
                                            <td><% =nbpaperz.Code %></td>
                                            <td><% =nbpaperz.Description %></td>


                                            <%}
                                               }
                                            
                                                 if (exemptionEntries.Count > 0) {
                                                    List<StudentProcessing> studetnEntriesz = new List<StudentProcessing>();

                                                    foreach (var exemptionEntrys in exemptionEntries)
                                                    {

                                                        StudentProcessing list1 = new StudentProcessing();
                                                        list1.Papercode = exemptionEntrys.No;

                                                        studetnEntriesz.Add(list1);

                                                    }

                                                    List<StudentProcessing> studetnExemptEntries = new List<StudentProcessing>();
                                                    StudentProcessing[] exemptEntryArray = studetnExemptEntries.ToArray();

                                                    var papersz = nav.Papers.Where(r => r.Course == examId && r.Level == parts);

                                                    foreach (var subtopic in papersz)
                                                    {

                                                        StudentProcessing list = new StudentProcessing();
                                                        list.code = subtopic.Code;
                                                        list.description = subtopic.Description;
                                                        studetnExemptEntries.Add(list);
                                                    }
                                                    HashSet<string> diffidsz = new HashSet<string>(studetnEntriesz.Select(s => s.Papercode));

                                                    var result = studetnExemptEntries.Where(m => !diffidsz.Contains(m.code)).ToList();
                                                 
                                                    foreach (var nbpaperz in result)
                                                    {
                                        %>
                                        <tr>
                                            <td>
                                                <input type="checkbox" id="worksselected" name="worksselected" class="checkboxes" value="<% =nbpaperz.code %>" /></td>
                                            <td><% =nbpaperz.code %></td>
                                            <td><% =nbpaperz.description %></td>

                                            <%}
                                                }
                                           

                                                if (exemptionEntries.Count > 0 && program.Count > 0)
                                                {



                                                    var examinationEntryCode = "";
                                                    List<StudentProcessing> studetnExamEntriesz = new List<StudentProcessing>();

                                                    foreach (var examEntry in exemptionEntries)
                                                    {

                                                        StudentProcessing list1 = new StudentProcessing();
                                                        list1.Papercode = examEntry.No;

                                                        studetnExamEntriesz.Add(list1);

                                                    }

                                                    List<StudentProcessing> studetnExamEntries = new List<StudentProcessing>();
                                                    StudentProcessing[] examEntryArray = studetnExamEntries.ToArray();

                                                    var papers = nav.Papers.Where(r => r.Course == examId && r.Level == parts);

                                                    foreach (var subtopic in papers)
                                                    {

                                                        StudentProcessing list = new StudentProcessing();
                                                        list.code = subtopic.Code;
                                                        list.description = subtopic.Description;
                                                        studetnExamEntries.Add(list);
                                                    }
                                                    HashSet<string> diffids = new HashSet<string>(studetnExamEntriesz.Select(s => s.Papercode));


                                                    //List 1
                                                    var result = studetnExamEntries.Where(m => !diffids.Contains(m.code)).ToList();


                                                    
                                                        List<StudentProcessing> studetnEntriesz = new List<StudentProcessing>();

                                                        foreach (var examEntryz in result)
                                                        {

                                                            StudentProcessing list2 = new StudentProcessing();
                                                            list2.Papercode = examEntryz.code;

                                                            studetnEntriesz.Add(list2);

                                                        }

                                                        List<StudentProcessing> studetnExamEntriez = new List<StudentProcessing>();
                                                        StudentProcessing[] exemptEntryArray = studetnExamEntriez.ToArray();

                                                        var ExamPapers = nav.Papers.Where(r => r.Course == examId && r.Level == parts);

                                                        foreach (var subtopic in papers)
                                                        {

                                                            StudentProcessing list = new StudentProcessing();
                                                            list.code = subtopic.Code;
                                                            list.description = subtopic.Description;
                                                            studetnExamEntriez.Add(list);
                                                        }
                                                        HashSet<string> diffidz = new HashSet<string>(studetnEntriesz.Select(s => s.Papercode));
                                                        //var list3 = studetnEntriesz.Except(studetnEntriesz).ToList();
                                                        //list 2
                                                        var resultz = studetnExamEntriez.Where(m => !diffidz.Contains(m.code)).ToList();


                                                        foreach (var item in resultz)
                                                        {

                                            %>
                                        <tr>
                                            <td>
                                                <input type="checkbox" id="worksselecteds" name="worksselecteds" class="checkboxes" value="<% =item.code %>" /></td>
                                            <td><% =item.code %></td>
                                            <td><% =item.description %></td>

                                            <%}
                                                }
                                             

                                                else if (program.Count > 0)
                                                {

                                                    //var examinationEntryCode = "";
                                                    List<StudentProcessing> studetnExamEntryz = new List<StudentProcessing>();

                                                    foreach (var examEntry in program)
                                                    {

                                                        StudentProcessing list1 = new StudentProcessing();
                                                        list1.examCode = examEntry.Paper;

                                                        studetnExamEntryz.Add(list1);

                                                    }

                                                    List<StudentProcessing> studetnExamEntrys = new List<StudentProcessing>();
                                                    StudentProcessing[] examEntryArrays = studetnExamEntrys.ToArray();

                                                    var Expapers = nav.Papers.Where(r => r.Course == examId && r.Level == parts);

                                                    foreach (var subtopic in Expapers)
                                                    {

                                                        StudentProcessing list = new StudentProcessing();
                                                        list.code = subtopic.Code;
                                                        list.description = subtopic.Description;
                                                        studetnExamEntrys.Add(list);
                                                    }
                                                    HashSet<string> Exdiffids = new HashSet<string>(studetnExamEntryz.Select(s => s.examCode));


                                                    //List 1
                                                    var results = studetnExamEntrys.Where(m => !Exdiffids.Contains(m.code)).ToList();

                                                    foreach (var item in results)
                                                    {

                                            %>
                                        <tr>
                                            <td>
                                                <input type="checkbox" id="worksselecteds" name="worksselecteds" class="checkboxes" value="<% =item.code %>" /></td>
                                            <td><% =item.code %></td>
                                            <td><% =item.description %></td>
                                            <% }

                                                    }%>
                                          
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-md-12 col-lg-12">
                                <input type="button" id="btn_apply_SubmitTargets" class="btn btn-success btn_apply_SubmitTargets" name="btn_apply_SubmitTargets" value="Submit Selected papers" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <script type='text/javascript'>
        $(document).ready(function () {

          


            
    
        });



    </script>

    <script>

        function removeLine(name, no) {
            document.getElementById("fueltoRemoveName").innerText = name;
            document.getElementById("MainContent_removeFuelNumber").value = no;
            $("#removeFuelModal").modal();
        }
    </script>
    <script>
        function makePayments(no) {
            document.getElementById("MainContent_ApplicationNo").value = no;

            $("#MakepaymentsModal").modal();
        }
    </script>
    <div id="removeFuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Examination Paper</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Examination Paper  <strong id="fueltoRemoveName"></strong> from the Booking? </p>
                    <asp:TextBox runat="server" ID="removeFuelNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Examination Paper" ID="delete" OnClick="delete_Click" />
                </div>
            </div>

        </div>
    </div>

    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Examination Booking Payments</h4>
                </div>
                <div class="modal-body">
                    <asp:TextBox runat="server" ID="TextBox3" type="hidden" />
                    <div class="form-group">
                        <strong>Invoice Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="InvoiceNo" placeholder="Invoice Number" ReadOnly="true" />

                    </div>
                    <div class="form-group">
                        <strong>Amount:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="Amount" ReadOnly="true" />
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

</asp:Content>
