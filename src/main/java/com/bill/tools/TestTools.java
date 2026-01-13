package com.bill.tools;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.mybatis.spring.annotation.MapperScan;

import java.io.IOException;
import java.io.Reader;
public abstract class TestTools {
    protected SqlSession sqlSession;
    protected static SqlSessionFactory sqlSessionFactory;

    static {
        try {
            Reader reader = Resources.getResourceAsReader("mybatis-config.xml");
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            throw new RuntimeException("SqlSessionFactory初始化失败", e);
        }
    }

    protected void initSession() {
        this.sqlSession = sqlSessionFactory.openSession();
    }

    protected void closeSession() {
        if (sqlSession != null) {
            sqlSession.close();
            sqlSession = null;
        }
    }

    protected <T> T getMapper(Class<T> mapperClass) {
        if (sqlSession == null) {
            throw new IllegalStateException("SqlSession未初始化，请先调用initSession()");
        }
        return sqlSession.getMapper(mapperClass);
    }
}