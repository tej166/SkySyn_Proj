<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
    <style>
        body {
            background: url(imgs/pexels.jpg);
            background-size: cover;
            background-attachment: fixed;
        }
        .card {
            opacity: 0.8; 
            border-radius: 10px;
            padding: 10px;
        }

        .margin-top-custom {
            margin-top: 70px; /* Adjust this value to move the form down */
        }
    </style>
</head>
<body>
<%
session.removeAttribute("uname");
session.invalidate();
%>
    <div class="container">
        <div class="row">
            <div class="col m8 offset-m2 margin-top-custom">
                <div class="card">
                    <div class="card-content">
                        <h4>Login</h4>
                        <div class="form">
                            <form action="Register" method="POST" style="display: flex; flex-direction: column; align-items: center;">
                                <input type="text" name="user_name" placeholder="Enter username" style="margin-bottom: 20px;" required/>
                                <input type="password" name="user_password" placeholder="Enter password" style="margin-bottom: 20px;" required/>
                                <button type="submit" class="btn #009688 teal">Submit</button>
                            </form>
                            <div id="errorMessage" style="color: red; margin-top: 10px;">
                                <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
