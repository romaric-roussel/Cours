package com.example.lpiem.magiccardapp;


import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.net.HttpURLConnection;
import java.util.List;

import okhttp3.OkHttpClient;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class Controller implements Callback<List<Datum>> {


    static final String BASE_URL = "http:10.0.0.2/Pokecard/";


    public void start() {
        Gson gson = new GsonBuilder()
                .setLenient()
                .create();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(BASE_URL)
                .addConverterFactory(GsonConverterFactory.create(gson))
                .build();

       // Pokemon pokemon = retrofit.create(Pokemon.class);

       // Call<List<Datum>> call = pokemon.getPokemon();
        //call.enqueue(this);

    }


    @Override
    public void onResponse(Call<List<Datum>> call, Response<List<Datum>> response) {
        if(response.isSuccessful()) {
            List<Datum> datumList = response.body();
            for (Datum datum : datumList) {
                System.out.println(datum.getId());
            }
        } else {
            System.out.println(response.errorBody());
        }
    }

    @Override
    public void onFailure(Call<List<Datum>> call, Throwable t) {
        t.printStackTrace();
    }
}

