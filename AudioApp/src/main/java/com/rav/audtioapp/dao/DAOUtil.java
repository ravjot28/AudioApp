package com.rav.audtioapp.dao;

import java.net.URI;
import java.sql.Connection;

import org.apache.commons.dbcp2.BasicDataSource;

public class DAOUtil {
	private static BasicDataSource connectionPool;

	public static void main(String[] args) {
		System.setProperty("DATABASE_URL", "postgres://postgres:admin@localhost:5432/AudioApp");
		System.out.println(System.getenv("DATABASE_URL"));
	}

	public static Connection getConnection() {
		URI dbUri;
		Connection connection = null;
		try {
			if (connectionPool != null) {
				connection = connectionPool.getConnection();
			} else {
				connectionPool = new BasicDataSource();
				connectionPool.setDriverClassName("org.postgresql.Driver");

				if (System.getenv("DATABASE_URL") != null) {
					dbUri = new URI(System.getenv("DATABASE_URL"));
					String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();

					if (dbUri.getUserInfo() != null) {
						connectionPool.setUsername(dbUri.getUserInfo().split(":")[0]);
						connectionPool.setPassword(dbUri.getUserInfo().split(":")[1]);
					}
					connectionPool.setUrl(dbUrl);
				} else {
					connectionPool.setUsername("postgres");
					connectionPool.setPassword("admin");
					connectionPool.setUrl("jdbc:postgresql://localhost:5432/AudioApp");

				}

				connectionPool.setInitialSize(100);
				connection = connectionPool.getConnection();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

}
