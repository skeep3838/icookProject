package com.icook.model;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "chatMember")
public class chatMember implements Serializable{
	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer seq;
	private Integer id;
	private String nickname;
	private String updateTime;
	
	public chatMember() {}
	
	public chatMember(Integer seq, Integer id, String nickname, String updateTime) {
		super();
		this.seq = seq;
		this.id = id;
		this.nickname = nickname;
		this.updateTime = updateTime;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	
	
}
