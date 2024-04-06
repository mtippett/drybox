/*   
    Integrated Auto-rewind Spool Holder
    Vincent Groenhuis
    
    This integrated design is the fifth iteration in the Auto-Rewind Spool Holder series, after the original, parametric, universal and Sisyphus iterations.
    
    This design returns to the original roots of the series with the spring wound up inside the cylindrical space of the hub, as opposed to the side spring designs. While the diameter is relatively small (45 mm-ish), almost the full width of the spool holder can be utilized allowing to stack many small springs and obtain sufficient rewinding revolutions at a good torque profile.
    
    The default implementation does not include a dedicated clutch. The contact surface between rewinder and spool is used as slipping surface. The magnitude of the friction is determined by the combination of materials and its structure (roughness), and the weight of the spool itself.

    Several parameters are available to specify the dimensions of the Integrated Auto-Rewind Spool Holder.

    Axle, stand and clips are not included. You can use those of any of the other spring-based spool holders such as the Parametric or Universal Auto-Rewind Spool Holder.
    
    Narrow: hub 60 mm, fits spools up to 55 mm
    Default: hub 75 mm, fits spools up to 70 mm
    Wide: hub 95 mm, fits spools up to 90 mm
    
    Narrow and default use 7 springs, wide uses 9 springs
    
    To generate springs for the Universal Auto-Rewind Spool holder, change the following settings:
    
    output="print"
    universalRewinderSpring=true
    rewinderDiameter=88.6
    rewinderLength=8
    springAlternate=true
    reverseSprings=true
    springBladeCount=2
    springBladeThickness=1.4
    springBladePitch=2.5
    $fn=100
    axleConnectionDiameter=12
    springFlatShaftLength=5
    
   
    Version history
    V5.6.1 Nov 15, 2019
      - Fixed missing parameter "w" in two functions; the earlier corrected V5.6 file did not get uploaded correctly to Thingiverse
      - Fixed bug in height of base tabs, only apparent in 95 mm wide hubs
    V5.6 Nov 10, 2019
      - Chamfered bottom of springs to eliminate effect of elephant feet
      - Reduced radial tab clearance to 0.05 mm for snug fit
    V5.5 Nov 6, 2019
      - Set springAlternate = true, optimizing rewind in one direction only
      - Changed top/down emboss characters to < and > to indicate correct rewind direction
      - Redesigned hub-spring attachment
      - Eliminated ribs
      - Three default sizes: 60 mm (narrow), 75 mm (standard) and 95 mm (wide)
      - Default output "print"
      - Fixed rendering issue in hole for flat shaft
      - Increased spring tab clearance
      - Set intertwinedThreadCount to 1 as there is no need anymore to un-screw the cap; changed thread dimensions to set overhang to 45 degrees for easier printing
      - Three STLs: small (60 mm), medium (75 mm), wide (95 mm).
      - Chamfered tabs for easier spring stack assembly
      - Reduced hub wall thickness
      - Adjusted spring parameters to make it slightly more flexible
    V5.4 Oct 9, 2019
      - Different decal characters top/bottom possible
      - Enable/disable decal character mirroring
      - rewinderSetRimDiameter now takes grips into account
      - Default rewinderSetRimDiameter set to 50 so that cap can stay in place when changing spools
      - Setting hubRibDepth to 0 now completely hides ribs
      - Added Halloween mode for Jack O'Lantern pattern cutout
    V5.3 Sept 10, 2019
      - Improved Universal Rewinder spring parameters
      - Changed default size and shape of decals for easier printing
      - Increased clearance in hub-spring attachment
      - Check for compatible OpenSCAD version
    V5.2 Sept 5, 2019
      - Added possibility to create spring systems for Universal Auto-Rewind Spool Holder
    V5.1 Aug 5, 2019
      - Fixed bug in rib generation (wrong variable name)
      - Changed default hub hole shape to square to make the overhang angle less steep, and also avoid floating rib segments
      - Reduced default spring blade width (from 1.3) to 1.2 and reduced spring blade pitch (from 2.5) to 2.1 to make the spring slightly more flexible
      - Two STLs: one for spools up to 55 mm (7 springs, hub length 60 mm), other for spools up to 90 mm (9 springs, hub length 95 mm)
    V5.0 Aug 1, 2019
      - First version
*/

// "assembly" gives assembly view with cutout; "print" STL output with all parts, other options select one specific part.
output = "print";//[assembly,print,hub,clutch,cap,springBase,springEven,springOdd,springTop,universalRewinderSpring]

// Set to true to create a spring module for the Universal Auto-Rewind Spool Holder.
universalRewinderSpring = false; //[true,false]

// Total length of the rewinder including rims (effective space for spool is about 5 mm less). Narrow: 60, standard: 75, wide: 95.
rewinderLength = 65 ;

// Number of spring blades, must be odd. Recommended: 7 for narrow, 9 for standard and wide rewinders.
springBladeCount = 9;

// Diameter of rewinder, should be at least 1 mm smaller than the inner diameter of the smallest spool.
rewinderDiameter = 48.1;

// Diameter of both rims at the ends of the rewinder (including grips), set equal to 0 to disable. V5.3 used 70
rewinderSetRimDiameter = 50;

// Nominal axle diameter; axle holes are slightly wider
axleDiameter = 8;

// Depth of ribs on hub surface for better grip on spool, set to 0 to disable
hubRibDepth = 0;//0.5;

// Generate holes in hub for spring visibility etc
hubHoles = true; //[true,false]

// Emboss decals on bottom of hub and cap
embossDecals = false; //[true,false]

// Emboss character, V5.1 used "∫", V5.4 used "I"
embossCharacterTop = "<";

// Bottom emboss character
embossCharacterBottom = ">";

// If true then emboss characters are alternatingly mirrored
embossAlternateMirror = false;

// Relative scale of decals, V5.1 used 1, V5.4 used 2
embossScale = 3;

// True if spring orientation flips every level giving symmetric spring behaviour, while "false" causes all springs to wind up either around the axle or towards the outer rim
springAlternate = true; //[true,false]

// If true, then all springs are reversed. Use this (toghether with springAlternate=true) if needed to get all springs wrap around the axle instead of to the outer rim, depending on spool configuration.
reverseSprings = false; //[true,false]

// Thickness of spring blade, stiffness is proportional to the third power of this value; not all values are well printable due to fixed print line thickness which must partially overlap itself for adhesion
springBladeThickness = 1.1; // was: 1.2

// Pattern spacing of the spring blade, typically between 2 and 3 mm
springBladePitch = 2.0; // was: 2.1

// Diameter of bearing, 608-type bearings have outer diameter 22 mm so use a slightly larger value to obtain a good fit
bearingDiameter = 22.2;

// Width of bearing, 608-type bearings have width 7 mm
bearingWidth = 7;

// If set to true, then a Jack O'Lantern pattern is cut out in the hub
halloween=false;





/*[Advanced Parameters]*/

// Higher = smoother circular segments but also longer rendering time
$fn=70;

// Clearance around axle
axleClearance = 0.3;

// Outer diameter of axle connection part, use 12 for the universal rewinder
axleConnectionDiameter = 13.5;

// chamfer for bearing cavity so that elephant feet do not block insertion
bearingChamfer = 0.5;

// Thickness of bearing covers to avoid bearings sliding through the hub; one mm is enough
bearingCoverThickness = 1;

// Relative hole size must be below 1 or else the individual gaps may merge into one big gap
hubHoleRelSize = 0.75;

// Set to nonzero to force number of hub hole layers
hubForceLevelCount = 0;

// Smaller value puts the hub holes closer to each other
hubHoleLevelSpacingFactor = 0.9;

// Number of ribs around hub
hubRibCount = 60;

// Thickness of rib (no effect is hub length is zero)
hubRibWidth = 0.7;

// Number of holes in hub (per layer)
hubHoleCount = 6;

// Number of sides of hub hole polygons, higher numbers are less printable due to overhang angles
hubHolePolygonSize = 40;

// Thread pitch
threadPitch = 3;

// Depth of thread profile, should be 1/4 the pitch to get a 45 degree overhang slope when using a trapezoid profile
threadDepth = 0.75;

// Number of intertwined threads, 1=single-start thread
intertwinedThreadCount = 1;

// Additional horizontal clearance in cap/nut thread, affects cap thread dimensions. Increase if cap is too tight, only cap needs to be reprinted then.
threadClearance = 0.3;

// Thickness of outer rim, set to 0 to disable if you manage the spool position in a different way
rewinderRimThickness = 2;

// Thickness of hub walls, including ribs
rewinderWallThickness = 1.5; // was: 2.0

// Thickness of inner and outer rims, may not be smaller than spring blade thickness
springRimThickness = 2.5;

// Clearance between hub wall and spring perimeter (default: 1)
springHubClearance = 0;

// Gap between rim and spring start
springThresholdSpace = 0.5;

// True if designed for a flat axle; false presents a zip-tie fixation point
springFlatShaft = true; //[true,false]

// Excess length of flat shaft, 2 mm is fine
springFlatShaftLength = 2;

// Excess length of round shaft, must be ~2 mm larger than the zip-tie width
springRoundShaftLength = 6;

// Number of tabs on hub-spring attachment
springBaseTabCount = 0;

// Number of tabs on outer rim
springOuterTabCount = 6;

// Number of tabs on inner rim
springInnerTabCount = 3;

// Tab thickness (both for inner and outer tabs)
springTabThickness = 1.3;

// Radial clearance around tab, ideally resulting in a snug fit
springRadialTabClearance = 0.05;

// Radial clearance around base tab, loose fit
springBaseRadialTabClearance = 0.5;

// Circular clearance around tab, loose fit
springCircularTabClearance = 0.5;

// Clearance in z-direction of tab
springVerticalTabClearance = 0.1;

// Relative angular size of base tabs, between 0 and 1
springBaseTabSizeFactor = 0.3;

// Relative angular size of base tab gaps, between 0 and 1
springBaseTabGapSizeFactor = 0.7;

// Relative angular size of tabs, between 0 and 1
springTabSizeFactor = 0.7;

// Depth of curved tab gap removal to make printing of overhangs easier
springTabGapCurvedPartRemovalDepth = 0.2;

// Gap between hub and spring and between successive springs in stack
springStackGap = 0.6;

// Relative tab height, value between 0 and 1
springTabHeightRel = 0.5;

// Number of grip sections on outer rims
rimGripCount = 0;

//Depth of the decals in the rewinder rim
embossDepth = 1;

// Thickness of inner and outer rims in emboss
embossEdgeThickness = 0;

// Number of decals
embossDecalCount = 1;

// Universal spring backplate
universalBackplateThickness = 0.8;



// Derived variables
springDiameter = rewinderDiameter-2*(rewinderWallThickness+springHubClearance);
springLength = universalRewinderSpring?rewinderLength-universalBackplateThickness-springStackGap:rewinderLength-bearingWidth-bearingCoverThickness-springStackGap-bearingWidth-springVerticalTabClearance;
springBladeTotalLength = springLength-(springBladeCount-1)*springStackGap - (universalRewinderSpring?0:(springFlatShaft?springFlatShaftLength:springRoundShaftLength));
springBladeWidth = springBladeTotalLength/springBladeCount;

springBaseTabAngle = 360/springBaseTabCount*springBaseTabSizeFactor;
springBaseTabGapAngle = 360/springBaseTabCount*springBaseTabGapSizeFactor;

springOuterTabAngle = 360/springOuterTabCount*springTabSizeFactor;
springOuterTabGapAngle = springOuterTabAngle + 4*springCircularTabClearance/springDiameter*180/PI;

springInnerTabAngle = 360/springInnerTabCount*springTabSizeFactor;
springInnerTabGapAngle = springInnerTabAngle + 4*springCircularTabClearance/axleDiameter*180/PI;


springTabHeight = springTabHeightRel*springBladeWidth;
capThreadSize = rewinderDiameter-2*rewinderWallThickness+2*threadDepth;

hubHoleStartZ = bearingWidth+bearingCoverThickness+springStackGap+springTabHeight+1;
hubHoleEndZ = rewinderLength-bearingWidth-bearingCoverThickness-2;
             
hubHoleSize = hubHoleRelSize*rewinderDiameter*PI/hubHoleCount;
hubHoleLevelCount = (hubForceLevelCount>0?hubForceLevelCount:floor((hubHoleEndZ-hubHoleStartZ)/(hubHoleSize*hubHoleLevelSpacingFactor)));
rewinderRimDiameter = max(rewinderDiameter,rewinderSetRimDiameter)/(1+PI/max(4,rimGripCount)/3);
rimGripDiameter = rewinderRimDiameter*PI/max(4,rimGripCount);
maxDiameter = rewinderRimDiameter+rimGripDiameter/3;

// Sanity checks
if(version_num()<20190500) {
    echo("<font color=red><b>Please update OpenSCAD to 2019.05 or newer!</b></font>");
}
assert(version_num()>=20190500);

assert(universalRewinderSpring?springBladeCount==2:springBladeCount%2==1);// springBladeCount must be odd
assert(springRimThickness>=springBladeThickness);
assert(springThresholdSpace<=springBladePitch-springBladeThickness-0.1);

// Output interesting derived values
echo(str("<b>Max spool width: ",rewinderLength-2*rewinderRimThickness," mm</b>"));

echo(str("<b>Spring diameter: ",springDiameter," mm, blade width: ",springBladeWidth," mm</b>"));


// Yay! Let's start!
generateOutput();



module error(text){
    echo(str("<font color='red'>",text,"</font>"));
}

module generateOutput(){
    if(output=="assembly") {
        if (universalRewinderSpring) {
            color("red")translate([0,0,0])universalHubSection();
            translate([0,0,universalBackplateThickness]) {
                universalSpringStackSection();
            }
        } else {
            color("red")translate([0,0,0])hubSection();
            translate([0,0,bearingWidth+bearingCoverThickness]) {
                springStackSection();
            }
            color("cyan")translate([0,0,rewinderLength])rotate([180,0,0])capSection();
        }
    } else if(output=="print") {
        if (universalRewinderSpring) {
            hubSpacing = rewinderDiameter+2;
            color("red")translate([0,0,0])universalHub();
            // blade 0 is odd, blade 1 = top = even
            color("yellow")translate([0,hubSpacing,0])separateSpring(type="odd");
            color("orange")translate([hubSpacing,hubSpacing,0])separateSpring(type="top");
        } else {
            hubSpacing = maxDiameter+2;
            springSpacing = springDiameter+2;
            // print layout
            color("red")translate([0,0,0])hub();
            color("cyan")translate([hubSpacing,0,0])cap();
            if (springBladeCount>=3) {
                for (i=[0:(springBladeCount-1)/2-1]) {
                    translate([i*springSpacing,0,0]) {
                        color(i==0?"magenta":"green")translate([0,(hubSpacing+springSpacing)/2,0])separateSpring(type=(i==0?"base":"even"));
                        color("yellow")translate([0,(hubSpacing+springSpacing)/2+springSpacing,0])separateSpring(type="odd");
                    }
                }
            }
            color("orange")translate([springSpacing*(springBladeCount-1)/2,(hubSpacing+springSpacing)/2,0])separateSpring(type="top");
        }
    } else if(output=="springBase") {
        separateSpring(type="base");
    } else if(output=="springEven") {
        separateSpring(type="even");
    } else if(output=="springOdd") {
        separateSpring(type="odd");
    } else if(output=="springTop") {
        separateSpring(type="top");
    } else if(output=="hub") {
        hub();
    } else if(output=="clutch") {
        hub();

    } else if(output=="cap") {
        cap();
    }
}

/*
    Creates a disc with emboss, acting as a handle and spool retainer. Used in both the hub and the cap. No center hole is created.
    Decal character choice depends on isTop
*/
module rewinderRim(isTop) {
    echo (rewinderRimDiameter,rewinderDiameter)
    union(){
        difference(){
            union(){
                if (rimGripCount>0) {
                    cylinder(d=rewinderRimDiameter,h=rewinderRimThickness);

                    for (i=[0:rimGripCount-1],a=i*360/rimGripCount) {
                        rotate([0,0,a]) {
                            translate([rewinderRimDiameter/2-rimGripDiameter/3,0,0]) {
                                cylinder(d=rimGripDiameter,h=rewinderRimThickness);
                            }
                        }                    
                    }      
                } else {
                                    cylinder(d=rewinderDiameter,h=rewinderRimThickness);
                }
            }
            if (embossDecals) {
                difference(){
                    translate([0,0,-0.1])cylinder(d=rewinderRimDiameter-2*embossEdgeThickness,h=embossDepth+0.1);
                    translate([0,0,-0.2])cylinder(d=bearingDiameter+2*embossEdgeThickness,h=embossDepth+0.2);
                }
            }        
        }
        
        if (embossDecals) {
            for (i=[0:embossDecalCount-1],a=360*i/embossDecalCount){
                rotate([0,0,a]){
                    translate([(rewinderRimDiameter+bearingDiameter)/4,0,0]) {
                        rotate([0,0,90])
                        //rotate([180,0,0])
                        mirror([embossAlternateMirror?i%2:0,0,0])
                            linear_extrude(height=embossDepth,convexity=4){
                            text((isTop?embossCharacterTop:embossCharacterBottom),size=(rewinderRimDiameter-bearingDiameter-4*embossEdgeThickness)/3.5*embossScale,font="Liberation Sans:style=bold",halign="center",valign="center");//"∫" in Century font
                        }
                    }
                }
            }
        }
    }
}

/*
  The integrated hub houses one bearing and connects to the spring and cap.
*/
module hub() {
    difference(){
        union(){
            rewinderRim(isTop=false);
            difference(){
                translate([0,0,rewinderRimThickness]) {
                    linear_extrude(height=rewinderLength-2*rewinderRimThickness,convexity=4) {
                        union(){
                            circle(d=rewinderDiameter-2*hubRibDepth);
                            if (hubRibDepth>0) {
                                ribs();
                            }
                        }
                    }
                }
                translate([0,0,bearingWidth+bearingCoverThickness])cylinder(d=rewinderDiameter-2*rewinderWallThickness,h=rewinderLength);
            }   
            translate([0,0,bearingWidth+bearingCoverThickness])
        baseSpringAttachmentTabs();                
        }
        // space for bearing
        translate([0,0,-0.1])cylinder(d=bearingDiameter,h=bearingWidth+0.1);
        // bearing chamfer
        translate([0,0,-bearingChamfer]) {
            cylinder(d1=bearingDiameter+4*bearingChamfer,d2=bearingDiameter,h=2*bearingChamfer);
        }
        // space for axle
        translate([0,0,-0.1])cylinder(d=bearingDiameter-0.01,h=rewinderLength+0.2,$fn=7);
        // thread for cap
        translate([0,0,rewinderLength-rewinderRimThickness])
            rotate([180,0,0])
                thread(size=capThreadSize, pitch=threadPitch, depth=threadDepth, length=bearingWidth-rewinderRimThickness+bearingCoverThickness+1, spiralCount=intertwinedThreadCount);
        makeHubHoles();
    }
}

module baseSpringAttachmentTabs() {
    // small ring to give bottom spring some room
    difference() {
        cylinder(d=rewinderDiameter-2*hubRibDepth,h=springStackGap-springVerticalTabClearance);
        translate([0,0,-2])cylinder(d=springDiameter-2*springRimThickness,h=springStackGap+4);
    }
    intersection(){
        translate([0,0,-1]) {
            difference(){
                cylinder(d=rewinderDiameter-2*hubRibDepth,h=springBladeWidth+2+springStackGap);
                translate([0,0,-0.1])cylinder(d=springDiameter-2*(springTabThickness-springBaseRadialTabClearance),h=springBladeWidth+2+springStackGap+0.2);
            }
        }
        for (i=[0:springBaseTabCount-1],a=360*i/springBaseTabCount) {
            rotate([0,0,a]) {
                translate([0,0,0]) {
                    linear_extrude(height=springStackGap+springBladeWidth) {
                        polygon(points=[[0,0],[rewinderDiameter*cos(springBaseTabAngle/2),rewinderDiameter*sin(springBaseTabAngle/2)],[rewinderDiameter*cos(springBaseTabAngle/2),-rewinderDiameter*sin(springBaseTabAngle/2)]]);
                    }
                }
            }
        }
    }
}

module ribs() {
    for (i=[0:hubRibCount-1],a=i*360/hubRibCount) {
        rotate([0,0,a]) {
            translate([rewinderDiameter/2-rewinderWallThickness,-hubRibWidth/2,0]) {
                square([rewinderWallThickness,hubRibWidth]);
            }
        }
    }
}

module makeHubHoles() {
    if (hubHoles) {
        if (halloween) {
            jack();
        } else {
            for (lv=[0:hubHoleLevelCount-1]) {
                translate([0,0,hubHoleStartZ+(0.5+lv)*(hubHoleEndZ-hubHoleStartZ)/hubHoleLevelCount])
                rotate([0,0,lv%2*180/hubHoleCount]) {
                    for (i=[0:hubHoleCount-1],a=360*i/hubHoleCount) {
                        rotate([0,0,a]) {
                            rotate([90,0,0]) {
                                rotate([0,0,90]) {
                                    cylinder(d=hubHoleSize,h=rewinderDiameter+1,$fn=hubHolePolygonSize);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

/* Creates complete face
*/
module jack(){
    translate([0,0,rewinderLength/2]) {
        rotate([0,0,90])
        rotate([0,-90,0])scale([0.8,0.8,1])
          union(){
            halfJack();
            mirror([1,0,0])halfJack();
        }
    }
}

/*
  halfJack creates an eye, half nose and a half mouth
  oriented in positive X and Z axis
  Pos Y axis points to top of head 
*/
module halfJack(){
  linear_extrude(height=rewinderDiameter+2) {
    union() {
      // eye
      polygon(points=[[5,17],[25,17],[25,27.5]]);
      // nose
      polygon(points=[[0,0],[10,0],[0,12]]);
      // mouth
        scale([1.2,1])
      polygon(points=[[0,-15],[5,-10],[10,-15],[15,-8],[20,-13],[25,-5],
        [25,-15],[20,-22],[15,-17],[10,-25],[5,-20],[0,-25]]);
     }
  }
}


module universalHub() {
    // outer wall, backplate with hole, connection with first spring
    union(){
        difference(){
            cylinder(d=rewinderDiameter,h=rewinderLength);
            translate([0,0,universalBackplateThickness])cylinder(d=rewinderDiameter-2*rewinderWallThickness,h=rewinderLength);
            translate([0,0,-0.1])cylinder(d=axleDiameter+2*axleClearance,h=universalBackplateThickness+0.2);
        }
        translate([0,0,universalBackplateThickness])innerTabs(a=axleDiameter+2*axleClearance+0.01);
    }
}


// Display half of the hub, for assembly view
module hubSection(){
    difference(){
        hub();
        translate([-maxDiameter/2-1,-0.01,-1])cube([maxDiameter+2,maxDiameter/2+1,rewinderLength+2]);
    }
}

module universalHubSection(){
    difference(){
        universalHub();
        translate([-maxDiameter/2-1,-0.01,-1])cube([maxDiameter+2,maxDiameter/2+1,rewinderLength+2]);
    }
}

module capSection() {
    difference(){
        cap();
        translate([-maxDiameter/2-1,-maxDiameter/2-1,-1])cube([maxDiameter+2,maxDiameter/2+1.02,bearingWidth+bearingCoverThickness+1.1]);
    }
}

/*
  The integrated cap houses one bearing and connects to the hub.
*/
module cap() {
    //rd=max(rewinderDiameter,rewinderRimDiameter);
    difference(){
        union(){
            translate([0,0,rewinderRimThickness]){
                thread(size=capThreadSize-2*threadClearance, pitch=threadPitch, depth=threadDepth, length=bearingWidth-rewinderRimThickness+bearingCoverThickness, spiralCount=intertwinedThreadCount);
            }
            rewinderRim(isTop=true);
        }
        // chamfer
        translate([0,0,bearingWidth+bearingCoverThickness-0.5]) {
            difference(){
                cylinder(d=capThreadSize+1,h=0.6);
                translate([0,0,-0.1])cylinder(d1=capThreadSize-2*threadClearance,d2=capThreadSize-2*threadClearance-0.8*2,h=0.8);
            }
        }
            
        // space for bearing
        translate([0,0,-0.1])cylinder(d=bearingDiameter,h=bearingWidth+0.1);
        // bearing chamfer
        translate([0,0,-bearingChamfer]) {
            cylinder(d1=bearingDiameter+4*bearingChamfer,d2=bearingDiameter,h=2*bearingChamfer);
        }
        // space for axle
        translate([0,0,-0.1])cylinder(d=bearingDiameter-0.01,h=rewinderLength+0.2,$fn=7);
    }
}

// Display 3/4 part of the spring stack for assembly view
module springStackSection(){
    difference(){
        springStack();
        translate([0,0,-1])cube([rewinderDiameter/2+1,rewinderDiameter/2+1,rewinderLength+1]);
    }
}

module universalSpringStackSection(){
    difference(){
        universalSpringStack();
        translate([0,0,-1])cube([rewinderDiameter/2+1,rewinderDiameter/2+1,rewinderLength+max(springFlatShaftLength,springRoundShaftLength)+1]);
    }
}

module springStack(){
    if (springBladeCount>=3) {
        for (i=[0:(springBladeCount-1)/2-1]) {
            translate([0,0,springStackGap+i*2*(springBladeWidth+springStackGap)]) {
                color(i==0?"magenta":"green")separateSpring(type=(i==0?"base":"even"));
                translate([0,0,springBladeWidth+springStackGap]){
                    color("yellow")separateSpring(type="odd");
                }
            }
        }
    }
    translate([0,0,springStackGap+(springBladeCount-1)*(springBladeWidth+springStackGap)]) {
        color("orange")separateSpring(type="top");
    }
}

module universalSpringStack(){
    translate([0,0,springStackGap])color("yellow")separateSpring(type="odd");
    translate([0,0,springBladeWidth+2*springStackGap])color("orange")separateSpring(type="top");
}


/*
    Creates individual spring with connectors.
    Order: [even, odd]*, top
*/
module separateSpring(d=springDiameter,w=springBladeWidth,t=springBladeThickness,p=springBladePitch,m=springRimThickness,type="even") {

    a=axleDiameter+2*axleClearance;
    
    // spring with tab gaps and tabs
    difference() {
        union(){
            singleSpringWithRings(d=d-2*(springTabThickness+springRadialTabClearance),w=w,t=t,p=p,a=a+2*(springTabThickness+springRadialTabClearance),f=springAlternate?type=="odd":false,s=0,g=springStackGap,m=m-springTabThickness-springRadialTabClearance,c=springThresholdSpace,rv=reverseSprings);
            // outer rim
            difference() {
                cylinder(d=d,h=w);
                translate([0,0,-0.5]){
                    cylinder(d=d-2*(springTabThickness+springRadialTabClearance+0.1),h=w+1);
                }
            }
            // inner rim
            difference(){
                cylinder(d=a+2*(springTabThickness+springRadialTabClearance)+0.2,h=w);
                translate([0,0,-0.5]){
                    cylinder(d=a,h=w+1);
                }
            }
            // outer tabs
            if(type=="odd"){
                translate([0,0,w]) {
                    makeOuterTabs(d=d,w=w,m=m);
                }
            }
            // inner tabs
            if(type=="even" || type=="base"){
                translate([0,0,w]) {
                    innerTabs(d=d,w=w,t=t,m=m,a=a);
                }
            }
            // axle connection
            if (type=="top") {
                if(springFlatShaft) {
                    axleConnectionFlat(a=a,m=m,w=w);
                } else {
                    // round shaft
                    axleConnectionRound(a=a,m=m,w=w);
                }
            }
        }
        // outer tab gaps
        if(type=="even" || type=="top"){
            makeOuterTabGaps(d=d,d0=d-2*(springTabThickness+springRadialTabClearance));
        } else if(type=="base"){
            makeBaseTabGaps(d=d,d0=d-2*(springTabThickness+springRadialTabClearance));
        }
        // inner tab gaps
        if(type=="odd"){
            makeInnerTabGaps(d=d,a=a);
        }
    }
}

module axleConnectionFlat(a,m,w) {
    union(){
        translate([0,0,springBladeWidth]) {
            difference(){
                cylinder(d=axleConnectionDiameter/*a+2*m*/,h=springFlatShaftLength);
                translate([0,0,-0.1])cylinder(d=a,h=springFlatShaftLength+0.2);
            }
        }
        intersection(){
            // cube
            translate([-a,-a,-1])cube([a*2,a-0.5*sqrt(2)*a/2,w+springFlatShaftLength+2]);
            cylinder(d=axleConnectionDiameter,h=w+springFlatShaftLength);
        }
    }
}

module axleConnectionRound(a,m,w) {
    translate([0,0,springBladeWidth])
    difference(){
        union(){
            cylinder(d=a+2*m,h=springRoundShaftLength);
            translate([0,0,springRoundShaftLength-1])cylinder(d=a+2*m+1,h=1);
        }
        translate([0,0,-0.1])cylinder(d=axleDiameter,h=springRoundShaftLength+0.2);
        translate([-a,-1,1])cube([a*2,2,springRoundShaftLength]);
        translate([-1,-a,1])cube([2,a*2,springRoundShaftLength]);
    }          
}

// d=spring diameter, w=spring blade width, m=spring rim thickness
module makeOuterTabs(d,w,m) {
    // Thin full ring on top of spring
    difference(){
        translate([0,0,-0.02])cylinder(d=d,h=springStackGap-springVerticalTabClearance+0.02);
        translate([0,0,-0.5]){
            cylinder(d=d-2*m,springStackGap+1);
        }
    }
    translate([0,0,springStackGap-springVerticalTabClearance]) {
        difference(){
            translate([0,0,-0.1])cylinder(d=d,h=springTabHeight+springVerticalTabClearance+0.1);
            // chamfer top
            translate([0,0,springTabHeight*0.67])cylinder(d1=d-2*springTabThickness,d2=d-2*springTabThickness+0.5*springTabHeight,h=springTabHeight);
            // tabs
            translate([0,0,-0.5]){
                cylinder(d=d-2*springTabThickness,h=w);
                for (i=[0:springOuterTabCount-1],an=(i+0.5)*360/springOuterTabCount) {
                    rotate([0,0,an]) {
                        linear_extrude(height=w) {
                            gapTriangle(360/springOuterTabCount-springOuterTabAngle,d/2);
                        }
                    }
                }
            }
        }
    }
}

module makeOuterTabGaps(d,d0) {
    difference(){
        for (i=[0:springOuterTabCount-1],an=i*360/springOuterTabCount) {
            rotate([0,0,an]) {
                translate([0,0,-0.5])
                linear_extrude(height=springTabHeight+0.5+springVerticalTabClearance) {
                    gapTriangle(springOuterTabGapAngle,d/2);
                }
                // make printing easier by eliminating part of the curved overhangs
                translate([0,0,-0.5])
                linear_extrude(height=springTabHeight+0.5+springVerticalTabClearance+springTabGapCurvedPartRemovalDepth) {
                    polygon(points=[
                    [d,0],
                    [cos(springOuterTabGapAngle/2)*d/2,sin(springOuterTabGapAngle/2)*d/2],
                    [max(d/2*cos(springOuterTabGapAngle/2),d/2-springTabThickness-springRadialTabClearance),0],
                    [cos(springOuterTabGapAngle/2)*d/2,-sin(springOuterTabGapAngle/2)*d/2]
                    ]);
                }    
            }
        }
        translate([0,0,-0.5])cylinder(d1=d0-1,d2=d0,h=0.5+0.3*springTabHeight);
        translate([0,0,0.3*springTabHeight])cylinder(d=d0,h=springTabHeight+3);
    }
}

module makeBaseTabGaps(d,d0) {
    difference() {
        for (i=[0:springBaseTabCount-1],an=i*360/springBaseTabCount) {
            rotate([0,0,an]) {
                translate([0,0,-0.5]) {
                    linear_extrude(height=springBladeWidth+0.5+springVerticalTabClearance) {
                    gapTriangle(springBaseTabGapAngle,d/2);
                    }
                }
            }
        }
        //translate([0,0,-0.5])cylinder(d=d0,h=springTabHeight+1);
        translate([0,0,-0.5])cylinder(d1=d0-1,d2=d0,h=1);
        translate([0,0,0.5])cylinder(d=d0,h=springBladeWidth);
    }
}

/*
    cylinder(d=a+2*(springTabThickness+springRadialTabClearance)+0.2,h=w);
    translate([0,0,-0.5]){
        cylinder(d=a,h=w+1);
        if(type=="odd"){
            makeInnerTabGaps(d=d,a=a);
        }
    }
*/
module makeInnerTabGaps(d,a) {
    difference() {
        for (i=[0:springInnerTabCount-1],an=i*360/springInnerTabCount) {
            rotate([0,0,an]) {
                translate([0,0,-1.5])
                linear_extrude(height=springTabHeight+1.5+springVerticalTabClearance) {
                    gapTriangle(springInnerTabGapAngle,d/2);
                }
                // make printing easier by eliminating part of the curved overhangs
                translate([0,0,-1.5])
                linear_extrude(height=springTabHeight+1.5+springVerticalTabClearance+springTabGapCurvedPartRemovalDepth) {
                    polygon(points=[[0,0],[a/2,-a/2],[a/2,a/2]]);
                }    
            }
        }
        difference() {
            translate([0,0,0])cylinder(d=d,h=springTabHeight+1);
            translate([0,0,-0.5])cylinder(d1=a+2*(springTabThickness+springRadialTabClearance)+1,d2=a+2*(springTabThickness+springRadialTabClearance),h=0.5+0.3*springTabHeight);
            cylinder(d=a+2*(springTabThickness+springRadialTabClearance),h=springTabHeight+0.5);
        }
    }
}    

module innerTabs(d=springDiameter,w=springBladeWidth,t=springBladeThickness,p=springBladePitch,m=springRimThickness,a=axleDiameter+2*axleClearance) {
    difference(){
        translate([0,0,-0.02])cylinder(d=a+2*m,h=springStackGap-springVerticalTabClearance+0.02);
        translate([0,0,-0.5]){
            cylinder(d=a,springStackGap+1);
        }
    }
    translate([0,0,springStackGap-springVerticalTabClearance]) {
        difference(){
            translate([0,0,-0.1])cylinder(d=a+2*springTabThickness,h=springTabHeight+springVerticalTabClearance+0.1);
            // chamfer top
            translate([0,0,0.7*springTabHeight])
            difference(){
                cylinder(d=a+2*springTabThickness+1,h=springTabHeight);
                cylinder(d1=a+2*springTabThickness,d2=a+2*springTabThickness-0.5*springTabHeight,h=springTabHeight);
            }
            translate([0,0,-0.52]){
                cylinder(d=a,h=w);
                for (i=[0:springInnerTabCount-1],a=(i+0.5)*360/springInnerTabCount) {
                    rotate([0,0,a]) {
                        linear_extrude(height=w) {
                            gapTriangle(360/springInnerTabCount-springInnerTabAngle,d/2);
                        }
                    }
                }
            }
        }
    }
}

module gapTriangle(a,r) {
    polygon(points=[[0,0],[r,r*tan(a/2)],[r,-r*tan(a/2)]]);
}


/*
    Make spring with inner and outer rims
    d:outer diameter
    w:blade width
    t:blade thickness
    p:spiral pitch
    a:diameter of hole for axle
    f:spring alternate (true/false)
    s:?
    g:spring stack gap
    m:rim thickness
    c:spring threshold space
*/
module singleSpringWithRings(d,w,t,p,a,f,s,g,m,c,rv) {
    h0=a/2+m+c;
    h1=d/2-m-c;
    delta=0.1;//
    difference() {
        union(){
            singleSpring(d=d-2*delta,w=w,t=t,m=m-2*delta,p=p,a=a+2*delta,f=f,h0=h0,h1=h1,rv=rv);
            ring(r=a/2,R=a/2+m,h=(s==1?w+g:w));
            ring(r=d/2-m,R=d/2,h=(s==2?w+g:w));
        }
    }
}

/*
    Make single spring spiral (without inner or outer ring)
    d=outer diameter
    w=blade width (height in this case)
    t=blade thickness
    m=rim thickness
    p=spiral pitch
    a=shaft diameter    
    f:flip
    h0:lower threshold
    h1:upper threshold
    rv:if true then reverse
*/
module singleSpring(d,w,t,m,p,a,f,h0,h1,rv){
    linear_extrude(height=w,convexity=8)
        springPolygon(r0=a/2,r1=d/2,t=t,m=m,p=p,f=f,h0=h0,h1=h1,rv=rv);
}

/*
    Make 2D spiral with pitch p, inner radius r0, outer radius r1, blade thickness t, rim thickness m, flip f (true/false), thresholds h0, h1
    For points r<h0 the r is set to r0
    For points r>h1 the r is set to r1
*/
module springPolygon(r0,r1,t,m,p,f,h0,h1,rv) {
    rstart = r0+m-t;
    rend = r1-m;
    aOffset=0;
    aExt=0;
    totalAngle=360*(rend-rstart)/p+aExt;
    s = (f?-1:1)*(rv?-1:1); // if flipped then the angle is negative
    nump=round($fn*totalAngle/360);
    polygon(points = concat(
    // polygon from two spirals: first from in to out, next from out to in
    // iterate angle from 0 to 360 * #loops with suitable step size and including range ends
    [for(i=[0:nump],a=i*totalAngle/nump+aOffset,r=rstart+p*a/360,r2=r<h0?r0:r>r1-m?r1-m:r)
        [r2*sin(s*a),r2*cos(s*a)]],
    [for(i=[nump:-1:0],a=i*totalAngle/nump+aOffset,r=rstart+p*a/360+t,r2=r<r0+m?r0+m:r>h1?r1:r)
        [r2*sin(s*a),r2*cos(s*a)]]
        ));
}

module ring(r,R,h){
    difference(){
        cylinder(r=R,h=h);
        translate([0,0,-0.5]) {
            cylinder(r=r,h=h+1);
        }
    }
}



/*
    Vincent's screw thread library
    
    This library outputs the desired thread as a single body without any Boolean operations.
    
    Different thread profiles can be chosen: sine, square, triangle, trapezoid and custom. A custom profile is defined by the power series of the harmonics, which can be obtained from the Fourier transformation of the desired thread profile.
    
    Common screw threads can be approximated using a trapezoid profile, but beware that it is not exact as the presented trapezoid profile differs slightly from the ISO thread specifications.
    
    Version history
    August 1, 2019: v1.0
       - First version
*/

/*
    size: outer diameter
    pitch: thread pitch
    depth: thread depth, set 0 for auto (which sets it to 0.541*pitch, as used in ISO threads)
    spiralCount: number of intertwining threads 
    length: the total length
    profile: "trapezoid","square","triangle","sine","custom"
    harmonics: array with coefficients of harmonic sine functions, in case profile="custom"
    fourierlen: the number of terms used in the Fourier series expansion
    np: number of points on perimeters
    nd: number of points in teeth profile (plus two)
*/
module thread(size,pitch,depth=0,spiralCount=1,length=10,profile="trapezoid",harmonics,fourierlen=50,np=$fn,nd=9) {
    lead=pitch*spiralCount;
    hh=(profile=="trapezoid"?[for(i=[0:fourierlen-1])i%2==0?0:((i-1)%8<4?1:-1)/(i*i)]:
        profile=="square"?[for(i=[0:fourierlen-1])i%2==0?0:4/(PI*i)]:
        profile=="triangle"?[for(i=[0:fourierlen-1])i%2==0?0:((i-1)%4<2?1:-1)/(i*i)]:
        profile=="sine"?[0,1]:
        profile=="custom"?harmonics:
        [1]);
    dp=depth>0?depth:pitch*5*sqrt(3)/16;
    scaleFactor=1/harmonicSum(harmonics=hh,phase=90);
    rev=length/lead+1;
    steps=floor(rev*np);

    intersection(){
        cylinder(d=size+2*dp,h=length,$fn=np);
    union(){
        translate([0,0,-pitch])cylinder(d=size-2*dp,h=length+2*pitch,$fn=np);
        translate([0,0,-pitch/2])
        for(sp=[0:spiralCount-1])
            rotate([0,0,sp*360/spiralCount])
            polyhedron(
                points=[for(i=[0:steps],a=i*360/np,z0=lead*i/np)each[
                [size/4*cos(a),size/4*sin(a),z0+pitch*((nd-2)/(nd-1)-0.5)],
                [size/4*cos(a),size/4*sin(a),z0-pitch*((nd-2)/(nd-1)-0.5)],
                for(j=[2:nd-1],phase=360*(j-1)/(nd-1)-90,r=size/2-dp/2+dp/2*scaleFactor*harmonicSum(harmonics=hh,phase=phase))
                    [r*cos(a),r*sin(a),z0+(phase-90)*pitch/360]
                ]],
                
                faces=[
                    for(j=[1:nd-2])[0,j+1,j],
                    for(i=[0:steps-1])
                        for(j=[0:nd-1])
                            each[[i*nd+j,i*nd+(j+1)%nd,(i+1)*nd+j],
                                 [i*nd+(j+1)%nd,(i+1)*nd+(j+1)%nd,(i+1)*nd+j]],
                    for(j=[1:nd-2])[nd*steps+0,nd*steps+j,nd*steps+j+1],
                ],
                convexity=8
            );
        }
    }
}

function harmonicSum(harmonics,i=0,phase,currentPhase=0)=(i>=len(harmonics)?0:harmonics[i]*sin(currentPhase)+harmonicSum(harmonics,i+1,phase,currentPhase+phase));
