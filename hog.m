function ohist = hog(I)
%
% compute orientation histograms over 8x8 blocks of pixels
% orientations are binned into 9 possible bins
%
% I : grayscale image of dimension HxW
% ohist : orinetation histograms for each block. ohist is of dimension (H/8)x(W/8)x9
%

[h,w] = size(I); %size of the input
h2 = ceil(h/8); %the size of the output
w2 = ceil(w/8);
nori = 9;       %number of orientation bins

[mag,ori] = mygradient(I);
thresh = 0.1 * max(mag(:));  %threshold for edges


% separate out pixels into orientation channels
ohist = zeros(h2,w2,nori);
for i = 1:nori
  % create a binary image containing 1's for the pixels that are edges at this orientation
  B = zeros(h,w);
  temp1 = zeros(h,w);
  temp2 = zeros(h,w);
  range = -90 + (i-1)*20;
  temp1(find(ori >= range & ori < (range + 20))) = 1;
  temp2(find(mag > thresh)) = 1;
  B = temp1 & temp2;
  % sum up the values over 8x8 pixel blocks.
  chblock = im2col(B,[8 8],'distinct');  %useful function for grabbing blocks
  temp = sum(chblock);                                       %sum over each block and store result in ohist
  ohist(:,:,i) = reshape(temp, [h2 w2]);                     
end

% normalize the histogram so that sum over orientation bins is 1 for each block
%   NOTE: Don't divide by 0! If there are no edges in a block (ie. this counts sums to 0 for the block) then just leave all the values 0. 

for height = 1:h2
    for width = 1:w2
        var = sum(ohist(height,width,:));
        if (var > 0)
            for ind = 1:nori
                ohist(height, width, ind) = ohist(height, width, ind)/var;
            end
        end
    end
end

