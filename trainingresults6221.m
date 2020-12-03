%%
clear;
load('CS6221project.mat');
%%
% for i = 1:10
%     eval(['outputobtained',num2str(i),'_51 = cat(3,outputobtained',num2str(i),')_511,outputobtained',num2str(i),'_512,outputobtained',num2str(i),'_513);']);
% %     eval(['outputobtained',num2str(i),'_51 = cat(3,outputobtained',num2str(i),')_511,outputobtained',num2str(i),'_512,outputobtained',num2str(i),'_513);']);
% end
%%
    outputobtained1_51 = cat(3,outputobtained1_511,outputobtained1_512,outputobtained1_513);
    outputobtained2_51 = cat(3,outputobtained2_511,outputobtained2_512,outputobtained2_513);
    outputobtained3_51 = cat(3,outputobtained3_511,outputobtained3_512,outputobtained3_513);
    outputobtained4_51 = cat(3,outputobtained4_511,outputobtained4_512,outputobtained4_513);
    outputobtained5_51 = cat(3,outputobtained5_511,outputobtained5_512,outputobtained5_513);
    outputobtained6_51 = cat(3,outputobtained6_511,outputobtained6_512,outputobtained6_513);
    outputobtained7_51 = cat(3,outputobtained7_511,outputobtained7_512,outputobtained7_513);
    outputobtained8_51 = cat(3,outputobtained8_511,outputobtained8_512,outputobtained8_513);
    outputobtained9_51 = cat(3,outputobtained9_511,outputobtained9_512,outputobtained9_513);
    outputobtained10_51 = cat(3,outputobtained10_511,outputobtained10_512,outputobtained10_513);
%%
figure();
for i = 1:50:5000
%     figure();
    ax1 = axes;
    imagesc(outputobtained2_51(:,:,i));
    set(gca,'FontSize',20,'FontWeight','bold','ytick',[],'xtick',[]);
    colormap(ax1,'gray');
    ax2 = axes;
    imagesc(ax2,input2,'alphadata',outputobtained2_51(:,:,i) == 1);
    colormap(ax2,'jet');
    alpha('0.5');
    ax2.Visible = 'off';
    linkprop([ax1 ax2],'Position');
%     colorbar;
    pause(0.1)
end
%%
WF = 0;
WFTN = zeros(1,5000);
WFTP = zeros(1,5000);
WFFN = zeros(1,5000);
WFFP = zeros(1,5000);
for k = 1:5000
    WF = 0;
        for i = 2:69
            for j=2:34
                if label1(i,j) == -1
                    WF = WF+1;
                end
                if label1(i,j) == -1 && outputobtained1_51(i,j,k) == -1
                    WFTP(k) = WFTP(k)+1;
                end
                if label1(i,j) == 1 && outputobtained1_51(i,j,k) == 1
                    WFTN(k) = WFTN(k)+1;
                end
                if label1(i,j) == -1 && outputobtained1_51(i,j,k) == 1
                    WFFN(k) = WFFN(k)+1;
                end
                if label1(i,j) == 1 && outputobtained1_51(i,j,k) == -1
                    WFFP(k) = WFFP(k)+1;
                end
            end
        end

sensitivity(k) = WFTP(k)/(WFTP(k) + WFFN(k));
specificity(k) = WFTN(k)/(WFTN(k) + WFFP(k));
accuracy(k) = (WFTP(k)+WFTN(k))/(WFTP(k) + WFFN(k) + WFTN(k) + WFFP(k));
precision(k) = WFTP(k)/(WFTP(k) + WFFP(k));
prevalence(k) = (WFTP(k) + WFFN(k)) / (WFTP(k) + WFFN(k) + WFTN(k) + WFFP(k));
% NWF(k) = (i*j)- WF;
TPF(k) = WFTP(k)/(WFTP(k) + WFFN(k));
FPF(k) = WFFP(k)/(WFTN(k) + WFFP(k));
% TPF(k) = WFTP(k)/WF;
% TNF(k) = WFTN(k)/NWF(k);
end
TP5 = WFTP([1:50:end,5000]);
TN5 = WFTN([1:50:end,5000]);
FN5 = WFFN([1:50:end,5000]);
FP5 = WFFP([1:50:end,5000]);
TPF5 = TPF([1:50:end,5000]);
FPF5 = FPF([1:50:end,5000]);
sensitivity5 = sensitivity([1:50:end,5000]);
specificity5 = specificity([1:50:end,5000]);
accuracy5 = accuracy([1:50:end,5000]);
precision5 = precision([1:50:end,5000]);
prevalence5 = prevalence([1:50:end,5000]);
figure();
plot(TPF5,'LineWidth',6);
hold on
plot(FPF5,'LineWidth',6);
hold on
plot(sensitivity5,'LineWidth',6);
hold on
plot(specificity5,'LineWidth',6);
hold on
plot(accuracy5,'LineWidth',6);
hold on
plot(precision5,'LineWidth',6);
hold on
plot(prevalence5,'LineWidth',6);
legend('TPF','FPF','sensitivity','specificity','accuracy','precision','prevalence');
xlabel('Epoch/100');
ylabel('Fraction');
title('performance 1');
set(gca,'FontSize',20,'FontWeight','bold');
grid on
hold off
confusionmatrix = cat(1,TPF5,FPF5,sensitivity5,specificity5,accuracy5,precision5,prevalence5,TP5,TN5,FN5,FP5);
csvwrite('/Users/lz/Desktop/cs6221performance.csv',confusionmatrix,0,1);