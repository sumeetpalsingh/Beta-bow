//Measures distance between two specific cells
//Open the RGB csv file generated from betabow.ijm before running the macro.
//Sumeet Pal Singh, 05 July, 2016
//sumeetpalsingh@gmail.com

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
