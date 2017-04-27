package controller;

import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.Path;

@Path("/msg")
public class VideogameRESTService {
	
	@GET
	public Response getUser() {
		return Response.status(200).entity("getUser is called").build();
	}

	@GET
	@Path("/test")
	@Produces(MediaType.TEXT_PLAIN)
    public String getMessage() {
        return "Hello " + getUser();
    }
}