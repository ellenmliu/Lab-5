function display_hist( hist )
size_h = size(hist);
colors = [[64,48,117];[99, 39, 112];[156, 52, 76];[170, 107, 57];[170, 138, 57];[170, 162, 57];[125, 159, 53];[41, 121, 76];[43, 75, 111]]/255;
colors = colors - repmat(sum(colors)/9,9,1);
colors = colors*1.7;
colors = colors + 0.5;
test = reshape ( hist,size_h(1)*size_h(2),size_h(3)) * colors;
test = reshape (test, size_h(1),size_h(2),3);

figure(1);
imshow(test);
figure(2);
circle(0,0,10,150,colors);
end

function h = circle(x,y,r,nsegments,colors)
if nargin<4
    nsegments=50;
end
diff = pi/9;
for i = 1:size(colors,1)
    hold on
    th = diff*(size(colors,1)-i):pi/nsegments:diff*(size(colors,1)-i+1);
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    h = plot(xunit, yunit, 'Color', colors(i,:), 'LineWidth', 5);
    hold off
end
end