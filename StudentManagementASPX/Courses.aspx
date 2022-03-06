<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="StudentManagementASPX.Courses" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="panel-heading">
     


        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                <div class="panel panel-default">
                    <p>Kasneb Examinations</p>
                    <div class="panel-heading"><%=Request.QueryString["courseId"]%> Papers</div>
                    <div class="panel-body">


                        <table class="table table-bordered table-striped datatable">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Examination Level</th>
                                    <th>Description</th>
                            </thead>
                            <tbody>
                                <%
                                    string course = Request.QueryString["courseId"];
                                    var nav = Config.ReturnNav();
                                    var courses = nav.Papers.Where(R => R.Course == course);
                                    int counter = 0;
                                    foreach (var Coursez in courses)
                                    {
                                        counter++;
                                %>
                                <tr>
                                    <td><%=counter %></td>

                                    <td><%=Coursez.Level %></td>
                                    <td><%=Coursez.Description %></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
                <h4 style="color: red"><u>Note:</u></h4>
                <p></p>
            </div>
            <asp:Button runat="server" CssClass="btn btn-success pull-right fa fa-arrow-right" Style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Next_Click" />
        </div>






    </div>
    <div class="clearfix"></div>
    <script type="text/javascript">
        function viewsections(code) {
            document.getElementById("MainContent_courseCode").value = code;
            $("#view").modal();
        }
    </script>


    <%--<div id="view" class="modal fade" role="dialog">
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

                                var paper = nav.Papers.Where(r => r.Course == courseCode.Text);
                                int i = 0;
                                foreach (var paperz in paper)
                                {
                                    i++;
                            %>
                            <tr>
                                <td><%=i %></td>
                                <td><%=paperz.Part %></td>
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
    </div>--%>

    
</asp:Content>
