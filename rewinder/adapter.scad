



rewinderDiameter = 48.1;
spoolDiameter = 55;
spoolOverlap = 10;

wallWidth=1;

hubHeight = 20;
spoolCollarHeight = 3;
outerSpool = 1;

$fn=100;



// Yay! Let's start!
generateOutput();




module generateOutput(){
    
    rewinderRadius = rewinderDiameter/2 + 1;
    spoolRadius = spoolDiameter/2;
    overlapRadius = spoolRadius + spoolOverlap;


    
        difference() {
          union() {
            cylinder(h=hubHeight,r=rewinderRadius,center=false);
            cylinder(h=spoolCollarHeight,r=spoolRadius,center=false);
            cylinder(h=outerSpool, r=overlapRadius,center=false );
         
          }
             cylinder(h=hubHeight*2+1,r=rewinderRadius-1,center=true);
         
        }
  }

