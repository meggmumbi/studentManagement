<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="studentTrainingDescription.aspx.cs" Inherits="StudentManagementASPX.studentTrainingDescription" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="content container-fluid">
        <div class="row">
            <div class="card">
                <div class="card-header text-center" data-background-color="darkgreen">
                    <h5 class="title"><i><strong>Welcome to student portal</strong></i></h5>
                </div>
                <br />
            </div>
        </div>
        <p>This Student Portal enables you to register for a kasneb Examination, book examination, apply for exemptions, withdrawal and differment.</p>
        <div class="row" style="background-color: #D3D3D3">
            <div class="col-xs-4">
                <h6><strong><u>Training General Details</u></strong></h6>
            </div>
            <div class="col-xs-8 text-right m-b-30">
               
                <a href="javascript:editTeamMember('<%=Request.QueryString["innovationNumber"]%>');" class="btn btn-primary pull-right rounded"><i class="fa fa-plus"></i>Confirm Attendance</a>                 
              

            </div>
        </div>

        <div id="responsesfeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
             <div id="submit" runat="server"></div>
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: #D3D3D3">
                    <a href="#tab_overview" data-toggle="tab">
                        <p style="color: black"><strong>General Training Information</strong> </p>
                    </a>
                </li>
                <%--  <li style="background-color: #D3D3D3">
                    <a href="#tab_purchase_items" data-toggle="tab">
                        <p style="color: black"><strong>Overview</strong></p>
                    </a>
                </li>--%>
                <%--  <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_documents" data-toggle="tab">
                        <p style="color: black"><strong>Objective</strong></p>
                    </a>
                </li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_overview">

                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Vacancy General Details</u></strong></h6>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Code:</label>

                                <asp:TextBox runat="server" class="form-control" type="text" ID="noticeNo" name="tendernotice" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Description:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="innovationDescription" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Start date:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="category" name="innovationCategory" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">End Date:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="department" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Start Time:</label>
                                <asp:TextBox runat="server" class="form-control" ID="starttime" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">End Time:</label>
                                <asp:TextBox runat="server" class="form-control" ID="endtime" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Duration:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionstartDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Duration units:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionEndDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Provider Name:</label>
                                <asp:TextBox runat="server" class="form-control" ID="executiveSummery" ReadOnly></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Location:</label>
                                <asp:TextBox runat="server" class="form-control" ID="region" ReadOnly></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Attendees:</label>
                                <asp:TextBox runat="server" class="form-control" ID="attendees" ReadOnly></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Cost Of Training:</label>
                                <asp:TextBox runat="server" class="form-control" ID="cost" ReadOnly></asp:TextBox>

                            </div>
                        </div>






                    </div>
                </div>

                   <div class="tab-pane fade " id="tab_purchase_items">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6 class="panel-title"><strong><u>Overview</u></strong></h6>
                        </div>
                        <p>
                            The user shall be required to provide overview of their idea. Please note the following:<br />
                            1. The user must fill in the overview of their idea.<br />
                            2. The user must fill in the Goals for the idea.<br />
                            3) The last part , the user is required to fill in additional comments to support their idea and attch a document if any. .
                        </p>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table datatable">
                                        <thead>
                                            <tr>

                                                <th>Document No</th>
                                                <th>Description</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var empNo = Session["studentNo"].ToString();
                                                var nav = Config.ReturnNav();
                                                var invitationNo = Request.QueryString["innovationNumber"];
                                                var requests = nav.InnovationSolicitationLines.Where(x => x.Document_No == invitationNo && x.Record_Type == "Overview" && x.Document_Type == "Innovation Invitation").ToList();
                                                //var requests = "";
                                                foreach (var request in requests)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=request.Document_No %>
                                                </td>
                                                <td>
                                                    <%=request.Description %>
                                                </td>



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
                 <div class="tab-pane fade " id="tab_tender_documents">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6 class="panel-title"><strong><u>Objectives</u></strong></h6>
                        </div>
                        <p>
                            The user shall be required to provide overview of their idea. Please note the following:<br />
                            1. The user must fill in the overview of their idea.<br />
                            2. The user must fill in the Goals for the idea.<br />
                            3) The last part , the user is required to fill in additional comments to support their idea and attch a document if any. .
                        </p>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table datatable">
                                        <thead>
                                            <tr>

                                                <th>Document No</th>
                                                <th>Description</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var empNo1 = Session["studentNo"].ToString();
                                                var nav1 = Config.ReturnNav();
                                                var invitationNos = Request.QueryString["innovationNumber"];
                                                var requestss = nav1.InnovationSolicitationLines.Where(x => x.Document_No == invitationNo && x.Record_Type == "Objective" && x.Document_Type == "Innovation Invitation").ToList();
                                                //var requests = "";
                                                foreach (var request in requestss)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=request.Document_No %>
                                                </td>
                                                <td>
                                                    <%=request.Description %>
                                                </td>



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


                <div class="form-actions">
                    <div class="row">
                        <div class="col-md-offset-5 col-md-8">
                            <a href="Vacancies.aspx" class="btn btn-primary pull-left"><i class="fas fa fa-angle-left"></i>&nbsp;Back </a>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>


    <script type="text/javascript">
        function editTeamMember(trainingNo) {
            document.getElementById("MainContent_removeFuelWorkType").value = trainingNo;


            $("#editTeamMemberModal").modal();
        }
    </script>
    <div id="editTeamMemberModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Attandance of Training</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Attend the training?</p>
                    <asp:TextBox runat="server" ID="removeFuelWorkType" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Confirm Attendance" ID="confirm" OnClick="confirm_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
