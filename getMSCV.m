function [MSCVslope MSCVsum MSCVratio npvi cv avebinvar normMSCVratio m_avebinvar mscv_range] = getMSCV(in, bins)

%    "in" is a row vector.
%    bins=[2,4,16,32,64] or bins=[2:n], where n is length(series)/2. 
%    Lowerbound must be 2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% MSCV Analysis %%%%%%%%%%%%%%%%

binvar=[];
if mod(length(in),2)==1
     in=in(1:length(in)-1);
end
    

for j=1:length(bins)     
    for k=1:length(in)/bins(j)   
             binvar{1,j}(:,k)=std(in((bins(j)*(k-1))+1:(bins(j)*(k))))/mean(in((bins(j)*(k-1))+1:(bins(j)*(k))));
    end  
end

for k=1:length(binvar)
    avebinvar(k)=mean(binvar{1,k}(1,:));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% nPVI and CV Computation %%%%%%%
in=in'
npvi = 100*sum(abs(diff(in,1,2)./((in(:,1:end-1,:)+in(:,2:end,:))/2)),2)/(size(in,2)-1); 
cv = std(in,0)./mean(in);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Plot MSCV Profile %%%%%%%%%%%%%

%figure()
hold on

plot(bins,avebinvar,'r')
hline(cv,'k','CV')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Extract values from MSCV Profile %%%

p=polyfit(log(bins),log(avebinvar),1);
MSCVslope=p(1);

MSCVsum=sum(avebinvar);
MSCVratio=sum(avebinvar)/cv;
normMSCVratio=MSCVratio/length(bins);
m_avebinvar=mean(avebinvar);
mscv_range=max(avebinvar)-min(avebinvar);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

