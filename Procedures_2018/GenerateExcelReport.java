package ap;

import java.util.ArrayList;
import java.util.Date;



public class GenerateExcelReport {
  static ArrayList<String>listOfMarkets = new ArrayList<String>();
  public static void main(String[] args) throws Exception {
		
	 	Grouping gr= new Grouping();
	 	SNAP_Report_By_LeadBrand s1=new SNAP_Report_By_LeadBrand();
		Date date = new java.util.Date();
		//gr.groupDataFSI(); //Grouping logic for FSI
		//gr.runLoadSnapByGroup(); / Calls loadSNAPbygroup_2017() which is already called earlier, hence ignore
		//gr.groupData(); //Grouping logic for Publication 
	 	//gr.groupDataModifiedGroupRank(); //Modified grouping using Publication and Market
	 	gr.groupDataGroupRankBasedOnPaperType(); //Modified grouping based on NewspaperType
	 	//gr.groupDataUpdatedGroupRank(); //Modified grouping using Publication and Market and County
		gr.createReportDynamicView(); //Grouping logic for Publication 
	    //Snap_Output_By_Market s =new Snap_Output_By_Market();
		
		
		//listOfMarkets=s1.getMarketList();
		//languages= s1.getNewsPaperLanguage(); //Gets list of Language and Brand when generating reports for each market individually
		//listOfBrands = s1.getBrandList();
		//s1.createReports(listOfMarkets);
		
	}

}
