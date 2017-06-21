package com.pm.session;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;

@Component
public class SessionManager {

    public static final String AUTHENTICATED = "authenticated";
    public static final String PARTIALLY_AUTHENTICATED = "partially-authenticated";
    public static final String USER_ID = "user-id";

    private static final int MAX_INACTIVE_INTERVAL = 30 * 60;

    public void logIn(HttpServletRequest request, String userTc) {
        HttpSession session = request.getSession();
        session.setAttribute(AUTHENTICATED, true);
        session.removeAttribute(PARTIALLY_AUTHENTICATED);
        session.setAttribute(USER_ID, userTc);
        session.setMaxInactiveInterval(MAX_INACTIVE_INTERVAL);
    }

    public void partialLogIn(HttpServletRequest request, String userTc) {
        HttpSession session = request.getSession();
        session.setAttribute(PARTIALLY_AUTHENTICATED, true);
        session.setAttribute(USER_ID, userTc);
        session.setMaxInactiveInterval(MAX_INACTIVE_INTERVAL);
    }

    public void logOut(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    public String getLoggedUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute(USER_ID);
        }

        return "";
    }

    public boolean isAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object authenticated = session.getAttribute(AUTHENTICATED);
            return authenticated != null && (Boolean) authenticated;
        }

        return false;
    }

    public boolean isPartiallyAuthenticated(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object partiallyAuthenticated = session.getAttribute(PARTIALLY_AUTHENTICATED);
            return partiallyAuthenticated != null && (Boolean) partiallyAuthenticated;
        }

        return false;
    }
}
