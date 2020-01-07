package com.test.ksj;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

public class MysqlConnection {
	
	private static final String DRIVER ="com.mysql.cj.jdbc.Driver";
    private static final String URL ="jdbc:mysql://localhost:3306/studydb?useSSL=false&serverTimezone=Asia/Seoul";
    private static final String USER ="root";
    private static final String PW ="1111";
    
    @Test
    public void testConnect() throws Exception{
        
        Class.forName(DRIVER);
        
        try(Connection con = DriverManager.getConnection(URL, USER, PW)){
            
            System.out.println(con);
            System.out.println("ddsdsd");
        }catch(Exception e) {
            e.printStackTrace();
        }
    }

}
