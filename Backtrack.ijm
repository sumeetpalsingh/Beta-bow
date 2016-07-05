//Helps identify a specific cell in the orginal image
//Open the original image and its csv file generated from betabow.ijm before running backtrack macro.
//Sumeet Pal Singh, 05 July, 2016
//sumeetpalsingh@gmail.com

getDimensions(width, height, channels, slices, frames);

Dialog.create("Backtrack Parameters");
Dialog.addMessage("Scaling Factor");
Dialog.addNumber("Image Length (um)", 42.51);
//Dialog.addNumber("Resolution", 1024);

Dialog.show();
Il=Dialog.getNumber();
//Ir=Dialog.getNumber();
Scale_Factor = width/Il;


n = nResults();

for (j=1; j<=n; j++) {
	Xc=getResult("X", j-1);
	Yc=getResult("Y", j-1);
	Zc=getResult("Z", j-1);
	setSlice(Zc);
	drawString(j, Xc*Scale_Factor, Yc*Scale_Factor);
}
