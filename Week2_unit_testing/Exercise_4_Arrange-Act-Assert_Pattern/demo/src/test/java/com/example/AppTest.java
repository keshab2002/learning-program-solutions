package com.example;

import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {

    private App calculator;

    @Before
    public void setUp() {
        calculator = new App();
        System.out.println("🔧 Setup");
    }

    @After
    public void tearDown() {
        calculator = null;
        System.out.println("🧹 Teardown");
    }

    @Test
    public void testAddition() {
        // Arrange
        int a = 4, b = 6;

        // Act
        int result = calculator.add(a, b);

        // Assert
        assertEquals(10, result);
    }

    @Test
    public void testSubtraction() {
        // Arrange
        int a = 9, b = 3;

        // Act
        int result = calculator.subtract(a, b);

        // Assert
        assertEquals(6, result);
    }
}
