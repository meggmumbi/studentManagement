<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="registrationInstructions.aspx.cs" Inherits="StudentManagementASPX.registrationInstructions" %>

<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% 
        var x = "Professional";
        var y = "Post-Graduate";
        var z = "Technical/Diploma";
        var n = "Certificate";
        var m = "Vocational";

    %>

    <div class="content container-fluid">
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h5 class="title"><i><strong>Welcome to Student portal</strong></i></h5>
                </div>
                <br />
            </div>
        </div>
        <center>
        <p><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
        <div class="row" style="background-color: #D3D3D3">
            <div class="col-xs-4">
                <h6 style="color: red"><strong><u>Examination Registration General Instructions</u></strong></h6>
            </div>
        </div>


        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: #D3D3D3">
                    <a href="#tab_tender_PostGrad" data-toggle="tab">
                        <p style="color: black"><strong>Post Professional Examination</strong></p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_overview" data-toggle="tab">
                        <p style="color: black"><strong>Professional Examinations</strong> </p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_purchase_items" data-toggle="tab">
                        <p style="color: black"><strong>Diploma Examinations</strong></p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_documents" data-toggle="tab">
                        <p style="color: black"><strong>Certificate Examination</strong></p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_vocational" data-toggle="tab">
                        <p style="color: black"><strong>Vocational Examinations</strong></p>
                    </a>
                </li>

            </ul>
            <div class="tab-content">
                <asp:TextBox CssClass="form-control" runat="server" ID="projectCode2" ReadOnly Visible="false" />
                <asp:TextBox CssClass="form-control" runat="server" ID="Cycle" ReadOnly Visible="false" />
                <asp:TextBox CssClass="form-control" runat="server" ID="projectCodes" ReadOnly Visible="false" />
                <div class="tab-pane fade active in " id="tab_tender_PostGrad">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Post Professional Examination</u></strong></h6>
                        </div>

                        <p>A person seeking to be registered as a student for Post graduate Examinations must show evidence of being a holder of the following minimum qualifications:</p>

                        <ol type="1">
                            <li>.</li>

                        </ol>
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                                <div class="panel panel-default">
                                    <p>Kasneb Examinations</p>
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Examination ID</th>
                                                    <th>Examination</th>
                                                    <th></th>
                                            </thead>
                                            <tbody>
                                                <%
                                                    string projectCode = projectCode2.Text;
                                                    var nav = Config.ReturnNav();
                                                    var courses = nav.ExamCourses.Where(r => r.Job_No == projectCode && r.Examination_Type == y);
                                                    int counter = 0;
                                                    foreach (var Coursez in courses)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>
                                                    <td><%=Coursez.Job_Task_No %></td>
                                                    <td><%=Coursez.Description %></td>
                                                    <td>
                                                        <label class="btn btn-success" onclick="createApplication('<%=Coursez.Job_Task_No %>');">Register Examination<i class="fa fa-arrow-right"></i></label></td>
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
                    <%-- <label class="btn btn-success pull-right" Style="margin-right: 100px;" id="mybitton" onclick="createApplication('<%=y %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>--%>
                </div>
                <div class="tab-pane fade" id="tab_overview">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Professional Examinations</u></strong></h6>
                        </div>

                        <p>A person seeking to be registered as a student for any of the professional examinations must show evidence of being a holder of one of the following minimum qualifications:</p>

                        <ol type="1">
                            <li>Kenya Certificate of Secondary Education (KCSE) examination with an aggregate average of at least grade C+ (C plus) or its equivalent.</li>
                            <li>Kenya Advanced Certificate of Education (KACE) with at least TWO Principal passes provided that the applicant has credits in Mathematics and English at Kenya Certificate of Education (KCE) level or equivalent qualifications.</li>
                            <li>kasneb technician, diploma or professional examination certificate.</li>
                            <li>A degree from a recognised university.</li>
                            <li>International General Certificate of Secondary Education (IGCSE) examination grade C in 6 papers with C in both English and Mathematics.</li>
                            <li>Such other certificates or diplomas as may be approved by kasneb.</li>
                        </ol>
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                <div class="panel panel-default">

                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Examination ID</th>
                                                    <th>Examination</th>
                                                    <th></th>
                                            </thead>
                                            <tbody>
                                                <%

                                                    var course = nav.ExamCourses.Where(r => r.Job_No == projectCode && r.Examination_Type == x);

                                                    foreach (var Coursez in course)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>

                                                    <td><%=Coursez.Job_Task_No %></td>
                                                    <td><%=Coursez.Description %></td>
                                                    <td>
                                                        <label class="btn btn-success" onclick="createApplication('<%=Coursez.Job_Task_No %>');">Register Examination<i class="fa fa-arrow-right"></i></label></td>
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
                    <%--<label class="btn btn-success pull-right" Style="margin-right: 100px;" id="mybitton" onclick="createApplication('<%=x%>');"><i class="fa fa-arrow-right"></i>Apply Now</label>--%>
                </div>
                <div class="tab-pane fade " id="tab_purchase_items">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Diploma Examinations</u></strong></h6>
                        </div>

                        <p>A person seeking to be registered as a student for any of the diploma examinations must show evidence of being a holder of one of the following minimum qualifications:</p>

                        <ol type="1">
                            <li>Kenya Certificate of Secondary Education (KCSE) examination with an aggregate average of at least grade C- (C Minus) or equivalent qualifications.</li>
                            <li>International General Certificate of Secondary Education (IGCSE) examination grade D.</li>
                            <li>Any other kasneb technician or diploma examination certificate.</li>

                        </ol>
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Examination ID</th>
                                                    <th>Examination</th>
                                                    <th></th>
                                            </thead>
                                            <tbody>
                                                <%

                                                    var coursez = nav.ExamCourses.Where(r => r.Job_No == projectCode && r.Examination_Type == z);
                                                    foreach (var Coursez in coursez)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>

                                                    <td><%=Coursez.Job_Task_No %></td>
                                                    <td><%=Coursez.Description %></td>
                                                    <td>
                                                        <label class="btn btn-success" onclick="createApplication('<%=Coursez.Job_Task_No %>');">Register Examination<i class="fa fa-arrow-right"></i></label></td>
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
                    <%--  <label class="btn btn-success pull-right" Style="margin-right: 100px;" id="mybitton" onclick="createApplication('<%=z %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>--%>
                </div>
                <div class="tab-pane fade " id="tab_tender_documents">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Certificate examination</u></strong></h6>
                        </div>

                        <p>A person seeking to be registered as a student for Certificate in Accounting and Management Skills (CAMS) qualification must show evidence of being a holder of the following minimum qualifications:</p>

                        <ol type="1">
                            <li>Kenya Certificate of Secondary Education (KCSE) examination with an aggregate average of at least grade D (D Plain) or its equivalent.</li>
                            <li>For CFFE University degree or professional qualification holder</li>

                        </ol>
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Examination ID</th>
                                                    <th>Examination</th>
                                                    <th></th>
                                            </thead>
                                            <tbody>
                                                <%
                                                    string studentNo = Convert.ToString(Session["studentNo"]);
                                                    var Examcourse = nav.ExamCourses.Where(r => r.Job_No == projectCode && r.Examination_Type == n);
                                                    foreach (var Coursez in Examcourse)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>

                                                    <td><%=Coursez.Job_Task_No %></td>
                                                    <td><%=Coursez.Description %></td>
                                                    <td>
                                                        <label class="btn btn-success" onclick="createApplication('<%=Coursez.Job_Task_No %>');">Register Examination<i class="fa fa-arrow-right"></i></label></td>
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

                    <%-- <label class="btn btn-success pull-right" Style="margin-right: 100px;" id="mybitton" onclick="createApplication('<%=n %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>--%>
                </div>

                <div class="tab-pane fade " id="tab_tender_vocational">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Vocational Examinations</u></strong></h6>
                        </div>

                        <p>A person seeking to be registered as a student for Vocational Examinations must show evidence of being a holder of the following minimum qualifications:</p>

                        <ol type="1">
                            <li>KCSE Certificate</li>

                        </ol>
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">

                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <table class="table table-bordered table-striped datatable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Examination Level</th>
                                                    <th>Description</th>
                                                    <th></th>
                                            </thead>
                                            <tbody>
                                                <%

                                                    var Examcourses = nav.ExamCourses.Where(r => r.Job_No == projectCode && r.Examination_Type == m);
                                                    foreach (var Coursez in Examcourses)
                                                    {
                                                        counter++;
                                                %>
                                                <tr>
                                                    <td><%=counter %></td>

                                                    <td><%=Coursez.Job_Task_No %></td>
                                                    <td><%=Coursez.Description %></td>
                                                    <td>
                                                        <label class="btn btn-success" onclick="createApplication('<%=Coursez.Job_Task_No %>');">Register Examination<i class="fa fa-arrow-right"></i></label></td>
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
                    <%-- <label class="btn btn-success pull-right" id="mybitton" style="margin-right: 100px;" onclick="createApplication('<%=m %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>--%>
                </div>

            </div>
            <h4 style="color: red"><u>Note:</u></h4>
            <p>system session timeout is 15-45 minutes.</p>
            <br />
            <p><strong>Please ensure You have the following documents in soft copy</strong></p>
            <ol type="1">
                <li>Passport size coloured photograph.(jpg)format.</li>
                <li>Identity Card (ID) or birth certificate or Passport Number. (pdf) format.</li>
                <li>Academic certificates. (pdf) format</li>

            </ol>


        </div>
        <%-- <label class="btn btn-success pull-right" id="mybitton" style="margin-right: 100px;" onclick="createApplication('<%=m %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>--%>
    </div>


    <script>
        function createApplication(courseId) {
            document.getElementById("courseName").innerText = courseId;
            document.getElementById("MainContent_fileName1").value = courseId;
            $("#downloadFileModal").modal();

            $("#removeLineModal").modal({ show: true });
            //__doPostBack('mybitton', b)
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Examination Registration</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Register for the <strong id="courseName"></strong>examination?</p>
                    <asp:TextBox runat="server" ID="fileName1" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Next" OnClick="nextButton_Click" />
                </div>
            </div>

        </div>

    </div>
    <%--        <asp:ScriptManager ID="ScriptManger1" runat="Server" />
        <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div id="generalFeedback" runat="server"></div>
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Please Select Examination To Register</h4>
                        </div>
                        <div class="modal-body">
                            <input hidden id="DIPt" runat="server" />
                            <%-- <asp:TextBox runat="server" ID="textType"  CssClass="form-group"></asp:TextBox>
                            <label>Examination Type:</label>
                            <asp:DropDownList runat="server" ID="examinationType" CssClass="form-control select2" OnSelectedIndexChanged="examinationType_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem>--Select Type--</asp:ListItem>
                                <asp:ListItem Value="Post-Graduate">Post-Graduate</asp:ListItem>
                                <asp:ListItem Value="Professional">Professional</asp:ListItem>
                                <asp:ListItem Value="Technical/Diploma">Diploma</asp:ListItem>
                                <asp:ListItem Value="Certificate">Certificate</asp:ListItem>
                                <asp:ListItem Value="Vocational">Vocational</asp:ListItem>
                            </asp:DropDownList>


                            <div class="row" style="display: none">
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label>Exam Cycle:</label>
                                     
                                    </div>
                                </div>

                            </div>
                            <label>Kasneb Examinations:</label>
                            <asp:DropDownList runat="server" ID="ApplicationNo" CssClass="form-control select2" />
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="nextButton_Click" />
                        </div>
                    </div>

                </div>
            </ContentTemplate>
        </asp:UpdatePanel>--%>



    <div class="clearfix"></div>

</asp:Content>
