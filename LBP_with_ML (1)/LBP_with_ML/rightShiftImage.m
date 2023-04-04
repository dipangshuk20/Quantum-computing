function [out]=rightShiftImage(temp_x)
    %shift the entire image to right -->
    out = temp_x;
    out = cellfun(@(x) x*0,out,'un',0);
    max_val = max(max(cell2mat(temp_x)));
    
    for i=1:size(temp_x,1)
        for j=1:size(temp_x,2)
            if j==1
                tmp = zeros(size(temp_x{1,1}));
                tmp(1)=1;
                out{i,j}=max_val*tmp;
            else
                tmp = temp_x{i,j};
                out{i,j}=temp_x{i,j-1};
            end
        end
    end
end