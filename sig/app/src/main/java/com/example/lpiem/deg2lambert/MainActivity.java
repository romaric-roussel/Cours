package com.example.lpiem.deg2lambert;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;


public class MainActivity extends Activity {

    private double GAMMA0,GAMMA;
    private  double lat,lon,L,R2,Lx,Ly;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        calculeGamma0();

        /*lat = 45.7f ;
        lon = 4.9f ;*/
        lon = 45.7 ;
        lat = 4.9 ;


        calculeLat();
        calculeLon();
        calculeL();
        calculeR();
        calculeGamma();
        Log.d("toto","LX : " + calculeLx() + " Ly : " + calculeLy());







    }

    public void calculeGamma0(){
        GAMMA0 = (3600*2)+(60*20)+14.025;
        GAMMA0 = (float) (GAMMA0/(180*3600)* Math.PI);
        Log.d("toto","GAMMA0 " + GAMMA0);


    }

    public void calculeLat(){
        lat =  (lat/(180) * Math.PI);
        Log.d("toto","lat " + lat);

    }

    public void calculeLon(){
        lon =  (lon/(180)*Math.PI);
        Log.d("toto","lon " + lon);

    }

    public void calculeL() {
        L =  (0.5*Math.log((1+Math.sin(lat))/(1-Math.sin(lat)))-Constante.e/2*Math.log((1+Constante.e*Math.sin(lat))/(1-Constante.e*Math.sin(lat))));
        Log.d("toto","L " + L);

    }

    public void calculeR() {
        R2 =  (Constante.C*Math.exp(-Constante.n*L));
        Log.d("toto","R2 " + R2);


    }

    public void calculeGamma() {
        GAMMA = Constante.n*(lon-GAMMA0);
        Log.d("toto","GAMMA " + GAMMA);


    }

    public double calculeLx() {
        Lx =  (Constante.Xs+(R2*Math.sin(GAMMA)));
        return Lx;
    }
    public double calculeLy() {
        Ly = (Constante.Ys-(R2*Math.cos(GAMMA)));
        return Ly;
    }
}
