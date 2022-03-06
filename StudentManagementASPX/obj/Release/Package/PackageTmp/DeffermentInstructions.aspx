<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="DeffermentInstructions.aspx.cs" Inherits="StudentManagementASPX.DeffermentInstructions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

     <div class="row" style="background-color: #f5f5f5;">
        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
            <p class="pull-left" style="font-size: 15px"><a href=""><i class="fa fa-file-pdf-o"></i>Portal User Guide</a></p>
            <h3 style="color: Highlight"><b>Defferment</b></h3>
        </div>
        <hr />
    </div>
    <hr />
    <div id="linesFeedback" runat="server" />
    <div class="panel-heading">
        <div class="row">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <h4 style="color: red"><u>Deferment Of Examinations:</u></h4>

                
                <p>Deferment of fees shall be allowed subject to the following conditions::</p>               
                
                <ol type="1">
                    <li>A formal application shall be made by the student for deferment of examination fees to the subsequent sitting..</li>
                    <li>Deferment of fees is not automatic and shall only be allowed on the basis of medical reasons, change of work station or similar extraneous circumstances as approved by the Secretary and Chief Executive..</li>
                    <li> All relevant evidence should be attached to the application letter. Applications received without any evidence attached SHALL NOT be considered.</li>
                    <li>A student shall be allowed to defer fees to the subsequent sitting only once in any particular level or section. The full amount of deferred fees not utilised in the subsequent sitting shall be forfeited to kasneb..</li>
                    <li> An administrative charge equivalent to 15% of the applicable examination fees shall be levied as a precondition for the deferment of the examination fees.</li>
                    <li>An application for deferment together with the supporting evidence must be received at least thirty (30) days before the commencement date of the examination, except for medical reasons.</li>
                </ol>
             
              

                <h4 style="color: red"><u>Note:</u></h4>
                <p>Timelines for required responses are inbuilt, and the system will automatically terminate evaluation at the expiry of the given response period; if this happens, you will be required to make a fresh application.</p>
            </div>
            <asp:Button runat="server" CssClass="btn btn-primary pull-right fa fa-arrow-right" Style="margin-right: 100px;" Text="Next" ID="Next" OnClick="Next_Click"/>
        </div>
    </div>

</asp:Content>
