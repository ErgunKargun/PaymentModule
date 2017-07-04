package com.pm.report;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.Columns;
import net.sf.dynamicreports.report.builder.component.Components;
import net.sf.dynamicreports.report.builder.datatype.DataTypes;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.exception.DRException;

public class Reporter {

	public void report(String tc, String[] serials) {
		Connection connection = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/payment_module_beta", "root",
					"Ergun_kargun2016");
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			return;
		}

		String query = "select * from debt where ";
		for (int i = 0; i < serials.length; i++) {
			query += "serial = '" + serials[i] + "'";
			if (i != serials.length - 1)
				query += " or ";
		}
		query += "";
		System.out.println(query);

		JasperReportBuilder report = DynamicReports.report();// a new report
		report.columns(Columns.column("Seri No", "serial", DataTypes.stringType()),
				Columns.column("Açıklama", "aciklama", DataTypes.stringType()),
				Columns.column("Dönem", "donem", DataTypes.stringType()),
				Columns.column("Parsel", "parsel", DataTypes.stringType()),
				Columns.column("Durum", "durum", DataTypes.stringType()))
				.title(// title of the report
						Components.text("Arma - Fatura").setHorizontalAlignment(HorizontalAlignment.CENTER))
				.pageFooter(Components.pageXofY())// show page number on the
													// page footer
				.setDataSource(query, connection);

		try {
			// show the report
			// report.show();

			// export the report to a pdf file
			report.toPdf(new FileOutputStream("E:/" + tc + "Fatura.pdf"));
		} catch (DRException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}
}