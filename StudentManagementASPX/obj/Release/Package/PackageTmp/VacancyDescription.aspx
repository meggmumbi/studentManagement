<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="VacancyDescription.aspx.cs" Inherits="StudentManagementASPX.VacancyDescription" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
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
                <h6><strong><u>Job Vacancy General Details</u></strong></h6>
            </div>
            <div class="col-xs-8 text-right m-b-30">
                  <a href="javascript:editTeamMember('<%=Request.QueryString["innovationNumber"]%>');" class="btn btn-primary pull-right rounded"><i class="fa fa-plus"></i>Apply</a>           
              <%--  <a href="ResearchandInnovationApplication.aspx?invitationNo=<%=Request.QueryString["innovationNumber"] %>" class="btn btn-success"><i class="fa fa-plus"></i>Apply</a>--%>
               
            </div>
        </div>

        <div id="responsesfeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
              <div id="submit" runat="server"></div>
             <div id="attach" runat="server"></div>
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: #D3D3D3">
                    <a href="#tab_overview" data-toggle="tab">
                        <p style="color: black"><strong>General vacancy Information</strong> </p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_purchase_items" data-toggle="tab">
                        <p style="color: black"><strong>Requirements</strong></p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_documents" data-toggle="tab">
                        <p style="color: black"><strong>Responsibilities</strong></p>
                    </a>
                </li>
                <li style="background-color: #D3D3D3">
                    <a href="#tab_tender_attach" data-toggle="tab">
                        <p style="color: black"><strong>Document Attachment</strong></p>
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_overview">

                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6><strong><u>Vacancy General Details</u></strong></h6>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Vacancy No:</label>

                                <asp:TextBox runat="server" class="form-control" type="text" ID="noticeNo" name="tendernotice" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Position:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="innovationDescription" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">No of Vacancies:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="category" name="innovationCategory" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Estimated Annual Salary:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="department" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Employment Type:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionstartDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Submission End Date:</label>
                                <asp:TextBox runat="server" class="form-control" type="text" ID="submissionEndDate" ReadOnly />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Employer:</label>
                                <asp:TextBox runat="server" class="form-control" ID="executiveSummery"  ReadOnly></asp:TextBox>

                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Region:</label>
                                <asp:TextBox runat="server"  class="form-control" ID="region" ReadOnly></asp:TextBox>

                            </div>
                        </div>
                           <div class="col-sm-6">
                            <div class="form-group">
                                <label class="control-label">Comments:</label>
                                <asp:TextBox runat="server"  class="form-control" ID="comments" ReadOnly></asp:TextBox>

                            </div>
                        </div>





                    </div>
                </div>
               
                <div class="tab-pane fade " id="tab_purchase_items">
                    <div class="row">
                        <div class="panel panel-heading" style="background-color: #D3D3D3">
                            <h6 class="panel-title"><strong><u>Vacancy Requirements</u></strong></h6>
                        </div>
                       
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table table-striped custom-table datatable">
                                        <thead>
                                            <tr>

                                                <th>Qualification Category</th>
                                                <th>Description</th>
                                                <th>Requirement Type</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                var empNo = Session["studentNo"].ToString();
                                                 var nav = Config.ReturnNav();
                                                var invitationNo = Request.QueryString["innovationNumber"];
                                                var requests = nav.crmVacancyRequirement.Where(r=>r.Vacancy_ID==invitationNo);
                                                //var requests = "";
                                                foreach (var request in requests)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=request.Qualification_Category %>
                                                </td>
                                                <td>
                                                    <%=request.Description %>
                                                </td>
                                                <td>  <%=request.Requirement_Type %></td>



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
                            <h6 class="panel-title"><strong><u>Job Responsibilities</u></strong></h6>
                        </div>
                     
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
                                                var requestss = nav1.crmvacancyResponsibility.Where(r=>r.Vacancy_ID==invitationNos);
                                                //var requests = "";
                                                foreach (var request in requestss)
                                                {
                                            %>
                                            <tr>
                                                <td>
                                                    <%=request.Vacancy_ID %>
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
                 <div class="tab-pane fade " id="tab_tender_attach">
                   <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>You are required to submit scanned copies of the following sets of documents, as part of your Registration process. Click on the Attach Documents Link, when ready to attach the supporting documents.</p>

                        </div>
                       <div id="completefeedback" runat="server"></div>
                        <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                            <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                        </div>
                         <div class="col-md-12">
                            <input type="hidden" value="<% =Request.QueryString["innovationNumber"] %>" id="txtapplicationNo" class="txtapplicationNo" />
                            <asp:TextBox runat="server" ID="template" CssClass="form-control" Visible="false"></asp:TextBox>
                             <div class="table-responsive">
                                 <table class="table table-striped custom-table datatable" id="example2">
                                     <thead>
                                         <tr>
                                             <th>#</th>
                                             <th>Document Type</th>
                                             <%--  <th>Document Type</th>--%>
                                             <th>Description</th>
                                             <th>Requirement Type</th>
                                             <th>Attach Document</th>
                                         </tr>

                                     </thead>
                                     <tbody>
                                         <% 

                                             var studentNo = Session["studentNo"].ToString();
                                             var nav2 = Config.ReturnNav();
                                             var vacancies = Request.QueryString["innovationNumber"];
                                             var vacant = nav.crmVacancyRequirement.Where(a=>a.Vacancy_ID==vacancies);
                                             //var requests = "";
                                             foreach (var vacants in vacant)
                                             {
                                        %>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <%=vacants.Qualification_Category %>
                                            </td>
                                            <td>
                                                <%=vacants.Description %>
                                            </td>
                                            <td><%=vacants.Requirement_Type %></td>

                                            <td><input class="form-control PrequalificationinputFileselectors" type="file" name="PrequalificationinputFileselectors[]"></td>
                                          
                                         



                                            <%--<td><a href="ExistingStudents.aspx?step=2&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.No %>&&courseId=<%=Request.QueryString["courseId"]; %>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>--%>
                                        </tr>
                                        <%  
                                            } %>
                                    </tbody>
                                </table>
                                  <div class="panel-footer">
                                    <br />
                                    <input type="button" id="btnSavevacancy" class="btn btn-success pull-left btnSavevacancy" name="btnSavevacancy" value="Submit Documents" />
                                </div>
                                <br />
                                <br />
                                  <div class="box-header">
                                        <h3 class="box-title">Attached Documents</h3>
                                    </div>

                                  <table class="table table-bordered table-striped" id="example7">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <%--<th>Download</th>--%>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <%
                                        List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                                        try
                                        {%>
                                    <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["S_URL"]))
                                        {
                                            // var vendorNo = Convert.ToString(Session["vendorNo"]);
                                            String leaveNo = Request.QueryString["innovationNumber"];
                                            string password = ConfigurationManager.AppSettings["S_PWD"];
                                            string account = ConfigurationManager.AppSettings["S_USERNAME"];
                                            string domainname = ConfigurationManager.AppSettings["S_DOMAIN"];
                                            var secret = new SecureString();



                                            foreach (char c in password)
                                            {
                                                secret.AppendChar(c);
                                            }

                                            ctx.Credentials = new NetworkCredential(account, secret, domainname);
                                            ctx.Load(ctx.Web);
                                            ctx.ExecuteQuery();
                                            List list = ctx.Web.Lists.GetByTitle("Student Portal");

                                            //Get Unique rfiNumber
                                            string uniqueLeaveNumber = leaveNo;

                                            ctx.Load(list);
                                            ctx.Load(list.RootFolder);
                                            ctx.Load(list.RootFolder.Folders);
                                            ctx.Load(list.RootFolder.Files);
                                            ctx.ExecuteQuery();

                                            FolderCollection allFolders = list.RootFolder.Folders;
                                            foreach (Folder folder in allFolders)
                                            {
                                                if (folder.Name == "KASNEB")
                                                {
                                                    ctx.Load(folder.Folders);
                                                    ctx.ExecuteQuery();
                                                    var uniquerfiNumberFolders = folder.Folders;

                                                    foreach (Folder folders in uniquerfiNumberFolders)
                                                    {
                                                        if (folders.Name == "CrmVacancy")
                                                        {
                                                            ctx.Load(folders.Folders);
                                                            ctx.ExecuteQuery();
                                                            var uniquevendorNumberSubFolders = folders.Folders;

                                                            foreach (Folder vendornumber in uniquevendorNumberSubFolders)
                                                            {
                                                                if (vendornumber.Name == uniqueLeaveNumber)
                                                                {
                                                                    ctx.Load(vendornumber.Files);
                                                                    ctx.ExecuteQuery();

                                                                    FileCollection vendornumberFiles = vendornumber.Files;
                                                                    foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                                    {%>
                                    <% ctx.ExecuteQuery();
                                        alldocuments.Add(new SharePointTModel { FileName = file.Name });
                                    %>


                                    <% }%>

                                    <%
                                        foreach (var item in alldocuments)
                                        {%>
                                    <tr>
                                        <td><% =item.FileName %></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteFile('<%=item.FileName %>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                    </tr>
                                    <% }
                                    %>

                                    <%  }

                                                                }


                                                            }
                                                        }

                                                    }
                                                }

                                            }

                                        }
                                        catch (Exception t)
                                        {

                                            completefeedback.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }

                                    %>
                                </tbody>

                            </table>
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
                    <h4 class="modal-title">Apply for this Job?</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to Apply for the job Postion?</p>
                    <asp:TextBox runat="server" ID="removeFuelWorkType" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Apply Job" ID="confirm" OnClick="confirm_Click" />
                </div>
            </div>

        </div>
    </div>
        <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteNames").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
     <div id="deleteFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Deleting File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteNames"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>
</asp:Content>
