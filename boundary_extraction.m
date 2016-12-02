
close all; clc; clear;
img = imread('rice.png');
B = [1 1 1; 1 1 1; 1 1 1];
b_w = im2bw(img);
figure, imshow(b_w, []), title('Otsu Thresholded Image');

L = bwlabel(b_w);
L = uint32(L);
stats = regionprops(L, 'Area');
stats_vec = [stats.Area];
T = 50;
plot(stats_vec);
[R, C] = size(img);

for k =1: numel(stats_vec);
    if stats_vec(k) <= T
        for i = 1: R
            for j = 1: C
                if L(i,j) == k
                    b_w(i,j) = 0;
                end
            end
        end
    end
end
figure, imshow(b_w, []), title('Binary Image After region removal with T < 50');
eroded_img = imerode(b_w, B);
output = b_w - eroded_img;
figure, imshow(eroded_img, []), title('Erosion Image');
figure, imshow(output, []), title('Output');
