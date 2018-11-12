package fr.lp.iem.tdd;

import java.util.Objects;

public final class Point {


    private final int x,y;

    public Point(int x, int y) {
        this.x = x;
        this.y = y;
    }


    public double distance(Point p) {
        return Math.sqrt((Math.pow(p.x - this.x,2)) + (Math.pow(p.y - this.y ,2)));
    }

    public Point move (int dx, int dy) {

        return new Point(dx,dy);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Point point = (Point) o;
        return x == point.x &&
                y == point.y;
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }
}
