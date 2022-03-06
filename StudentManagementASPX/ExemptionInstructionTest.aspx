<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ExemptionInstructionTest.aspx.cs" Inherits="StudentManagementASPX.ExemptionInstructionTest" %>
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
            The Student Portal enables the students to register for a kasneb Examination, book examination, apply for exemptions, withdrawal and Deferment.

        </p>
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


                <p>Applications for exemptions should ideally be before payment for the first examination.These policies addresses exemptions for holders of the following qualifications:
                </p>

                <p class="pull-left" style="font-size: 15px"><a href="downloads/Exemption%20Schedule%20I%20July%202021%20-%20Kasneb%20Graduates.pdf"><i class="fa fa-file-pdf-o"></i>Kasneb GRADUATES REGISTERING FOR OTHER Kasneb QUALIFICATIONS</a></p>
                <br />
                <p class="pull-left" style="font-size: 15px"><a href="downloads/EXEMPTION%20SCHEDULE%20II%20JULY%202021%20-%20OTHER%20QUALIFICATIONS.pdf"><i class="fa fa-file-pdf-o"></i>EXEMPTIONS TO HOLDERS OF UNIVERSITY DEGREES AND OTHER NON-Kasneb QUALIFICATIONS</a></p>
                <br /> <br /><p class="pull-left" style="font-size: 15px; position:absolute"><a href="downloads/EXEMPTION%20SCHEDULE%20III%20-%20LLB%20GRADUATES%20AND%20ADVOCATES.pdf"><i class="fa fa-file-pdf-o"></i>EXEMPTIONS FOR LLB FINALISTS AND ADVOCATES</a></p>
               
                <br />
                
                <ol type="1">
                    <li>KASNEB professional, diploma and technician qualifications.</li>
                    <li>Undergraduate and postgraduate degrees from recognised universities based in Kenya or outside Kenya.</li>
                    <li>Diploma qualifications offered by the Kenya National Examinations Council (KNEC), Kenya Institute of Management (KIM) and the Kenya School of Law (KSL).</li>
                    <li>Association of Certified Chartered Accountants (ACCA) and Institute of Chartered Secretaries and Administrators (ICSA) of the United Kingdom..</li>
                </ol>

            
            </div>
            <%--   <label   class="btn btn-success pull-right"  onclick="createApplicationsss('<% =x %>');"><i class=""></i>Proceed</label>--%>
         <label class="btn btn-success pull-right" Style="margin-right: 100px;" onclick="createApplication('<% =x %>');"><i class="fa fa-arrow-right"></i>Apply Now</label>
        </div>
        </div>
       
     <%-- <asp:Button runat="server" CssClass="btn btn-success" Text="Next" id="nextAppliation" OnClick="nextAppliation_Click" />
        --%>
     
    </div>


    <script>
        function createApplication(y) {
            document.getElementById("MainContent_TextBox1").value = y;
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
                    <h4 class="modal-title">Exemption Application</h4>
                </div>
                <div id="exemptionFeedback" runat="server" />
                <div class="modal-body">
                    <div class="row" style="display: none">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Exam Cycle:</label>
                                 <asp:TextBox runat="server" ID="TextBox1" />
                                <asp:TextBox CssClass="form-control" runat="server" ID="courseId" Visible="false" />
                                <asp:TextBox CssClass="form-control" runat="server" ID="TestData" ReadOnly Visible="false" />
                            </div>
                        </div>

                    </div>
                    <p>Examination: </p>
                    <asp:Textbox CssClass="form-control" runat="server" ID="regNos" ReadOnly/>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <asp:Button runat="server" CssClass="btn btn-success" Text="Next" OnClick="Next_Click" />
                </div>
            </div>


        </div>
    </div>

    <div class="clearfix"></div>


</asp:Content>
