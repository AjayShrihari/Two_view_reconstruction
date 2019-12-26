function main
    im1=rgb2gray(imread("./img1.png"));
    im2=rgb2gray(imread("./img2.png"));
    [matchedPts1,matchedPts2]=features(im1,im2);
%     figure; showMatchedFeatures(im1,im2,matchedPts1,matchedPts2);
    sz1=size(im1,1); sz2=size(im1,2);
    mp1=matchedPts1; mp2=matchedPts2;
    
    K = [558.7087, 0.0, 310.3210; 0.0, 558.2827, 240.2395; 0.0, 0.0, 1.0];
    mp1=[mp1.Location, ones(length(mp1),1)];
    mp2=[mp2.Location, ones(length(mp2),1)];
    matchedPts1=matchedPts1.Location; matchedPts2=matchedPts2.Location;
    
%     mpt=[mp1;mp2];
%     mpt(:,1)=mpt(:,1)-sz1*(ones(size(mpt,1),1));
%     mpt(:,2)=mpt(:,2)-sz2*(ones(size(mpt,1),1));
%     d=mean(sqrt(mpt(:,1).^2+mpt(:,2).^2));
    mu=sum(mp1)/size(mp1,1);
    d = mean(sqrt((mp1(:,1)-mu(1)).^2 + (mp1(:,2)-mu(2)).^2));
    T1=[1.44/d, 0, -1.44/d * mu(1); 0, 1.44/d, -1.44/d * mu(2); 0, 0, 1];
    mp1=(T1*mp1')'; 
    mu=sum(mp2)/size(mp2,1);
    d = mean(sqrt((mp2(:,1)-mu(1)).^2 + (mp2(:,2)-mu(2)).^2));
    T2=[1.44/d, 0, -1.44/d * mu(1); 0, 1.44/d, -1.44/d * mu(2); 0, 0, 1];
    mp2=(T2*mp2')'; 
%     mp1=mp1*inv(K)';
%     mp2=(inv(K)*mp2')';
    
    %E=estimate_init_F(mp1,mp2);
    E=Ransac(mp1,mp2,T1,T2);
%     E=K'*E*K;
    
    camera_intrinsic = cameraIntrinsics([558.7087, 558.2827], [310.3210, 240.2395], [480, 640]);
    [R, t] = relativeCameraPose(E, camera_intrinsic, matchedPts1, matchedPts2);
    
    figure, visualizescene(R,t);
    visualizescene(eye(3),[0 0 0]);
    pt=triangulate(K,R,t,matchedPts1,matchedPts2);
    scatter3(pt(:,1),pt(:,2),pt(:,3));
    
    axis([-5 5 -5 5 -10 10]);
end