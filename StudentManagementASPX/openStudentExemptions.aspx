<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="openStudentExemptions.aspx.cs" Inherits="StudentManagementASPX.openStudentExemptions" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
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
       <center>
        <p><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
        <h5><u>Unsubmitted Applications</u></h5>
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
            <div class="col-md-12">
                <div class="table-responsive">
                 <table class="table table-striped table-bordered" style="width:100%" id="example4">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Application No</th>
                        <th>Student Name</th>
                        <th>Id Number</th>
                        <th>Registration Number</th>
                        <th>Examination Description</th>

                        <th>Edit</th>

                    </tr>
                </thead>
                 <tbody>
                    <% 
                        //String applicationNo = Request.QueryString["applicationNo"];
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["studentNo"]);
                        var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Document_Type == "Exemption" && r.Approval_Status=="Open");
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
                          <td><%=detail.Student_Reg_No %></td>
                        <td><%=detail.Examination_ID %></td>
                       
                       

                        <td><a href="StudentExemptions.aspx?step=1&&courseId=<%=detail.Examination_ID%>&&applicationNo=<%=detail.No %>" class="btn btn-success"><i class="fa fa-eye"></i>Edit Application</a></td>
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
