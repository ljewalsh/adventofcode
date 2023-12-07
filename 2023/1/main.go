package main

import (
    "fmt"
    "os"
    "bufio"
    "regexp"
    "strconv"
)

func evaluateLine(line string) int {
  r := regexp.MustCompile(`\d`)
  numbersInLine := r.FindAllString(line, -1)
  firstNumber, _ := strconv.Atoi(numbersInLine[0])
  lastNumber, _ := strconv.Atoi(numbersInLine[len(numbersInLine) - 1])
  return firstNumber * 10 + lastNumber
}

func main(){
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
