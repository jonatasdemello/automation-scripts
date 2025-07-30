There is different way based on the condition

To add a custom header  to an individual request then just add the headers property:

// Request with custom header
$.ajax({
    url: 'edureka/co',
    headers: { 'custom-header': 'some value' }
});

To add a default header to every request then use $.ajaxSetup():

$.ajaxSetup({
    headers: { 'custom-header': 'some value' }
});

// Sends your custom header
$.ajax({ url: 'edureka/co' });

// Overwrites the default header with a new header
$.ajax({ url: 'edureka/co', headers: { 'some-other-header': 'some value' } });

To add a header to every request then use the beforeSend hook with $.ajaxSetup():

$.ajaxSetup({
    beforeSend: function(xhr) {
        xhr.setRequestHeader('custom-header', 'some value');
    }
});
// Sends your custom header
$.ajax({ url: 'edureka/co' });

// Sends both custom headers
$.ajax({ url: 'foo/bar', headers: { 'x-some-other-header': 'some value' } });

Hope it helps!! If not then you should enroll with one of our Java certification course.
Thank You!


function setHeader(xhr) {
	xhr.setRequestHeader('Authorization', token);
}
$.ajax({
	type: "POST",
	headers: {
		'Access-Control-Allow-Origin': '*',
		'accept': '*/*'
	 },
	url: base_url,
	accepts: 'application/json',
	contentType: 'application/json',
	dataType: 'application/json',
	data: JSON.stringify(formdata),
	beforeSend: setHeader,
	success: function (data) {
		console.log(data);
		console.log(data.token)
		if (data == "OK") {
			$("#first").hide();
			$("#second").append("<p>Hello, admin</p> <br/><input type='button' id='logout' value='Log Out' />");
		}
		else {
			alert("Login Failed. Please try again.");
		}
	}
});
