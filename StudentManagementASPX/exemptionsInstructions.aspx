<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="exemptionsInstructions.aspx.cs" Inherits="StudentManagementASPX.exemptionsInstructions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
      <% 
          var y = "Test";

    %>
  <div class="row">
            <div class="card">
                  <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Welcome to Student Portal</strong></h3>
                </div>
            </div>
        </div>
       <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
     <div class="content container-fluid">
        <div class="row">
            <div class="card">
                  <div class="card-header text-center" data-background-color="darkgreen">
                    <h3 class="title"><strong>Welcome to Student Portal</strong></h3>
                </div>
            </div>
        </div>
       <center class="center-item">
            <p style="color:black"><strong>This Portal enable a student to access services related to kasneb Examinations.</strong></p></center>
           
        <div class="row" style="background-color: #f5f5f5;">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <p class="pull-left" style="font-size: 15px"><a href=""><i class="fa fa-file-pdf-o"></i>Portal User Guide</a></p>
                <h3 style="color: Highlight"><b>Exemptions</b></h3>
            </div>
            <hr />
        </div>
        <hr />

        <div id="responsesfeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
         <div runat="server" id="linesFeedback"></div>
        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <h4 style="color: red"><u>EXEMPTION POLICY:</u></h4>


                <p>Applications for exemptions should ideally be before payment for the first examination.This policy addresses exemptions for holders of the following qualifications:
                </p>

                <p class="pull-left" style="font-size: 15px"><a href="downloads/REVISED-EXEMPTION-POLICY.pdf"><i class="fa fa-file-pdf-o"></i>Exemption Policy</a></p>
                <br />
                <p class="pull-left" style="font-size: 15px"><a href="downloads/Summary-of-exemptions-to-Advocates-under-the-CS-qualification-Final.pdf"><i class="fa fa-file-pdf-o"></i>Exemptions to Advocates of the High Court of Kenya and Other Holders of Bachelor of Laws (LLB) Degree Wishing to Pursue The Certified Secretaries (CS)</a></p>
                <br />
                <ol type="1">
                    <li>KASNEB professional, diploma and technician qualifications.</li>
                    <li>Undergraduate and postgraduate degrees from recognised universities based in Kenya or outside Kenya.</li>
                    <li>Diploma qualifications offered by the Kenya National Examinations Council (KNEC), Kenya Institute of Management (KIM) and the Kenya School of Law (KSL).</li>
                    <li>Association of Certified Chartered Accountants (ACCA) and Institute of Chartered Secretaries and Administrators (ICSA) of the United Kingdom..</li>
                </ol>

            
            </div>
            <%--   <label   class="btn btn-success pull-right"  onclick="createApplicationsss('<% =x %>');"><i class=""></i>Proceed</label>--%>
         
        </div>
        </div>
          <label class="btn btn-success pull-right" Style="margin-right: 100px;" onclick="createApplication('<% =y %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>
     
    </div>


 
    <div id="removeLineModall" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Do you want to Apply for Exemption?</h4>
                </div>
                <div id="exemptionFeedback" runat="server" />
                <div class="modal-body">
                    <div class="row" style="display: none">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Exam Cycle:</label>

                                <asp:TextBox CssClass="form-control" runat="server" ID="courseId" Visible="false" />
                                <asp:TextBox CssClass="form-control" runat="server" ID="TestData" ReadOnly Visible="false" />
                            </div>
                        </div>

                    </div>
                    <p>Registration No:</p>
                    <asp:DropDownList CssClass="form-control select2" runat="server" ID="regNo" />

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Next_Click" />
                </div>
            </div>


        </div>
    </div>

    <script>
        function createApplication(x) {
            document.getElementById("MainContent_TestData").value = x;
            $("#removeLineModall").modal();
        }
    </script>
    
</asp:Content>
