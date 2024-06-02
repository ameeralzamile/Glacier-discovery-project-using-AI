data = imread('nnm.jpeg');


if size(data, 3) == 3
    data = rgb2gray(data);
end

data = histeq(data);

threshold = graythresh(data);
binary_data = imbinarize(data, threshold);

binary_data = bwareaopen(binary_data, 1000);

binary_data = imfill(binary_data, 'holes');

figure;
imshow(binary_data);
title('Binary Glacier Map');

stats = regionprops(binary_data, 'Area', 'Perimeter', 'Centroid', 'BoundingBox');

disp(['Number of detected glacier regions: ', num2str(length(stats))]);
disp(['Total glacier area: ', num2str(sum([stats.Area]))]);
disp(['Average glacier perimeter: ', num2str(mean([stats.Perimeter]))]);

figure;
imshow(data);
hold on;
for i = 1:length(stats)
    centroid = stats(i).Centroid;
    plot(centroid(1), centroid(2), 'r*', 'MarkerSize', 10);
    rectangle('Position', stats(i).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 1);
    text(centroid(1) + 10, centroid(2), ['Glacier ', num2str(i)], 'Color', 'r');
end
title('Detected Glaciers');
