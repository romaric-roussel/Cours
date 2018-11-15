package fr.lp.iem.tdd;

public class Etudiant implements Comparable<Etudiant>{

    private final String name;
    private final String firstName;

    public Etudiant(String name, String firstName) {
        this.name = name;
        this.firstName= firstName;
    }

    public String getName() {
        return name;
    }

    public String getFirsttName() {
        return firstName;

    }

    @Override
    public String toString() {
        return "FirstName : " + firstName + ",name : " + name;
    }

    @Override
    public int compareTo(Etudiant other) {
        int res = name.compareTo(other.name);
        if(res== 0){
            res = firstName.compareTo(other.firstName);
        }
        return res;
    }
}
