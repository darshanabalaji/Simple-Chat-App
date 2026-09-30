package com.chat;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");

        // Check username
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        username = username.trim();

        // Create session
        HttpSession session = request.getSession();
        session.setAttribute("username", username);

        // Go to chat page
        response.sendRedirect("Chat.jsp");
    }
}