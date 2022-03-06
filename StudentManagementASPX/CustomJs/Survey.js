var PrimaryInitiative = new Array();
$(".btn_applyallselectedannualActvities").on("click",
    function (e) {
        e.preventDefault();
        PrimaryInitiative = [];
        $.each($(".secondary1ActivityInitiativeTableDetails tr.active"), function () {
            //procurement category
            var checkbox_value = $('#selectedactivityrecords2').val();
            var Targets = {};
            Targets.annualNumber = ($(this).find('td').eq(1).text());
            PrimaryInitiative.push(Targets);
        });
        var postData = {
            catgeories: PrimaryInitiative
        };
        console.log(JSON.stringify(PrimaryInitiative))
        Swal.fire({
            title: "Confirm Activity Submission?",
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
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: '{annualNumber: ' + JSON.stringify(PrimaryInitiative) + '}',
                    url: "NewIndividualScoreCard.aspx/submitannualplan",
                    dataType: "json",
                    processData: false
                }).done(function (status) {
                    var registerstatus = status.d;
                    console.log(JSON.stringify(registerstatus))
                    switch (registerstatus) {
                        case "success":
                            Swal.fire
                            ({
                                title: "Activity Categories Submitted!",
                                text: registerstatus,
                                type: "success"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $('#feedback').attr("class", "alert alert-success");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "green");
                                $("#feedback").html("Your Activity Details have been successfully submitted!");
                                $("#feedback").reset();
                            });
                            PrimaryInitiative = [];
                            $('#allsecondaryActivities').modal('hide');
                            $.modal.close();
                            //document.location.reload();
                            // window.location("NewIndividualScoreCard.aspx");
                            break;
                        default:
                            Swal.fire
                            ({
                                title: "feedback Error!!!",
                                text: registerstatus,
                                type: "error"
                            }).then(() => {
                                $("#feedback").css("display", "block");
                                $("#feedback").css("color", "red");
                                $('#feedback').addClass('alert alert-danger');
                                $("#feedback").html("Your Activity Details could not be submitted!" + registerstatus);
                            });
                            PrimaryInitiative = [];
                            break;
                    }
                }
                );
            } else if (result.dismiss === Swal.DismissReason.cancel) {
                Swal.fire(
                    'Activity Cancelled',
                    'You cancelled your Activity submission details!',
                    'error'
                );
            }
        });

    });
