package com.bill.mapper;

import com.bill.entity.bill;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Component
@Repository
public interface billMapper {
    boolean makeBill(@Param("name") String name, @Param("money") double money,
                     @Param("date") String date, @Param("comment") String comment, @Param("type") String type);

    int billNumber(@Param("name") String name);

    List<bill> allBill(@Param("name") String name,
                       @Param("start") int start, @Param("end") int end);

    bill selectBillById(@Param("id") int id);

    boolean deleteBillById(@Param("id") int id);

    boolean updateBillById(@Param("id") int id, @Param("money") double money,
                           @Param("comment") String comment, @Param("date") String date, @Param("type") String type);

    Double findAllMoney(@Param("name") String name,@Param("type") String type);
}
