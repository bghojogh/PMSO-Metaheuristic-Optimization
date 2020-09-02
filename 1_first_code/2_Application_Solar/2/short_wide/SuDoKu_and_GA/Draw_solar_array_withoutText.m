function Draw_solar_array_withoutText(k_of_cells, number_of_rows, number_of_columns)
    for column = 1:number_of_columns
        for row = 1:number_of_rows
            x1 = column;
            x2 = column+1;
            y1 = number_of_rows+1-(row-1);
            y2 = number_of_rows+1-row;
            switch k_of_cells(row,column)
                case 0.9
                    Color = [1,1,1];
                case 0.6
                    Color = [0.8,0.8,0.8];
                case 0.4
                    Color = [0.5,0.5,0.5];
                case 0.2
                    Color = [0.3,0.3,0.3];
            end
            X=[x1 x2 x2 x1];
            Y=[y1 y1 y2 y2];
            hold on
            fill(X,Y,Color)
            xm=(x1+x2)/2;
            ym=(y1+y2)/2;
            str = sprintf('%d%d',row,column);
%             text(xm,ym,num2str(column),...
%                 'FontWeight','bold',...
%                 'HorizontalAlignment','center',...
%                 'VerticalAlignment','middle');
%             text(xm,ym,str,...
%                 'FontWeight','bold',...
%                 'HorizontalAlignment','center',...
%                 'VerticalAlignment','middle');
        end
    end
end