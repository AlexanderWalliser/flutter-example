package com.example.entities;

import javax.persistence.*;
import javax.persistence.GeneratedValue;

@Entity
public class ChatMessage {
    @Id @GeneratedValue
    private Integer id;
    private String name;
    private String text;
    private String imageUrl;
    private String author;


    public ChatMessage() {
    }

    public ChatMessage(Integer id, String name, String text, String imageUrl, String author) {
        this.id = id;
        this.name = name;
        this.text = text;
        this.imageUrl = imageUrl;
        this.author = author;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }
}
