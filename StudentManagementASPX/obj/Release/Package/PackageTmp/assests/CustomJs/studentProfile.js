$(document).ready(function () {
    $(".btn_personalinformations").click(function () {
        var data = {
           
            "IDNumber": $("#txtidNumber").val(),
            "Surname": $("#txtfirstname").val(),
            "First_Name": $("#txtsurname").val(),
            "Othernames": $("#txtothernames").val(),
            "Gender": $("#txtgender").val(),
            "DOB": $("#txtdob").val(),
            "Disabled": $("#disabled").val(),           
            "E_Mail": $("#emailaddress").val(),
            "Address": $("#txtpobox").val(),
            "Post_Code": $("#txtpostcode").val(),
            "City": $("# txtcity").val(),
            "examcenters": $("#txttrainingInstitution").val(),
            "examination": $("#txtExamination").val(),
            "Phone_No": $("#txtmobilenumber").val(),
            "Highest_Academic_Qualification": $("#txteducationallevel").val(),
            "county": $("#txtcountyoforigin").val(),
            "examCycle": $("#txtexamcycle").val(),
            
        }
        Swal.fire({
            title: "Confirm student application?",
            text: "Are you sure you would like to proceed with submission?",
            type: "warning",
            showCancelButton: true,
            closeOnConfirm: true,
            confirmButtonText: "Yes, Proceed!",
            confirmButtonClass: "btn-success",
            confirmButtonColor: "#008000",
            position: "center"
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: "/Home/StudentApplication",
                    type: "POST",
                    data: JSON.stringify(data),
                    contentType: "application/json",
                    cache: false,
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.split('*');
                    status = registerstatus[0];
                    switch (status) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Candidate Registration Submitted!",
                                text: registerstatus[1],
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Your Personal Information have been successfully submitted" + "  " + registerstatus[1]);
                                $("#uploadsMsg").css("display", "block");
                                $("#uploadsMsg").css("color", "green");
                                $("#uploadsMsg").html("Your Personal Information have been successfully submitted." + "  " + registerstatus[1]);
                                $("#preqappl_form").reset();
                                document.getElementById("emailaddress").value = "";
                                document.getElementById("txtsurname").value = "";
                                document.getElementById("txtfirstname").value = "";
                                document.getElementById("txtothernames").value = "";
                                document.getElementById("txtgender").value = "";
                                document.getElementById("txtgender").value = "";
                                document.getElementById("txtidnumber").value = "";
                                document.getElementById("txtpassport").value = "";
                                document.getElementById("txtnationality").value = "";
                                document.getElementById("txtreligion").value = "";
                            });
                            $("button#nextBtn").css("display", "block");
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "Registration Error!!!",
                                text: "Your Account Creation Request could not been successfully submitted" + " " + registerstatus[1],
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("Your Account Creation Request could not been successfully submitted" + " " + registerstatus[1]);
                            });
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Registration Cancelled',
                    'You cancelled your Candidate Registration submission details!',
                    'error'
                );
            }
        });

    });
})