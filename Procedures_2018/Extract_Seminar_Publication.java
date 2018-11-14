package ap;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
/**
 * @author akansha.sharma
 *
 */
public class Extract_Seminar_Publication {

	/**
	 * @param args
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
		 DateFormat dformat = new SimpleDateFormat("MM/d/yyyy");
		try{
			Class.forName("com.mysql.jdbc.Driver");
            mysqlConn = "jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/AetnaPrint_2018" + SQLParameter;
			conn = DriverManager.getConnection(mysqlConn,mysqlUsr,mysqlPwd);
			stmt = conn.createStatement(); 
			conn.setAutoCommit(false);    
			rs=stmt.executeQuery("select `Market`,`Submarket`,`State`,`County`,`Publication`,`NucleusNDXCode`,`InsertionDate`,`Meeting1`,`Meeting2`,`Meeting3`,`Meeting4`,`Meeting5`,`Meeting6`,`Meeting7`,`Meeting8`,`Meeting9` from Media_Final_Publication_Report_2018");  			
			while(rs.next()){
				List<String> meetings = new ArrayList<String>();
				int msize = 0;
				String market = rs.getString("Market");
				String submarket = rs.getString("SubMarket");
				String state = rs.getString("State");
				String county = rs.getString("County");
				String publication = rs.getString("Publication");
				String nucleuscode = rs.getString("NucleusNDXCode");
				String insertiondate = rs.getString("InsertionDate");
				for(int i=1; i<=9; i++){
					if(! rs.getString("Meeting"+i).equals("") )
						meetings.add(rs.getString("Meeting"+i));
				}
				msize = meetings.size();
				while(msize > 0){
					List<String> details = new ArrayList<String>();
					List<String> events = new ArrayList<String>();
					List<String> dates = new ArrayList<String>();
					List<String> times = new ArrayList<String>();
					List<String> dateform = new ArrayList<String>();
					details = Arrays.asList(meetings.get(msize-1).split("\n"));
					if(details.size() == 4){
						events = Arrays.asList(details.get(3).split(",|&"));
							for(String e : events){
								if(e.contains("/"))
									dates.add(e);
									//dates.add(e.trim().concat("/2018"));
								else
									times.add(e);
							}
							System.out.println(dates);
								for(int i=0; i<dates.size(); i++){
									for(int j=0; j<times.size(); j++){
										System.out.println("before insert query");
										query = "insert into AetnaPrint_2018.Extract_Seminar_SNAP_2018 (`Market`,`SubMarket`,`State`,`County`,`Publication`,`NucleusNDXCode`,`InsertionDate`,`VenueCity`,`VenueName`,`VenueAddress`,`EventDate`,`EventTime`)values" + "(?,?,?,?,?,?,?,?,?,?,?,?)";
										ps = conn.prepareStatement(query);
										ps.setString(1, market);
										ps.setString(2, submarket);
										ps.setString(3, state);
										ps.setString(4, county);
										ps.setString(5, publication);
										ps.setString(6, nucleuscode);
										ps.setString(7, insertiondate);
										ps.setString(8, details.get(0));
										ps.setString(9, details.get(1));
										ps.setString(10, details.get(2));
										ps.setString(11, dates.get(i).trim().concat("/2018"));
										//ps.setDate(11, (java.sql.Date) dateform.get(i));
										ps.setString(12, times.get(j));
										ps.executeUpdate();
										conn.commit();
										System.out.println("Insert successful");
								}
							}
					}		
					msize--;
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