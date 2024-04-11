
SPOOL_VENDOR = 0;
SPOOL_BRAND = 1;
SPOOL_DIAMETER = 2;


// spoolInfo =  [ "Polymaker", 55 ] ;
spoolInfo =  [ "California Filament","",54 ] ;

            // [ 55 ] // prusa 

spoolOverlap = 10;  // How far up the outside of the spool diameter we go
hubDepth = 20;  // Assumign the rewinder hub is flush, how deep do we go
spoolCollarHeight = 5;  // How much of a collar do we want to provide for the spool to sit on
wallWidth=2;  // Thickness of the overlap and hub surround.
rewinderDiameter = 48.1; // diameter of the gripless reqwinder
fontHeight = 3.75;
fontDepth = 1;

echo (str("Generating Spool Adapter for ", spoolInfo));

spoolDiameter = spoolInfo[SPOOL_DIAMETER];
spoolVendor = spoolInfo[SPOOL_VENDOR];
spoolBrand = spoolInfo[SPOOL_BRAND];


// Set quality to high - so circles are circles.
$fn=100;

adapter();




module adapter(){
    
    rewinderRadius = rewinderDiameter/2;
    rewinderCoverRadius = rewinderRadius + 1;
    spoolRadius = spoolDiameter/2;
    overlapRadius = spoolRadius + spoolOverlap;
    

    difference() {
      union() {
        // Snug fit attachement to the 
        cylinder(h=hubDepth,r=rewinderCoverRadius,center=false);

        // Step that the spool sits on
        cylinder(h=spoolCollarHeight,r=spoolRadius,center=false);

        // Flat part on outside of spool
        cylinder(h=wallWidth, r=overlapRadius,center=false );
      
      }
      // Negative space through the middle
      cylinder(h=hubDepth*2+1,r=rewinderRadius,center=true);
      translate([0,spoolRadius-1,-0.01])
      mirror([1,0,0])
      linear_extrude(height=fontDepth)
      text(spoolVendor,fontHeight,halign="center");

      translate([0,-spoolRadius+1-3,-0.01])
      mirror([1,0,0])
      linear_extrude(height=fontDepth)
      text(str(spoolBrand, " " , spoolDiameter , "mm"),fontHeight,halign="center");
    }
  }

