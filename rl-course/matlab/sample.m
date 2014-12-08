function a = sample(p)
%SAMPLE Sample from a discrete distribution
    pc = cumsum(p);
    a = find(pc>pc(end)*rand,1);
end