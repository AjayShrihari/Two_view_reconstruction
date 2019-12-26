function [matchedPts1,matchedPts2]=features(im1,im2)
    points1 = detectSURFFeatures(im1);
    points2 = detectSURFFeatures(im2);
    [f1,vpts1] = extractFeatures(im1,points1);
    [f2,vpts2] = extractFeatures(im2,points2);
    indexPairs = matchFeatures(f1,f2) ;
    matchedPts1 = vpts1(indexPairs(:,1));
    matchedPts2 = vpts2(indexPairs(:,2));
end