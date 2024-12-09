package klu.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "shipping")
public class Shipping 
{
	@Id
	@Column(name ="orderid",nullable = false)
	public String orderid;
	
	@Column(name ="artid",nullable = false)
	public String artid;

	@Column(name = "arttitle",nullable = false)
	public String arttitle;

	@Column(name = "artmedium",nullable = false)
	public String artmedium;

	@Column(name = " artdimensions",nullable = false)
	public String artdimensions;

	@Column(name = "artcost",nullable = false)
	public String artcost;
	
	@Column(name = "artseller",nullable = false)
	public String artseller;
	
	@Column(name = "artsellerid",nullable = false)
	public String artsellerid;
	
	@Column(name = "buyername",nullable = false)
	public String buyername;
	
	@Column(name = "buyerid",nullable = false)
	public String buyerid;
	
	@Column(name = "shippingaddress",nullable=false)
	public String shippingaddress;
	
//	@Column(name = "modeofpay",nullable = false)
//	public String modeofpay;
//	
	@Column(name = "orderstatus",nullable=false)
	public String orderstatus;
	
	@Column(name = "artimage",nullable = false)
	public String artimage;
	
	@Column(name = "paystatus",nullable =false)
	public String paystatus;

	public String getOrderid() {
		return orderid;
	}

	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}

	public String getArtid() {
		return artid;
	}

	public void setArtid(String artid) {
		this.artid = artid;
	}

	public String getArttitle() {
		return arttitle;
	}

	public void setArttitle(String arttitle) {
		this.arttitle = arttitle;
	}

	public String getArtmedium() {
		return artmedium;
	}

	public void setArtmedium(String artmedium) {
		this.artmedium = artmedium;
	}

	public String getArtdimensions() {
		return artdimensions;
	}

	public void setArtdimensions(String artdimensions) {
		this.artdimensions = artdimensions;
	}

	public String getArtcost() {
		return artcost;
	}

	public void setArtcost(String artcost) {
		this.artcost = artcost;
	}

	public String getArtseller() {
		return artseller;
	}

	public void setArtseller(String artseller) {
		this.artseller = artseller;
	}

	public String getBuyername() {
		return buyername;
	}

	public void setBuyername(String buyername) {
		this.buyername = buyername;
	}

	public String getBuyerid() {
		return buyerid;
	}

	public void setBuyerid(String buyerid) {
		this.buyerid = buyerid;
	}

	public String getShippingaddress() {
		return shippingaddress;
	}

	public void setShippingaddress(String shippingaddress) {
		this.shippingaddress = shippingaddress;
	}

	public String getOrderstatus() {
		return orderstatus;
	}

	public void setOrderstatus(String orderstatus) {
		this.orderstatus = orderstatus;
	}

	public String getArtimage() {
		return artimage;
	}

	public void setArtimage(String artimage) {
		this.artimage = artimage;
	}

	public String getArtsellerid() {
		return artsellerid;
	}

	public void setArtsellerid(String artsellerid) {
		this.artsellerid = artsellerid;
	}

	public String getPaystatus() {
		return paystatus;
	}

	public void setPaystatus(String paystatus) {
		this.paystatus = paystatus;
	}
	
	
	

}
