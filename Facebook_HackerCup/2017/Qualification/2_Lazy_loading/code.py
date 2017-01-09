#!/usr/bin/env python

import math

f = open('lazy_loading.txt', 'r')
t = int(f.readline())
for i in range(1,t+1):
	output = "Case #" + str(i) + ": "
	n = int(f.readline())
	weights = []
	for i in range(n):
		weights.append(int(f.readline()))
	weights.sort()
	count = 0
	while ( len(weights) > 0 ):
		count += 1
		w = weights.pop()
		a = w
		while ( a < 50 ):
			if ( len(weights) == 0 ):
				count -= 1
				break
			weights.pop(0)
			a += w
	output += str(count)
	print output
