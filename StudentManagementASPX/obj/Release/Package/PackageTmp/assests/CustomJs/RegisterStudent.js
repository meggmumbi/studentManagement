$('.btn_accountcreation').click(function (event) {
    //To prevent form submit after ajax call
    event.preventDefault();
    var ttype = $('#Applicationtype :selected').val();
    var tfirstname = $("#firstName").val().replace(/[\\"']/g, '\\$&').replace(/\u0000/g, '\\0');
    var tmiddlname = $("#middlname").val();
    var tlastname = $('#lastname').val();
    var tphonenumber = $('#phonenumber').val();
    var temailaddress = $('#email').val();
    var taddress = $('#address').val();
    var tpostcode = $('#postcode').val();
    var tcity = $('#city').val();
    var tcountry = $('#country').val();
    var tIdNumber = $('#idNumber').val();
    

    
    
    
    if (tfirstname != '' && tlastname != '' && tphonenumber != '' && temailaddress != '' && tIdNumber != '') {
        //Swal Message
        Swal.fire({
            title: "Confirm Account signup?",
            text: "Are you sure you would like to proceed with submission? Please make sure that the email address " + temailaddress + " is correct and active.",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
                $.ajax
                   ({
                       type: 'POST',
                       url: 'Register.aspx/register',
                       async: false,
                       data: "{'ttype':'" + ttype + "','tfirstname':'" + tfirstname + "','tmiddlname':'" + tmiddlname
                           + "','tlastname':'" + tlastname + "','tphonenumber':'" + tphonenumber + "','temailaddress':'" + temailaddress
                           + "','taddress':'" + taddress + "','tpostcode':'" + tpostcode + "','tcity':'" + tcity + "','tcountry':'" + tcountry + "','tIdNumber':'" + tIdNumber + "'}",
                       contentType: 'application/json; charset =utf-8',
                       success: function (status) {
                           var obj = status.d;
                           if (obj == 'success') {                             
                               $('#tfirstname').val('');
                               $('#tmiddlname').val('');
                               $('#tlastname').val('');
                               swal
                                  ({
                                      title: "Account Created!",
                                      text: "Your student account was successfully created. Please Check your email to get your login credentials!",
                                      icon: "success",
                                      type: "success"
                                  }).then(() => {
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $('#acccountfeedback').attr("class", "alert alert-success");
                                      $("#acccountfeedback").html("Your Account Details was Successfully Submitted.Kindly wait for Notification from kasneb!!");
                                      $("#acccountfeedback").css("display", "block");
                                      $("#acccountfeedback").css("color", "green");
                                      $("#acccountfeedback").html("Your Account Details was Successfully Submitted.Kindly wait for Notification from kasneb!");
                                      window.location = "Login.aspx";
                                  });

                           }
                           else {
                               Swal.fire
                                   ({
                                       title: "Account Creation Error!!!",
                                       text: obj,
                                       type: "error"
                                   }).then(() => {
                                       $("#acccountfeedback").css("display", "block");
                                       $("#acccountfeedback").css("color", "red");
                                       $('#acccountfeedback').addClass('alert alert-danger');
                                       $("#acccountfeedback").html(status.d);
                                   });
                           }
                       },
                       error: function (result) {
                           Swal.fire
                            ({
                                title: "Account Creation Error!!!",
                                text: "Error Occured when Submitting your Details" + status.d,
                                type: "error"
                            }).then(() => {
                                $("#acccountfeedback").css("display", "block");
                                $("#acccountfeedback").css("color", "red");
                                $('#acccountfeedback').addClass('alert alert-danger');
                                $("#acccountfeedback").html(status.d);
                            });
                       }
                   });
            }
            else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Account Registration Cancelled',
                    'You cancelled your registration submission details!',
                    'error'
                );
            }
        });
    }
    else {
        Swal.fire({
            icon: 'error',
            title: 'Oops...',
            text: 'Fill in all the Details before you register!',
            footer: '<a href>Contact kasneb for Any Clarifications?</a>'
        })
    }
})
