<%-- 
    Document   : signup
    Created on : 25 Jun 2024, 12:46:23 pm
    Author     : tejal mahur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
    </head>
    <body style="background: url(imgs/pexels.jpg); background-size: cover;background-attachment: fixed">
        <div class="container">
            <div class ="row">
                <div class="col m8 offset-m2">
                    <div class="card">
                        <div class="card-content">
                            <h4>Login</h4>                           
                            <div class ="form">
                                <form action="Register" method="post" style="display: flex; flex-direction: column; align-items: center;">
                                    <input type="text" name="user_name" placeholder="Enter user name" style="margin-bottom: 10px;"/>
                                    <input type="password" name="user_password" placeholder="Enter user password" style="margin-bottom: 10px;"/>
                                    
                                    <h7>Wrong Info</h7>  
                                    <br></br>
                                    <button type="submit" class="btn #009688 teal">Submit</button>
                                    
                                    
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        
            <script>
            $(document).ready(function(){
                console.log("page is ready...")
            })
            </script>
    </body>
</html>
