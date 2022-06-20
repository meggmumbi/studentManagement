<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExistingStudents.aspx.cs" Inherits="StudentManagementASPX.ExistingStudents" %>

<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
    <script src="assets/css/sweetalert2.all.js"></script>
    <script>
        function success() {
            Swal.fire(
                'Registration submission failed. Please accept the terms and conditions '


            )
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {

            $(".table").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable();

        });
        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    document.getElementById('<%=imgviews.ClientID%>').src = e.target.result;
                    //$('#imgviews').attr('src', e.target.result);
                };

                reader.readAsDataURL(input.files[0]);
                }
            }


    </script>
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

    <div class="panel panel-default">
        <div class="panel-heading">
            Registration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 1 of <%= maxStep %> <i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="generalFeedback" runat="server"></div>
            <div id="feedback" runat="server"></div>
            <div runat="server" id="linesFeedback"></div>
            <section class="content">
                <div class="box box-default">
                    <div class="box-header with-border">
                        <h3 class="box-title">Examination Registration</h3>

                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div id="Div2" runat="server"></div>
                        <div id="Div3" runat="server"></div>
                        <div runat="server" id="Div4"></div>

                        <div class="row">
                            <div class="col-md-3">

                                <!-- Profile Image -->
                                <div class="box box-primary">
                                    <div class="box-body box-profile">
                                        <%  string IdNumber = Convert.ToString(Session["idNumber"]);
                                            var path = "~/images/" + IdNumber + ".jpg";
                                            string servpath = Server.MapPath(path);
                                            System.IO.FileInfo file = new System.IO.FileInfo(servpath);

                                            if (file.Exists.Equals(false))
                                            {%>
                                        <img class="img-responsive img-circle" src="images/profile.jpg" alt="User profile picture">
                                        <%--  <br />--%>

                                        <%}
                                            else
                                            {
                                                 FileUpload1.Enabled = false;
                                        %>

                                        <asp:Image runat="server" ImageUrl='<%# "../images/" + Convert.ToString(Session["idNumber"]) + ".jpg" %>' ID="imgviews" CssClass="img-responsive img-circle" alt="User profile picture" />

                                        <%} %>


                                        <p>Passport Requirements</p>
                                        <ol type="1">
                                            <li>JPG Image Only</li>

                                            <li>Size: 45mm x 35mm</li>

                                            <li>Color: Full color</li>
                                            <li>Full face, centered</li>
                                            <li>Background: White</li>
                                            <li>Smile: Neutral</li>
                                            <li>Eyes: Open</li>
                                            <li>Headgear: Non allowed</li>
                                        </ol>
                                        <div class="row">

                                            <div class="form-group">

                                                <asp:FileUpload onchange="readURL(this);" class="form-control" ID="FileUpload1" runat="server" Enabled="true" />

                                                <asp:Button runat="server" class="btn btn-primary" ID="uploadphoto" name="btn_personalinformations" Text="Upload" OnClick="uploadphoto_Click"></asp:Button>

                                            </div>
                                        </div>


                                    </div>
                                    <!-- /.box-body -->
                                </div>
                                <!-- /.box -->

                                <!-- About Me Box -->

                                <!-- /.box -->
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="firstName">Student No<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="studentNumber" Enabled="false" required></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Examination Code<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="examCode" Enabled="false" ReadOnly></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label for="currency">Training Institution </label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="currency"></asp:DropDownList>
                                </div>
                                <div class="form-group" style="display: none">
                                    <label for="exampleInputEmail1">Examination Cycle</label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="examCylces" ReadOnly></asp:TextBox>
                                </div>

                            </div>
                            <div class="col-md-4" style="display: none">
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Examination project Code<span class="text-danger">*</span></label>
                                    <asp:TextBox runat="server" CssClass="form-control" ID="project" ReadOnly Visible="false"></asp:TextBox>
                                </div>
                                <div class="form-group" style="display: none">
                                    <label for="exampleInputEmail1">Examination Center<span class="text-danger">*</span></label>
                                    <asp:DropDownList runat="server" CssClass="form-control" ID="examCenter"></asp:DropDownList>
                                </div>


                            </div>
                        </div>
                    </div>
                </div>


            </section>


            <%-- <center>
                <asp:Button runat="server" class="btn btn-primary" id="btn_personalinformations"  Text="Save Details" OnClick="btn_personalinformations_Click"></asp:Button>

               
            </center>--%>
            <%--   <div class="table-responsive">
                <table class="table table-bordered table-striped dataTable" id="example3">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Application No</th>
                            <th>Student No</th>
                            <th>Examination</th>

                            <th>Proceed</th>

                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            string studentNo = Convert.ToString(Session["studentNo"]);
                            //  var nav = Config.ReturnNav();
                            var course_id = Request.QueryString["courseId"];
                            var details = nav.StudentProcessing.Where(r => r.Student_No == studentNo && r.Approval_Status == "Open" && r.studentType == "Existing" && r.Course_ID == course_id);
                            //string university = Convert.ToString(Session["UniversityCode"]);
                            int programesCounter = 0;
                            foreach (var detail in details)
                            {
                                programesCounter++;
                        %>
                        <tr>
                            <td><%=programesCounter %></td>
                            <td><%=detail.No %></td>
                            <td><%=detail.Student_No %></td>
                            <td><%=detail.Course_Description %></td>



                            <td><a href="ExistingStudents.aspx?step=2&&studentNo=<%=detail.Student_No%>&&applicationNo=<%=detail.No %>&&courseId=<%=detail.Course_ID%>" class="btn btn-success"><i class="fa fa-eye"></i>Proceed</a></td>

                        </tr>
                        <%  
                            } %>
                    </tbody>
                </table>
            </div>--%>
        </div>

        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="nextExamDetails" OnClick="btn_personalinformations_Click" />
            <div class="clearfix"></div>
        </div>
    </div>


    <%
        }
        else if (myStep == 2)
        {
    %>
    <div class="panel-default setup-content" id="step-10">
        <div class="panel-heading">
            Mandatory Documents
            <span class="pull-right"><i class="fa fa-chevron-left"></i>Step 4 of <%= maxStep %> <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>

        </div>
        <div runat="server" id="attach"></div>
        <div id="completefeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
            <ul class="nav nav-tabs">
                <li class="active" style="background-color: gray">
                    <a href="#tab_1_documents" data-toggle="tab">
                        <p style="color: black">Registration Document Attachments</p>
                    </a>
                </li>
                <%--   <li style="background-color: gray">
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
                            <p>Submit scanned copies of the following sets of documents, as part of your Registration process. (Allowed Extensions. Pdf only) </p>

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
                                            <%--  <th>Document Type</th>--%>
                                            <th>Description</th>
                                            <th>Requirement Type</th>
                                            <th>Attach Document</th>


                                        </tr>

                                    </thead>
                                    <tbody>
                                        <% 
                                            // string studentNo = Convert.ToString(Session["studentNo"]);
                                            string courseId = Request.QueryString["courseId"];
                                            var details = nav.AttachDocuments.Where(r => r.Template_No == template.Text && r.Examination_Process == "Registration" && r.Examiantion_ID == courseId && r.Type=="Both").ToList();
                                            //string university = Convert.ToString(Session["UniversityCode"]);
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
                                            <%--  <td><%=detail.Examination_Document %></td>--%>
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
                            <div class="panel-footer">
                                <br />
                                <input type="button" id="btnSavePrequalifiedDocuments" class="btn btn-success pull-left btnSavePrequalifiedDocuments" name="btnSavePrequalifiedDocuments" value="Submit Documents" />
                            </div>
                            <br />
                            <br />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
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
                                                            if (folders.Name == "ExistingStudentRegistration")
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

                                                attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                                  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                            }

                                        %>
                                    </tbody>

                                </table>
                            </div>
                        </div>
                    </div>
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="previous_Click1" />
                    <%
                        if (alldocuments.Count == details.Count)
                        {
                            nextDocs.Visible = true;
                        }

                    %>
                    <asp:Button runat="server" ID="nextDocs" CssClass="btn btn-success pull-right" Text="Next" OnClick="next_Click1" Visible="false" />
                </div>

                <div class="tab-pane" id="tab_1_attach">
                    <div id="keydocumentsuploadfeedback" style="display: none" data-dismiss="alert"></div>
                    <!-- The global progress bar -->
                    <div class="progress progress-striped" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                        <div class="progress-bar progress-bar-success" style="width: 0%;"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                            <p>
                                Submit scanned copies of the following sets of documents, as part of your Registration process.
                            This Section enables you to upload scanned copies of the supporting documents as part of this Registration process.
                            </p>
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
                                <%--    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <strong>Select file to upload:</strong>
                                        <asp:FileUpload runat="server" ID="document" CssClass="form-control" Style="padding-top: 0px;" />
                                    </div>
                                </div>--%>
                            </div>
                            <%--     <div class="row">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6">
                                    <div class="form-group">
                                        <br />
                                        <asp:Button runat="server" CssClass="btn btn-success" Text="Upload Document" ID="uploadDocument" OnClick="uploadDocument_Click" />
                                    </div>
                                </div>
                            </div>--%>
                            <%--  <table class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>Document Title</th>
                                        <th>Download</th>
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
                                                        if (folders.Name == "Registration")
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

                                            attach.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                              "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                                        }

                                    %>
                                </tbody>

                            </table>--%>
                        </div>


                    </div>
                    <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" ID="prev" OnClick="previous_Click1" />
                    <asp:Button runat="server" CssClass="btn btn-success pull-right" Text="Next" ID="next" OnClick="next_Click1" />
                </div>

            </div>

        </div>
    </div>


    <%
        }
        else if (myStep == 3)
        {
    %>


    <div class="panel panel-default">
        <div class="panel-heading">
            Declaration<div class="pull-right"><i class="fa fa-angle-left"></i>Step 3 of 3<i class="fa fa-angle-right"></i></div>
            <div class="clearfix"></div>
        </div>
        <div class="panel-body">
            <div id="submit" runat="server"></div>
            <div class="row">
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="Dashboard.aspx">Dashboard </a></li>
                        <li class="breadcrumb-item active">Examination Registration</li>
                    </ol>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="form-group">
                        <h5>I <b><% =Session["StudentName"] %></b>  hereby declare that to the best of my knowledge all the information I have provided in this application and all supporting documents are true and correct and l agree to abide by the Examination Rules and Regulations and Code of Conduct and Ethics for kasneb students.</h5>

                    </div>
                    <div class="col-lg-12">

                        <asp:CheckBox runat="server" ID="declaration" />
                        <label class="font-noraml" for="acceptTerms">I agree with the Terms and Conditions.</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="text-center padding-15">
                    <center>
                       <%-- <asp:Button runat="server" class="btn btn-primary btn_submitregistration_Details" id="btn_submitregistration_Details" type="button" onclick=""> </asp:Button>--%>
                        <asp:Button runat="server" Text="Submit Registration" ID="submitRegistration" CssClass="btn btn-primary" OnClick="submitRegistration_Click" />
                    </center>
                </div>
            </div>
        </div>
        <div class="panel-footer">
            <asp:Button runat="server" CssClass="btn btn-warning pull-left" Text="Previous" OnClick="Unnamed_Click3" />
            <asp:Button runat="server" CssClass="btn btn-success pull-right" Visible="false" Text="Proceed to Payment" ID="Payment" OnClick="Payment_Click" />
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
    <div id="DocumentsAttach" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Attach the Document</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <strong>Upload Document</strong><span class="text-danger" style="font-size: 25px">*</span>
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



</asp:Content>
