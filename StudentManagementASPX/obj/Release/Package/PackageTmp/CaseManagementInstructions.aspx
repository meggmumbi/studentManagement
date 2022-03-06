<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CaseManagementInstructions.aspx.cs" Inherits="StudentManagementASPX.CaseManagementInstructions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    
     <% 
        var x = "Test";

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
        <p>
            The Student Portal enables the students to register for a kasneb Examination, book examination, apply for exemptions, withdrawal and differment.

        </p>
        <div class="row" style="background-color: #f5f5f5;">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">                
                <h3 style="color: Highlight"><b>Case Management</b></h3>
            </div>
            <hr />
        </div>
        <hr />

        <div id="responsesfeedback" style="display: none" data-dismiss="alert"></div>
        <div class="panel-body">
         <div runat="server" id="linesFeedback"></div>
        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <h4 style="color: red"><u>Case Managemnt Instructions:</u></h4>


                <p>Applications for exemptions should ideally be before payment for the first examination.These policies addresses exemptions for holders of the following qualifications: </p>

             
                
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
          <label class="btn btn-success pull-right" Style="margin-right: 100px;" onclick="createApplication();"><i class="fa fa-arrow-right"></i>Apply Now</label>
     
    </div>


    <script>
        function createApplication() {
           
            $("#removeLineModal").modal();
        }
    </script>
    <div id="removeLineModal" class="modal fade" role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Proceed to make an enquiry</h4>
                </div>
                <div id="exemptionFeedback" runat="server" />
           

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Next_Click" />
                </div>
            </div>


        </div>
    </div>

    <div class="clearfix"></div>


</asp:Content>
