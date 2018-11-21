<%-- 
    Document   : process.jsp
    Created on : 05/11/2018, 21:09:59
    Author     : jessi
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>

<%

    try {
        String url = "jdbc:mysql://localhost/parqueos";
        String username = "jessica";
        String password = "1234";

        Connection connection = DriverManager.getConnection(url, username, password);

        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT * FROM `estados` ORDER BY `number");
        while (rs.next()) {

            int id = rs.getInt("number");
            String nombre = rs.getString("estado");
             out.println("Parqueo: "+id+" estado: "+nombre+"</br>");
        }
    } catch (Exception e) {
        System.out.print(e);
        e.printStackTrace();
    }


%>
