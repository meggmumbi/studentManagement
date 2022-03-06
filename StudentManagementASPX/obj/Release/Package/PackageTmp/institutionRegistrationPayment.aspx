<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="institutionRegistrationPayment.aspx.cs" Inherits="StudentManagementASPX.institutionRegistrationPayment" %>
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


    <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Applications(s) Pending Payments(Please make Payments per Application)</div>
                    <div class="panel-body">
                        <div id="feedback" runat="server"></div>
                        <table class="table table-striped table-bordered table-hover" id="example1">
                            <thead>
                                <tr>
                                    <th>Exam Booking No:</th>
                                    <th>Student No.</th>
                                    <th>Examination Description</th>
                                    <th>Training Campus</th>
                                    <th>Exam center</th>
                                    <th>Receipt No</th>
                                    <th>Confirm Payment</th>
                                    <%-- <th>Receipt</th>--%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav = Config.ReturnNav();
                                    string studentNumber = Request.QueryString["studentId"];
                                    string applicationNumber = Request.QueryString["applicationNo"];
                                    var programs = nav.StudentProcessing.Where(r => r.No == applicationNumber && r.Student_No == studentNumber && r.Document_Type == "Booking" && r.Booking_Invoice_No != "");
                                    foreach (var program in programs)
                                    {

                                %>
                                <tr>
                                    <td><%=program.No %></td>
                                    <td><%=program.Student_No %></td>
                                    <td><%=program.Course_Description %></td>
                                    <td><%=program.Training_Institution %></td>
                                    <td><%=program.Examination_Center %></td>
                                    <td><%=program.Booking_Receipt_No %></td>

                                    <td>
                                        <label class="btn btn-success" onclick="makePayments('<%=program.No %>', '<%=program.Student_No %>');"><i class="fa fa-edit"></i>Make Payments</label></td>

                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                        <div class="col-xs-6">
                            <p class="lead">Receipt Details</p>

                            <div class="table-responsive">
                                <table class="table">
                                    <%

                                        string studentNo = Request.QueryString["studentId"];
                                        string applicationNo = Request.QueryString["applicationNo"];
                                        var programss = nav.StudentProcessing.Where(r => r.No == applicationNumber && r.Student_No == studentNumber && r.Document_Type == "Booking");
                                        foreach (var program in programss)
                                        {

                                    %>
                                    <tr>
                                        <th style="width: 50%">Reference No:</th>
                                        <td><%=program.Payment_Reference_No %></td>
                                    </tr>
                                    <tr>
                                        <th>Bank</th>
                                        <td><%=program.Pay_Mode%></td>
                                    </tr>
                                    <tr>
                                        <th>Receipt Number:</th>
                                        <td><%=program.Application_Receipt %></td>
                                    </tr>
                                    <tr>
                                        <th></th>
                                        <td><a href="BookingReceipt.aspx?receiptNo=<%=program.Application_Receipt%>&&applicationNo=<%=program.No %>&&studentNo=<%=program.Student_No %>" class="btn btn-success"><i class="fa fa-eye"></i>Generate Receipt</a></td>

                                    </tr>
                                    <%
                                        }
                                    %>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
