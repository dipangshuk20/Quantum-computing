function [lbp,featureMetrics] = localBinary(X)
    %% Conversino of data into qbits
    n = ceil(log2(size(X,1)));
    q = ceil(log2(double(max(X(:))+1)))+1; %added 1
    h = hadamard(1);
    h_1=h*[1,0]';
    H = selfTensor(h_1,2*n);
    i=identity(1);
    I = i*[1,0]';
    I_i = selfTensor(I,q);
    %I_i = kron(I,kron(I,kron(I,I)));
    In_Im = kron(H,I_i);
    Ix = In_Im'/max(In_Im(:));
    qLen = numel(I_i);
    out = zeros(size(In_Im));
    i = 0;
    for j=1:size(X,1)
        for k=1:size(X,1)
            tmp_x0 = xor(dec2vec(X(j,k),q),dec2vec(0,q));
            tmp_x1 = xor(In_Im((i*qLen)+1:(i+1)*qLen),tmp_x0);
            out((i*qLen)+1:(i+1)*qLen)=tmp_x1;
            i=i+1;
        end
    end
    out = out*max(In_Im(:));
    %% Edge detection scheme
    % Conversion of 1D data to 2D image points
    i=0;
    for j=1:size(X,1)
        for k=1:size(X,1)
            tmp_x{j,k} = out((i*qLen)+1:(i+1)*qLen);
            i=i+1;
        end
    end

    [lbp,lbpQbit] = computeComp(tmp_x);
    featureMetrics = var(lbp,[],2);
end

%X = double(imread('Leena_new.png'));
%[lbp1,lbpQbit1] = localBinary(X);
