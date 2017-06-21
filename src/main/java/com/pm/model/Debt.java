package com.pm.model;

import java.io.Serializable;
import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.NotEmpty;

import com.pm.model.enums.Durum;

/**
 * 
 * @author Ergun
 *
 */

@Entity
@Table(name = "debt")
public class Debt implements Serializable {

	private static final long serialVersionUID = 1L;

	private Durum durum = Durum.ODENMEDI;
	private String donem;
	private String parsel;
	private String tc;
	private String serial;
	private String gelirCinsi;
	private String aciklama;
	private BigDecimal tahakkuk;
	private BigDecimal odenen;
	private BigDecimal bakiye;

	public Debt() {

	}

	public Debt(String donem, String parsel, String tc, String gelirCinsi, String aciklama, BigDecimal tahakkuk, BigDecimal odenen) {
		super();
		this.donem = donem;
		this.parsel = parsel;
		this.tc = tc;
		this.gelirCinsi = gelirCinsi;
		this.aciklama = aciklama;
		this.tahakkuk = tahakkuk;
		this.odenen = odenen;
		//this.serial = donem.replace('/', '_') + "_" + parsel + "_" + gelirCinsi + "_" + tc;
		this.bakiye = tahakkuk.subtract(odenen);
		this.durum = Durum.ODENMEDI;
	}

	@Id
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid2")		
	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}	
	
	@Enumerated(EnumType.STRING)
	@Column(name="durum")	
	public Durum getDurum() {
		return durum;
	}

	public void setDurum(Durum durum) {
		this.durum = durum;
	}

	@NotEmpty
	@NotNull
	public String getDonem() {
		return donem;
	}

	public void setDonem(String donem) {
		this.donem = donem;
	}

	@NotEmpty
	@NotNull
	public String getParsel() {
		return parsel;
	}

	public void setParsel(String parsel) {
		this.parsel = parsel;
	}

//	@Size(min=11,max=11)	
//	@Digits(integer=11,fraction=0)	
//	@NotNull
	public String getTc() {
		return tc;
	}

	public void setTc(String tc) {
		this.tc = tc;
	}
	
	@NotEmpty
	@NotNull
	public String getGelirCinsi() {
		return gelirCinsi;
	}

	public void setGelirCinsi(String gelirCinsi) {
		this.gelirCinsi = gelirCinsi;
	}
	
	@NotEmpty
	@NotNull
	public String getAciklama() {
		return aciklama;
	}

	public void setAciklama(String aciklama) {
		this.aciklama = aciklama;
	}
	
	@NotNull
	@Digits(integer = 10 /*precision*/, fraction = 2 /*scale*/)
	public BigDecimal getTahakkuk() {
		return tahakkuk;
	}

	public void setTahakkuk(BigDecimal tahakkuk) {
		this.tahakkuk = tahakkuk;
	}

	@NotNull
	@Digits(integer = 10,fraction = 2)
	public BigDecimal getOdenen() {
		return odenen;
	}

	public void setOdenen(BigDecimal odenen) {
		this.odenen = odenen;
	}

	public BigDecimal getBakiye() {
		return bakiye;
	}

	public void setBakiye(BigDecimal bakiye) {
		this.bakiye = bakiye;
	}

	@Override
	public String toString() {
		return "Debt [durum=" + durum + ", donem=" + donem + ", parsel=" + parsel + ", tc=" + tc + ", serial=" + serial
				+ ", gelirCinsi=" + gelirCinsi + ", aciklama=" + aciklama + ", tahakkuk=" + tahakkuk + ", odenen="
				+ odenen + ", bakiye=" + bakiye + "]";
	}
}