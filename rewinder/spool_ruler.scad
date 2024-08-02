

// Set quality to high - so circles are circles.
$fn = 10;

ruler();

minDiameter = 48;
maxDiameter = 60;
increment = 0.5;
stepDepth = 2.5;

module ruler()
{

	leftSide = 0;

	difference()
	{
		union()
		{
			for (i = [minDiameter:increment:maxDiameter])
			{

				stepNumber = (i - minDiameter) / increment;
				xOffset = (maxDiameter - i) / 2;
				translate([ xOffset, stepNumber * stepDepth, 0 ])
				{
					cube([ i, stepDepth, 2 ]);
			
				}
				horiz_alignment =  (abs(i - floor(i)) < 0.1 ) ? "left" : "right";
				position = (abs(i - floor(i)) < 0.1 ) ? xOffset + 1 : maxDiameter - xOffset - 1;
				text_string = (abs(i - floor(i)) < 0.1 )  ?  str("_",i) : str(i,"_");

				translate([ position, (stepNumber +1) * stepDepth, 0 ])
					linear_extrude(height=2.5)
						text(size =stepDepth*2-1, text=text_string, halign=horiz_alignment);
			}
			translate([ 0, ((maxDiameter-minDiameter)/increment + 1) * stepDepth, 0 ])
				cube([ maxDiameter , stepDepth*2, 2 ]);

		}
	}
}
