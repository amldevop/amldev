function sendEmail(){
    Email.send({
        Host : "smtp.gmail.com",
        Username : "username",
        Password : "password",
        To : 'test@website.com',
        From : document.getElementById("email").value, 
        Subject : "This is the subject",
        Body : "Name: " + document.getElementById("name").value
            + "<br> Email: " + document.getElementById("email").value
            + "<br> Phone no: " + document.getElementById("phone").value
            + "<br> Message: " + document.getElementById("message").value
    }).then(
        message => alert(message)
    );
}