package fr.lp.iem.tdd;

import java.util.*;

public class TestEtudiant {

    public static void main(String[] args) {

        //testTriList();
        List<String> chaine = Arrays.asList("toto","titi","TUTU","aBc","abc");

        Collections.sort(chaine, String.CASE_INSENSITIVE_ORDER);
        System.out.println(chaine);
    }

    private static void testTriList() {
        List<Etudiant> maListe = new ArrayList<>();
        Etudiant johnDoe = new Etudiant("john","Doe");
        maListe.add(johnDoe);
        maListe.add(new Etudiant("test","bidon"));
        Etudiant romGAG = new Etudiant("rom","GAG");
        maListe.add(romGAG);
        maListe.add(new Etudiant("rom","gagag"));
        maListe.add(new Etudiant("trou","pouri"));


        //Collections.sort(maListe);
        System.out.println(maListe);

        Collections.sort(maListe, new Comparator<Etudiant>() {
            @Override
            public int compare(Etudiant o1, Etudiant o2) {
                int res= o1.getFirsttName().compareTo(o2.getFirsttName());
                if(res==0){
                    res = o1.getName().compareTo(o2.getName());
                }
                return res;
            }
        });
        System.out.println(maListe);
    }
}
