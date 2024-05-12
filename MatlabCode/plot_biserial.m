function plot_biserial(data,label, text)
% copyright MCuperlovicCulf, Canada, 2024
% plot of biserial correlation for two groups
% calculation is performed using pointbiserial function by F. Nagel:
% https://www.mathworks.com/matlabcentral/fileexchange/11222-point-biserial-correlation
% function input is:
% data in original, untrasformed format, 
% label - sample label has to be binary and numeric, 
% text - for the plot title

trans_data=log10(data);
[biserial, ~, pbiserial, ~]=pointbiserial(label-min(label),trans_data);


mdl=fitlm(label-min(label),trans_data);
figure
plot(mdl)
xlim([-0.25 1.25])
title([text biserial]);

ylabel("log10(concentration)");
xlabel("Groups");

fontname("Arial")

end