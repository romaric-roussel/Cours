package com.example.lpiem.getapi;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class Controller implements Callback<Datum> {


    static final String BASE_URL = "http:10.0.2.2/Pokecard/";


    public void start() {
        Gson gson = new GsonBuilder()
                .setLenient()
                .create();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create(gson))
                .build();

        Pokemon pokemon = retrofit.create(Pokemon.class);

        Call<Datum>call = pokemon.getPokemon();
        call.enqueue(this);

    }

    public ArrayList<Datum> liste;
    @Override
    public void onResponse(Call<Datum> call, Response<Datum> response) {
        if(response.isSuccessful()) {
            List<Datum> ex = response.body();
            System.out.println(((Datum) ex).getNom());
        } else {
            System.out.println(response.errorBody());
            System.out.println("ERREUR");
        }
    }

    @Override
    public void onFailure(Call<Datum> call, Throwable t) {
        t.printStackTrace();
        System.out.println("ERREUR2");
    }
}

