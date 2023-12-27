const fs = require('fs');

const allFileContents = fs.readFileSync('input.txt', 'utf-8');

function solve(){
  const [ timeLine, distanceLine ]= allFileContents.split(/\r?\n/)
  const timeValues = getValuesForLine(timeLine)
  const distanceValues = getValuesForLine(distanceLine)
  return getMarginOfErrorForRaces(timeValues, distanceValues)
}

function getValuesForLine(line){
  const [ suffix, valuesString ] = line.split(":")
  return valuesString.trim().split("   ")
}

function getMarginOfErrorForRaces(timeValues, distanceValues){
  var marginOfError = 0;
  for (var raceIndex=0; raceIndex < timeValues.length; raceIndex ++){
    const raceTime = Number(timeValues[raceIndex].trim()) 
    const bestDistance = Number(distanceValues[raceIndex].trim())
    const numberOfOptions = calculateNumberOfOptions(raceTime, bestDistance)
    marginOfError = marginOfError === 0 ? numberOfOptions : marginOfError * numberOfOptions
  }
  return marginOfError
}

function calculateNumberOfOptions(raceTime, bestDistance){
  var options = 0; 
  for (var speed = 0; speed < raceTime; speed ++){
    const timeRemainingAfterHoldingButton = raceTime - speed
    const distanceTravelled = timeRemainingAfterHoldingButton * speed
    if (distanceTravelled > bestDistance){
      options += 1
    }
  }
  return options
}

const solution = solve()
console.log(solution)
