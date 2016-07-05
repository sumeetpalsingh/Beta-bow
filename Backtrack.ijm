//Helps identify a specific cell in the orginal image
//Open the original image and its csv file generated from betabow.ijm before running backtrack macro.

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
