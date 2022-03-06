<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Renewal.aspx.cs" Inherits="StudentManagementASPX.Renewal" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="assets/css/sweetalert2.all.js"></script>
   
    <script type="text/javascript">
       
        function CalculateTotal(inputVal) {

            var output = document.getElementById('<%=totalAmt.ClientID %>');          
            var query = document.getElementById('<%=RenAmount.ClientID %>');
            var reactivation = document.getElementById('<%=reACtivation.ClientID %>');

            output.value = parseFloat(query.value) * parseFloat(inputVal.value);
            document.getElementById('<%=totalAmt.ClientID%>').value = parseFloat(query.value) * parseFloat(inputVal.value);

            document.getElementById("<%:myHiddenId.ClientID%>").value = parseFloat(query.value) * parseFloat(inputVal.value) + parseFloat(reactivation.value);
          //  document.getElementById("<%=RenReact.ClientID%>").value = parseFloat(query.value) * parseFloat(inputVal.value) + parseFloat(reactivation.value);
            

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
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
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
                        var details = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Renewal_Amount > 0).ToList();
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

                        <td><a href="Renewal.aspx?step=2" class="btn btn-success"><i class="fa fa-plus"></i>Make Renewal Application</a></td>

                        
                    </tr>
                    <%  
                        } %>
                </tbody>
                 </table>
                </div>
            </div>
        </div>
    </div>

     <%
         }
         else if (step == 2)
         {
     %>
    
        <div class="panel panel-primary">
        <div class="panel-heading">
            Renewals<div class="pull-right"><i class="fa fa-angle-left"></i>Step 2 of 4<i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Renewals</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div2" runat="server"></div>
                        <div id="Div3" runat="server"></div>
                        <div runat="server" id="Div4"></div>                      
                           <asp:HiddenField ID ="myHiddenId" runat ="server" />
                        <div class="row">

                            <div class="col-md-6">
                                <div class="form-group" hidden>
                                    <label>Student No:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="studentNo" ReadOnly />
                                </div>

                                <div class="form-group" style="display:none">
                                    <label>Registration No:</label>
                                    <asp:Textbox CssClass="form-control" runat="server" ID="regNos" Placeholder="Name" ReadOnly />
                                </div>

                                 <p class="col-md-offset-3">--Renewal && Reactivation Information --</p> 
                                  <div class="form-group" >
                                    <label>Renewal pending:</label>
                                    <asp:Textbox CssClass="form-control" runat="server" ID="renPends" Readonly />
                                </div>      
                                  <div class="form-group">
                                    <label> Renewal Amount:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="renewalAmount" ReadOnly />
                                </div>
                                <div class="form-group">
                                    <label>Reactivation Amount:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="reACtivation" ReadOnly />
                                </div>
                                <div style="display:none">
                                <div class="form-group">
                                    <label>Specify renewal years you are applying for:</label>
                                    <asp:TextBox onblur="CalculateTotal(this);" TextMode="Number" CssClass="form-control" runat="server" ID="RenewalYr" />
                                </div>
                                <div class="form-group">
                                    <label>Renewal Amount per year:</label>
                                    <asp:TextBox TextMode="Number" CssClass="form-control" runat="server" ID="RenAmount" ReadOnly />
                                </div>
                                    </div>
                                <div class="form-group">
                                    <label>Total Renewals</label>
                                    <asp:TextBox TextMode="Number" CssClass="form-control" runat="server" ID="totalAmt" ReadOnly />
                                </div>
                                
                                 

                           
                                    <!-- accepted payments column -->
                                    <div class="col-xs-6">
                                      <p class="lead">Payment Method:</p>         
       
                                      <img src="assets/img/paybill-number.jpg" width="101px" height="60px"/>
                                      <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
                                        Payment is strictly by Mpesa
                                      </p>
                                    </div>
    
     
                            <div class="col-xs-6">
                                <p class="lead">
                                    <label>Amount Due</label></p>

                                <div class="table-responsive">
                                    <table class="table">

                                        <tr>
                                            <th>Total (Renewal + Reactivation):</th>
                                            <td><strong> <asp:TextBox TextMode="Number" CssClass="form-control" runat="server" ID="RenReact" ReadOnly /></strong></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                                          </div>
                            <div class="col-md-6">
                              
                                <div class="form-group" style="display: none">
                                    <label>Exam centre:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="examCenter" Placeholder="Name" />
                                </div>
                            </div>
                </div>
                </div>
                </div>
            </section>

        </div>
        <div class="panel-footer">
        
              <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="renew"/>

             <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Renew" ID="Button1" OnClick="renew_Click" />

            <div class="clearfix"></div>
        </div>

    </div>

   

     <%
        }
        else if (step == 3)
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
                    <h3 class="title"><strong>Renewal Payment</strong></h3>
                </div>
            </div>
        </div>
            <br />
                <div class="row">

                    <div class="tab-content">
                        <div class="tab-pane fade active in" id="tab_1_1" style="width: 100%">
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
                                                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" EnableViewState="true" />
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

            </div>



        </div>
    </div>
    <div class="clearfix"></div>






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
            <div runat="server" id="submit"></div>
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
        <script>
        function makePayments(no) {
            document.getElementById("MainContent_InvoiceNo").value = no;

            $("#MakepaymentsModal").modal();
        }
    </script>
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
