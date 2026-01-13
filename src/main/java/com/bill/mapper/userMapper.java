package com.bill.mapper;

import com.bill.entity.user;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Mapper
@Component
@Repository
public interface userMapper {
    user findByName(@Param("name") String  name);
    user findByNameAndPassword(@Param("name") String name, @Param("password") String password);
    boolean insertUser(@Param("user") user user);
}
