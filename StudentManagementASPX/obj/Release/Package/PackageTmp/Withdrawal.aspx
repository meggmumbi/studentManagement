<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="Withdrawal.aspx.cs" Inherits="StudentManagementASPX.Withdrawal" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <%
        const int maxStep = 3;
        var nav = Config.ReturnNav();
        String appplication = "";


        int myStep = 1;
        try
        {
            myStep = Convert.ToInt32(Request.QueryString["step"]);
            if (myStep > maxStep || myStep < 1)
            {
                myStep = 1;
            }
        }
        catch (Exception)
        {
            myStep = 1;
        }
    %>
    <%
        if (myStep == 1)

        {
    %>


    <div class="panel panel-primary">
        <div class="panel-heading">
            Student Withdrawal Application<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="Div4" runat="server"></div>
            <div id="Div5" runat="server"></div>
            <div runat="server" id="Div6"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Student Withdrawal</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="generalFeedback" runat="server"></div>
                        <div id="feedback" runat="server"></div>

                        <br />
                        <br />
                        <div class="row">
                            <div class="col-md-6"> 
                                <div class="form-group" style="display: none">
                                    <label>Student No:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="studentNo" />                                 
                                </div>
                                <div class="form-group">
                                    <label>Examination :</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="regNo" Placeholder="Name" OnSelectedIndexChanged="regNo_SelectedIndexChanged" />
                                 
                                    <asp:TextBox CssClass="form-control" runat="server" ID="courseId" Visible="false" />
                                </div>
                                   <div class="form-group">
                                    <label>Withdrawal Reason:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="withdrawal" />                                  
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Exam sitting:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="examCycle" />
                                    <%-- <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="examCycle" ErrorMessage="Please select worktype!" ForeColor="Red" />--%>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>
            </section>
 
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%
        }
        else if (myStep == 2)
        {
    %>
  <div class="panel panel-primary">
        <div class="panel-heading">
            Student Withdrawal
             <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 2 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div runat="server" id="Div1"></div>
            <div class="row">
                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p>Active Booking Papers.</p>

                </div>
                <div class="col-md-12">
                    <table id="example1" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Booking Header</th>
                                <th>Examination </th>
                                <th>Part </th>
                                <th>Paper</th>
                                <th>Description </th>
                                <th>Amount </th>
                                <th>Remove</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String applicationNo = Request.QueryString["applicationNo"];
                                string studentNo = Convert.ToString(Session["studentNo"]);
                                    var studentProcessingLine = nav.studentProcessingLines.Where(r => r.Document_Type == "Withdrawal" && r.Booking_Header_No == applicationNo);
                                    foreach (var line in studentProcessingLine)
                                    {
                            %>
                            <tr>

                                <td><% =line.Booking_Header_No %></td>
                                <td><% =line.Course_Id %></td>
                                <td><% =line.Part %></td>
                                <td><% =line.Paper %></td>
                                <td><% =line.Description %></td>
                                <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>
                                <td>                                   
                                         <Label class="btn btn-danger" id="button" onclick="removeLine('<%=line.Description %>','<%=line.Paper %>');"><i class="fa fa-trash"></i>Delete</Label></td>
                             
                            </tr>
                            <% 
                                    }
                                
                            %>
                        </tbody>
                    </table>
                </div>
                <div />
            </div>
        </div>


        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="step3" OnClick="step3_Click"/>
              <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="View Withdrawal Summery" ID="submitApp" OnClick="attachdoc_Click" Visible="false" />
            <div class="clearfix"></div>
        </div>
    </div>
  

    <%
        }
        else if (myStep == 3)
        {
    %>

     <div class="panel-default setup-content" id="step-10">
        <div class="panel-heading">
            Mandatory Documents
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 3 of 4 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>

        </div>
           <div runat="server" id="attach"></div>
        <div id="completefeedback" runat="server"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_documents" data-toggle="tab">
                        <p style="color: black">Withdrawal Document Attachments</p>
                    </a>
                </li>
            <%--    <li style="background-color: gray">
                    <a href="#tab_1_attach" data-toggle="tab">
                        <p style="color: black">Attach Document </p>
                    </a>
                </li>--%>
                <%--         <li style="background-color:gray">
                    <a href="#tab_1_attached" data-toggle="tab"><p style="color:black">Attached Document </p></a>
                </li>--%>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active in" id="tab_1_documents">
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>You are to submit scanned copies of the following sets of documents, as part of your Withdrawal process. Click on the submit Documents button, when ready to attach the supporting documents.</p>

                        </div>
                        <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                            <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                        </div>
                         <div class="col-md-12">
                            <input type="hidden" value="<% =Request.QueryString["applicationNo"] %>" id="txtapplicationNo" class="txtapplicationNo" />
                            <asp:TextBox runat="server" ID="template" CssClass="form-control" Visible="false"></asp:TextBox>
                            <div class="table-responsive">
                                              <table class="table table-striped custom-table datatable" id="example2">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Document Type</th>
                                            <th>Description</th>
                                            <th>Requirement Type</th>
                                            <th>Attach Document</th>
                                        </tr>

                                    </thead>
                                    <tbody>
                                        <% 
                                            string courseId = Request.QueryString["courseId"];
                                            var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text  && r.Examination_Process == "Withdrawal" && r.Examiantion_ID == courseId).ToList();
                                            int programesCounter = 0;
                                            int counter = 0;
                                            foreach (var detail in details)
                                            {

                                                counter++;
                                                programesCounter++;
                                        %>
                                        <tr>
                                            <td><%=programesCounter %></td>
                                            <td><%=detail.Examination_Document_Type %></td>
                                            <td><%=detail.Description %></td>
                                            <td><%=detail.Requirement_Type %></td>
                                            <td>
                                               <label class="btn btn-success" onclick="studentattachdocuments('<%=detail.Entry_No %>');">Attach Document</label>
                                            </td>
                                        </tr>
                                        <%  
                                            } %>
                                    </tbody>
                                </table>
                                </div>
                                
                                <br />
                                <br />
                                  <div class="box-header">
                                        <h3 class="box-title">Attached Documents</h3>
                                    </div>
                             <div class="table-responsive">
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
                                            String leaveNo = Request.QueryString["applicationNo"];
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
                                                        if (folders.Name == "Withdrawal")
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
                                        alldocuments.ToList();
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

                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="prevstep1" OnClick="prevstep1_Click" />
                    <%
                        if (alldocuments.Count >= details.Count)
                        {
                            attachdoc.Visible = true;
                        }

                    %>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Submit Application" ID="attachdoc" OnClick="attachdoc_Click" Visible="false" />

                </div>

                <div class="tab-pane fade" id="tab_1_attach">
                    <div id="keydocumentsuploadfeedback" style="display: none" data-dismiss="alert"></div>
                    <!-- The global progress bar -->
                    <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>This Section enables you to upload scanned copies of the supporting documents as part of this Booking process.</p>
                        </div>
                        <div class="panel-body col-lg-12">
                            <div id="Div14" runat="server"></div>
                            <div class="row">
                                   <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Document Type:</strong>
                                       <asp:DropDownList runat="server" CssClass="form-control" ID="DocType"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select:</strong>
                                        <asp:FileUpload runat="server" CssClass="form-control" ID="uploadsDoc"></asp:FileUpload>
                                    </div>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="fileuploads"/>
                                    </div>
                                </div>
                            </div>
                          <div class="table-responsive">
                            <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <th>Download</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        try
                                        {
                                            String fileFolderApplication = ConfigurationManager.AppSettings["FileFolderApplication"];
                                            String filesFolder = ConfigurationManager.AppSettings["FilesLocation"] + "Student Processing Header/";
                                            String applicationNo = Request.QueryString["applicationNo"].Trim();
                                            applicationNo = applicationNo.Replace('/', '_');
                                            applicationNo = applicationNo.Replace(':', '_');
                                            String documentDirectory = filesFolder + applicationNo + "/";
                                            if (Directory.Exists(documentDirectory))
                                            {
                                                foreach (String file in Directory.GetFiles(documentDirectory, "*.*", SearchOption.AllDirectories))
                                                {
                                                    String url = documentDirectory;
                                    %>
                                    <tr>
                                        <td><% =file.Replace(documentDirectory, "") %></td>

                                        <td><a href="<%=fileFolderApplication %>\Non-Project Purchase Order\<% =applicationNo + "\\" + file.Replace(documentDirectory, "") %>" class="btn btn-success" download>Download</a></td>
                                        <td>
                                            <label class="btn btn-danger" onclick="deleteOrganizationFile('<%=file.Replace(documentDirectory, "")%>');"><i class="fa fa-trash-o"></i>Delete</label></td>
                                    </tr>
                                    <%
                                                }
                                            }
                                        }
                                        catch (Exception)
                                        {

                                        }%>
                                </tbody>
                            </table>
                              </div>

                        </div>


                    </div>
                   
                </div>

            </div>

        </div>

     </div>
  

    <%}%>


     <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
       
           <script type="text/javascript">
           function studentattachdocuments(entryNo) {
            $("#DocumentsAttach").modal();
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
                    <p>Are you sure you want to delete the file <strong id="filetoDeleteName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete File" OnClick="deleteFile_Click" />
                </div>
            </div>

        </div>
    </div>
       <div id="DocumentsAttach" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attach the Document</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                      <strong>Upload Document</strong><span class="text-danger" style="font-size:25px">*</span>
                          <asp:FileUpload runat="server" CssClass="form-control" ID="uploadfile" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="Button1" OnClick="UploadDocuments_Click" />
                </div>
            </div>

        </div>
    </div>

        <script>

        function removeLine(name, no) {
            document.getElementById("fueltoRemoveName").innerText = name;
            document.getElementById("MainContent_removeFuelNumber").value = no;
            $("#removeFuelModal").modal();
        }
    </script>
        <div id="removeFuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Examination Paper</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Examination Paper  <strong id="fueltoRemoveName"></strong> from the Booking? </p>
                    <asp:TextBox runat="server" ID="removeFuelNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Examination Paper" ID="delete" OnClick="delete_Click" />
                </div>
            </div>

        </div>
    </div>

</asp:Content>
