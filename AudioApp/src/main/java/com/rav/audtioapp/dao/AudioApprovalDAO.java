package com.rav.audtioapp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;

public class AudioApprovalDAO {

	public AudioApprovalDAO() {

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

	public void updateStatus(String status, int id) {
		Connection connection = DAOUtil.getConnection();
		PreparedStatement statement = null;
		try {
			statement = connection.prepareStatement("update \"AudioRepo\" set status = ? where id = ?");
			statement.setString(1, status);
			statement.setInt(2, id);
			statement.executeUpdate();

			statement.close();
			connection.close();
		} catch (Exception e) {
			System.err.println(e);
		}
	}

}
