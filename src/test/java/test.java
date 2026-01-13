import com.bill.mapper.userMapper;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import com.bill.tools.TestTools;

public class test extends TestTools{
    private userMapper userMapper;

    @Before
    public void SetUp() {
        initSession();
        userMapper = getMapper(com.bill.mapper.userMapper.class);
    }

    @After
    public void tearDown() {
        closeSession();
    }

    @Test
    public void selectUser(){
        System.out.println(userMapper.findByName("admin"));
    }
}
