function [Points] = triangulate(K, R, t, matchCoords1, matchCoords2)
    P1 = K * eye(3) * cat(2,eye(3), [0 0 0]');
    P2 = K * R * cat(2,eye(3), t');
    
    m1 = matchCoords1;
    m2 = matchCoords2;
    
    sz = size(m1,1);
    
    Points = zeros(sz,4);
 
    for i=1:sz
        A =[m1(i,1).*P1(3,:) - P1(1,:);...
            m1(i,2).*P1(3,:) - P1(2,:);...
            m2(i,1).*P2(3,:) - P2(1,:);...
            m2(i,2).*P2(3,:) - P2(2,:)];
        [U, S, V] = svd(A);
        
        Points(i,:) = V(:,4)./V(4,4);
    end
end