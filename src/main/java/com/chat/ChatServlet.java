package com.chat;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Stores messages temporarily in memory
    private static final List<Message> messages = new ArrayList<>();

    // Send message
    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String sender = (String) session.getAttribute("username");
        String receiver = request.getParameter("receiver");
        String message = request.getParameter("message");

        if (sender != null
                && receiver != null
                && message != null
                && !receiver.trim().isEmpty()
                && !message.trim().isEmpty()) {

            String time = new SimpleDateFormat("HH:mm:ss")
                    .format(new Date());

            Message newMessage = new Message(
                    sender,
                    receiver.trim(),
                    message.trim(),
                    time
            );

            synchronized (messages) {
                messages.add(newMessage);
            }
        }

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        response.getWriter().print("Message Sent");
    }

    // Load messages
    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String username = (String) session.getAttribute("username");
        String receiver = request.getParameter("receiver");

        response.setContentType("text/html");
        response.setCharacterEncoding("UTF-8");

        StringBuilder result = new StringBuilder();

        if (username == null || receiver == null
                || receiver.trim().isEmpty()) {

            response.getWriter().print("");
            return;
        }

        receiver = receiver.trim();

        synchronized (messages) {

            for (Message m : messages) {

                boolean conversation =
                        (m.sender.equals(username)
                                && m.receiver.equals(receiver))
                        ||
                        (m.sender.equals(receiver)
                                && m.receiver.equals(username));

                if (conversation) {

                    result.append("<div class='message'>");

                    result.append("<b>")
                          .append(escapeHtml(m.sender))
                          .append("</b>: ");

                    result.append(escapeHtml(m.message));

                    result.append("<span>")
                          .append(escapeHtml(m.time))
                          .append("</span>");

                    result.append("</div>");
                }
            }
        }

        response.getWriter().print(result.toString());
    }

    // Simple HTML escaping
    private String escapeHtml(String text) {

        if (text == null) {
            return "";
        }

        return text
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;")
                .replace("\"", "&quot;")
                .replace("'", "&#39;");
    }

    // Message class
    static class Message {

        String sender;
        String receiver;
        String message;
        String time;

        Message(String sender,
                String receiver,
                String message,
                String time) {

            this.sender = sender;
            this.receiver = receiver;
            this.message = message;
            this.time = time;
        }
    }
}