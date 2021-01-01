package org.zerock.persistence;

import static org.junit.Assert.fail;
import java.sql.Connection;
import java.sql.DriverManager;
import org.junit.Test;
import lombok.extern.log4j.Log4j;


@Log4j
public class JDBC_Tests {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}


	@Test
	public void testConnection() {
	//	�Ұ�ȣ �ȿ� connection �� ���ָ� �ڵ����� close.
		try (Connection con =
				DriverManager.getConnection(
						"jdbc:oracle:thin:@localhost:1521:xe",
						"bituser",
						"1004")) {
			log.info(con);
		} catch (Exception e) {
			fail(e.getMessage());
		}
	}
}