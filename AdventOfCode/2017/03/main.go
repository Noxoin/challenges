package main

import (
	"fmt"
)

func solve(n int) int {
	if n == 1 {
		return 0
	}
	dist := 0
	sq := 1
	for ; n > sq*sq; sq = sq+2 {
		dist = dist + 1
	}
	cornerNum := sq*sq
	for ; cornerNum - sq + 1 >= n; cornerNum = cornerNum - sq + 1 {
	}
	diff := cornerNum - n
	if diff > sq/2 {
		diff = diff - sq/2
	}
	return dist + sq/2 - diff
}

func sum(grid [][]int, x int, y int) int {
	sum := grid[x-1][y-1] +
		grid[x-1][y] +
		grid[x-1][y+1] +
		grid[x][y-1] +
		grid[x][y+1] +
		grid[x+1][y-1] +
		grid[x+1][y] +
		grid[x+1][y+1]
	return sum
}

func solve2(n int) int {
	var grid [][]int
	grid = make([][]int, 20)
	for row := range grid {
		grid[row] = make([]int, 20)
	}
	x := 10
	y := 10
	grid[x][y] = 1
	for {
		// Down, Next Right
		for grid[x+1][y] != 0 {
			y = y + 1
			grid[x][y] = sum(grid, x, y)
			if grid[x][y] > n {
				return grid[x][y]
			}
		}
		x = x + 1
		grid[x][y] = sum(grid, x, y)
		if grid[x][y] > n {
			return grid[x][y]
		}
		// Right, Next Up
		for grid[x][y-1] != 0 {
			x = x + 1
			grid[x][y] = sum(grid, x, y)
			if grid[x][y] > n {
				return grid[x][y]
			}
		}
		y = y - 1
		grid[x][y] = sum(grid, x, y)
		if grid[x][y] > n {
			return grid[x][y]
		}
		// Up, Next Left
		for grid[x-1][y] != 0 {
			y = y - 1
			grid[x][y] = sum(grid, x, y)
			if grid[x][y] > n {
				return grid[x][y]
			}
		}
		x = x - 1
		grid[x][y] = sum(grid, x, y)
		if grid[x][y] > n {
			return grid[x][y]
		}
		// Left, Next Down
		for grid[x][y+1] != 0 {
			x = x - 1
			grid[x][y] = sum(grid, x, y)
			if grid[x][y] > n {
				return grid[x][y]
			}
		}
		y = y + 1
		grid[x][y] = sum(grid, x, y)
		if grid[x][y] > n {
			return grid[x][y]
		}
	}
}

func main() {
	// fmt.Println(solve(1))
	// fmt.Println(solve(2))
	// fmt.Println(solve(3))
	// fmt.Println(solve(4))
	// fmt.Println(solve(5))
	// fmt.Println(solve(6))
	// fmt.Println(solve(7))
	// fmt.Println(solve(8))
	// fmt.Println(solve(9))
	// fmt.Println(solve(12))
	// fmt.Println(solve(22))
	// fmt.Println(solve(1024))
	// fmt.Println(solve(265149))
	fmt.Println(solve2(265149))
}
