function F=estimate_init_F(mp1,mp2)
    temp=[];
    %sz=[sz1,sz2]
%     mp1=[mp1.Location, ones(length(mp1),1)];
%     mp2=[mp2.Location, ones(length(mp2),1)];
    for i = [1:8]
        temp=[temp;kron(mp2(i,:),mp1(i,:))];
    end
    [u,d,v]=svd(temp);
    f=v(:,size(v,2));
    F=vec2mat(f,3);
    [u,d,v]=svd(F);
    d(size(d))=0;
    F=u*d*v';
end