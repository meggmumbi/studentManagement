<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="MyExamBookings.aspx.cs" Inherits="StudentManagementASPX.PrivateStudent" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
         <div class="content container-fluid">
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h5 class="title"><i>Welcome to Student portal</i></h5>
                </div>
            </div>
        </div>
        <p>This Student Portal enables the students to assceess services related to kasneb examinations.</p>
        <h5><u>Booked Examinations</u></h5>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Student Name</th>
                        <th>Examination Id</th>
                        <th>Examination </th>
                        <th>Examination Center </th>
                        <th>Examination Sitting</th>
                        <th>Booking Amount</th>                                           
                        

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["studentNo"]);
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type=="Booking" && r.Posted==true && r.Cancelled==false);
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Student_Name %></td>
                        <td><%=detail.Examination_ID%></td>
                        <td><%=detail.Examination_Description %></td>
                        <td><%=detail.Examination_Center %></td>
                        <td><%=detail.Examination_Sitting %></td>
                        <td><%=detail.Booking_Amount %></td>
                                            
                        
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
