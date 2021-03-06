clear;
close all;
clc;


% Global Count
global WinnerCount_X;
global WinnerCount_O;
global Tie;
WinnerCount_X=0;
WinnerCount_O=0;
Tie=0;

% start the app
start();




function start()

fprintf("Well Come to Tic Tac Toe Game\n");


while(true)
    fprintf("\nEnter 1 for Play and 2 for End\n");
    fprintf("Enter 2 for Display Game Win Borad\n");
    fprintf("Enter 3 for End\n");
    
    choice=input("Enter: ");
    
    if choice==1
        TicTacToe_Game()
    elseif choice==2
        ShowWinnerBord()
    else 
       break;
    end
end

end





function  TicTacToe_Game()
    global WinnerCount_X;
    global WinnerCount_O;
    global Tie;

    % Create Game Figure
    f1=figure('Name','Tic Tac Toe');
    
    % Creating 2-d xy line plot
    plot(1)
    
    % Creating 3x3 Grid in plot
    axis([0 3 0 3])
    
    % set the grid line in  x
    set(gca,'xTick',0:3)
    % set the grid line in y
    set(gca,'yTick',0:3)
    
    xlabel('Player: X')
    % Show Grid in Plot
    grid on
    
  
    is_x = 1;
    winner = -1;
    
    
    % the state of the game (-1 none, 0 = 0, 1 = X)
    state = [[-1 -1 -1]
             [-1 -1 -1]
             [-1 -1 -1]]; 

    

    % Run Till There is No Winner
    while winner == -1

        % make choice
        next = play(is_x, state); 

        % if the player clicks on a filled in slot, ask them to try again
        if next == -1
           title('Invalid move, please try again');

        else
           state = next; % advance the current state
          
           
           is_x = mod(is_x + 1,2); % pick the next player and update the player label
           
           if is_x == 1
               xlabel('Player: X');
           else
               xlabel('Player: O');
           end

           % cheking if there is Winner
           winner = isWin(state);

        end
    end
    
    if winner == 0 % O won
        WinnerCount_O=WinnerCount_O+1;
        warndlg('O wins');
        title('O wins');
        xlabel('');
    elseif winner == 1 % X won
        WinnerCount_X=WinnerCount_X+1;
        warndlg('X wins');
        title('X wins');
        xlabel('');
    else % else it's a tie
        Tie=Tie+1;
        warndlg('Tie');
        title('Tie');
        xlabel('');
    end
end




% The state function takes in the current player and the previous state the
function state = play(is_x, state)

    % get the mouse position with respect to the plot. will retuen the (x,y) 
    % of user click
    [x, y] = ginput(1); 

    % get the corresponding row/col (note row starts off with 0 at the bottom)
    [col, row] = position(x, y);

    
    if state(col+1, row+1) ~= -1 % if the player tries to click on a filled spot
        state = -1; % invalid, ask the player to try again
    else
        % set the state and draw the X and the O
        state(col+1, row+1) = is_x; 

        if is_x
            % draw X
            drawX(col, row);
        else
            % drew Y
            drawO(col, row);
        end
    end
end



% Returns the rounded off position of the mouse
function [col, row] = position(x, y)
    col = floor(x);
    row = floor(y);
end



function drawX(col, row)
    hold on
    x = 0:1;
    pos = 0:1;
    neg = 1-x;
    % draw the two line
    plot(x+col, pos+row)
    plot(x+col, neg+row)
    hold off
end




function drawO(col, row)
    hold on
    th = 0:pi/50:2*pi;
    r=.5;

    % r radius cricle with clenter (col+0.5, row+0.5)
    xunit = r * cos(th) + col+0.5;
    yunit = r * sin(th) + row+0.5;
    h = plot(xunit, yunit);

    hold off
end



% The isWin function calculates if any player win the game out not

function won = isWin(state)

    % Row
    if (state(1,1) == state(1,2) && state(1,1) == state(1,3) && state(1,1) ~= -1)
        won = state(1,1);
    elseif (state(2,1) == state(2,2) && state(2,1) == state(2,3) && state(2,1) ~= -1)
        won = state(2,1);
    elseif (state(3,1) == state(3,2) && state(3,1) == state(3,3) && state(3,1) ~= -1)
        won = state(3,1);
   
    % Cloumn
    elseif (state(1,1) == state(2,1) && state(1,1) == state(3,1) && state(3,1) ~= -1) 
        won = state(1,1);
    elseif (state(1,2) == state(2,2) && state(1,2) == state(3,2) && state(1,2) ~= -1) 
        won = state(1,2);
    elseif (state(1,3) == state(2,3) && state(1,3) == state(3,3) && state(1,3) ~= -1) 
        won = state(1,3);
    
    % Diagonal
    elseif (state(1,1) == state(2,2) && state(1,1) == state(3,3) && state(1,1) ~= -1)
        won = state(1,1);
    elseif (state(1,3) == state(2,2) && state(1,3) == state(3,1) && state(2,2) ~= -1)
        won = state(1,3);
   
    % If no more slots are open, it's a tie
    elseif ~ismember(state, -1)
        won = 2;
    
    % no winner till this point
    else
        won = -1;
    end
end


function ShowWinnerBord()
global WinnerCount_X;
global WinnerCount_O;
global Tie;

Total=WinnerCount_O+WinnerCount_X+Tie;

fprintf("\n Total: %d \n",Total);
fprintf(" X Win: %d \n",WinnerCount_X);
fprintf(" O Win: %d \n",WinnerCount_O);
fprintf(" Tie : %d \n",Tie);
end

