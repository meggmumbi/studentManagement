<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BrQuestions.aspx.cs" Async="true" Inherits="StudentManagementASPX.BrQuestions" %>
<%@ Import Namespace="StudentManagementASPX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
       <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
      
  
    <script>
        function success() {
            Swal.fire(
                'successful'

            )
        }

      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<div class="panel panel-default" style="width:70%; margin: 0px auto;">
        <div class="panel-heading">
            BR Questions General Details
             <span class="pull-right"><i class="fa fa-chevron-left"></i> Page 3 of 3 <i class="fa fa-chevron-right"></i></span><span class="clearfix"></span>
        </div>
        <div class="panel-body">
            <div id="feedback" style="display: none"></div>
            <div id="generalFeedback" runat="server"></div>
            <% 
                string surveyNo = Request.QueryString["surveyNo"];
                string sectionCode = Request.QueryString["sectionCode"];
                var nav = Config.ReturnNav();
                %>
            <%
                var section = nav.BrResponseSection.Where(x=> x.Survey_Response_ID == surveyNo && x.Section_Code == sectionCode).ToList();
                foreach(var sectionheader in section)
                {
                    %>
                    
                        <h3><strong><%=sectionheader.Description %></strong></h3>
                     <%
                }

                 %>


            <br />
            <%
                var quiz = nav.BRResponseQuestion.Where(x=> x.Survey_Response_ID == surveyNo && x.Section_Code == sectionCode).ToList();
                foreach (var project in quiz)
                {
                %>
            
            <div class="row">                
                <div class="col-md-6 col-lg-12">
                    <div class="form-group">
                        <div class="divSurvey">
                        <input type="hidden" value="<% =Request.QueryString["surveyNo"] %>" class="txtsurveyNo"/>
                        <input type="hidden" value="<% =Request.QueryString["sectionCode"] %>" class="txtsectioncode"/>
                        <input runat="server" type="hidden" value="<%=project.Question_ID %>" id="txtQuestionId" name="txtQuestionId" class="txtQuestionId"/>
                        <input type="hidden" value="<%=project.Response_Type %>" id="txtresponsetype" name="txtresponsetype" class="txtresponsetype"/>
                        <input type="hidden" value="<%=project.Branch_Logic_Question %>" id="txtbraching" name="txtbraching" class="txtbraching"/>
                        <asp:TextBox runat="server" ID="quizId" value="<%=project.Question_ID %>" Visible="false"></asp:TextBox>
                       <h4><strong><label><% =project.Question %></label></strong></h4> 
                        <%
                            if (project.Rating_Type == "Options Text")
                            {
                                string responseType = project.Option_Text_Response_Type;
                                var resCode = nav.BRResponseCode.Where(x=> x.Response_Type == responseType).ToList();
                                CheckBoxList1.DataSource = resCode;
                                CheckBoxList1.DataTextField = "Response_Code";
                                CheckBoxList1.DataValueField = "Response_Code";
                                CheckBoxList1.DataBind();

                                var resCode1 = nav.BRResponseCode.Where(x=> x.Response_Type == responseType).ToList();
                                listItem.DataSource = resCode1;
                                listItem.DataTextField = "Response_Code";
                                listItem.DataValueField = "Response_Code";
                                listItem.DataBind();

                                if(project.Response_Type == "Multiple Response")
                                {
                                        %>
                                            <asp:CheckBoxList Font-Normal="true" runat="server" CssClass="checkbox-inline CheckBoxList1" ID="CheckBoxList1" style="font-weight:lighter"></asp:CheckBoxList>
                                        <%
                                    }
                                     else if (project.Response_Type == "Single Response")
                                    {
                                       %>
                                         <asp:RadioButtonList runat="server" ID="listItem" class="listItem">
                                             
                                         </asp:RadioButtonList>
                                        <%
                                           
                                    }
                             }  
                            else if(project.Rating_Type == "Open Text") 
                            {
                            %>
                                    <textarea class="form-control response" rows="1" style="font-weight:normal"></textarea>
                                <%
                            }

                        %> 
<%--                              <div id="divtest" visible="false">
                                  <label style="color:red"><strong><i>Branched Question</i></strong></label>
                                  <asp:TextBox runat="server"></asp:TextBox>
                              </div>  --%>    
                        </div>                                     
                    </div>
                 </div>
               </div>

            <%
                }
              %>
                <asp:Button type="button" class="btn btn-primary pull-left" ID="previous" runat="server" Text="Previous Page"  OnClick="previous_Click"/>
                 <button type="submit" class="btn btn-success pull-right saveresponce">Submit Response</button> 
           </div>           
    </div>





<script>
    $("body").delegate(".saveresponce", "click", function (event) {
            //To prevent form submit after ajax call

            event.preventDefault();
            //Loop through the Table rows and build a JSON array.
            var allrfqitems = new Array();
            //declare an array
            var i = 0;


            $(".divSurvey").each(function () {
                var row = $(this);
                var onerfqitem = {};

                i++;

                onerfqitem.SurveyNo = row.attr("id", "txtsurveyNo" + i).find(".txtsurveyNo").val();

                onerfqitem.SectionCode = row.attr("id", "txtsectioncode" + i).find(".txtsectioncode").val(); 

                onerfqitem.QuestionCode = row.attr("id", "txtQuestionId" + i).find(".txtQuestionId").val(); 

                onerfqitem.ResponseType = row.attr("id", "txtresponsetype" + i).find(".txtresponsetype").val();

                onerfqitem.Branching = row.attr("id", "txtbraching" + i).find(".txtbraching").val();

                onerfqitem.CheckBox = $("#<%= CheckBoxList1.ClientID %> input:checked").val();  

                onerfqitem.RadioButton = $("#<%= listItem.ClientID %> input:checked").val();

                onerfqitem.GeneralResponse = row.attr("id", "response" + i).find(".response").val();

                allrfqitems.push(onerfqitem);

            });

            $.ajax({
                type: "POST",
                url: "BrQuestions.aspx/InsertComponentItems",
                data: '{cmpitems: ' + JSON.stringify(allrfqitems) + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (status) {
                    switch (status.d) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Response Added!",
                                text: "Survey Response saved successfully!",
                                type: "success"
                            }).then(() => {
                                //$("#feedback").css("display", "block");
                                //$("#feedback").css("color", "green");
                                //$('#feedback').attr("class", "alert alert-success");
                                //$("#feedback").html("Survey Responce saved successfully!");
                            });
                            break;

                        case "componentnull":
                            Swal.fire
                            ({
                                title: "Component not filled!",
                                text: "Component field empty!",
                                type: "danger"
                            }).then(() => {
                                //$("#feedback").css("display", "block");
                                //$("#feedback").css("color", "red");
                                //$('#feedback').attr("class", "alert alert-danger");
                                //$("#feedback").html("Component field empty!");
                            });
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Error!!!",
                                text: "You have already responded to this question",
                                type: "error"
                            }).then(() => {
                                //$("#feedback").css("display", "block");
                                //$("#feedback").css("color", "red");
                                //$('#feedback').addClass('alert alert-danger');
                                //$("#feedback").html(status.d);
                            });

                            break;
                    }
                },
                error: function (err) {
                    console.log(err.statusText);
                    console.log(status.d);
                }

            });

            console.log(allrfqitems);
    });

    //show modal popup
<%--    $(function () {
        //Attach click event to your Dropdownlist
        $("#<%= listItems.ClientID %>").change(function () {
            $(".divSurvey").each(function () {
                var branching = $(".txtbraching").val();
                if (branching == "true")
                {
                    $('.indexchangemodal').modal('show');
                }
            });
        });
    });--%>

    //insert branched responses
    //$("body").delegate(".addbranchedresponse", "click", function (event) {
    //        //To prevent form submit after ajax call

    //        event.preventDefault();
    //        //Loop through the Table rows and build a JSON array.
    //        var Ballrfqitems = new Array();
    //        //declare an array
    //        var i = 0;


    //        $(".brachedDiv").each(function () {
    //            var row = $(this);
    //            var onerfqitem = {};

    //            //tonerfqitem.SurveyNo = row.attr("id", "tSurvceyno" + i).find(".tSurvceyno").val();

    //            //tonerfqitem.SectionCode = row.attr("id", "tSectioncode" + i).find(".tSectioncode").val();

    //            //tonerfqitem.ParentQuestionId = row.attr("id", "parentquestionid" + i).find(".parentquestionid").val();

    //            //tonerfqitem.Parentresponse = row.attr("id", "parentresponsevalue" + i).find(".parentresponsevalue").val();

    //            //tonerfqitem.QuestionId = row.attr("id", "brachedQuestionId" + i).find(".brachedQuestionId").val();

    //            //tonerfqitem.Question = row.attr("id", "branchedQuiz" + i).find(".branchedQuiz").val();

    //            //tonerfqitem.Responsevalue = row.attr("id", "branchinresponse" + i).find(".branchinresponse").val();

    //            onerfqitem.SurveyNo = $(".tSurvceyno").val();
    //            onerfqitem.SectionCode = $(".tSectioncode").val();
    //            onerfqitem.ParentQuestionId = $(".parentquestionid").val();
    //            onerfqitem.Parentresponse = $(".parentresponsevalue").val();
    //            onerfqitem.QuestionId = $(".brachedQuestionId").val();
    //            onerfqitem.Question = $(".branchedQuiz").val();
    //            onerfqitem.Responsevalue = $(".branchinresponse").val();

    //            Ballrfqitems.push(onerfqitem);

    //        });

    //        $.ajax({
    //            type: "POST",
    //            url: "BrQuestions.aspx/Insertbrachedresponse",
    //            data: '{Bcmpitems: ' + JSON.stringify(Ballrfqitems) + '}',
    //            contentType: "application/json; charset=utf-8",
    //            dataType: "json",
    //            success: function (status) {
    //                switch (status.d) {
    //                    case "success":
    //                        Swal.fire
    //                        ({
    //                            title: "Response Added!",
    //                            text: "Kindly Proceed To The Next Question!",
    //                            type: "success"
    //                        }).then(() => {
    //                            //$("#feedback").css("display", "block");
    //                            //$("#feedback").css("color", "green");
    //                            //$('#feedback').attr("class", "alert alert-success");
    //                            //$("#feedback").html("Survey Responce saved successfully!");
    //                        });
    //                        break;

    //                    case "componentnull":
    //                        Swal.fire
    //                        ({
    //                            title: "Component not filled!",
    //                            text: "Component field empty!",
    //                            type: "danger"
    //                        }).then(() => {
    //                            //$("#feedback").css("display", "block");
    //                            //$("#feedback").css("color", "red");
    //                            //$('#feedback').attr("class", "alert alert-danger");
    //                            //$("#feedback").html("Component field empty!");
    //                        });
    //                        break;
    //                    default:
    //                        Swal.fire
    //                        ({
    //                            title: "Error!!!",
    //                            text: "You have already responded to this question",
    //                            type: "error"
    //                        }).then(() => {
    //                            //$("#feedback").css("display", "block");
    //                            //$("#feedback").css("color", "red");
    //                            //$('#feedback').addClass('alert alert-danger');
    //                            //$("#feedback").html(status.d);
    //                        });

    //                        break;
    //                }
    //            },
    //            error: function (err) {
    //                console.log(err.statusText);
    //                console.log(status.d);
    //            }

    //        });

    //        console.log(Ballrfqitems);
    //});


<%--                            <!--Onselected index change modal popup-->
                <div class="modal fade indexchangemodal" id="indexchangemodal" role="dialog">
                    <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title"><i style="color:blue">Respond To the Question Below</i></h4>
                        </div>
                        <div class="modal-body">
                         <div class="brachedDiv">
                            <%
                                string parentQuestionId = project.Question_ID;
                                string parentResponse = listItem.SelectedValue;
                                var branchedquestion = nav.BRBranchResponseQuestion.Where(x=> x.Response_ID == surveyNo && x.Section_Code == sectionCode && x.Parent_Question_ID == parentQuestionId && x.Parent_Response == parentResponse);
                                foreach (var question in branchedquestion)
                                {
                                    %>
                                    <div class="form-group">
                                        <strong id="branchedQuizs" class=""><%=question.Question %></strong>
                                        <textarea class="form-control branchinresponse" rows="1" style="font-weight:normal"></textarea>
                                        <input type="hidden" value="<%=question.Question_ID %>" id="brachedQuestionId" name="brachedQuestionId" class="brachedQuestionId"/>
                                        <input type="hidden" value="<%=parentQuestionId %>" id="parentquestionid" name="parentquestionid" class="parentquestionid"/>
                                        <input type="hidden" value="<%=parentResponse %>" id="parentresponsevalue" name="parentresponsevalue" class="parentresponsevalue"/>
                                        <input type="hidden" value="<%=question.Question %>" id="branchedQuiz" name="branchedQuiz" class="branchedQuiz"/>
                                        <input type="hidden" value="<% =Request.QueryString["surveyNo"] %>" class="tSurvceyno"/>
                                        <input type="hidden" value="<% =Request.QueryString["sectionCode"] %>" class="tSectioncode"/>

                                    </div>
                              
                                    <%
                                }

                            %>

                        </div>
                        </div> 
                        <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-success pull-right addbranchedresponse">Add Response</button> 
                        </div>
                    </div>

                    </div>
                </div>--%>
</script>

</asp:Content>
