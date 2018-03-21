--Title: Numeric Textfield
--Name: Valeria Veverita
--Course: ICS2O
--This program displays a math question and ask the user to answer in a numeric texfield. 

--hide the status bar 
display.setStatusBar(display.HiddenStatusBar)
--set the background color
local background = display.setDefault("background", 255/255, 195/255, 0/255)

-------------------------------------------------------------------------------------------------------------------------
--LOCAL VARIABLES
-------------------------------------------------------------------------------------------------------------------------

--create loocal variables
local questionObject
local correctObject
local numericField
local number1
local number2
local userAnswer
local correctAnswer
local counter = 0

---------------------------------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
---------------------------------------------------------------------------------------------------------------

local function AskQuestion()
	-- generate 2 random numbers between a max amd a min number
	number1 = math.random(0,100)
	number2 = math.random(0, 100)
   
    correctAnswer = number1 + number2
   
    --create question in text object
    questionObject = number1 .. "+" .. number2 .. "="
    
   
end

local function HideCorrrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function NumericFieldListener (event)
	--User begin editing "numericField"
	if (event.phase == " began") then

		--clear text field
		event.target.text = ""

	elseif (event.phase == "submitted") then

		--wneh the answer is submitted(enter key is pressed) set user's input to user's answer
        userAnswer = tonumber(event.target.text)

        -- is the user's answer and the correct answer are the same:
        if (userAnswer == correctAnswer) then
            correctObject.isVisible = true
            timer.performWithDelay(2000, HideCorrect)
        end
    end
end

----------------------------------------------------------------------------------------------------
--OBJECT CREATION
-----------------------------------------------------------------------------------------------------

--displays a question and sets its color
questionObject = display.newText("", display.contentWidth/3, display.contentHeight/2, nil, 50)
questionObject:setTextColor(155/255, 42/255, 198/255)

---create the correct text object and makes it invisible
correctObject = display.newText("Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50)
correctObject:setTextColor(155/255, 42/255, 198/255)
correctObject.isVisible = false

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