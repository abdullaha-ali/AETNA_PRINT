package ap;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * @author akansha.sharma
 *
 */
public class Extract_Publication {

	/**
	 * @param args
	 * @throws SQLException 
	 */
	public static void main(String[] args) throws SQLException {
		 String SQLParameter = "?useServerPrepStmts=false&rewriteBatchedStatements=true&noDatetimeStringSync=true";
		 String mysqlConn;
		 String mysqlUsr = "root";
		 String mysqlPwd = "Rds@Ogilvy!";
		 String query;
		 Connection conn = null;
		 Statement stmt = null;  
		 PreparedStatement ps = null;
		 ResultSet rs = null;
		 int id = 0;
		try{
			
			Class.forName("com.mysql.jdbc.Driver");
           mysqlConn = "jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/AetnaPrint_2018" + SQLParameter;
			conn = DriverManager.getConnection(mysqlConn,mysqlUsr,mysqlPwd);
			stmt = conn.createStatement(); 
			conn.setAutoCommit(false);    
			rs=stmt.executeQuery("select `Territory`,`Market`,`SubMarket`,`DominantCounty`,`DominantCounty_State`,`SecondaryCounties`,`State`,`DominantCountyHHCount`,`DailyCirculationPenetration`,"
					+ "`NucleusNDXCode`,`PublicationName`,`PaidFree`,`City`,`PublicationDays`,`DailyCirc`,`SundayCirc`,`Multicultural`,`NewspaperType`,`FullPage`,"
					+ "`JrPage`,`HalfPage`, `OrderDeadline`,`MaterialDeadline`,"
					+ "`County2`,`County3`,`County4`,`County5`,`County6`,`County7`,`County8`,`County9`,`County10`,`County11`,`County12`,`County13`,`County14`,`County15`,"
					+ "`County16`,`County17`,`County18`,`County19`,`County20`,`County21`,`County22`,`County23`,`County24`,`County25`,`County26`,`County27`,`County28`,`County29` from AetnaPrint_2018.RawPublication");  			
			while(rs.next()){
				List<String> counties = new ArrayList<String>();	
				String Territory = rs.getString("Territory");
				String Market = rs.getString("Market");			
				String SubMarket = rs.getString("SubMarket");
				String DominantCounty = rs.getString("DominantCounty");
				String DominantCounty_State = rs.getString("DominantCounty_State");
				String SecondaryCounties = rs.getString("SecondaryCounties");
				String State = rs.getString("State");
				int DominantCountyHHCount = rs.getInt("DominantCountyHHCount");
				String DailyCirculationPenetration = rs.getString("DailyCirculationPenetration");
				String NucleusNDXCode = rs.getString("NucleusNDXCode");
				String PublicationName = rs.getString("PublicationName");
				String PaidFree = rs.getString("PaidFree");
				String City = rs.getString("City");
				String PublicationDays = rs.getString("PublicationDays");
				int DailyCirc = rs.getInt("DailyCirc");
				String SundayCirc = rs.getString("SundayCirc");
				String Multicultural = rs.getString("Multicultural");
				String NewspaperType = rs.getString("NewspaperType");
				String FullPage = rs.getString("FullPage");
				String JrPage = rs.getString("JrPage");
				String HalfPage = rs.getString("HalfPage");
				String OrderDeadline = rs.getString("OrderDeadline");
				String MaterialDeadline = rs.getString("MaterialDeadline");
				//Loop to iterate through 29 county columns
				for(int i=2; i<=29; i++){
					if(! rs.getString("County"+i).equals(""))
						counties.add(rs.getString("County"+i));
				}
				
				if(counties.contains(DominantCounty_State))
					counties.remove(DominantCounty_State);
				
				int countysize,counter,rank;
				countysize = counter = rank = 0;
				countysize = counties.size();

				//If secondarycounty blank then dominant county as secondary county else parse out secondary counties
				if(countysize == 1){
						query = "insert into AetnaPrint_2018.aetna_print_publication_2018(`id`,`Territory`,`Market`,`SubMarket`,`DominantCounty`,`DominantCounty_State`,`SecondaryCounties`,`State`,`DominantCountyHHCount`,"
								+ "`DailyCirculationPenetration`,`NucleusNDXCode`,`PublicationName`,`PaidFree`,`City`,`PublicationDays`,`DailyCirc`,`SundayCirc`,`Multicultural`,"
								+ "`NewspaperType`,`FullPage`,`JrPage`,`HalfPage`,`OrderDeadline`,`MaterialDeadline`,`Rank`) values" + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						ps = conn.prepareStatement(query);
						ps.setInt(1, id);
						ps.setString(2,Territory);
						ps.setString(3,Market);
						ps.setString(4,SubMarket);
						ps.setString(5,DominantCounty);
						ps.setString(6,DominantCounty_State);
						ps.setString(7,DominantCounty_State);
						ps.setString(8,DominantCounty_State.substring(0,2));
						ps.setInt(9,DominantCountyHHCount);
						ps.setString(10,DailyCirculationPenetration);
						ps.setString(11,NucleusNDXCode);
						ps.setString(12,PublicationName);
						ps.setString(13,PaidFree);
						ps.setString(14,City);
						ps.setString(15,PublicationDays);
						ps.setInt(16,DailyCirc);
						ps.setString(17,SundayCirc);
						ps.setString(18,Multicultural);
						ps.setString(19,NewspaperType);
						ps.setString(20,FullPage);
						ps.setString(21,JrPage);
						ps.setString(22,HalfPage);
						ps.setString(23,OrderDeadline);
						ps.setString(24,MaterialDeadline);
						ps.setInt(25, rank);
						ps.executeUpdate();
						conn.commit();
						System.out.println(ps);
				}
				else{
					//First commit to insert dominant county as secondary county
					query = "insert into AetnaPrint_2018.aetna_print_publication_2018(`id`,`Territory`,`Market`,`SubMarket`,`DominantCounty`,`DominantCounty_State`,`SecondaryCounties`,`State`,`DominantCountyHHCount`,"
							+ "`DailyCirculationPenetration`,`NucleusNDXCode`,`PublicationName`,`PaidFree`,`City`,`PublicationDays`,`DailyCirc`,`SundayCirc`,`Multicultural`,"
							+ "`NewspaperType`,`FullPage`,`JrPage`,`HalfPage`,`OrderDeadline`,`MaterialDeadline`,`Rank`) values" + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					ps = conn.prepareStatement(query);
					ps.setInt(1,id);
					ps.setString(2,Territory);
					ps.setString(3,Market);
					ps.setString(4,SubMarket);
					ps.setString(5,DominantCounty);
					ps.setString(6,DominantCounty_State);
					ps.setString(7,DominantCounty_State);
					ps.setString(8,DominantCounty_State.substring(0,2));
					ps.setInt(9,DominantCountyHHCount);
					ps.setString(10,DailyCirculationPenetration);
					ps.setString(11,NucleusNDXCode);
					ps.setString(12,PublicationName);
					ps.setString(13,PaidFree);
					ps.setString(14,City);
					ps.setString(15,PublicationDays);
					ps.setInt(16,DailyCirc);
					ps.setString(17,SundayCirc);
					ps.setString(18,Multicultural);
					ps.setString(19,NewspaperType);
					ps.setString(20,FullPage);
					ps.setString(21,JrPage);
					ps.setString(22,HalfPage);
					ps.setString(23,OrderDeadline);
					ps.setString(24, MaterialDeadline);
					ps.setInt(25, rank);
					ps.executeUpdate();
					conn.commit();
					System.out.println(ps);
					
					while(countysize > 1){
						String county = counties.get(counter);
						query = "insert into AetnaPrint_2018.aetna_print_publication_2018(`id`,`Territory`,`Market`,`SubMarket`,`DominantCounty`,`DominantCounty_State`,`SecondaryCounties`,`State`,`DominantCountyHHCount`,"
								+ "`DailyCirculationPenetration`,`NucleusNDXCode`,`PublicationName`,`PaidFree`,`City`,`PublicationDays`,`DailyCirc`,`SundayCirc`,`Multicultural`,"
								+ "`NewspaperType`,`FullPage`,`JrPage`,`HalfPage`,`OrderDeadline`,`MaterialDeadline`,`Rank`) values" + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
						ps = conn.prepareStatement(query);
						ps.setInt(1,id);
						ps.setString(2,Territory);
						ps.setString(3,Market);
						ps.setString(4,SubMarket);
						ps.setString(5,DominantCounty);
						ps.setString(6,DominantCounty_State);
						ps.setString(7,county);
						ps.setString(8,county.substring(0,2));
						ps.setInt(9,DominantCountyHHCount);
						ps.setString(10,DailyCirculationPenetration);
						ps.setString(11,NucleusNDXCode);
						ps.setString(12,PublicationName);
						ps.setString(13,PaidFree);
						ps.setString(14,City);
						ps.setString(15,PublicationDays);
						ps.setInt(16,DailyCirc);
						ps.setString(17,SundayCirc);
						ps.setString(18,Multicultural);
						ps.setString(19,NewspaperType);
						ps.setString(20,FullPage);
						ps.setString(21,JrPage);
						ps.setString(22,HalfPage);
						ps.setString(23,OrderDeadline);
						ps.setString(24, MaterialDeadline);
						ps.setInt(25, rank);
						ps.executeUpdate();
						conn.commit();
						counter++;
						countysize--;
						System.out.println(ps);
					}
				}
			}
		}
		catch(Exception e){
		}
		finally{
			if(rs != null)
				rs.close();
			if(stmt != null)
				stmt.close();
			if(ps != null)
				ps.close();
			conn.close();
		}
	}
}