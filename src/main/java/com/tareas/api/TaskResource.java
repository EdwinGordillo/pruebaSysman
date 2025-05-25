package com.tareas.api;

import com.tareas.dao.TaskDAO;
import com.tareas.model.Task;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;

@Path("/tasks")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class TaskResource {
    private final TaskDAO dao = new TaskDAO();

    @GET
    public List<Task> getAll() {
        return dao.getAllTasks();
    }

    @GET
    @Path("/{id}")
    public Task getById(@PathParam("id") int id) {
        return dao.getTaskById(id);
    }

    @POST
    public Response create(Task task) {
        int newId = dao.createTask(task);
        return Response.status(Response.Status.CREATED).entity(newId).build();
    }

    @PUT
    @Path("/{id}")
    public Response update(@PathParam("id") int id, Task task) {
        task.setTaskId(id);
        dao.updateTask(task);
        return Response.ok().build();
    }

    @DELETE
    @Path("/{id}")
    public Response delete(@PathParam("id") int id) {
        dao.deleteTask(id);
        return Response.noContent().build();
    }
}
