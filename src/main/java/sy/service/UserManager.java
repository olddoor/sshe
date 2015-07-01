package sy.service;

import sy.model.base.Syuser;
import sy.service.base.SyuserServiceI;
import sy.service.base.impl.SyuserServiceImpl;

public class UserManager {
	SyuserServiceI service=new SyuserServiceImpl();
	public Syuser getUser(String id){
		return service.getById(id);
	}
}
