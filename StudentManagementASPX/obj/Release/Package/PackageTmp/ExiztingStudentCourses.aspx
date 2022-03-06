<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExiztingStudentCourses.aspx.cs" Inherits="StudentManagementASPX.ExiztingStudentCourses" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

      <div class="panel-heading">

        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                <div class="panel panel-default">
                    <p>Kasneb Examinations</p>
                    <div class="panel-heading">Examinations</div>
                    <div class="panel-body">                      
                        <div class="row" style="display:none">
                            <div class="col-lg-6">
                                  <div class="form-group">
                        <label>Exam Cycle:</label>
                        <asp:TextBox CssClass="form-control" runat="server" ID="Cycle" required ReadOnly/>
                        <asp:TextBox CssClass="form-control" runat="server" ID="projectCode" required ReadOnly Visible="false" />
                        </div>
                            </div>

                        </div>
                                <table class="table table-bordered table-striped datatable" id="example2">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Examination Id</th>
                                        <th>Description</th>                                       
                                        <th>Register</th>
                                </thead>
                                <tbody>
                                    <%
                                        var nav = Config.ReturnNav();
                                        var courses = nav.ExamCourses.Where(r=>r.Job_No== projectCode.Text);
                                        int counter = 0;
                                        foreach (var Coursez in courses)
                                        {
                                            counter++;
                                    %>
                                    <tr>
                                        <td><%=counter %></td>
                                        <td><%=Coursez.Job_Task_No%></td>
                                        <%-- <td><a href="ExistingStudents.aspx?courseId=<%=Coursez.Code %>"><%=Coursez.Description %></a></td>
                                        <td><%=Coursez.Domain_ID %></td>
                                        <td><a href="javascript:viewsections('<%=Coursez.Code%>');"><%=Coursez.No_of_Parts %></a></td>         --%>

                                        <%--<td><%=Coursez.No_of_Sections %></td>--%>
                                        <td><%=Coursez.Description %></td>
                                        <%
                                            if (string.IsNullOrEmpty((string)Session["studentNo"]))
                                            {
                                        %>
                                        <td><a href="StudentRegistration.aspx?courseId=<%=Coursez.Job_Task_No %>&&cycle=<%=Cycle.Text %>&&projectCode=<%=projectCode.Text %>" class="btn btn-primary">Enroll now</a></td>
                                        <%}
                                            else if (Session["studentNo"] != null)
                                            {
                                        %>
                                        <td><a href="ExistingStudents.aspx?courseId=<%=Coursez.Job_Task_No %>&&cycle=<%=Cycle.Text %>&&projectCode=<%=projectCode.Text %>" class="btn btn-primary">Enroll now</a></td>


                                        <%} %>
                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                          <h4 style="color: red"><u>Note:</u></h4>
                    <p></p><br />
                        <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-right" Style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Next_Click"/>

                        </div>
                    </div>
                  
            </div>
        </div>
    </div>
        <script type="text/javascript">
            function viewsections(code) {       
                document.getElementById("MainContent_courseCode").value = code;
            $("#view").modal();
        }
    </script>

    
    <div id="view" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Papers</h4>
                </div>
                <div class="modal-body">
                   <asp:TextBox runat="server" ID="courseCode" CssClass="form-control" />
                     <asp:TextBox runat="server" ID="test" CssClass="form-control" />
                    <table class="table table-bordered table-striped datatable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Part</th>                                       
                                        <th>Decsription</th>
                                      
                                </thead>
                                <tbody>
                                    <%
                                       
                                        var paper = nav.Papers.Where(r=>r.Course == courseCode.Text);
                                        int i = 0;
                                        foreach (var paperz in paper)
                                        {
                                            i++;
                                    %>
                                    <tr>
                                        <td><%=i %></td>
                                        <td><%=paperz.Level %></td>
                                        <td><%=paperz.Description %></td>

                                       
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

      <div class="clearfix"></div>
</asp:Content>
