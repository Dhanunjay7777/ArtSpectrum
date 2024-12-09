package klu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import klu.model.Consumer;

@Repository
public interface ConsumerRepository extends JpaRepository<Consumer, Long>
{
@Query("select count(C) from Consumer C where C.email=:cemail")
public int validateEmail(@Param("cemail") String cemail);


@Query("SELECT C FROM Consumer C WHERE C.email = :cemail AND C.password = :pwd")
public Consumer loginvalidate(@Param("cemail") String cemail,@Param("pwd") String pwd);

List<Consumer> findAll();

@Transactional
@Modifying
@Query("UPDATE Consumer C SET C.name=:name,  C.gender = :gender, C.contactno = :contactno, "
        + "C.address = :address, C.dateOfBirth = :dob, C.artPreference = :artPreference, "
        + "C.newsletter = :newsletter WHERE C.userid = :userid")
int updateCustomer(@Param("userid") Long userid,@Param("name")String name,
                   @Param("gender") String gender, @Param("contactno") String contactno,
                   @Param("address") String address, @Param("dob") String dob,
                   @Param("artPreference") String artPreference, 
                   @Param("newsletter") String newsletter);

@Modifying
@Transactional
@Query("DELETE FROM Consumer c WHERE c.userid = ?1")
public int deleteCustomerById(String userId);


@Modifying
@Transactional
@Query("update Consumer C set C.password=?2 where C.userid = ?1")
public int changepass(Long userid, String newpwd);


@Modifying
@Transactional
@Query("update Consumer C set C.password=?2 where C.email = ?1")
public int updatepassword(String email, String newPassword);

@Query("select c.contactno from Consumer c where c.email=?1 ")
public String findmobile(String email);

}
