//Tests for equivalence from csv table containing ch1 ch2 ch3 sdch1 sdch2 sdch3 data 
// Drag and drop the .CSV file in the Fiji main window, it will open as a "Results" file (displaying X,Y,Z,R,G,B, sdR, sdG, sdB values from each cell)
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




//Ask for cells to test
Dialog.create("Equivalence testing");
Dialog.addMessage("Two cells to test");
Dialog.addNumber("Cell #1", 1);
Dialog.addNumber("Cell #2", 2);
Dialog.addMessage("CI, Limit = 90,1.65 ; 95,2 ; 99,2.58 ; 99.7,3");
Dialog.addNumber("Limit #1", 1.00);
Dialog.addNumber("Limit #2", 3.00);

//Obtain cell numbers
Dialog.show();
C1=Dialog.getNumber();
C2=Dialog.getNumber();
L1=Dialog.getNumber();
L2=Dialog.getNumber();

//Retrieve paramenters for first cell
RR1=getResult("Ch1", C1-1);
GG1=getResult("Ch2", C1-1);
BB1=getResult("Ch3", C1-1);

sdRR1=getResult("SD_Ch1", C1-1);
sdGG1=getResult("SD_Ch2", C1-1);
sdBB1=getResult("SD_Ch3", C1-1);

//Normalize parameters for first cell
tot1=(RR1+GG1+BB1);
R1=RR1/tot1;
G1=GG1/tot1;
B1=BB1/tot1;

sdR1 = (sdRR1/RR1)*R1;
sdG1 = (sdGG1/GG1)*G1;
sdB1 = (sdBB1/BB1)*B1;

//Retrieve paramenters for second cell
RR2=getResult("Ch1", C2-1);
GG2=getResult("Ch2", C2-1);
BB2=getResult("Ch3", C2-1);

sdRR2=getResult("SD_Ch1", C2-1);
sdGG2=getResult("SD_Ch2", C2-1);
sdBB2=getResult("SD_Ch3", C2-1);

//Normalize parameters for second cell
tot2=(RR2+GG2+BB2);
R2=RR2/tot2;
G2=GG2/tot2;
B2=BB2/tot2;

sdR2 = (sdRR2/RR2)*R2;
sdG2 = (sdGG2/GG2)*G2;
sdB2 = (sdBB2/BB2)*B2;

//Test Equivalence
if (R1+L1*sdR1 < R2+L2*sdR2 && R1-L1*sdR1 > R2-L2*sdR2 && G1+L1*sdG1 < G2+L2*sdG2 && G1-L1*sdG1 > G2-L2*sdG2 && B1+L1*sdB1 < B2+L2*sdB2 && B1-L1*sdB1 > B2-L2*sdB2) {
	print(C1 + " and " + C2 + " are equivalent!");
}
else print(C1 + " and " + C2 + " are NOT equivalent.");

////Test partial equivalence
//if ((R1+1.65*sdR1 < R2+2.58*sdR2 && R1-1.65*sdR1 > R2-2.58*sdR2) || (G1+1.65*sdG1 < G2+2.58*sdG2 && G1-1.65*sdG1 > G2-2.58*sdG2) || (B1+1.65*sdB1 < B2+2.58*sdB2 && B1-1.65*sdB1 > B2-2.58*sdB2)) {
//	print(C1 + " and " + C2 + " are partially equivalent");
//}
//else print(C1 + " and " + C2 + " are NOT partially equivalent");