package klu.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import jakarta.transaction.Transactional;
import klu.model.Shipping;

@Repository
public interface ShippingRepository extends JpaRepository<Shipping, String>
{

	List<Shipping> findByBuyerid(String buyerid);
	
	
	
	List<Shipping> findByartsellerid(String artsellerid);

	
	@Modifying 
	@Transactional
    @Query("UPDATE Shipping s SET s.orderstatus = ?2 WHERE s.orderid = ?1 AND s.buyerid = ?3 AND s.orderstatus != 'Delivered'")
	int cancelorder(String orderid,String orderstatus,String userid);


@Modifying
@Transactional
@Query("""
    UPDATE Shipping s 
    SET s.orderstatus = ?2 
    WHERE s.orderid = ?1 
      AND s.artsellerid = ?3
      AND (
        (s.orderstatus = 'Ordered' AND ?2 = 'Dispatched') OR
        (s.orderstatus = 'Dispatched' AND ?2 IN ('Shipped', 'Delivered')) OR
        (s.orderstatus = 'Shipped' AND ?2 = 'Delivered')
      )
      AND NOT (s.orderstatus = 'Dispatched' AND ?2 = 'Ordered') 
      AND NOT (s.orderstatus = 'Shipped' AND ?2 IN ('Dispatched', 'Ordered')) 
      AND NOT (s.orderstatus = 'Delivered' AND ?2 IN ('Shipped', 'Dispatched', 'Ordered'))
""")
	int updateorder(String orderid, String newstatus, String sellerid);



	List<Shipping> findAll();

	@Modifying 
	@Transactional
    @Query("DELETE FROM Shipping s WHERE s.orderid = ?1")
	int deleteOrderById(String orderId);

	@Modifying
	@Transactional
	@Query("UPDATE Shipping s SET s.artcost = ?2, s.artdimensions = ?3, s.artid = ?4, " +
	       "s.artmedium = ?5, s.artseller = ?6, s.arttitle = ?7, s.buyerid = ?8, " +
	       "s.buyername = ?9, s.orderstatus = ?10, s.shippingaddress = ?11 " +
	       "WHERE s.orderid = ?1")
	int updateallorder(String orderid, String artcost, String artdimensions, String artid, 
	                   String artmedium, String artseller, String arttitle, 
	                   String buyerid, String buyername, String orderstatus, 
	                   String shippingaddress);


    @Query("SELECT SUM(s.artcost) FROM Shipping s")
	long sumTotalAmount();


    @Modifying
    @Transactional
    @Query("UPDATE Shipping s SET s.paystatus = :paystatus WHERE s.orderid = :orderid")
    int paysuccess( String orderid,String paystatus);






	
	
	
	



}
