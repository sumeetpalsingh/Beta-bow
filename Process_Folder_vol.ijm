/*
 * Macro template to process multiple images in a folder
 */

input = getDirectory("Input directory");
output = getDirectory("Output directory");

Dialog.create("File type");
Dialog.addString("File suffix: ", ".tif", 5);
Dialog.show();
suffix = Dialog.getString();

//Obtains the minimum number of expected cells
Dialog.create("Minimum Number of Expected Cells");
Dialog.addNumber("Cells", 15);
Dialog.show();
Min_Exp_Cells = Dialog.getNumber();

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
	print("Processing: " + input + file);
	open(input + file);run("Size...", "width=512 height=512 constrain average interpolation=Bilinear");
	run("8-bit");
	run("3D object counter...", "threshold=15 slice=11 min.=50 statistics");
	//selectWindow(file);
	//run("Close");
	//print(file);
	selectWindow("Statistics for " + file);
	//runMacro("/home/sumeet/Nikolay Lab/Projects/BB/Macros/SUM_Vol.ijm");	
	//Initialize variables for number of observations and sum of volume  
	IJ.renameResults("Results");
	n = nResults();
	SUM_Vol = 0;
	//String.getResultsHeadings
	
	//Initialized the string for the column header with volume information
	headings = split(String.getResultsHeadings);
	//print(headings[1]+" "+headings[2]);
	//print(getResult(headings[1]+" "+headings[2],2));
	VOL_Header = headings[1]+" "+headings[2];
	
	//Adds up all the volumes
	for (i=0; i<n; i++)
	{
	  	//print(i);
	  	//print(getResult(VOL_Header,i));
	  	SUM_Vol = SUM_Vol+getResult(VOL_Header, i);
	  	}

	if (SUM_Vol < Min_Exp_Cells*185){
		run("3D object counter...", "threshold=7 slice=11 min.=50 statistics");
	//selectWindow(file);
	//run("Close");
	//print(file);
	selectWindow("Statistics for " + file);
	//runMacro("/home/sumeet/Nikolay Lab/Projects/BB/Macros/SUM_Vol.ijm");	
	//Initialize variables for number of observations and sum of volume  
	IJ.renameResults("Results");
	n = nResults();
	SUM_Vol = 0;
	//String.getResultsHeadings
	
	//Initialized the string for the column header with volume information
	headings = split(String.getResultsHeadings);
	//print(headings[1]+" "+headings[2]);
	//print(getResult(headings[1]+" "+headings[2],2));
	VOL_Header = headings[1]+" "+headings[2];
	
	//Adds up all the volumes
	for (i=0; i<n; i++)
	{
	  	//print(i);
	  	//print(getResult(VOL_Header,i));
	  	SUM_Vol = SUM_Vol+getResult(VOL_Header, i);
	  	}
	}
	//print the complete volume 
	print(SUM_Vol);
}
