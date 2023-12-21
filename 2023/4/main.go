package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func evaluateLine(line string) int{
  cleanedString := strings.Replace(line, "  ", " ", -1)
  card := strings.Split(cleanedString, ": ")
  winningNumbers, myNumbers := getNumbersFromCard(card)
  return calculatePoints(winningNumbers, myNumbers)
}

func getNumbersFromCard(card []string) ([]string, []string) {
  numbers := strings.Split(card[1], " | ")
  winningNumbers := strings.Split(numbers[0], " ")
  myNumbers := strings.Split(numbers[1], " ")
  return winningNumbers, myNumbers
}

func calculatePoints(winningNumbers []string, myNumbers []string) int {
  points := 0
  for i := 0; i < len(myNumbers); i++ {
    number := myNumbers[i]
    if (arrayContainsElement(winningNumbers, number)){
      points = calculateNewPoints(points)
    }
  }
  return points
}

func calculateNewPoints(points int) int{
  if (points > 0){
    return points * 2
  }
  return 1
}

func arrayContainsElement(array []string, element string) bool {
  contains := false
  index := 0
  for (contains == false && index < len(array)){
    contains = array[index] == element
    index = index + 1
  }
  return contains
}


func main() {
	file, err := os.Open("./input.txt")
	if err != nil {
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

	var total int

	for scanner.Scan() {
		total += evaluateLine(scanner.Text())
	}

	fmt.Println(total)
}
