<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Simple Chat</title>

    <style>

        body {
            font-family: Arial, sans-serif;
            background-color: #f1f8e9;
            margin: 0;
            padding: 0;
        }

        .chat-container {
            width: 600px;
            margin: 40px auto;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px gray;
        }

        h2 {
            text-align: center;
            color: #2e7d32;
        }

        .logged-user {
            text-align: center;
            margin-bottom: 20px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 10px 20px;
            background-color: #2e7d32;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin: 5px;
        }

        button:hover {
            background-color: #1b5e20;
        }

        #chatbox {
            height: 300px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 10px;
            margin-top: 15px;
            background-color: #fafafa;
        }

        .message {
            padding: 10px;
            margin: 8px 0;
            background-color: #e8f5e9;
            border-radius: 5px;
        }

        .message span {
            color: gray;
            font-size: 12px;
            margin-left: 10px;
        }

        .message-input {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .message-input input {
            flex: 1;
        }

    </style>

</head>

<body>

<div class="chat-container">

    <h2>Simple Chatting System</h2>

    <div class="logged-user">

        Logged in as:
        <b><%= username %></b>

    </div>

    <input type="text"
           id="receiver"
           placeholder="Enter Receiver Username">

    <button onclick="loadMessages()">
        Open Chat
    </button>

    <div id="chatbox">

        <p>Select a receiver to start chatting.</p>

    </div>

    <div class="message-input">

        <input type="text"
               id="message"
               placeholder="Type your message">

        <button onclick="sendMessage()">
            Send
        </button>

    </div>

</div>


<script>

function loadMessages() {

    const receiver =
        document.getElementById("receiver").value.trim();

    if (receiver === "") {

        alert("Please enter receiver username");

        return;
    }

    fetch("chat?receiver=" + encodeURIComponent(receiver))

        .then(response => response.text())

        .then(data => {

            document.getElementById("chatbox").innerHTML = data;

            const chatbox =
                document.getElementById("chatbox");

            chatbox.scrollTop = chatbox.scrollHeight;

        })

        .catch(error => {

            console.error("Error loading messages:", error);

        });
}


function sendMessage() {

    const receiver =
        document.getElementById("receiver").value.trim();

    const message =
        document.getElementById("message").value.trim();


    if (receiver === "") {

        alert("Please enter receiver username");

        return;
    }


    if (message === "") {

        alert("Please enter a message");

        return;
    }


    const formData = new URLSearchParams();

    formData.append("receiver", receiver);

    formData.append("message", message);


    fetch("chat", {

        method: "POST",

        headers: {
            "Content-Type":
                "application/x-www-form-urlencoded"
        },

        body: formData

    })

    .then(response => response.text())

    .then(data => {

        document.getElementById("message").value = "";

        loadMessages();

    })

    .catch(error => {

        console.error("Error sending message:", error);

    });

}


/* Refresh messages every 2 seconds */

setInterval(function() {

    const receiver =
        document.getElementById("receiver").value.trim();

    if (receiver !== "") {

        loadMessages();

    }

}, 2000);

</script>

</body>

</html>