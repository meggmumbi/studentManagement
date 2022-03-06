<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RenewalApplications.aspx.cs" Inherits="StudentManagementASPX.RenewalApplications" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
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
    <h5><u>Renewal Applications</u></h5>
    <div class="row">
        <div runat="server" id="PaymentsMpesa" />
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-striped table-bordered" style="width: 100%" id="example4">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Student Name</th>
                            <th>Id Number</th>
                            <th>Renewal Amount </th>
                            <th></th>


                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            //String applicationNo = Request.QueryString["applicationNo"];
                            var nav = Config.ReturnNav();
                            string studentNo = Convert.ToString(Session["studentNo"]);
                            var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Renewal");
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
                            <td><%=detail.Renewal_Amount %></td>
                            <%if (detail.Posted == false)
                                {

                            %>
                            <td><a href="Renewal.aspx?step=3&&applicationNo=<%=detail.No%>" class="btn btn-success"><i class="fa fa-eye"></i>Complete Payment</a></td>
                            <%}%>
                        </tr>
                        <%  
                            } %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
</asp:Content>
