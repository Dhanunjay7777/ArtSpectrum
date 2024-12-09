package klu.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "artreg")
public class Artreg 
{
@Id
@Column(name ="artid",nullable = false)
public String artid;

@Column(name = "sellername",nullable = false)
public String sellername;

@Column(name = "sellerid",nullable = false)
public String sellerid;

@Column(name = "arttitle",nullable = false)
public String arttitle;

@Column(name = "artdesc",nullable = false)
public String artdescription;

@Column(name = "artmedium",nullable = false)
public String artmedium;

@Column(name = " artdimensions",nullable = false)
public String artdimensions;

@Column(name = "artcost",nullable = false)
public String artcost;

@Column(name = "datelisted",nullable = false)
public String datelisted;

@Column(name = "availstatus",nullable = false)
public String availstatus;

@Column(name = "imageurl",nullable = false)
public String imageurl;

public String getArtid() {
	return artid;
}

public void setArtid(String artid) {
	this.artid = artid;
}

public String getSellername() {
	return sellername;
}

public void setSellername(String sellername) {
	this.sellername = sellername;
}

public String getSellerid() {
	return sellerid;
}

public void setSellerid(String sellerid) {
	this.sellerid = sellerid;
}

public String getArttitle() {
	return arttitle;
}

public void setArttitle(String arttitle) {
	this.arttitle = arttitle;
}

public String getArtdescription() {
	return artdescription;
}

public void setArtdescription(String artdescription) {
	this.artdescription = artdescription;
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

public String getDatelisted() {
	return datelisted;
}

public void setDatelisted(String datelisted) {
	this.datelisted = datelisted;
}

public String getAvailstatus() {
	return availstatus;
}

public void setAvailstatus(String availstatus) {
	this.availstatus = availstatus;
}

public String getImageurl() {
	return imageurl;
}

public void setImageurl(String imageurl) {
	this.imageurl = imageurl;
}


}
