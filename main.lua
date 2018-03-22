--Title: Numeric Textfield
--Name: Valeria Veverita
--Course: ICS2O
--This program displays a math question and ask the user to answer in a numeric texfield. 


--hide the status bar 
display.setStatusBar(display.HiddenStatusBar)

--set the background color
local background = display.setDefault("background", 10/255, 20/255, 50/255)

-------------------------------------------------------------------------------------------------------------------------
--LOCAL VARIABLES
-------------------------------------------------------------------------------------------------------------------------

--create loocal variables
local questionObject
local correctObject
local incorrectObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local randomOperator
local pointsObject 
local points = 0 



---------------------------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
---------------------------------------------------------------------------------------------------------------
   
local function AskQuestion()
	-- generate 2 random numbers between a max amd a min number
	randomNumber1 = math.random(0,10)
	randomNumber2 = math.random(0, 10)
	randomOperator = math.random(1,4)
	

    if (randomOperator == 1) then
       correctAnswer = randomNumber1 + randomNumber2
       --create question in text object
        questionObject.text = randomNumber1 .. "+" .. randomNumber2 .. "=" 
    elseif (randomOperator == 2) then
    	correctAnswer = randomNumber1 - randomNumber2 
    	--create qustion in text object
        questionObject.text = randomNumber1 .."-" .. randomNumber2 .. "="
    elseif (randomOperator == 3) then
    	correctAnswer = randomNumber1 * randomNumber2 
    	--create qustion in text object
        questionObject.text = randomNumber1 .."*" .. randomNumber2 .. "="
    elseif (randomOperator == 4) then
       correctAnswer = randomNumber1 / randomNumber2
       --create qustion in text object
        questionObject.text = randomNumber1 .."/" .. randomNumber2 .. "="
    end

end

local function HideCorrect()
	correctObject.isVisible = false
	AskQuestion() 
	
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener (event)

	--User begin editing "numericField"
	if (event.phase == " began") then


	elseif event.phase == "submitted" then

		--wneh the answer is submitted(enter key is pressed) set user's input to user's answer
        userAnswer = tonumber(event.target.text)

        -- is the user's answer and the correct answer are the same:
        if (userAnswer == correctAnswer) then
            correctObject.isVisible = true
            timer.performWithDelay(2000, HideCorrect)
            --clear the text field

            event.target.text = ""

            points = points + 1 
            pointsObject.text = "Points =" ..points
        else 
        	incorrectObject.isVisible = true
        	timer.performWithDelay(2000, HideIncorrect)
        	--clear the text field
        	event.target.text = ""

        	
        end
    end
end

----------------------------------------------------------------------------------------------------
--OBJECT CREATION
-----------------------------------------------------------------------------------------------------

--displays a question and sets its color
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObject:setTextColor(255/255, 195/255, 0/255)

--displays a question and sets its color
pointsObject = display.newText("Points = 0",150, 50, nil, 50)
pointsObject:setTextColor(255/255, 195/255, 0/255)

---create the correct text object and makes it invisible
correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(255/255, 195/255, 0/255)
correctObject.isVisible = false

--create the correct text object and makes it invisible
incorrectObject = display.newText("Incorrect!", display.contentWidth/2, display.contentWidth*2/3, nil, 50)
incorrectObject:setTextColor(255/255, 195/255, 0/255)
incorrectObject.isVisible = false
--create numeric field
numericField = native.newTextField( display.contentWidth/2, display.contentHeight/2, 150, 80)
numericField.inputType = "number"

--add the event listener to the numeric field
numericField:addEventListener("userInput", NumericFieldListener)

---------------------------------------------------------------------------------------------------------------
--FUNCTION CALLS
---------------------------------------------------------------------------------------------------------------

--call the function to ask the question
AskQuestion()