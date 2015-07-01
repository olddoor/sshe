package sy.model.base;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

@Entity
@Table(name = "SYUSER", schema = "")
@DynamicInsert(true)
@DynamicUpdate(true)
public class Syuser implements java.io.Serializable {

	private String ip;// 此属性不存数据库，虚拟属性

	private String id;
	private Date createdatetime;
	private Date updatedatetime;
	private String loginname;
	private String pwd;
	private String name;
	private String sex;
	private Integer age;
	private String photo;
	private Set<Syorganization> syorganizations = new HashSet<Syorganization>(0);
	private Set<Syrole> syroles = new HashSet<Syrole>(0);
	private String email; //新增
	private String cellPhone;//新增
	private String fax;//新增
	private String company;//新增
	private String company_address;//新增
	private String qrPhoto;//新增
	private String duty;//职务
	private Integer qrmoban;//模板
	private String company_phone;//新增
	private String phone;//固话
	private String zipCode;//邮编


	@Id
	@Column(name = "ID", unique = true, nullable = false, length = 36)
	public String getId() {
		if (!StringUtils.isBlank(this.id)) {
			return this.id;
		}
		return UUID.randomUUID().toString();
	}

	public void setId(String id) {
		this.id = id;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CREATEDATETIME", length = 7)
	public Date getCreatedatetime() {
		if (this.createdatetime != null)
			return this.createdatetime;
		return new Date();
	}

	public void setCreatedatetime(Date createdatetime) {
		this.createdatetime = createdatetime;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "UPDATEDATETIME", length = 7)
	public Date getUpdatedatetime() {
		if (this.updatedatetime != null)
			return this.updatedatetime;
		return new Date();
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCompany_phone() {
		return company_phone;
	}

	public void setCompany_phone(String company_phone) {
		this.company_phone = company_phone;
	}

	public void setUpdatedatetime(Date updatedatetime) {
		this.updatedatetime = updatedatetime;
	}

	@Column(name = "LOGINNAME", nullable = false, length = 100)
	public String getLoginname() {
		return this.loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	@Column(name = "PWD", length = 100)
	public String getPwd() {
		return this.pwd;
	}


	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	@Column(name = "NAME", length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "SEX", length = 1)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
	
	@Column(name = "QRMOBAN", precision = 8, scale = 0)
	public Integer getQrmoban() {
		return qrmoban;
	}

	public void setQrmoban(Integer qrmoban) {
		this.qrmoban = qrmoban;
	}
	
	@Column(name = "AGE", precision = 8, scale = 0)
	public Integer getAge() {
		return this.age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	@Column(name = "PHOTO", length = 200)
	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "SYUSER_SYORGANIZATION", schema = "", joinColumns = { @JoinColumn(name = "SYUSER_ID", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "SYORGANIZATION_ID", nullable = false, updatable = false) })
	public Set<Syorganization> getSyorganizations() {
		return this.syorganizations;
	}

	public void setSyorganizations(Set<Syorganization> syorganizations) {
		this.syorganizations = syorganizations;
	}

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "SYUSER_SYROLE", schema = "", joinColumns = { @JoinColumn(name = "SYUSER_ID", nullable = false, updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "SYROLE_ID", nullable = false, updatable = false) })
	public Set<Syrole> getSyroles() {
		return this.syroles;
	}

	public void setSyroles(Set<Syrole> syroles) {
		this.syroles = syroles;
	}

	@Transient
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getFax() {
		return fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCompany_address() {
		return company_address;
	}

	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}
	@Column(length = 500)
	public String getQrPhoto() {
		return qrPhoto;
	}

	public void setQrPhoto(String qrPhoto) {
		this.qrPhoto = qrPhoto;
	}
	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}
	
}
