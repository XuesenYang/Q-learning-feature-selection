function [reward]=get_reward(data,features,K)
if length(features)==0
    reward=0;
else
    acc=(1-func(data,features))*100;
    tot_f=length(features);
    if tot_f>K
        reward=acc*K/tot_f;
    else
        reward=acc;
    end     
end
    
    