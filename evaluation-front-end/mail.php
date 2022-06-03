<?php

$name = htmlspecialchars($_POST['name']);
$email = htmlspecialchars($_POST['email']);
$phone = htmlspecialchars($_POST['phone']);
$body = "Name: ".$name
."<br> Email: ". $email
."<br> Phone no: ". $phone
."<br> Message:  hello world"

mail($email,"This is the subject", $message);