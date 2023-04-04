function a = comparator2(x,y)
    x1 = find(x==max(x));
    y1 = find(y==max(y));
    
    if x1>=y1
        a = 1;
    else
        a = 0;
    end
end