function [newIm flag] = imAreaResize(im, targetPxCount, frame)


% resize image to have the proper target pixel count
% pad image to fill a frame
% error if the image doesn't fit in the frame size (by how much is it
% over?)


imBW        = mean(im,3);
imThresh    = imBW<250;
pxCount     = sum(imThresh(:));
pxTotal     = length(imThresh(:));
pctArea     = pxCount/pxTotal * 100;

% 
% subplot(1,2,1)
% imagesc(imBW);  axis square;
% subplot(1,2,2)
% imagesc(imThresh); axis square;
% keyboard

% compute the size it has to be to achieve the target Px Count
scaleFactor = sqrt(targetPxCount/pxCount);


newIm = imresize(im, scaleFactor);
imBW        = mean(newIm,3);
imThresh    = imBW<253;
newPxCount  = sum(imThresh(:));

% [targetPxCount newPxCount]
% size(newIm)

if size(newIm, 1)>frame
    % if the new image doesn't fit in the frame error
    flag=1;
    disp(['Image does not fit in frame: ' num2str(size(newIm,1)) ' pixels'])
else
    % if it fits, center it in the frame
    flag=0;
    blankIm = repmat(255, [frame frame 3]);
    offset = floor((frame-size(newIm,1))/2);
    blankIm(offset+1:offset+(size(newIm,1)), offset+1:offset+(size(newIm,1)),:) = newIm;
    newIm = blankIm;
end
