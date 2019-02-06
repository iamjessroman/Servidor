<%-- 
    Document   : process.jsp
    Created on : 05/11/2018, 21:09:59
    Author     : jessi
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page import ="org.json.*"%>
<%@ page import="java.io.*" import="com.ute.models.coordenates.Conexion"%>

<%
    Conexion cx = new Conexion();
    String json = request.getParameter("code");

    //out.println(json);

    JSONArray array = new JSONArray(json);
     
    //out.print(array.length());
    
    
    
           for (int i = 0; i < array.length(); i++) {
            String sql = "INSERT INTO `parklots`(`id_parking`, `path_parking`, `id_parklot`, `data_url`) VALUES (?,?,?,?);";
                        String[] c = {
                           Integer.toString((Integer)array.getJSONObject(i).get("id_parking")),
                           (String)array.getJSONObject(i).get("path"),
                           Integer.toString((Integer)array.getJSONObject(i).get("id")),
                           (String)array.getJSONObject(i).get("src")
                        };
                        String msg = " ";
                        cx.insert(sql, c, msg, 2);
        }


%>

