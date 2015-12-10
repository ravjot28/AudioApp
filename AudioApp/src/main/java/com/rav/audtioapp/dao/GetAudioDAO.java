package com.rav.audtioapp.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class GetAudioDAO {

	public GetAudioDAO() {

		try {
			Statement stmt = DAOUtil.getConnection().createStatement();
			stmt.executeUpdate("CREATE TABLE IF NOT EXISTS \"AudioRepo\" "
					+ "(id numeric NOT NULL, bag text, cot text, gang text, past text, spa text, band text, "
					+ "deck text, house text, pasta text, test text, boat text, duck text, how text, pool text, "
					+ "tie text, boot text, face text, kiss text, seat text, tight text, caught text, far text, "
					+ "pack text, sharp text, too text, longitude character varying(4000), lattitude character varying(4000), "
					+ "birthyear character varying(4000), gender character varying(4000), mothertoungedata character varying(4000), "
					+ "ratefluency character varying(4000),  atwhatage character varying(4000),  emailaddress character varying(4000),  "
					+ "town character varying(4000),  bornincanada character varying(4000), ifnotmothertounge character varying(4000),"
					+ "status character varying(4000), " + "CONSTRAINT \"AudioRepo_pkey\" PRIMARY KEY (id) )");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<String> getUnApprovedAudio() {
		List<String> result = new ArrayList<String>();
		Connection connection = DAOUtil.getConnection();
		Statement statement = null;
		try {
			statement = connection.createStatement();
			String sql = "select emailaddress,longitude,lattitude FROM \"AudioRepo\" where status  ='NOTAPPROVED'";
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				result.add("{" + rs.getString(1) + "}" + "{" + rs.getString(2) + "}" + "{" + rs.getString(3) + "}");
			}
			statement.close();
			connection.close();
		} catch (Exception e) {
			System.err.println(e);
		}

		return result;
	}
	
	public List<String> getApprovedAudio() {
		List<String> result = new ArrayList<String>();
		Connection connection = DAOUtil.getConnection();
		Statement statement = null;
		try {
			statement = connection.createStatement();
			String sql = "select emailaddress,longitude,lattitude FROM \"AudioRepo\" where status  ='APPROVED'";
			ResultSet rs = statement.executeQuery(sql);
			while (rs.next()) {
				result.add("{" + rs.getString(1) + "}" + "{" + rs.getString(2) + "}" + "{" + rs.getString(3) + "}");
			}
			statement.close();
			connection.close();
		} catch (Exception e) {
			System.err.println(e);
		}

		return result;
	}

}
