function [out1,out2] = computeComp(temp)
    %temp = tmp_x;
    D1 = down1ShiftImage(temp);             %1*D1      2*D2      4*D3
    D2 = downShiftImage(temp);              %128*D8     X        8*D4
    D3 = down2ShiftImage(temp);             %64*D7     32*D6     16*D5
    D4 = leftShiftImage(temp);
    D5 = up2ShiftImage(temp);
    D6 = upShiftImage(temp);
    D7 = up1ShiftImage(temp);
    D8 = rightShiftImage(temp);

    out1 = zeros(size(D1));
    out2 = D1;
    out2 = cellfun(@(x) x*0,out2,'un',0);
    MaxVecVal = max(D1{1,1});
    n = log2(numel(D1{1,1}));

    for i=1:size(D1,1)-1
        for j=1:size(D1,2)-1
            %Comparing and storing in 
            t = 0;
            %x = temp{i+1,j+1};
%             t1 = 1 * comparator2(D1{i,j},x);
%             t2 = 2 * comparator2(D2{i,j},x);
%             t3 = 4 * comparator2(D3{i,j},x);
%             t4 = 8 * comparator2(D4{i,j},x);
%             t5 = 16 * comparator2(D5{i,j},x);
%             t6 = 32 * comparator2(D6{i,j},x);
%             t7 = 64 * comparator2(D7{i,j},x);
%             t8 = 128 * comparator2(D8{i,j},x);
            t = t+1 * comparator2(D1{i,j},temp{i,j});
            t = t+2 * comparator2(D2{i,j},temp{i,j});
            t = t+4 * comparator2(D3{i,j},temp{i,j});
            t = t+8 * comparator2(D4{i,j},temp{i,j});
            t = t+16 * comparator2(D5{i,j},temp{i,j});
            t = t+32 * comparator2(D6{i,j},temp{i,j});
            t = t+64 * comparator2(D7{i,j},temp{i,j});
            t = t+128 * comparator2(D8{i,j},temp{i,j});
            %t = [t1,t2,t3,t4,t5,t6,t7,t8];
            %dec = bin2dec(num2str(t));
            out1(i,j) = t;
            out2{i,j} = dec2vec(t,n);
        end
    end
end