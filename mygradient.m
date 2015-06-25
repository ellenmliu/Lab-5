function [mag,ori] = mygradient(I)
%
% compute image gradient magnitude and orientation at each pixel
%
%I = im2double(rgb2gray(imread('test0.jpg')));

%convolve image with discrete derivative mask
H = [-1 1];
dx = imfilter(I, H, 'replicate', 'same', 'conv');
dy = imfilter(I, H', 'replicate', 'same', 'conv');


mag = dx.^2 + dy.^2;
mag = sqrt(mag);
ori = atand(dy./dx);


