package ap;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;
import java.sql.*;
 
class Grouping{ 
	int counter=0;
	int groupcounter=0;
	int prevpid = 0;
	String prevPublication ="";
	String prevMarket ="";
	String prevCountyPub ="";
	String prevstate="";
	String prevcounty="";
	String groupname="";
	StringBuilder querybuilder= new StringBuilder();
	
	public void runLoadSnapByGroup(){
		
		try{  
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(  
					"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/Aetna_2017_new?noAccessToProcedureBodies=true","root","Rds@Ogilvy!");
			
			
			CallableStatement cstmt = null;
			
			String SQL = "{call loadSNAPbygroup_2017(?,?)}";
			cstmt = con.prepareCall (SQL);
			cstmt.setInt(1, 31);
			cstmt.setString(2, "AET");
			cstmt.execute();
			cstmt.close();
			con.close();  
			
		}
		catch(Exception e ){
			System.out.println(e.getMessage());
		}
		
	}
	
public void createReportDynamicView(){
		
		try{  
			System.out.println(new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date())+" Generating Report");
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection(  
					"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/AetnaPrint_2018?noAccessToProcedureBodies=true","root","Rds@Ogilvy!");
			
			
			CallableStatement cstmt = null;
			
			String SQL = "{call ReportDynamicView_2018()}";
			cstmt = con.prepareCall (SQL);
			cstmt.execute();
			cstmt.close();
			con.close();
			System.out.println(new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new Date()) + " End");
		}
		catch(Exception e ){
			System.out.println(e.getMessage());
		}
		
	}


public void groupDataFSI()
{
	try{  
		Class.forName("com.mysql.jdbc.Driver");  
		Connection con=DriverManager.getConnection(  
				"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/AetnaPrint_2018?noAccessToProcedureBodies=true","root","Rds@Ogilvy!");  
	//here sonoo is database name, root is username and password  
		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery("select * from report_by_id_group_2018 order by state,county");  
		while(rs.next())  {
			counter++;
			if(prevcounty.equals(rs.getString("County")) && prevstate.equals(rs.getString("State"))){
				if(counter>=9){
					groupcounter++;
					groupname="Group"+groupcounter;
					
					counter=0;
				}
				else{
					groupname="Group"+groupcounter;
				}
			}
			
			
			if(!prevcounty.equals(rs.getString("County"))|| !prevstate.equals(rs.getString("State"))){
				groupcounter++;
				groupname="Group"+groupcounter;
				
				counter=0;
			}
			//prevPublication=rs.getString("Publication");
			prevcounty=rs.getString("County");
			prevstate=rs.getString("State");
			querybuilder.append("update report_by_id_group_2018 set grouprank='"+groupname+"' where pid="+rs.getInt(1)+" "
					+ "and eid=" + rs.getInt(2)+" and date='"+rs.getString(3)+"' and geid='"+ rs.getString(4)+"' and county='"+rs.getString("County")+"' and state='"+rs.getString("State")+"';"  );
			querybuilder.append("\n");
		
			//System.out.println(rs.getDate(3));  
		}
		java.sql.PreparedStatement executestaement= null;
		Scanner queryscan= new Scanner(querybuilder.toString());
		while (queryscan.hasNextLine() ){
			executestaement= con.prepareStatement(queryscan.nextLine());
			executestaement.executeUpdate();
			executestaement= null;
			}
		queryscan.close();
				 
	}
	catch(Exception e){ System.out.println(e);}  
	}
 	

public void groupDataModifiedGroupRank() {
	try{  
		
		Class.forName("com.mysql.jdbc.Driver");  
		Connection con=DriverManager.getConnection(  
				"jdbc:mysql://gfprdsmysqlp001.cvbz72fzclwf.us-west-2.rds.amazonaws.com:3306/AetnaPrint_2018?noAccessToProcedureBodies=true","root","Rds@Ogilvy!");  

		Statement stmt=con.createStatement();  
		ResultSet rs=stmt.executeQuery("select * from report_by_id_group_2018 order by Publication");  
		while(rs.next())  {
			counter++;
			if(prevPublication.equals(rs.getString("Publication")) && (prevMarket.equals(rs.getString("Market")))){
				if(counter>=9){
					groupcounter++;
					groupname="Group"+groupcounter;
					
					counter=0;
				}
				else{
					groupname="Group"+groupcounter;
				}
			}
			
			
			if(!(prevPublication.equals(rs.getString("Publication")) && (prevMarket.equals(rs.getString("Market"))))){
				groupcounter++;
				groupname="Group"+groupcounter;
				
				counter=0;
			}
			prevPublication=rs.getString("Publication");
			prevMarket=rs.getString("Market");
			querybuilder.append("update report_by_id_group_2018 set grouprank='"+groupname+"' where pid="+rs.getInt(1)+" "
					+ "and eid=" + rs.getInt(2)+" and date='"+rs.getString(3)+"' and geid='"+ rs.getString(4)+"';"  );
			querybuilder.append("\n");
		
			//System.out.println(rs.getDate(3));  
		}
		java.sql.PreparedStatement executestaement= null;
		Scanner queryscan= new Scanner(querybuilder.toString());
		while (queryscan.hasNextLine() ){
			executestaement= con.prepareStatement(queryscan.nextLine());
			executestaement.executeUpdate();
			executestaement= null;
			}

		
		queryscan.close();
		
		
			 
	}
	catch(Exception e){ System.out.println(e);}  
	}
}



