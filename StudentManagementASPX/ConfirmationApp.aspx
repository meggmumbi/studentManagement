<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ConfirmationApp.aspx.cs" Inherits="StudentManagementASPX.ConfirmationApp" %>
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
        <h5><u>Examination Accounts</u></h5>
        <div runat="server" id="linesFeedback"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Registration No:</th>
                                <th>Examination Id</th>
                                <th>Examination</th>
                                <th>Student Name</th>
                                <th>Student IdNo</th>
                                <th>Status</th>
                                <th>Registration Date</th>

                                 <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                var nav = Config.ReturnNav();
                                string studentNumber = Convert.ToString(Session["studentNo"]);
                                //string applicationNumber = Request.QueryString["applicationNo"];
                                var programs = nav.ExaminationAccounts.Where(r => r.Student_Cust_No == studentNumber && r.Blocked == false);
                                foreach (var programe in programs)
                                {

                            %>
                            <tr>
                                <td><%=programe.Registration_No %></td>
                                <%--<td><%=program.Student_No %></td>--%>
                                <td><%=programe.Course_ID %></td>
                                <td><%=programe.Course_Description %></td>
                                <td><%=programe.First_Name %> <%=programe.Middle_Name %> <%=programe.Surname %></td>
                                <td><%=programe.ID_No %></td>
                                <td><%=programe.Status %></td>
                                <td><%=Convert.ToDateTime(programe.Registration_Date).ToString("MM/dd/yyyy") %></td>
                                 <td><label class="btn btn-default" onclick="CloseRisk('<% =programe.Student_Cust_No %>','<%=programe.Registration_No %>');"><i class="fa fa-trash"></i>Close</label></td>


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
    <script>

             function CloseRisk(studentNo, Regno) {
                 document.getElementById("itemName").innerText = Regno;
                 document.getElementById("MainContent_lineNo").value = studentNo;
           
            $("#removeLineModal").modal();
        }
    </script>
        <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation Application</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Apply for Confirmation of Examination Account<strong id="itemName"></strong>?</p>
                    <asp:TextBox runat="server" ID="lineNo" type="hidden" />
                   
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Apply" ID="apply" OnClick="apply_Click" />
                </div>
            </div>

        </div>
    </div>
    
</asp:Content>
