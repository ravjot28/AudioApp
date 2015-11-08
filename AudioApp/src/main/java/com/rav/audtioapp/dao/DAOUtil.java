package com.rav.audtioapp.dao;

import java.net.URI;
import java.sql.Connection;

import org.apache.commons.dbcp2.BasicDataSource;

public class DAOUtil {
	private static BasicDataSource connectionPool;

	public static Connection getConnection() {
		URI dbUri;
		Connection connection = null;
		try {
			if (connectionPool != null) {
				connection = connectionPool.getConnection();
			} else {
				dbUri = new URI(System.getenv("DATABASE_URL"));
				String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
				connectionPool = new BasicDataSource();
				if (dbUri.getUserInfo() != null) {
					connectionPool.setUsername(dbUri.getUserInfo().split(":")[0]);
					connectionPool.setPassword(dbUri.getUserInfo().split(":")[1]);
				}
				connectionPool.setDriverClassName("org.postgresql.Driver");
				connectionPool.setUrl(dbUrl);
				connectionPool.setInitialSize(100);
				connection = connectionPool.getConnection();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

}
