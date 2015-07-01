package sy.test;

import static org.junit.Assert.*;

import java.util.Date;

import org.junit.Test;

import sy.model.base.Syuser;
import sy.util.base.BeanUtils;

public class TestBeancopyWithNull extends BeanUtils {

	@Test
	public void test() {
		Syuser target=new Syuser();
		target.setName("name");
		target.setLoginname("loginame");
		target.setCreatedatetime(new Date());
		target.setPwd("pwd");
		
		Syuser source=new Syuser();
		source.setName("name2");
		source.setLoginname("source2");
		source.setCreatedatetime(new Date());
//		source.setPwd(null);
		
		BeanUtils.copyNotNullProperties(source, target);
		System.out.println(source.getName());
		System.out.println(source.getLoginname());
		System.out.println(source.getPwd());
		System.out.println("-----");
		System.out.println(target.getName());
		System.out.println(target.getLoginname());
		System.out.println(target.getPwd());
	}

}
