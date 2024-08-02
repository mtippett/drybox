
spoolOverlap = 10;  // How far up the outside of the spool diameter we go
hubDepth = 20;  // Assumign the rewinder hub is flush, how deep do we go
spoolCollarHeight = 10;  // How much of a collar do we want to provide for the spool to sit on
wallWidth=1.5;  // Thickness of the overlap and hub surround.
rewinderDiameter = 48.1; // diameter of the gripless reqwinder
fontHeight = 5;
fontDepth = 0.75;


// 52: Prusament
// 53: California Filament Cardboard
// 55: Polymaker
// 56: California Filament Plastic


// Spool diameters to generate, choose ones to print in slicer
spoolDiameters = [50,51,52,53,54,55,56,57];



// Set quality to high - so circles are circles.
$fn=76;


for(spoolDiameterIndex = [0:len(spoolDiameters) - 1]) {
  spoolDiameter = spoolDiameters[spoolDiameterIndex];
  assert(rewinderDiameter + wallWidth < spoolDiameter, str("Spool Diameter (" , spoolDiameter,") less than rewinder diameter (",rewinderDiameter,") + wall width (",wallWidth,") (",rewinderDiameter + wallWidth,")"))
  
  echo (spoolDiameters[spoolDiameterIndex]);
  translate([spoolDiameterIndex*80,0,0])
    adapter(spoolDiameter = spoolDiameter);
    
}



module adapter(spoolDiameter){
    
    rewinderRadius = rewinderDiameter/2;
    rewinderCoverRadius = rewinderRadius + 0.5;
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
      translate([0,spoolRadius,-0.01])
      mirror([1,0,0])
      linear_extrude(height=fontDepth)
      text(str(spoolDiameter , "mm"),fontHeight,halign="center");

    }
  }

