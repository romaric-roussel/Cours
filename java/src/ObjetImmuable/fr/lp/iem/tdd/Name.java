package fr.lp.iem.tdd;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Name {
    private final String first, last;

    public Name(String first, String last) {
        this.first = first;
        this.last = last;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Name name = (Name) o;
        return Objects.equals(first, name.first) &&
                Objects.equals(last, name.last);
    }

    @Override
    public int hashCode() {
        return 31 * first.hashCode() + last.hashCode();
    }

    public static void main(String[] args) {
        Set<Name> s = new HashSet<Name>();
        s.add(new Name("Donald", "Duck"));
        System.out.println(s.contains(new Name("Donald", "Duck")));
    }
}
