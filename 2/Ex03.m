clear
close all
clc


h = [0.25, 0.5, 0.25];
y = zeros(1, 52);

for n = 0:51
    total = 0;
    for i = 0:2
        total = total + h(i+1) * x(n-i);
    end
    y(n+1) = total;
end

x_list = zeros(1, 50);
for n = 1:50
    x_list(n) = x(n-1);
end
y_true = conv(x_list, h);

figure;
hold on;

stem(0:49, x_list, "filled");
stem(0:51, y);
plot(0:51, y_true, Color="green");
stem(0:51, y_true - y, "filled");

hold off;
xlim([0, 51]);
legend('x(n)','y(n)', 'y_{true}(n)', 'y_{true}(n) - y');
saveas(gcf,'Ex03.png');

function [n] = x(n)
    if (0 < n) && (n < 50)
        n = cos((2 * n * pi) / 20);
    else
        n = 0;
    end
end
