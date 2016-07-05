//Measures distance between two specific cells
//Open the RGB csv file generated from betabow.ijm before running the macro.

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

Dialog.create("Distance Parameters");
Dialog.addMessage("Distance between cells");
Dialog.addNumber("First Cell", 1);
Dialog.addNumber("Second Cell", 2);
Dialog.addNumber("Z-thickness (um)", 0.51);


Dialog.show();
First_cell=Dialog.getNumber();
Second_cell=Dialog.getNumber();
Z_dist=Dialog.getNumber();

//print(""+First_cell);
X1=getResult("X", First_cell-1);
Y1=getResult("Y", First_cell-1);
Z1=getResult("Z", First_cell-1);

X2=getResult("X", Second_cell-1);
Y2=getResult("Y", Second_cell-1);
Z2=getResult("Z", Second_cell-1);
//print(""+X1);

Xd = X1-X2;
Yd = Y1-Y2;
Zd = (Z1-Z2)*Z_dist;
//print(Xd);
//print(Yd);
//print(Zd);
Distance = sqrt(Xd*Xd + Yd*Yd + Zd*Zd);
print(Distance);
