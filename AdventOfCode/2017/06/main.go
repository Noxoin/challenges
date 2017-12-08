package main

import (
	"fmt"
	"strconv"
	"strings"
)

func solve(in []int) int {
	cycle := 0
	seen := make(map[string]bool)
	for !seen[fmt.Sprintf("%v", in)] {
		seen[fmt.Sprintf("%v", in)] = true
		max, c := 0, 0
		for i, v := range in {
			if v > max {
				max, c = v, i
			}
		}
		in[c] = 0
		c = (c + 1) % len(in)
		for ; max > 0; max = max - 1 {
			in[c] = in[c] + 1
			c = (c + 1) % len(in)
		}
		cycle = cycle + 1
	}
	return cycle
}

func solve2(in []int) int {
	cycle := 1
	seen := make(map[string]int)
	for seen[fmt.Sprintf("%v", in)] == 0 {
		seen[fmt.Sprintf("%v", in)] = cycle
		max, c := 0, 0
		for i, v := range in {
			if v > max {
				max, c = v, i
			}
		}
		in[c] = 0
		c = (c + 1) % len(in)
		for ; max > 0; max = max - 1 {
			in[c] = in[c] + 1
			c = (c + 1) % len(in)
		}
		cycle = cycle + 1
	}
	return cycle - seen[fmt.Sprintf("%v", in)]
}

func main() {
	//s := "0	2	7	0"
	s := "0	5	10	0	11	14	13	4	11	8	8	7	1	4	12	11"
	in := make([]int, 0)
	for _, v := range strings.Split(s, "\t") {
		i, _ := strconv.Atoi(v)
		in = append(in, i)
	}
	fmt.Println(solve(in))
	fmt.Println(solve2(in))
}

