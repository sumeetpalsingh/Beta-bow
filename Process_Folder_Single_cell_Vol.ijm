//Measures single cell volume from a folder containing tif files 
// note : the folder should only contain tif files!
// Run macro.

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

input = getDirectory("Input directory");
output = getDirectory("Output directory");

Dialog.create("File type");
Dialog.addString("File suffix: ", ".tif", 5);
Dialog.show();
suffix = Dialog.getString();

//Obtains the minimum number of expected cells
//Dialog.create("Minimum Number of Expected Cells");
//Dialog.addNumber("Cells", 15);
//Dialog.show();
//Min_Exp_Cells = Dialog.getNumber();

processFolder(input);

function processFolder(input) {
	list = getFileList(input);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(list[i]))
			processFolder("" + input + list[i]);
		if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}


function processFile(input, output, file) {
	// do the processing here by replacing
	// the following two lines by your own code
	//print("Processing: " + input + file);
	open(input + file);
	run("Size...", "width=512 height=512 constrain average interpolation=Bilinear");
	run("Split Channels");

	//Get Title of Image
	Image_Title = getTitle();

	if (substring(Image_Title, 0, 1) == "C"){
		//Close Red Channel
		selectWindow("C1-" + file);
		close();
		
		//Work on Green Channel
		selectWindow("C2-" + file);
		run("8-bit");
		run("3D object counter...", " min.=500 max.=15000 statistics");
		selectWindow("Statistics for " + "C2-" + file);
			
		//Initialize variables for number of observations  
		IJ.renameResults("Results");
		n = nResults();
		
		//Initialized the string for the volume column header information
		headings = split(String.getResultsHeadings);
		VOL_Header = headings[1]+" "+headings[2];
		
		//Prints individual Cell Volumes
		for (i=0; i<n; i++){
		  	Cell_Vol = getResult(VOL_Header, i);
		  	if (Cell_Vol > 115 && Cell_Vol <300) print(Cell_Vol);
		  	}
		
		//Finish work on green channel
		selectWindow("C2-" + file);
		close();
		
		//Work on Blue Channel
		selectWindow("C3-" + file);
		run("8-bit");
		run("3D object counter...", " min.=500 max.=15000 statistics");
		selectWindow("Statistics for " + "C3-" + file);
			
		//Initialize variables for number of observations  
		IJ.renameResults("Results");
		n = nResults();
		
		//Initialized the string for the volume column header information
		headings = split(String.getResultsHeadings);
		VOL_Header = headings[1]+" "+headings[2];
		
		//Prints individual Cell Volumes
		for (i=0; i<n; i++){
		  	Cell_Vol = getResult(VOL_Header, i);
		  	if (Cell_Vol > 115 && Cell_Vol <300) print(Cell_Vol);  	
		  	}
		
		//Finish work on green channel
		selectWindow("C3-" + file);
		close();
	}
	else {
		//Close Red Channel
		selectWindow(file + " (red)");
		close();
		
		//Work on Green Channel
		selectWindow(file + " (green)");
		run("8-bit");
		run("3D object counter...", " min.=500 max.=15000 statistics");
		selectWindow("Statistics for " + file + " (green)");
			
		//Initialize variables for number of observations  
		IJ.renameResults("Results");
		n = nResults();
		
		//Initialized the string for the volume column header information
		headings = split(String.getResultsHeadings);
		VOL_Header = headings[1]+" "+headings[2];
		//print(VOL_Header);
		//Prints individual Cell Volumes
		for (i=0; i<n; i++){
		  	Cell_Vol = getResult(VOL_Header, i);
		  	//print(Cell_Vol);
		  	if (Cell_Vol > 115 && Cell_Vol <300) print(Cell_Vol);
		  	}
		
		//Finish work on green channel
		selectWindow(file + " (green)");
		close();
		
		//Work on Blue Channel
		selectWindow(file + " (blue)");
		run("8-bit");
		run("3D object counter...", " min.=500 max.=15000 statistics");
		selectWindow("Statistics for " + file + " (blue)");
			
		//Initialize variables for number of observations  
		IJ.renameResults("Results");
		n = nResults();
		
		//Initialized the string for the volume column header information
		headings = split(String.getResultsHeadings);
		VOL_Header = headings[1]+" "+headings[2];
		
		//Prints individual Cell Volumes
		for (i=0; i<n; i++){
		  	Cell_Vol = getResult(VOL_Header, i);
		  	//print(Cell_Vol);
		  	if (Cell_Vol > 115 && Cell_Vol <300) print(Cell_Vol);  	
		  	}
		
		//Finish work on green channel
		selectWindow(file + " (blue)");
		close();
	}
}
