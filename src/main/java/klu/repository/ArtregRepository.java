package klu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import klu.model.Artreg;

@Repository
public interface ArtregRepository extends JpaRepository<Artreg, String> {

	List<Artreg> findAll();
	
    List<Artreg> findBySellerid(String sellerid); 

    @Modifying
    @Transactional
    @Query("UPDATE Artreg a SET a.arttitle = ?2, a.artcost = ?3, a.artdimensions = ?4, "
         + "a.artmedium = ?5, a.artdescription = ?6, a.availstatus = ?7 "
         + "WHERE a.artid = ?1 AND a.sellerid = ?8")
    int updatemyart(String artid, String arttitle, String artcost, String artdimensions, String artmedium,
			String artdescription, String availstatus, String sellerid);


    @Modifying
    @Transactional
    @Query("DELETE FROM Artreg a WHERE a.artid = ?1 AND a.sellerid = ?2")
    int deleteArtById(String artId, String sellerid);


    @Modifying
    @Transactional
    @Query("UPDATE Artreg a SET a.arttitle = ?2, a.artcost = ?3, a.artdimensions = ?4, "
         + "a.artmedium = ?5, a.artdescription = ?6, a.availstatus = ?7, "
         + "a.sellerid = ?8, a.sellername = ?9 "
         + "WHERE a.artid = ?1")
    int updateallart(String artid, String arttitle, String artcost, String artdimensions, String artmedium,
			String artdescription, String availstatus, String sellerid, String sellername);


    @Modifying
    @Transactional
    @Query("DELETE FROM Artreg a WHERE a.artid = ?1")
	int deleteArtAllById(String artId);



	

    


	
	

}
