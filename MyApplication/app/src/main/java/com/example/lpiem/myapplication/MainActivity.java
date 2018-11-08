package com.example.lpiem.myapplication;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class MainActivity extends AppCompatActivity {

    private float GAMMA0,GAMMA;
    private float lat,lon,L,R,Lx,Ly;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        calculeGamma0();
        calculeLat();
        calculeLon();
        calculeL();
        calculeR();
        calculeGamma();
        System.out.println("LX : " + calculeLx() + " Ly : " + calculeLy());

    }

    public float calculeGamma0(){
        GAMMA0 = (3600*2)+(60*2)+14.025f;
        GAMMA0 += GAMMA0/(180*3600)* Math.PI;

        return GAMMA0;
    }

    public float calculeLat(){
        lat = (float) (-lat/(180*3600) * Math.PI);
        return lat;
    }

    public float calculeLon(){
        lon = (float) (-lon/(180*3600)*Math.PI);
        return lon;
    }

    public float calculeL() {
        L = (float) (0.5*Math.log((1+Math.sin(lat))/(1-Math.sin(lat)))-Constante.e/2*Math.log((1+Constante.e*Math.sin(lat))/(1-Constante.e*Math.sin(lat))));
        return L;

    }

    public float calculeR() {
        R = (float) (Constante.C*Math.exp(-Constante.n*L));
        return R;

    }

    public float calculeGamma() {
        GAMMA = Constante.n*(lon-GAMMA0);
        return GAMMA;

    }

    public float calculeLx() {
        Lx = (float) (Constante.Xs+(R*Math.sin(GAMMA)));
        return Lx;
    }
    public float calculeLy() {
        Ly = (float) (Constante.Ys-(R*Math.cos(GAMMA)));
        return Ly;
    }
}
