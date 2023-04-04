function val = selfTensor(x,n)
val = x;
    for i=1:n-1
        val = kron(val,x);
    end
end