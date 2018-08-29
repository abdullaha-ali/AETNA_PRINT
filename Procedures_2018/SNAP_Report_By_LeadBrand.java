package ap;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class SNAP_Report_By_LeadBrand {
	String query;
	ArrayList<String>marketList=new ArrayList<String>();
	ArrayList<String>languages = new ArrayList<String>();
	ArrayList<String>listOfBrands = new ArrayList<String>();

	Connection con;
	public ArrayList<String> getMarketList() throws SQLException{
	try{
		Class.forName("com.mysql.jdbc.Driver");
		 con=DriverManager.getConnection(  
				"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/Aetna_2017_new","root","Rds@Ogilvy!");
		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery("select distinct market from Publication_Report_2017");  
		while(rs.next()){
			marketList.add(rs.getString("market"));
		}
		
		rs.close();
	}
	catch(Exception e){
	}
	finally{
		//con.close();
	}
	return marketList;
	}
	public ArrayList<String> getBrandList(String market) throws SQLException{
		
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
			 con=DriverManager.getConnection(  
					"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/Aetna_2017_new","talendJob","talendApple");
			Statement stmt=con.createStatement();  
			ResultSet rs=stmt.executeQuery("select distinct lead_brand from Publication_Report_2017 where market='"+market+"' ;");  
			while(rs.next()){
				listOfBrands.add(rs.getString("lead_brand"));
			}
			rs.close();
		}
		catch(Exception e){
		}
		finally{
			//con.close();
		}
		return listOfBrands;
		}

	public void createReports(ArrayList<String> marketList ) throws ClassNotFoundException, SQLException, IOException,IndexOutOfBoundsException {
		
		
		//String [] leadbrand = {"AET","CVTY"};
		
		Class.forName("com.mysql.jdbc.Driver");
		con=DriverManager.getConnection(  
				"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/Aetna_2017_new","talendJob","talendApple");
		Statement stmt=con.createStatement();  
		
		System.out.println("List of markets " + marketList);
		System.out.println("Market size "+marketList.size());
		for(int i=0;i<=marketList.size()-1;i++){			
			languages= getNewsPaperLanguage(marketList.get(i));
			System.out.println("LAnguage size "+languages.size());
			for(int m=0;m<=languages.size()-1;m++){
				listOfBrands = getBrandList(marketList.get(i));
				System.out.println("Brand size "+listOfBrands.size());
				
			XSSFWorkbook workbook = new XSSFWorkbook(); 
			for(int j=0;j<=listOfBrands.size()-1;j++){
				System.out.println(i+marketList.get(i));
				System.out.println(i+languages.get(m));
				System.out.println(i+listOfBrands.get(j));
				XSSFSheet sheet= workbook.createSheet(listOfBrands.get(j).replaceAll("[\\\\/:*?\"<>|]", ""));	
				XSSFRow row=sheet.createRow(0);
				XSSFCell cell;
				cell=row.createCell(0);
			    cell.setCellValue("PID");
			    cell=row.createCell(1);
			    cell.setCellValue("Region");
			    cell=row.createCell(2);
			    cell.setCellValue("Lead Brand");
			    cell=row.createCell(3);
			    cell.setCellValue("Market");
			    cell=row.createCell(4);
			    cell.setCellValue("SubMarket");
			    cell=row.createCell(5);
			    cell.setCellValue("ZipCode");
			    cell=row.createCell(6);
			    cell.setCellValue("County");
			    cell=row.createCell(7);
			    cell.setCellValue("State");
			    cell=row.createCell(8);
			    cell.setCellValue("Publication");
			    cell=row.createCell(9);
			    cell.setCellValue("Insertion Date");
			    cell=row.createCell(10);
			    cell.setCellValue("Publication Days");
			    cell=row.createCell(11);
			    cell.setCellValue("Material Deadline Range");
			    cell=row.createCell(12);
			    cell.setCellValue("Material Due Date");
			    cell=row.createCell(13);
			    cell.setCellValue("Total Events");
			    cell=row.createCell(14);
			    cell.setCellValue("Meeting Block 1");
			    cell=row.createCell(15);
			    cell.setCellValue("Meeting Block 2");
			    cell=row.createCell(16);
			    cell.setCellValue("Meeting Block 3");
			    cell=row.createCell(17);
			    cell.setCellValue("Meeting Block 4");
			    cell=row.createCell(18);
			    cell.setCellValue("Meeting Block 5");
			    cell=row.createCell(19);
			    cell.setCellValue("Meeting Block 6");
			    cell=row.createCell(20);
			    cell.setCellValue("Meeting Block 7");
			    cell=row.createCell(21);
			    cell.setCellValue("Meeting Block 8");
			    cell=row.createCell(22);
			    cell.setCellValue("Meeting Block 9");
			    cell=row.createCell(23);
			    cell.setCellValue("NewsPaper Specs");
			    cell=row.createCell(24);
			    cell.setCellValue("Insertion Format");
			    cell=row.createCell(25);
			    cell.setCellValue("Insertion Cost");
			    cell=row.createCell(26);
			    cell.setCellValue("Bullet 1");
			    cell=row.createCell(27);
			    cell.setCellValue("Bullet 2");
			    cell=row.createCell(28);
			    cell.setCellValue("Bullet 3");
			    cell=row.createCell(29);
			    cell.setCellValue("Bullet 4");
			    cell=row.createCell(30);
			    cell.setCellValue("Bullet 5 ");
			    cell=row.createCell(31);
			    cell.setCellValue("TFN");
			    cell=row.createCell(32);
			    cell.setCellValue("Paper Type");
			    cell=row.createCell(33);
			    cell.setCellValue("Presentation Language");
			    int k=1;
			    
			    
			    ResultSet rs=stmt.executeQuery("select pid,region,lead_brand,market,submarket,zipcode,county,state,publication,"
			    		+ "insertion_date,publication_days,material_deadline_range,material_due_date,total_event,meeting1,meeting2,meeting3,meeting4,meeting5,"
			    		+ "meeting6,meeting7,meeting8,meeting9,newspaper_specs,insertion_format,insertion_cost,bullet_1,bullet_2,bullet_3,bullet_4,bullet_5,TFN,Paper_Type"
			    		+ " from Publication_Report_2017 where market ='"+marketList.get(i)+"' and lead_brand='"+listOfBrands.get(j)+"' and Presentation_Language='"+languages.get(m)+"' ;");  
			    
			    
			    while(rs.next()){
			    	
			    	row=sheet.createRow(k);
			    	cell=row.createCell(0);
			        cell.setCellValue(rs.getInt("pid"));
			        cell=row.createCell(1);
			        cell.setCellValue(rs.getString("region"));
			        cell=row.createCell(2);
			        cell.setCellValue(rs.getString("lead_brand"));
			        cell=row.createCell(3);
			        cell.setCellValue(rs.getString("market"));
			        cell=row.createCell(4);
			        cell.setCellValue(rs.getString("submarket"));
			        cell=row.createCell(5);
			        cell.setCellValue(rs.getString("zipcode"));
			        cell=row.createCell(6);
			        cell.setCellValue(rs.getString("county"));
			        cell=row.createCell(7);
			        cell.setCellValue(rs.getString("state"));
			        cell=row.createCell(8);
			        cell.setCellValue(rs.getString("publication"));
			        cell=row.createCell(9);
			        cell.setCellValue(rs.getString("insertion_date"));
			        cell=row.createCell(10);
			        cell.setCellValue(rs.getString("publication_days"));
			        cell=row.createCell(11);
			        cell.setCellValue(rs.getString("material_deadline_range"));
			        cell=row.createCell(12);
			        cell.setCellValue(rs.getString("material_due_date"));
			        cell=row.createCell(13);
			        cell.setCellValue(Integer.parseInt(rs.getString("total_event")));
			        cell=row.createCell(14);
			        cell.setCellValue(rs.getString("meeting1"));
			        cell=row.createCell(15);
			        cell.setCellValue(rs.getString("meeting2"));
			        cell=row.createCell(16);
			        cell.setCellValue(rs.getString("meeting3"));
			        cell=row.createCell(17);
			        cell.setCellValue(rs.getString("meeting4"));
			        cell=row.createCell(18);
			        cell.setCellValue(rs.getString("meeting5"));
			        cell=row.createCell(19);
			        cell.setCellValue(rs.getString("meeting6"));
			        cell=row.createCell(20);
			        cell.setCellValue(rs.getString("meeting7"));
			        cell=row.createCell(21);
			        cell.setCellValue(rs.getString("meeting8"));
			        cell=row.createCell(22);
			        cell.setCellValue(rs.getString("meeting9"));
			        cell=row.createCell(23);
			        cell.setCellValue(rs.getString("newspaper_specs"));
			        cell=row.createCell(24);
			        cell.setCellValue(rs.getString("insertion_format"));
			        cell=row.createCell(25);
			        cell.setCellValue(rs.getString("insertion_cost"));
			        cell=row.createCell(26);
			        cell.setCellValue(rs.getString("bullet_1"));
			        cell=row.createCell(27);
			        cell.setCellValue(rs.getString("bullet_2"));
			        cell=row.createCell(28);
			        cell.setCellValue(rs.getString("bullet_3"));
			        cell=row.createCell(29);
			        cell.setCellValue(rs.getString("bullet_4"));
			        cell=row.createCell(30);
			        cell.setCellValue(rs.getString("bullet_5"));
			        
			       cell=row.createCell(31);
			       //cell.setCellValue(String.format("(%s)-%s-%s", rs.getString("TFN").substring(0, 3), rs.getString("TFN").substring(3, 6),rs.getString("TFN").substring(6, 10)));
			       cell.setCellValue(rs.getString("TFN"));
			       cell=row.createCell(32);
			       cell.setCellValue(rs.getString("Paper_Type"));
			       String presentation_language="English";
			       cell=row.createCell(33);
			       cell.setCellValue(presentation_language);
			        
			        k++;
			    }
			    rs.close();
			    /*XSSFCellStyle cs = workbook.createCellStyle();
			    
			    cs.setWrapText(true);
			    cell.setCellStyle(cs);*/
			}
			Date d = new Date();
			String modifiedDate= new SimpleDateFormat("yyyy-MM-dd").format(d);
			FileOutputStream file = new FileOutputStream(
						new File("Publication_Report_"+marketList.get(i).replaceAll("[\\\\/:*?\"<>|]", "")+"_"+languages.get(m)+"_"+ modifiedDate+"_SF.xlsx"));
			
			 workbook.write(file);
			 workbook.close();
			 
			 listOfBrands.clear();
			 System.out.println("Done " + i + "Brand cleared");
			 
		}con.close();
		languages.clear();
		System.out.println("Done " + i + "Language cleared");
		}
	}
		

	
	public ArrayList<String> getNewsPaperLanguage(String market) {
try{
			
			Class.forName("com.mysql.jdbc.Driver");
			 con=DriverManager.getConnection(  
					"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/Aetna_2017_new","talendJob","talendApple");
			Statement stmt=con.createStatement();  
			ResultSet rs=stmt.executeQuery("select distinct Presentation_Language  from Publication_Report_2017 where market='"+market+"' ;"); 
			while(rs.next()){
				languages.add(rs.getString("Presentation_Language"));
			}
			
			
			rs.close();
			
		}
		catch(Exception e){
			
		}
		finally{
			
			//con.close();
		
		}
		return languages;
		
	}

}
	
	

