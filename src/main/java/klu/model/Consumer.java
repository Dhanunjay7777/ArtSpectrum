package klu.model;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.Column;

@Entity
@Table(name = "customer")
public class Consumer 
{

   
	@Id
    @Column(name = "userid",nullable = false,length = 50)
    public Long userid;
    
    @Column(name = "email", nullable = false, unique = true,length=60)
    public String email;
    
    @Column(name = "fullname", nullable = false,length=100)
    public String name;


    @Column(name = "password", nullable = false,length=100)
    public String password;

    @Column(name = "gender",nullable=false,length=20)
    public String gender;
    
    @Column(name = "contactno",nullable=false,length=20)
    public String contactno;

    @Column(name = "address",nullable=false,length=200)
    public String address;

    @Column(name = "dob",nullable=false,length=15)
    public String dateOfBirth;

    @Column(name = "user_role", nullable = false,length=20)
    public String userRole;

    @Column(name = "artpreference",nullable=false,length=25)
    public String artPreference;

    @Column(name="newsletter",nullable=false,length=10)
    public String newsletter;


	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}

	
	

	public String getArtPreference() {
		return artPreference;
	}

	public void setArtPreference(String artPreference) {
		this.artPreference = artPreference;
	}

	public String getContactno() {
		return contactno;
	}

	public void setContactno(String contactno) {
		this.contactno = contactno;
	}

	public String getNewsletter() {
		return newsletter;
	}

	public void setNewsletter(String newsletter) {
		this.newsletter = newsletter;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}



	
    

}
