<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BookingInvoiceDeatails.aspx.cs" Inherits="StudentManagementASPX.BookingInvoiceDeatails" %>

<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
    <h5><u>Application Pending Payment</u></h5>
    <%--    <div class="row filter-row">
        <div class="col-sm-4 col-xs-6">
            <div class="form-group form-focus">
                <label class="control-label">Seacrh by  Procurement Method</label>
                <input type="text" class="form-control floating" />
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <div class="form-group form-focus">
                <label class="control-label">Search by Regions</label>
                <input type="text" class="form-control floating" />
            </div>
        </div>
        <div class="col-sm-4 col-xs-6">
            <a href="#" class="btn btn-success btn-block"> Search </a>
        </div>
    </div>--%>
    <div class="row">
        <div id="feedback" runat="server"></div>
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-bordered table-hover" style="width: 100%" id="example1">
                    <thead>
                        <tr>

                            <th>Application No:</th>
                            <th>Student No.</th>
                            <th>Student Name</th>
                            <th>Examination </th>
                            <th>Student Registration No</th>
                            <th>Amount</th>
                            <th></th>
                            <%-- <th>Receipt</th>--%>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            var nav = Config.ReturnNav();
                            string IdNumber = Convert.ToString(Session["idNumber"]);
                            string studentNumber = Convert.ToString(Session["studentNo"]);
                            string application = "";

                            var programz = nav.StudentProcessing.Where(r => r.Student_No == studentNumber && r.Document_Type == "Booking" && r.Submitted == true).ToList();
                            if (programz.Count > 0)
                            {
                                foreach (var detailsz in programz)
                                {
                                    application = detailsz.No;
                                }
                            }
                            var mpesa = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == application).ToList();
                            if (mpesa.Count == 0)
                            {
                                var programs = nav.StudentProcessing.Where(r => r.Student_No == studentNumber && r.Document_Type == "Booking" && r.Submitted == true).ToList();

                                int programesCounter = 0;
                                foreach (var program in programs)
                                {





                        %>
                        <tr>
                            <td><%=program.No %></td>
                            <td><%=program.Student_No %></td>
                            <td><%=program.Student_Name %></td>
                            <td><%=program.Examination_Description %></td>
                            <td><%=program.Student_Reg_No %></td>
                            <td><%=program.Booking_Amount%></td>


                            <td><a href="BookingInvoice.aspx?applicationNo=<%=program.No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Invoice</a></td>

                        </tr>
                        <%
                                }
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

</asp:Content>
