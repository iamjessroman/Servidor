
import java.io.File;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author jessi
 */
@Path("/descarga")
public class Download {

    @GET
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML, MediaType.TEXT_PLAIN})
    @Path("/json")
    public Response downloadJson() {
        File file = new File("C:\\Servidor\\1.json");
        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition", "attachment;filename=Json.json");
        return response.build();
    }

    @GET
    @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML, MediaType.TEXT_PLAIN})
    @Path("/parkings")
    public Response downloadparkings() {
        File file = new File("C:\\Servidor\\data.json");
        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition", "attachment;filename=Json.json");
        return response.build();
    }

    @GET
    @Produces("image/jpg")
    @Path("/image")
    public Response downloadImage() {
        File file = new File("C:\\Servidor\\1.jpg");
        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition", "attachment;filename=Image.jpg");
        return response.build();
    }

}
