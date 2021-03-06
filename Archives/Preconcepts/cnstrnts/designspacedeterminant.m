function [vls]=designspacedeterminant
    d = dialog('Position',[300 100 250 500],...
        'Name','Design Space');

    txt = uicontrol('Parent',d,...
        'Style','text',...
        'Position',[20 440 210 40],...
        'String','Check Design Parameters to include');
    
    btn1 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 400 150 25],...
        'String','Takeoff',...
        'Callback',@vlupdate,...
        'Value',1);
    
    btn2 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 350 150 25],...
        'String','Cruise',...
        'Callback',@vlupdate,...
        'Value',1);
    
    btn3 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 300 150 25],...
        'String','Ceiling_{Service}',...
        'Callback',@vlupdate,...
        'Value',1);
    
    btn4 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 250 150 25],...
        'String','Ceiling_{Cruise}',...
        'Callback',@vlupdate);
    
    btn5 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 200 150 25],...
        'String','2.5g @ SL',...
        'Callback',@vlupdate);
    
    btn6 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 150 150 25],...
        'String','Range',...
        'Callback',@vlupdate,...
        'Value',1);
    
    btn7 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 100 150 25],...
        'String','Stall',...
        'Callback',@vlupdate);
    
    btn8 = uicontrol('Parent',d,...
        'Style','checkbox',...
        'Position',[85 50 150 25],...
        'String','Landing',...
        'Callback',@vlupdate);
    
    uicontrol('Parent',d,...
        'Position',[85 10 70 25],...
        'String','Execute',...
        'Callback','delete(gcf)');
    
    vls=[get([btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8],'Value')];
    
    function vlupdate(src,cllbck)
        vls=[get([btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8],'Value')];
    end
    waitfor(d)
end