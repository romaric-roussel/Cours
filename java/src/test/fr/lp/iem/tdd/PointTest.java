package fr.lp.iem.tdd;

import org.junit.Test;

import static org.junit.Assert.*;

public class PointTest {

    Point p = new Point(2,2);
    Point p2 = new Point(4,4);


    @Test
    public void distance() {
      (p.distance(p2));
    }

    @Test
    public void move() {
    }
}