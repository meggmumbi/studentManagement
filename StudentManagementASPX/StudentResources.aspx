<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="StudentResources.aspx.cs" Inherits="StudentManagementASPX.StudentResources" %>

<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="StudentManagementASPX" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Microsoft.SharePoint.Client" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="StudentManagementASPX.Models" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="row">
        <div class="card">
            <div class="card-header text-center" data-background-color="darkgreen">
                <h3 class="title"><strong>Welcome to Student Portal</strong></h3>
            </div>
        </div>
    </div>
    <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
    <h5><u>Sylabuses</u></h5>
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
        <div runat="server" id="documents" />
        <div class="col-md-12">
            <div class="table-responsive">
                <table class="table table-bordered table-striped" id="example3">
                    <thead>
                        <tr>
                             <th>#</th>
                            <th> Title</th>
                            <%-- <th>Download</th>--%>
                            <th>Download</th>
                           
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            int counter = 0;
                            List<SharePointTModel> alldocuments = new List<SharePointTModel>();
                            try
                            {%>
                        <%  using (ClientContext ctx = new ClientContext(ConfigurationManager.AppSettings["sServer_URL"]))
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
                                List list = ctx.Web.Lists.GetByTitle("Documents");

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
                                    if (folder.Name == "Examination")
                                    {
                                        ctx.Load(folder.Folders);
                                        ctx.ExecuteQuery();
                                        var uniquerfiNumberFolders = folder.Folders;

                                        foreach (Folder folders in uniquerfiNumberFolders)
                                        {
                                            if (folders.Name == "Kasneb Syllabuses 2021")
                                            {
                                                ctx.Load(folders.Files);
                                                ctx.ExecuteQuery();
                                                //var uniquevendorNumberSubFolders = folders.Folders;

                                                //foreach (Folder vendornumber in uniquerfiNumberFolders)
                                                //{
                                                //    if (vendornumber.Name == uniqueLeaveNumber)
                                                //    {
                                                // ctx.Load(vendornumber.Files);
                                                // ctx.ExecuteQuery();

                                                FileCollection vendornumberFiles = folders.Files;
                                                foreach (Microsoft.SharePoint.Client.File file in vendornumberFiles)
                                                {%>
                        <% ctx.ExecuteQuery();
                            alldocuments.Add(new SharePointTModel { FileName = file.Name });
                            alldocuments.ToList();
                        %>


                        <% }%>

                        <%
                            foreach (var item in alldocuments)
                            {
                                var sharepointUrl = ConfigurationManager.AppSettings["sServer_URL"];
                                var filePath = sharepointUrl + "Shared%20Documents/Examination/Kasneb Syllabuses 2021/" + "/"  ;
                                var parentFolderName = "Shared%20Documents/Examination/Kasneb Syllabuses 2021/";
                                string webUrl = sharepointUrl + parentFolderName + "/" + item.FileName;

                                counter++;
                                %>
                        <tr>
                          <td><%=counter %></td>
                            <td><a href='<%=webUrl%>'><% =item.FileName %></a></td>
                            <td>
                                <label class="btn btn-success" onclick="downloadFile('<%=item.FileName %>');"><i class="fa fa-download"></i>Download</label></td>
                        </tr>
                        <% }
                        %>

                        <%  }

                                            }


                                        }
                                        //    }

                                        //}
                                    }

                                }

                            }
                            catch (Exception t)
                            {

                                documents.InnerHtml = "<div class='alert alert-danger'>" + t.Message +
                                                  "<a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a></div>";
                            }

                        %>
                    </tbody>

                </table>
            </div>
        </div>
    </div>


    <script>

        function downloadFile(fileName) {
            document.getElementById("filetoDownloadName").innerText = fileName;
            document.getElementById("MainContent_fileName1").value = fileName;
            $("#downloadFileModal").modal();

        }
    </script>
    <div id="downloadFileModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirm Download File</h4>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to download the file <strong id="filetoDownloadName"></strong>?</p>
                    <asp:TextBox runat="server" ID="fileName1" type="hidden" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Download File" ID="downloadFile" OnClick="downloadFile_Click" />
                </div>
            </div>

        </div>
    </div>





</asp:Content>
