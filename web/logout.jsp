<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <link href="CSS/myStyles.css" rel="stylesheet" type="text/css"/>
    </head>
    <body style="background: url(imgs/pexels.jpg); background-size: cover;background-attachment: fixed">
        <div class="container">
            <div class="row">
                <div class="col m8 offset-m2">
                    <div class="card">
                        <div class="card-content">
                            <h4>Login</h4>
                            <div class="form">
                                <form action="Register" method="post" style="display: flex; flex-direction: column; align-items: center;">
                                    <input type="text" name="user_name" placeholder="Enter username" style="margin-bottom: 10px;" required/>
                                    <input type="password" name="user_password" placeholder="Enter password" style="margin-bottom: 10px;" required/>
                                    <button type="submit" class="btn #009688 teal">Submit</button>
                                </form>
                                <% 
                                    String errorMessage = (String) request.getAttribute("errorMessage");
                                    if (errorMessage != null) {
                                %>
                                    <div class="error-message" style="color: red; margin-top: 10px;">
                                        <%= errorMessage %>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
<!--        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>-->
    </body>
</html>
