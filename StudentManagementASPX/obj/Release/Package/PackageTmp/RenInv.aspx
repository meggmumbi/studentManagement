<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RenInv.aspx.cs" Inherits="StudentManagementASPX.RenInv" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div>
        <div class="row">
            <div class="col-md-12 col-lg-12">
                <div class="panel panel-default">
                    <div class="panel-heading">Invoice</div>
                    <div class="panel-body">
                        <div id="feedback" runat="server"></div>
                        <table class="table table-striped table-bordered table-hover" id="example1">
                            <thead>
                                <tr>
                                    <th>Application No:</th>
                                    <th>Student No.</th>
                                    <th>Student Name</th>
                                    <th>Examination Id</th>
                                    <th>Registration No</th>
                                    <th>Amount</th>
                                    <th></th>
                                    <%-- <th>Receipt</th>--%>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    var nav = Config.ReturnNav();
                                    string studentNumber = Convert.ToString(Session["studentNo"]);
                                    //string applicationNumber = Request.QueryString["applicationNo"];
                                    var programs = nav.studentProcessingLines.Where(r => r.Student_No == studentNumber && r.Document_Type == "Renewal");
                                    foreach (var program in programs)
                                    {

                                %>
                                <tr>
                                    <td><%=program.Booking_Header_No %></td>
                                    <td><%=program.Student_No %></td>
                                    <td><%=program.Name %></td>
                                    <td><%=program.Course_Id %></td>
                                    <td><%=program.Registration_No %></td>
                                    <td><%=program.Amount%></td>
                                   

                                <td><a href="RenewalInvoice.aspx?applicationNo=<%=program.Booking_Header_No %>" class="btn btn-success"><i class="fa fa-eye"></i>View Invoice</a></td>

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

</asp:Content>
