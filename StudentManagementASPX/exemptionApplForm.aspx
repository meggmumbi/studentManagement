<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="signup.aspx.cs" Inherits="StudentManagementASPX.signup" %>

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
        <p>This Student Portal enables you to register for a kasneb Examination, book examination, apply for exemptions, withdrawal and deferment.</p>
        <h5><u>Exemption Papers</u></h5>
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
                        <th>Registration No</th>
                        <th>Registration Date</th>                        
                        <th>Examination Id</th>
                        <th>Examination</th>                        
                        <th>Name</th>
                        <th>Apply Now</th>

                    </tr>
                </thead>
                <tbody>
                    <% 

                        string IdNumber = Convert.ToString(Session["idNumber"]);
                        var nav = Config.ReturnNav();
                        string studentNo = Convert.ToString(Session["studentNo"]);
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNo && r.Status=="Active");
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Registration_No %></td>
                        <td><%=Convert.ToDateTime(detail.Registration_Date).ToString("dd/mm/yyyy") %></td>                     
                        <td><%=detail.Course_Description %></td>
                        <td><%=detail.Name %></td>
                        <td> <label class="btn btn-success pull-right" Style="margin-right: 100px;" onclick="createApplication('<% =x %>');"><i class="fa fa-arrow-right"></i>Apply Now</label></td>


                       
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
