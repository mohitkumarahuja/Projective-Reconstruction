function Plot_Image( Image_1, Image_2 )

x = Image_1(1,:);
y = Image_1(2,:);
figure;
hold on;
plot(x,y);
title('Two 2D Images formed from 3D Object');
x2 = Image_2(1,:);
y2 = Image_2(2,:);
plot(x2,y2);
xlabel('x axis');
ylabel('y axis');
legend('camera 1 Image','camera 2 Image');
end

