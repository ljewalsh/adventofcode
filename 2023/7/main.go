package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"slices"
	"strconv"
)

var CardValues = map[string]int{
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "T": 10,
    "J": 11,
    "Q": 12,
    "K": 13,
    "A": 14,
}

func byRank(A, B []interface{}) int {
  cardsA := A[0].([]string); 
  cardsB := B[0].([]string);
  cardsAScore := getCardsScore(cardsA)
  cardsBScore := getCardsScore(cardsB)
  if (cardsAScore == cardsBScore){
    return compareCards(cardsA, cardsB)
  }
  return cardsAScore - cardsBScore
}

func compareCards(cardsA, cardsB [] string) int {
  index := 0;
  rank := 0;
  for (index < len(cardsA) && rank == 0){
    cardA := cardsA[index]
    cardB := cardsB[index]
    rank = calculateRank(cardA, cardB)
    index = index + 1
  }
  return rank
}

func calculateRank(cardA string, cardB string) int {
  if (cardA == cardB){
    return 0
  }
  cardAValue := CardValues[cardA]
  cardBValue := CardValues[cardB]
  return cardAValue - cardBValue
}

func getCardsScore(cards []string) int {
  score := 5;
  var cardsByType = make(map[string]int);
  for i := 0; i < len(cards); i++ {
    card := cards[i]
    cardQuantity, ok := cardsByType[card]
    score = getNewScore(ok, cardQuantity, score)
    cardsByType[card] = getNewCardQuantity(ok, cardQuantity);
  }
  return score
}

func getNewCardQuantity(ok bool, cardQuantity int) int {
  if (!ok) {
    return 1
  }
  return cardQuantity + 1
}

func getNewScore(ok bool, cardQuantity, score int) int {
  if (!ok){
    return score - 1;
  }
  return score + cardQuantity - 1
}

func evaluateLine(line string) ([]string, string){
  splitLine := strings.Split(line, " ");
  cards := splitLine[0];
  bets := splitLine[1];
  return strings.Split(cards, ""), bets
}

func main() {
	file, err := os.Open("./input.txt")
	if err != nil {
		os.Exit(1)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)

  var cards [][]interface{}
	for scanner.Scan() {
	  evaluatedCards, bet := evaluateLine(scanner.Text())
	  cardsAndBet := []interface{}{evaluatedCards, bet}
		cards = append(cards, cardsAndBet)
	}

	slices.SortFunc(cards, byRank)

  total := 0;
  for i := 0; i < len(cards); i++ {
    cardData := cards[i]
    bet := cardData[1].(string)
    betAsInteger, _ := strconv.Atoi(bet) 
    winnings := (i + 1) * betAsInteger
    total = total + winnings
  }
  fmt.Println(total)
}
