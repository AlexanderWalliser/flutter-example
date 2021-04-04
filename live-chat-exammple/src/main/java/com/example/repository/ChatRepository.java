package com.example.repository;

import com.example.entities.ChatMessage;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import io.smallrye.reactive.messaging.annotations.Broadcast;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Emitter;
import org.hibernate.reactive.mutiny.Mutiny;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.util.concurrent.CompletionStage;


@ApplicationScoped
public class ChatRepository {

    @Inject
    @Channel("chat-stream")
    @Broadcast
    Emitter<ChatMessage> messages;

    @Inject
    Mutiny.Session mutinySession;

    public Uni<ChatMessage> getSingle(Integer id) {
        return mutinySession.find(ChatMessage.class, id);
    }

    public Multi<ChatMessage> get() {
        return mutinySession.createQuery("SELECT c FROM ChatMessage c", ChatMessage.class).getResults();
    }

    public Uni<Void> create(ChatMessage chatMessage) {
        if (chatMessage != null && chatMessage.getId() == null) {
            return mutinySession.persist(chatMessage)
                    .onItem().transform(t ->notify(chatMessage))
                    .chain(mutinySession::flush);
        }
        return null;
    }

    private CompletionStage<Void> notify(ChatMessage chatMessage){
        try{
            return messages.send(chatMessage);
        }catch (Exception e){
            return null;
        }
    }
}
