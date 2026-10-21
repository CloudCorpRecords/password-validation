package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	readLine := func() string {
		line, _ := reader.ReadString('\n')
		return strings.TrimRight(line, "\r\n")
	}
	readList := func() []string {
		n, _ := strconv.Atoi(readLine())
		items := make([]string, n)
		for i := range items {
			items[i] = readLine()
		}
		return items
	}

	passwords := readList()
	commonWords := readList()
	for _, r := range GetPasswordStrength(passwords, commonWords) {
		fmt.Println(r)
	}
}
