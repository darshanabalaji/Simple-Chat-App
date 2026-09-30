<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Chat Login</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
            text-align: center;
            padding-top: 100px;
        }

        .login-box {
            background-color: white;
            width: 350px;
            margin: auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
        }

        h2 {
            color: #2e7d32;
            margin-bottom: 25px;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 12px 30px;
            background-color: #2e7d32;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
        }

        button:hover {
            background-color: #1b5e20;
        }

    </style>

</head>

<body>

    <div class="login-box">

        <h2>Simple Chatting System</h2>

        <form action="login" method="post">

            <input type="text"
                   name="username"
                   placeholder="Enter Username"
                   required>

            <br>

            <button type="submit">
                Login
            </button>

        </form>

    </div>

</body>

</html>