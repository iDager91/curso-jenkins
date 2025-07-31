package com.miempresa;

import org.junit.Test;
import static org.junit.Assert.*;


/**
 * Unit test for simple App.
 */
public class AppTest 
{
    @Test
    public void testSumar(){
        App app = new App();
        assertEquals(5, app.sumar(2,3));
    }
}
