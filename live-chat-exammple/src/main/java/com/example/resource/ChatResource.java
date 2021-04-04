package com.example.resource;

import com.example.entities.ChatMessage;
import com.example.repository.ChatRepository;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.jboss.resteasy.annotations.SseElementType;
import org.jboss.resteasy.annotations.jaxrs.PathParam;
import org.reactivestreams.Publisher;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/chat")
@ApplicationScoped
@Produces("application/json")
@Consumes("application/json")
public class ChatResource {

    @Inject
    ChatRepository repository;
    

    @GET
    public Multi<ChatMessage> get() {
        return repository.get();
    }

    @GET
    @Path("{id}")
    public Uni<ChatMessage> getSingle(@PathParam("id") Integer id) {
        return repository.getSingle(id);
    }

    @POST
    public Uni<Response> create(ChatMessage chatMessage) {
        if (chatMessage == null || chatMessage.getId() != null) {
            throw new WebApplicationException("Id was invalidly set on request.", 422);
        }

        return repository.create(chatMessage)
                .map(ignore -> Response.ok(chatMessage).status(201).build());
    }

    @Inject
    @Channel("chat-stream") Publisher<ChatMessage> messages;

    @GET
    @Path("/stream")
    @Produces(MediaType.SERVER_SENT_EVENTS)
    @SseElementType(MediaType.APPLICATION_JSON)
    public Publisher<ChatMessage> stream() {
        return messages;
    }
}
