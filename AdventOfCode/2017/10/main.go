package main

import (
	"fmt"
	"strconv"
	"strings"
)

func rotate(list []int, start int, l int) []int {
	for i := 0; i < l/2; i = i + 1 {
		x := (start + i) % len(list)
		y := (start + l - 1 - i) % len(list)
		list[x], list[y] = list[y], list[x]
	}
	return list
}

func solve(n int, in []string) int {
	list := make([]int, n)
	for i := range list {
		list[i] = i
	}
	skip := 0
	curr := 0
	for _, val := range in {
		l, _ := strconv.Atoi(val)
		list = rotate(list, curr, l)
		curr = (curr + l + skip) % n
		skip = skip + 1
	}
	return list[0]*list[1]
}

func solve2(n int, s string) string {
	in := []byte(s)
	list := make([]int, n)
	for i := range list {
		list[i] = i
	}
	in = append(in, byte(17))
	in = append(in, byte(31))
	in = append(in, byte(73))
	in = append(in, byte(47))
	in = append(in, byte(23))
	skip := 0
	curr := 0
	for i := 0; i < 64; i = i + 1 {
		for _, val := range in {
			l := int(val)
			list = rotate(list, curr, l)
			curr = (curr + l + skip) % n
			skip = skip + 1
		}
	}
	res := make([]string, 0)
	for i := 0; i < 16; i = i + 1 {
		xor := 0
		for j := 0; j < 16; j = j + 1 {
			xor = xor ^ list[i*16+j]
		}
		r := fmt.Sprintf("%02v", strconv.FormatInt(int64(xor), 16))
		res = append(res, r)
	}
	return strings.Join(res, "")
}

func main() {
	ins := `3, 4, 1, 5`
	fmt.Println(solve(5, strings.Split(ins, ", ")))
	inl := `199,0,255,136,174,254,227,16,51,85,1,2,22,17,7,192`
	fmt.Println(solve(256, strings.Split(inl, ",")))
	fmt.Println(solve2(256, ""))
	fmt.Println(solve2(256, "AoC 2017"))
	fmt.Println(solve2(256, "1,2,3"))
	fmt.Println(solve2(256, "1,2,4"))
	fmt.Println(solve2(256, inl))
}
