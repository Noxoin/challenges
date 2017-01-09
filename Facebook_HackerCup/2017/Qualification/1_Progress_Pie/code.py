#!/usr/bin/env python

import math

f = open('progress_pie.txt', 'r')
n = int(f.readline())
for i in range(1,n+1):
	output = "Case #" + str(i) + ": "
	p, x, y = f.readline().split()
	p = int(p)
	x = int(x)
	y = int(y)
	if ( (x-50)**2 + (y-50)**2 > 2500 ) :
		output += "white"
	else :
		pAngle = 360*(p/100.0)
		a2 = (50-50)**2 + (100-50)**2
		b2 = (50-x)**2 + (50-y)**2
		c2 = (50-x)**2 + (100-y)**2
		dotAngle = math.acos((c2 - a2 - b2)/100/math.sqrt(b2)*(-1))
		dotAngle = math.degrees(dotAngle)
		if ( x < 50 ):
			dotAngle = 360 - dotAngle
		if ( pAngle < dotAngle ):
			output += "white"
		else:
			output += "black"
	print output
