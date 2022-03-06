<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="IntroductionForm.aspx.cs" Inherits="StudentManagementASPX.IntroductionForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
 .card {
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;
  width: 30%;

  }

 .card-row {
      display: flex;
      justify-content: space-between;
  }

.card:hover {
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
}

.container {
  padding: 2px 16px;
}
</style>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
       <div class="row" style="background-color: #f5f5f5;">
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                    <p class="pull-left" style="font-size: 15px">
                      <p class="pull-right" style="font-size: 15px">
                  <h3 style="color:Highlight"><b>Registartion</b></h3>
                </div>
                <hr />
            </div> <hr/>
   <div class="panel-heading">
    <div class="row" >
       <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
        <p>Are you a new student?
           <p></p> </p>

           
            
           
    
           <h4 style="color:red"><u>Note:</u></h4>
        
        </div>
        </div>
        
    <div class="card-row">          
               <div class="card">
                   <img src="assests/test-passed.png" alt="Avatar" style="width: 100%">
                   <div class="container">
                       <h4><b>John Doe</b></h4>
                       <p><a href="StudentRegistration.aspx">New Registration</a></p>
                   </div>
               </div>
               
          
               <div class="card">
                   <img src="assests/test-passed.png" alt="Avatar" style="width: 100%">
                   <div class="container">
                       <h4><b>John Doe</b></h4>
                       <p><a href="ExistingStudents.aspx">New Examination Registration</a></p>
                   </div>
               </div>
                 
         
          
               <div class="card">
                   <img src="assests/test-passed.png" alt="Avatar" style="width: 100%">
                   <div class="container">
                       <h4><b>John Doe</b></h4>
                       <p><a href="Intitutional.aspx">Institutional Registration</a></p>
                   </div>
               </div>
           </div>
   </div>
</asp:Content>
