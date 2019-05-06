import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.text.*;
import java.util.Random;

class ProjectLogs {
	private static final String FILENAME= "//home//rushikesh//Desktop//test.sql";
	
	String pattern = "00";
	String pattern2 = "0";
	DecimalFormat fmt = new DecimalFormat(pattern);
	DecimalFormat fmt2 = new DecimalFormat(pattern2);

	public static String[] reqs = {"GET /Default.htm","POST /index.htm","PUT /blank.htm","DELETE /test.htm"};
	public static String[] nurses = {"'Gloria', 'John George'",
			"'Jessica','Eden'",
			"'Monica','Alameda'",
			"'Natasha','John Hopkins'",
			"'Victoria','John Hopkins'",
			"'Cynthia','Highland'",
			"'Cersie','Alameda'",
			"'Sylvia','Alameda'",
			"'Kate','Eden'",
			"'Jack','Kaiser'",
			"'Gilly','Kaiser'",
			"'Ygritte','Fairmont'",
			"'Rosie','Fairmont'",
			"'Genie','Highland'",
			"'Jennifer','Alta Bates'",
			"'Kylie','Alta Bates'" };
	public static String[] depts= {"radiology","neurology","cardiac","trauma","orthopedic","Psychiatry"};
	public static String[] tasks= {"Cleaning Bedsheets","Serving Food","Changing IV","Surgery Preparations","Pre visit checkup","Medical record preparation","Cleaning patient rooms","Ambulance duty","X-ray duty","Garbage Disposal","Outpatient department duties","Billing","Surgery room duties","Medical instruments cleaning","Elder patient care","Children care"};
	public static String[] shifts= {"Morning","Afternoon","Evening","Night","Early Morning"};
	public static String[] users = {"Rushikesh","Akshay","Ipsha","Aditya"};
	
	public static String getrandstring(String[] rndstr) {
		String random = (rndstr[new Random().nextInt(rndstr.length)]);
		return random;
	}

	public static int getRandom(int[] array) {
	    int rnd = new Random().nextInt(array.length);
	    return array[rnd];
	}	

	public static int randomInteger(int min, int max) {
	    Random rand = new Random();
	    // nextInt excludes the top value so we have to add 1 to include the top value
	    int randomNum = rand.nextInt((max - min) + 1) + min;
	    return randomNum;
	}

	public void generateLogs (int l,int delay) {
		
		System.out.println("\nGenerating "+l+" entries with the delay of "+delay+" miliseconds");
		int m=l;
		int d=delay;
		BufferedWriter bw=null;
		FileWriter fw=null;
		
		
		try {
			//	fw= new FileWriter(ProjectLogs.FILENAME,true);
				//bw=new BufferedWriter(fw);
				
				for(int k=0;k<m;k++) {
					
					try{
						fw= new FileWriter(ProjectLogs.FILENAME,true);
						bw=new BufferedWriter(fw);
								
						
					}catch(IOException e)
					{
						e.printStackTrace();
						
					}
					bw.write("("+fmt2.format(k+1)+","+ProjectLogs.getrandstring(nurses)+","+"'"+"2018"+"-"+fmt.format(ProjectLogs.randomInteger(1, 12))+"-"+fmt.format(ProjectLogs.randomInteger(1, 28))+"'"+","+"'"+fmt2.format(ProjectLogs.randomInteger(1,8 ))+"'"+","+"'"+ProjectLogs.getrandstring(tasks)+"'"+","+"'"+ProjectLogs.getrandstring(shifts)+"'"+","+"'"+ProjectLogs.getrandstring(depts)+"'"+")"+",");
					bw.newLine();
					try{
						if (bw != null)
						bw.close();

					if (fw != null)
						fw.close();
					}
					catch(IOException e)
					{
						e.printStackTrace();
						
					}
					
					//System.out.println("("+fmt2.format(k+1)+","+ProjectLogs.getrandstring(nurses)+","+"'"+"2018"+"-"+fmt.format(ProjectLogs.randomInteger(1, 12))+"-"+fmt.format(ProjectLogs.randomInteger(1, 28))+"'"+","+"'"+fmt2.format(ProjectLogs.randomInteger(1,8 ))+"'"+","+"'"+ProjectLogs.getrandstring(tasks)+"'"+","+"'"+ProjectLogs.getrandstring(shifts)+"'"+","+"'"+ProjectLogs.getrandstring(depts)+"'"+")"+",");
					Thread.sleep(d);
				}		
		}
		catch(IOException e){
			e.printStackTrace();
		}
		catch(InterruptedException e){
			e.printStackTrace();
		}
		finally {
			try{
				if (bw != null)
				bw.close();

			if (fw != null)
				fw.close();
			}
			catch(IOException e)
			{
				e.printStackTrace();
				
			}
		}			
	}
	
	public static void main(String[] args) {
		ProjectLogs P=new ProjectLogs();
		System.out.println( "generating script " + ProjectLogs.FILENAME + "....");
		P.generateLogs(5,1);
	    System.out.println("Finished");
	
	}	
}


  
 //use nursing; insert into worklog (id,nurse_name,facility_name,date,hours,task_name,shift,dept_name) values 
 


