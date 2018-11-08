package com.example.lpiem.getapi;


import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;


public interface Pokemon {

    @GET("api/Pokemon/read.php")
    Call<Datum> getPokemon();

}
