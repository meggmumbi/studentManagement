<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="myBookings.aspx.cs" Inherits="StudentManagementASPX.myBookings" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel panel-default">
        <div class="panel-heading">
            My Applications<div class="pull-right"></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">

            <div runat="server" id="Div1"></div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped dataTable" id="example4">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Student Name</th>
                            <th>Id Number</th>
                            <th>Examination Description</th>
                            <th></th>
                            <th></th>
                            <th></th>

                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            string application = "";
                            var nav = Config.ReturnNav();
                            string studentNo = Convert.ToString(Session["studentNo"]);
                            var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Booking" && r.Cancelled==false && r.Posted==false);
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
                            <td><%=detail.Examination_Description %></td>
                            <%
                                var drafts = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Booking" && r.Submitted == false).ToList();
                                if (drafts.Count > 0)
                                {

                            %>
                            <td><a href="ExamBooking.aspx?step=1&&courseId=<%=detail.Examination_ID %>&&applicationNo=<%=detail.No%>" class="btn btn-success"><i class="fa fa-pencil-square-o"></i>Edit application</a></td>
                            <%}

                                else
                                {%>
                            <td></td>
                            <%} %>

                            <%
                                var programz = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Booking" && r.Submitted == true && r.Posted==false).ToList();
                                if (programz.Count > 0)
                                {
                                    foreach (var detailsz in programz)
                                    {
                                        application = detailsz.No;
                                    }

                                    var mpesa = nav.MpesaTransaction.Where(r => r.ACCOUNT_NUMBER == application).ToList();
                                    if (mpesa.Count == 0)
                                    {%>
                             <td><a href="ExamBooking.aspx?step=1&&courseId=<%=detail.Examination_ID %>&&applicationNo=<%=detail.No%>" class="btn btn-success"><i class="fa fa-pencil-square-o"></i>Edit application</a></td>
                            <td><a href="BookingInvoice.aspx?applicationNo=<%=detail.No %>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed to payment</a></td>
                            <%}
                                else if(mpesa.Count > 0 && detail.Posted==false)
                                {

                            %>
                            <td><strong><%="Aplication Awaiting processing"%></strong></td>

                            <%        }
                                    else if (detail.Posted == true)
                                    { %>
                                       <td><strong><%="Your Student Timetable is ready!"%></strong></td>

                            <%    
                                    }
                                }

                                else
                                { %>
                            <td></td>
                            <%} %>
                        </tr>
                        <%  
                            } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</asp:Content>
