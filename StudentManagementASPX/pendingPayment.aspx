<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="pendingPayment.aspx.cs" Inherits="StudentManagementASPX.pendingPayment" %>

<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            $('#example1').DataTable()
            $('#example2').DataTable({
                'paging': true,
                'lengthChange': false,
                'searching': false,
                'ordering': true,
                'info': true,
                'autoWidth': false
            })
        })
    </script>

    <script>
        $("#MakepaymentsModal").dialog({
            appendTo: "form"

        });
    </script>
    <script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
        <div class="row">
            <div class="card">
                  <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Student Portal</strong></h3>
                </div>
            </div>
        </div>
       <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
  <div class="content container-fluid">

        <h5><u>Submitted Applications Pending Payment</u></h5>
            <%
            if (string.IsNullOrEmpty((string)Session["studentNo"]))
            {
        %>
               <div class="row">
                  <div id="feedback" runat="server" /> 
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Passport No</th>
                        <th>Address</th>
                        <th>Examination Id</th>
                      <%--  <th>Edit</th>--%>
                        <th>Payment</th>

                    </tr>
                </thead>
                     <tbody>
                         <%  var nav = Config.ReturnNav();
                             string IdNumber = Convert.ToString(Session["idNumber"]);
                             string application = "";

                             var detailz = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration" && r.Submitted == true).ToList();
                             if (detailz.Count > 0)
                             {
                                 foreach (var detailsz in detailz)
                                 {
                                     application = detailsz.No;
                                 }
                             }
                             var mpesa = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == application).ToList();
                             if (mpesa.Count == 0)
                             {
                                 var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration" && r.Submitted == true).ToList();

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
                             <td><%=detail.Examination_ID %></td>
                             <%--  <td><a href="StudentRegistration.aspx?step=1&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Edit</a></td>--%>
                             <td><a href="PaymentInvoice.aspx?&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Complete Application</a></td>
                         </tr>
                         <%  
                                 
                             }
                         } %>
                     </tbody>
                 </table>
                </div>
            </div>
               </div>

      <%}


          else if (Session["studentNo"] != null)
          {
        %>
       <div class="row">
                  <div id="Div1" runat="server" /> 
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Passport No</th>
                        <th>Address</th>
                        <th>Examination Id</th>
                      <%--  <th>Edit</th>--%>
                        <th>Payment</th>

                    </tr>
                </thead>
                     <tbody>
                         <%  var nav = Config.ReturnNav();
                             string IdNumber = Convert.ToString(Session["idNumber"]);
                             string application = "";

                             var detailz = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration" && r.Submitted == true).ToList();
                             if (detailz.Count > 0)
                             {
                                 foreach (var detailsz in detailz)
                                 {
                                     application = detailsz.No;
                                 }
                             }
                             var mpesa = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == application).ToList();
                             if (mpesa.Count == 0)
                             {
                                 var details = nav.StudentProcessing.Where(r => r.ID_Number_Passport_No == IdNumber && r.Document_Type == "Registration" && r.Submitted == true).ToList();

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
                             <td><%=detail.Examination_ID %></td>
                             <%--  <td><a href="StudentRegistration.aspx?step=1&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Edit</a></td>--%>
                             <td><a href="PaymentInvoice.aspx?&&applicationNo=<%=detail.No%>&&courseId=<%=detail.Examination_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Complete Application</a></td>
                         </tr>
                         <%  
                             }
                         } %>
                     </tbody>
                 </table>
                </div>
            </div>
        </div>
        <%} %>
    </div>
    




    <script>
        function makePayments(no, name) {
            document.getElementById("MainContent_accreditationnumber").value = no;
            document.getElementById("MainContent_studentNUmber").value = name;
            $("#MakepaymentsModal").modal();
        }
    </script>
    <asp:HiddenField ID="MyHiddenControl" Value="name" runat="server" />

    <div id="MakepaymentsModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Examination registration Payment</h4>
                </div>
                <div class="modal-body">

                    <asp:TextBox runat="server" ID="editRationaleCode" type="hidden" />
                    <div class="form-group">
                        <strong>Application Number:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="accreditationnumber" />

                    </div>
                    <div class="form-group">
                        <strong>Student No:</strong>
                        <asp:TextBox runat="server" CssClass="form-control" ID="studentNUmber" />
                    </div>
                    <div class="form-group">
                        <strong>Payment Mode:</strong>
                        <asp:DropDownList runat="server" CssClass="form-control" ID="paymentsM" />
                    </div>
                    <div class="form-group">
                        <strong>Payment Document:</strong>
                        <asp:FileUpload runat="server" ID="paymentdocument" CssClass="form-control" Style="padding-top: 0px;" />
                        <asp:RequiredFieldValidator runat="server" ID="payments" ControlToValidate="paymentdocument" ErrorMessage="Please attach the Payment Document!" ForeColor="Red" />
                        <div class="form-group">
                            <strong>Payment Reference Number:</strong>
                            <asp:TextBox runat="server" CssClass="form-control" ID="paymentsref" placeholder="Payment Reference Number" />
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Payments" ID="makePayments" OnClick="makePayments_Click" EnableViewState="true" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
