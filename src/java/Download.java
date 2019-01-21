
import com.ute.models.coordenates.Coordenates;
import java.io.File;
import java.io.IOException;
import javax.ws.rs.Consumes;

import javax.ws.rs.GET;
import static javax.ws.rs.HttpMethod.POST;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import org.json.JSONException;

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
    public Response downloadJson() throws IOException, JSONException {
//        GetNames gn = new GetNames();
//        String path = gn.listFolder();
//        CreateJson cj = new CreateJson();
//        cj.create(path);
        String path = "C:\\Servidor\\1.json";
        File file = new File(path);
        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition", "attachment;filename=Json.json");
        return response.build();
    }
    @POST
    @Path("obtenervaloresOswaldo/{id}/{idp}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response obtenerValoresOswaldo(Valores url, @PathParam("id") int id, @PathParam("idP") int idp) {
        try {
            url.getCoordenadas();
            url.getImagen();
        } catch (Exception e) {

        }
        return null;
    }

    @GET
    @Produces("image/jpg")
    @Path("/image")
    public Response downloadImage() throws IOException {
//        GetNames gn = new GetNames();
//        String path = gn.listFolder();
        String path = "C:\\Servidor\\1.jpg";
        File file = new File(path);
        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition", "attachment;filename=Image.jpg");
        return response.build();
    }

}
