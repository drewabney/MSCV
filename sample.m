dat=[10,2,4,5,20,34,5,10,23,88,4,2,5,1,19,30] % Example short time series.

in=dat;

bin_len=round(length(in)/2)-1; % This is for the 'default' binning. User can comment this out
                               % if they prefer assigning specific bins to
                               % the MSCV analysis. If user wants to define
                               % their own bins, change '[2:bin_len]'. For
                               % example, if the user prefers the bins,
                               % '2','4','8','16', they would change
                               % '[2:bin_len]' to [2,4,8,16].

[MSCVslope MSCVsum MSCVratio npvi cv avebinvar normMSCVratio m_avebinvar mscv_range] = getMSCV(in', [2:bin_len]);
