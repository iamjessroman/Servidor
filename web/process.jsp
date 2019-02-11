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
    String color="";
    boolean temp = false;
    String res = "";

    //out.println(json);
    JSONArray array = new JSONArray(json);
    
    String sql="DELETE FROM `parklots`";
    cx.delete(sql, "", 2);
    
    //out.print(array.length());
        for (int i = 0; i < array.length(); i++) {
            sql = "INSERT INTO `parklots`(`id_parking`, `name_parking`,`path_parking`, `id_parklot`, `data_url`) VALUES (?,?,?,?,?);";
            String[] c = {
                Integer.toString((Integer) array.getJSONObject(i).get("id_parking")),
                (String) array.getJSONObject(i).get("name_parking"),
                (String) array.getJSONObject(i).get("path"),
                Integer.toString((Integer) array.getJSONObject(i).get("id")),
                (String) array.getJSONObject(i).get("src")
            };
            String msg = " ";
            temp = cx.insert(sql, c, msg, 2);

        }

        if (temp) {
            res = "Parqueos Convertidos, para Seleccionar el estado de cada parqueo dar 'clic' en 'Continuar'";
            color="#265b91";
        } else {
            res = "Error ! No se ha logrado convertir los parqueos";
            color="#dd4c55";
        }
%> 
<div id="tittle" class="tittle" style="
     text-align: center; 
     font-family: 'Arial';
     font-size: 22;
     font-weight: bold;
     padding: 15px;
     color: <%= color%>;
     "><%= res%></div>



