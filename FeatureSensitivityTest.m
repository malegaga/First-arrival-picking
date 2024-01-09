%Feature sensitivity test
%% 计算不同窗口不同SNR下的特征曲线
%导入数据
load('E:\workspace\TimePicking\PFCM_TimePicking\data\Synthetic_100HzRick.mat');%89-149为信号区段
fs=2000;
data=yc_scale(data,2);%三分量归一化时
x=data(:,1);
y=data(:,2);
z=data(:,3);
t=linspace(1/fs,length(z)/fs,length(z))';
q=55;
dB=[5,0,-5,-7,-8,-10];
for i=1:length(dB)
    %加噪
    noisex=awgn(x,dB(i),'measured');
    noisey=awgn(y,dB(i),'measured');
    noisez=awgn(z,dB(i),'measured');
    
    %特征提取
    F(:,:,i) = Feature_ext([noisex,noisey,noisez],q,0,'Power','Std','L');%特征提取
end

%% 观察信噪比SNR,对特征F的影响
fig1=figure('OuterPosition',[509,55.666666666666664,1250,1294.666666666667]);
h1=subplot(4,1,1);
hold(h1,'on');
plot(t,x,'color',[0.9290 0.6940 0.1250],'LineWidth',1.5);ylim([-1,1]);xlim([0,0.15]);
plot(t,y,'color','g','LineWidth',1.5);ylim([-1,1]);xlim([0,0.15]);
plot(t,z,'color','b','LineWidth',1.5);ylim([-1,1]);xlim([0,0.15]);
plot([89/2000,89/2000],[-1,1],'color','m','LineWidth',1.5);
title('Synthetic Signal');
box(h1,'on');
hold(h1,'off');
% 设置其余坐标区属性
set(h1,'FontSize',15);

h2=subplot(412);
hold(h2,'on');
plot(t,F(:,1,1),'color','k','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,1,2),'color','r','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,1,3),'color','g','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,1,4),'color','b','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,1,5),'color','c','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,1,6),'color',[0.9290 0.6940 0.1250],'LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
% plot([t(89),t(89)],[0,1],'color','m','LineWidth',1.5);
title('SensitivityTest(Power)');
% legend('5dB','0dB','-5dB','-7dB','-8dB','-10dB','First Arrival');
box(h2,'on'); 
hold(h2,'off');
set(h2,'FontSize',15);


h3=subplot(413);
hold(h3,'on');
plot(t,F(:,2,1),'color','k','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,2,2),'color','r','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,2,3),'color','g','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,2,4),'color','b','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,2,5),'color','c','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,2,6),'color',[0.9290 0.6940 0.1250],'LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
% plot([t(89),t(89)],[0,1],'color','m','LineWidth',1.5);
title('SensitivityTest(Std)');
% legend('5dB','0dB','-5dB','-7dB','-8dB','-10dB','First Arrival');
box(h3,'on');
hold(h3,'off');
set(h3,'FontSize',15);

h4=subplot(414);
hold(h4,'on');
plot(t,F(:,3,1),'color','k','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,3,2),'color','r','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,3,3),'color','g','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,3,4),'color','b','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,3,5),'color','c','LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
plot(t,F(:,3,6),'color',[0.9290 0.6940 0.1250],'LineWidth',1.5);ylim([0,1]);xlim([0,0.15]);
% plot([t(89),t(89)],[0,1],'color','m','LineWidth',1.5);
title('SensitivityTest(L)');
% legend('5dB','0dB','-5dB','-7dB','-8dB','-10dB','First Arrival');
box(h4,'on');
hold(h4,'off');
set(h4,'FontSize',15);







