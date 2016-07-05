//Extracts location (XYZ) and color (RGB, and sd in each) value of a specified area
// Open tif file and run macro.

//Original macro kindly provided by Xavier Morin (xavier.morin@ens.fr).
//Copyright (C) 2016  Sumeet Pal Singh

//This macro is free code: you can redistribute it and/or modify
 //it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or any later version.

//This code is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details: <http://www.gnu.org/licenses/>.

//The code can be modified, distributed and sold without any strings attached. 
//If you find the code useful, you can buy me coffee when we meet.
//Find me at sumeetpalsingh@gmail.com or http://journalcoverage.blogspot.com/

{
//For selecting current file
name = getTitle();
run("Set Measurements...", "  centroid stack redirect=None decimal=3");

//Create the "Final Measurements" table
  title1 = "Final Measurements";
  title2 = "["+title1+"]";
  f = title2;
  if (isOpen(title1))
     print(f, "\\Clear");
  else
     run("Table...", "name="+title2+" width=600 height=500");
  print(f, "\\Headings:Cell#\tX\tY\tZ\tCh1\tCh2\tCh3\tSD_Ch1\tSD_Ch2\tSD_Ch3");
  
Nb=5000;

setTool("oval");
for (k=1; k<=Nb; k++){
	//setTool("freehand");
	//Stack.setActiveChannels(11100);
	
	//Choose a cell
	selectWindow(name);
	title = "select ROI";
	msg = "select ROI\n then click \"OK\".";
	waitForUser(title, msg);
	
	run("Measure");
	x=getResult("X", 0);
	y=getResult("Y", 0);
	z=getResult("Slice", 0);
	//z=getSliceNumber();
	run("Color Histogram");
	mR=getResult("mean", 0);
	mG=getResult("mean", 1);
	mB=getResult("mean", 2);
	sR=getResult("std.dev.", 0);
	sG=getResult("std.dev.", 1);
	sB=getResult("std.dev.", 2);
	
	//open a checkbox to chose which type of cell
 	rows = 1;
 	columns = 2;
 	labels = newArray(2);
	defaults = newArray(2);
		labels[0] = "is this the last cell you want to measure";
	defaults[0] = false;
		labels[1] = "are you sure you want to keep this cell?";
	defaults[1] = true;

	Dialog.create("Checkbox Group");
		Dialog.addCheckboxGroup(rows,columns,labels,defaults);
		Dialog.show();
		stop=Dialog.getCheckbox();
		keep=Dialog.getCheckbox();
		
		if (keep == 1) {
			//write single cell data in the final measurement table
			print(f, (k) + "\t" + x + "\t" + y + "\t" + z + "\t" + mR + "\t" + mG + "\t" + mB + "\t" + sR + "\t" + sG + "\t" + sB);
			
			//empty results table
			m = nResults();
			IJ.deleteRows(0, m-1);

			//Remove the measured area
			selectWindow(name);
			run("Cut");
		}
		else {	k=k-1;
			//empty results table
			m = nResults();
			IJ.deleteRows(0, m-1);
		}
		if (stop == 1) Nb=k;
		else ;
		
		//Closes color Histogram Window
		//selectWindow("Histogram of Image");
		//close();
	}
}