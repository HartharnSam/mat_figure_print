function figure_print_format(fig_hand, fontsize)
%FIGURE_PRINT_FORMAT - Formats the figure nicely ready for printing
%Changes to LaTeX like text, at appropriate text size, sets a nice line
%width, box outline, ticks, etc.
%
% Syntax: figure_print_format(fig_hand)
%
% Inputs:
%    fig_hand - Figure Handle
%    font_size = Font size for 
%
% Example:
%    figure_print_format(fig1);
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: figure_defaults
% Author: Sam Hartharn-Evans, based on SPINSmatlab figure_defaults (David
% Deepwell, 2016)
% Department of Geography & Environmental Sciences, Northumbria University
% email address: sam.hartharn-evans@northumbria.ac.uk
% GitHub: https://github.com/HartharnSam
% 15-Dec-2020; Last revision: 03-Jul-2025
% MATLAB Version: 23.2.0.2668659 (R2023b) Update 9

if nargin == 0
    fig_hand = gcf;
end

% settings
if nargin < 2
    fontsize = get(0, 'defaultaxesfontsize');
end

% get figure children
childs = allchild(fig_hand);

% Change axis
ax = findobj(childs,'Type','Axes');
if ~isempty(ax)
    for ii = 1:length(ax)
        if ~strcmp(ax(ii).Type, 'axestoolbar')
            % change font size and font
            ax(ii).FontSize = fontsize;
            ax(ii).FontName = 'Arial';
            ax(ii).XLabel.Interpreter = 'Latex';
            ax(ii).YLabel.Interpreter = 'Latex';
            ax(ii).TickLabelInterpreter = 'Latex';
            ax(ii).Title.FontSize = fontsize;
           
            % change axis outline
            set(ax(ii),'layer','top');
            ax(ii).Box = 'on';
            ax(ii).Toolbar.Visible = 'off';
            
            % Get rid of the annoying exponent thing
            for i = 1:length(ax(ii).YAxis)
                ax(ii).YAxis(i).Exponent = 0;
            end
            for i = 1:length(ax(ii).XAxis)
                ax(ii).XAxis(i).Exponent = 0;
            end
            
            % Set the line width & Marker size
            ax(ii).LineWidth = 1.5;
            for i = 1:length(ax(ii).Children)
                if strcmp(class(ax(ii).Children(i)), 'matlab.graphics.chart.primitive.Line')
                    ax(ii).Children(i).LineWidth = 1.5;
                end
                if isfield(ax(ii).Children(i), 'MarkerFaceColor')
                    ax(ii).Children(i).MarkerFaceColor = ax(ii).Children(i).Color;
                end
            end
            
            % remove line colour on contourf plots
            for jj = 1:length(ax(ii).Children)
                if strcmp(ax(ii).Children(jj).Type, 'contour') ...
                        && strcmp(ax(ii).Children(jj).Fill, 'on')
                    ax(ii).Children(jj).LineStyle = 'none';
                end
            end
        end
    end
end

% Change colorbar
cbar = findobj(childs,'Type','ColorBar');
if ~isempty(cbar)
    for ii = 1:length(cbar)
        cbar(ii).TickLabelInterpreter = 'Latex';
        cbar(ii).Label.Interpreter = 'Latex';
        cbar(ii).FontSize = fontsize;
        
    end
end

% Change legend
leg = findobj(childs,'Type','Legend');
if ~isempty(leg)
    for ii = 1:length(leg)
        leg(ii).Interpreter = 'Latex';
    end
end

% Change text size
text_hand = findall(fig_hand, 'Type', 'Text');
%texthands = texthands(~strcmp(get(texthands,'string'),''));
set(text_hand, 'Interpreter', 'Latex',...
    'Fontsize',fontsize)

%% Set some other things
settings = struct('DefaultLineLineWidth',1, 'DefaultTextFontWeight','normal',...
    'DefaultAxesFontWeight','normal', 'defaultfigurecolor', 'w',...
    'DefaultAxesTickDir', 'in');

fields = fieldnames(settings);
for i = 1:length(fields)
    str = strjoin(['settings.', fields(i),';'], '');
    set(fig_hand, fields{i}, eval(str));
end

drawnow;


