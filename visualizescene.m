function visualizescene(R, t)
    colors = ['r', 'g', 'b'];
    pyramid = [0,0,0; 1,1,1; -1,1,1; 1,-1,1; -1,-1,1];
    pyramid = R * pyramid' + R * t';
    pyramid = double(-pyramid');
    shape = alphaShape(pyramid(:,1),pyramid(:,2),pyramid(:,3));
    s1 = plot(shape);
    c = randi(3, [1 1]);
    s1.FaceColor = colors(c);
    hold on;
end