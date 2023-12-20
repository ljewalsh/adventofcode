const fs = require('fs');

const allFileContents = fs.readFileSync('parts.txt', 'utf-8');

const digits = ["0", "1","2","3","4","5","6","7","8","9"]
const symbols = ['*', '@', '#', '$','+', '%', '/', '&','=', '-']

function findNumbers(){
  const matrix = createMatrix();
  let numbers = []
  for (var x = 0; x < matrix.length; x++){
    const line = matrix[x]
    const numbersInLine = findNumbersInLine(x, line, matrix)
    numbers = [...numbers, ...numbersInLine]
  }
  return numbers
}

function findNumbersInLine(x, line, matrix){
  let number = ""
  let nextToSymbol = false;
  const numbers = []
  for (var y = 0; y < line.length; y++){
    const char = line[y]
    const isDigit = digits.includes(char)
    const isSymbol = symbols.includes(char)
    if (isDigit){
      number = number.concat(char)
      nextToSymbol = nextToSymbol || isNumberNextToSymbol(x, y, matrix)
    }
    if (char === "." || isSymbol || y == line.length - 1){
      if (number !== "" && nextToSymbol){
        numbers.push(number)
      }
      number = "";
      nextToSymbol = false;
    }
  }
  return numbers
}

function isNumberNextToSymbol(x,y, matrix){
  let nextToSymbol = false;
  for (let i = x - 1; i <= x + 1; i++) {
    for (let j = y - 1; j <= y + 1; j++){
      const line = matrix[i]
      if (line != null){
        const char = line[j]
        if (char != null){
          nextToSymbol = nextToSymbol || symbols.includes(char)
        }
      }
    }
  }
  return nextToSymbol
}

function createMatrix(){
  const lines = allFileContents.split(/\r?\n/)
  const matrix = lines.map(line =>  {
    return line.split("")
  });
  return matrix;
}

const sumOfPartNumbers = findNumbers().reduce((partialSum, a) => partialSum + Number(a), 0);

console.log(sumOfPartNumbers)
