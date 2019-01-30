<%-- 
    Document   : Parklot
    Created on : 27/01/2019, 07:18:57 PM
    Author     : Jessica Roman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <script src="./js/fabric.min.js"></script>
    <script language="JavaScript" type="text/javascript" src="./js/script.js"></script>
    <script language="JavaScript" type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <button onclick="upload('http://localhost:8080/Servidor/app/parklot/37');">Cargar</button>
    <button id="accionar" onclick="next()">Cortar</button>
    <div class="screen">
        <div id="Layer" style="display:none; width: 400px; height: 400px; overflow: scroll;"></div>
        <canvas id="parking" style="display:none;"width="2048" height="1536"></canvas>
    </div>
</html>
