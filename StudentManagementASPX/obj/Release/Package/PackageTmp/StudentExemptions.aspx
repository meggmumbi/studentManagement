<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentExemptions.aspx.cs" Inherits="StudentManagementASPX.StudentExemptions" %>

<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
           <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="assets/css/sweetalert2.all.js"></script>

    <script type="text/javascript">
        function reloadPage() {
            window.location.reload()
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <%
        const int maxStep = 4;
        var nav = Config.ReturnNav();
        var application = Request.QueryString["applicationNo"];
       
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
            Student Exemptions<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Student Exemptions</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div2" runat="server"></div>
                        <div id="Div3" runat="server"></div>
                        <div runat="server" id="Div4"></div>

                        <div class="row">

                            <div class="col-md-6">
                           
                                <div class="form-group" style="display:none">
                                    <label>Student No:</label>
                                    <asp:TextBox CssClass="form-control" runat="server" ID="studentNo"/>
                                     <asp:TextBox CssClass="form-control" runat="server" ID="courseId" Visible="false" />
                                </div>

                      
                           
                           
                                <div class="form-group">
                                    <label>Qualification type:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="qualificationtype" OnSelectedIndexChanged="qualificationtype_SelectedIndexChanged" AutoPostBack="true">
                                        <asp:ListItem>--select--</asp:ListItem>
                                        <asp:ListItem Value="0">Degree</asp:ListItem>
                                        <asp:ListItem Value="1">Diploma</asp:ListItem>
                                        <asp:ListItem Value="2">Kasneb Qualification</asp:ListItem>
                                        

                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="qualificationtype" ErrorMessage="Please enter the Proposed Name!" ForeColor="Red" />

                                </div>


                                <div class="form-group">
                                    <label>Qualification description:</label>
                                    <asp:DropDownList CssClass="form-control" runat="server" ID="qualificationDecsription" OnSelectedIndexChanged="qualificationDecsription_SelectedIndexChanged" AutoPostBack="true"/>
                                   
                                </div>

                       
                            </div>

                        </div>
                    </div>
                </div>
            </section>

            
            <center>
                <asp:Button runat="server" class="btn btn-primary" id="Nxt" name="btn_personalinformations" Text="Save Details" OnClick="next_Click"></asp:Button>

               
            </center>
            <div class="table-responsive">
            <table class="table table-bordered table-striped dataTable" id="example4">
                <thead>
                    <tr>
                        <th>#</th>                        
                        <th>Qualification Type</th>
                        <th>Qualification</th>
                        <th>Description</th>
                        <th>Delete</th>
                     

                    </tr>
                </thead>
                <tbody>
                    <% 

                       // string studentNo = Convert.ToString(Session["studentNo"]);
                       
                        //string courseId = Request.QueryString["courseId"];
                        var details = nav.ExemptionQualification.Where(r => r.Document_No == application);
                        //string university = Convert.ToString(Session["UniversityCode"]);
                        int programesCounter = 0;
                        foreach (var detail in details)
                        {
                            programesCounter++;
                    %>
                    <tr>
                        <td><%=programesCounter %></td>
                        <td><%=detail.Qualification_Type %></td>
                        <td><%=detail.Qualification_Code %></td>
                        <td><%=detail.Qualification %></td>
                        <td><label class="btn btn-danger" onclick="removeLineQualification('<% =detail.Qualification %>','<%=detail.Entry_No %>');"><i class="fa fa-trash"></i>Delete</label></td>
                    
                    </tr>
                    <%  
                        } %>
                </tbody>
            </table>
                </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" Id="NextExemption" OnClick="NextExemption_Click" Visible="false"/>
            <div class="clearfix"></div>
        </div>
    </div>
    
    
    <%
        }
        else if (myStep == 2)
        {
    %>

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
        <h5><u>Examination Papers qualified to be exempted and their rates</u></h5>
         <div id="feedbackPaper" runat="server"></div>
        <div class="row">
            <div class="col-md-12">
                <div class="table-responsive">
                    <table class="table table-striped table-bordered" style="width: 100%" id="example4">
                        <thead>
                            <tr>

                                <th>No </th>
                                <th>Name </th>
                                <th>Amount </th>
                                <th>Remove </th>

                            </tr>
                        </thead>
                        <tbody>
                            <%
                                String applicationNo = Request.QueryString["applicationNo"];
                                String courseid = Request.QueryString["courseid"];
                                var exemptionLines = nav.exemptionLines.Where(r => r.Header_No == applicationNo);
                                foreach (var line in exemptionLines)
                                {
                            %>
                            <tr>




                                <td><%=line.No %></td>
                                <td><%=line.Name %></td>
                                <td><%=String.Format("{0:n}", Convert.ToDouble(line.Amount)) %></td>

                                <td><label class="btn btn-danger" onclick="removeLine('<% =line.Name %>','<%=line.Line_No %>');"><i class="fa fa-trash"></i>Delete</label></td>


                            </tr>
                            <% 
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
          <div class="row">
        <!-- accepted payments column -->
        <div class="col-xs-6">
          <p class="lead">Payment Method:</p>         
       
          <img src="assets/img/paybill-number.jpg" width="101px" height="60px"/>
          <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">
            Payment is strictly by Mpesa
          </p>
        </div>
        <!-- /.col -->
              <% var exemptionLinee = nav.StudentProcessing.Where(r => r.No == applicationNo).ToList();
                  if (exemptionLinee.Count > 0)
                  {
                      foreach (var line in exemptionLinee)
                      { %>
        <div class="col-xs-6">
          <p class="lead"><label>Amount Due</label></p>

          <div class="table-responsive">
            <table class="table">
             
              <tr>
                <th>Total:</th>
                <td><strong><%=line.Exemption_Amount %></strong></td>
              </tr>
            </table>
          </div>
        </div>
              <%}
    } %>
        <!-- /.col -->
      </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="previous" OnClick="previous_Click1" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="invoice" OnClick="invoice_Click1" />

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
        <div id="completefeedback" runat="server"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_documents" data-toggle="tab">
                        <p style="color: black">Exemptions Document Attachments</p>
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
                            <p>You are to submit scanned copies of the following sets of documents, as part of your Exemption process. Click on the submit Documents button, when ready to attach the supporting documents.</p>

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
                                             var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Exemption" && r.Examiantion_ID == courseId).ToList();

                                             int programesCounter = 0;
                                             foreach (var detail in details)
                                             {
                                                 programesCounter++;
                                         %>
                                         <tr>
                                             <td><%=programesCounter %></td>
                                             <td><%=detail.Examination_Document_Type %></td>
                                             <td><%=detail.Description %></td>
                                             <td><%=detail.Requirement_Type %></td>
                                             <td>
                                                 <label class="btn btn-success" onclick="studentattachdocuments('<%=detail.Entry_No %>');">Attach Document</label></td>

                                         </tr>
                                         <%  
                                             } %>
                                     </tbody>
                                </table>
                                </div>
                                  <div class="panel-footer">
                                    <br />
                                    <input type="button" id="btnSaveExceptions" class="btn btn-success pull-left btnSaveExceptions" name="btnSaveExceptions" value="Submit Documents" />
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
                                                        if (folders.Name == "Exception")
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
                     <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="prev" OnClick="prev_Click" />
                             <%
                               if (alldocuments.Count == details.Count)
                               {
                                   attachdoc.Visible = true;
                               }
                               
                        %>
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="attachdoc" OnClick="next_Click1" Visible="false" />
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


    <%
        }
        else if (myStep == 4)
        {
    %>


    <div class="panel panel-default">
        <div class="panel-heading">
            Declaration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 4 of 4<i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div id="submit" runat="server"></div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard </a></li>
                        <li class="breadcrumb-item active">Exemption Application</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <h5>I <b><% =Session["StudentName"] %></b>  hereby declare that to the best of my knowledge all the information I have provided in this application and all supporting documents are true and correct and l agree to abide by the Examination Rules and Regulations and Code of Conduct and Ethics for kasneb students.</h5>

                    </div>
                    <div class="col-lg-12">
                        <div class="form-group">
                          <p class="pull-left" style="font-size: 15px"> <a href="downloads/Code-of-Conduct-Ethics-for-KASNEB-Students.pdf"><i class="fa fa-file-pdf-o"></i>Terms and Conditions</a></p><br/><br />
                        <asp:CheckBox runat="server" ID="declaration" />
                        <label class="font-noraml" for="acceptTerms">I agree with the Terms and Conditions.</label>
                            </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="text-center padding-15">
                    <center>
                       <%-- <asp:Button runat="server" class="btn btn-primary btn_submitregistration_Details" id="btn_submitregistration_Details" type="button" onclick=""> </asp:Button>--%>
                        <asp:Button runat="server" Text="Submit Exemption Application" ID="submitRegistration" CssClass="btn btn-primary" OnClick="submitRegistration_Click"/>
                    </center>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed_Click"/>

            <div class="clearfix"></div>
        </div>
    </div>

  
    <%} %>

        <script type="text/javascript">
        function studentattachdocuments(entryNo) {
            $("#DocumentsAttach").modal();
        }
    </script>
    <script>

        function deleteFile(fileName) {
            document.getElementById("filetoDeleteName").innerText = fileName;
            document.getElementById("MainContent_fileName").value = fileName;
            $("#deleteFileModal").modal();
        }
    </script>
        <script>

        function removeLine(name, no) {
            document.getElementById("fueltoRemoveName").innerText = name;
            document.getElementById("MainContent_removeFuelNumber").value = no;
            $("#removeFuelModal").modal();
        }
    </script>
    <script>

        function removeLineQualification(name, no) {
            document.getElementById("qualificationtoRemoveName").innerText = name;
            document.getElementById("MainContent_QualificationNo").value = no;
            $("#removeQualificationModal").modal();
        }
    </script>
    <div id="removeQualificationModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of the  Qualification</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Qualification <strong id="qualificationtoRemoveName"></strong> from list of Qualifications</p>
                    <asp:TextBox runat="server" ID="QualificationNo" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Qualificationr" ID="DeleteQual" OnClick="DeleteQual_Click" />
                </div>
            </div>

        </div>
    </div>
     <div id="removeFuelModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Removal of Examination Paper</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to remove the Examination Paper  <strong id="fueltoRemoveName"></strong> from list of papers to be exempted? </p>
                    <asp:TextBox runat="server" ID="removeFuelNumber" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-danger" Text="Remove Examination Paper" ID="delete" OnClick="delete_Click" />
                </div>
            </div>

        </div>
    </div>

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

</asp:Content>
