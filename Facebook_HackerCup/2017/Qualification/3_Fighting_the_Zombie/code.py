#!/usr/bin/env python

import re

f = open('fighting_the_zombie.txt', 'r')
t = int(f.readline())
for i in range(1,t+1):
	output = "Case #" + str(i) + ": {:.6f}"
	h, s = f.readline().split()
	spells = f.readline().split()
	h = int(h)
	s = int(s)
	prob = 0
	for spell in spells:
		matchObj = re.match('(\d+)d(\d+)(.*)',spell)
		x = int(matchObj.group(1))
		y = int(matchObj.group(2))
		z = matchObj.group(3)
		health = h
		if ( z != "" ):
			z = int(z)
			health -= z
		if ( health-x <= 0 ):
			prob = 1
			break

		outcomes = []
		for i in range(y):
			outcomes.append(1)

		for i in range(x-1):
			tmp = []
			for j in range(len(outcomes)+y-1):
				tmp.append(0)
			for j in range(y):
				for k in range(len(outcomes)):
					tmp[j+k] += outcomes[k]
			outcomes = list(tmp)

		health -= x
		killCount = 0
		count = 0
		for i in range(len(outcomes)):
			count += outcomes[i]
			if (health - i) < 1:
				killCount += outcomes[i]
		p = killCount*1.0/count
		if ( prob < p ):
			prob = p
	print output.format(prob)
