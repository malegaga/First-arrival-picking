load('E:\workspace\TimePicking\PFCM_TimePicking\data\Synthetic_100HzRick.mat');
%三分量归一化时
data=yc_scale(data,2);
q=53;
x=data(:,1);noisex=awgn(x,-2,'measured');%归一化并加噪
y=data(:,2);noisey=awgn(y,-2,'measured');
z=data(:,3);noisez=awgn(z,-2,'measured');
xx=linspace(0,length(z)/2000,length(z));

features= Feature_ext([noisex,noisey,noisez],q,0,'Power','L','Std');%特征提取
[~,U,~]=yc_fcm(features,2);
if sum(U(1,:))>sum(U(2,:))   
    t=U(1,:);
    U(1,:)=U(2,:);
    U(2,:)=t;    
end

eps=0.2;
% Find the data points with highest grade of membership in noise
index2 = find(U(1,:)>eps);
% if sum(abs(U(1,1:2*q))) < sum(abs(U(2,1:3*q)))
%     n_onset=min(find(U(1,:)>eps));
% else
%     n_onset=min(find(U(2,:)>eps));
% end
% O=n_onset;


figure1 = figure('OuterPosition',...
    [2823 526.333333333333 2008 666.666666666667]);
subplot1 = subplot(2,2,1);
hold(subplot1,'on');
noisedata=[noisex,noisey,noisez];
noisedata=yc_scale(noisedata,2);
noisex=noisedata(:,1);
noisey=noisedata(:,2);
noisez=noisedata(:,3);
plot(xx,noisex','color',[0.9290 0.6940 0.1250],'LineWidth',1.5);ylim([-1,1]);xlim([0,0.15]);
plot(xx,noisey','color','g','LineWidth',1.5);ylim([-1,1]);xlim([0,0.15]);
plot(xx,noisez','color','b','LineWidth',1.5);ylim([-1,1]);xlim([0,0.15]);

% plot([89/2000,89/2000],[-1,1],'color','m','LineWidth',1.5);
title('Noisy Signal(-2dB)');
box(subplot1,'on');
hold(subplot1,'off');
% 设置其余坐标区属性
set(subplot1,'FontSize',15);


subplot2=subplot(2,2,2);
plot3(subplot2,ones(length(z),1),xx',features(:,1)','color','r','LineWidth',1.5);zlim([0,1]);ylim([0,0.15]);hold on
plot3(2*ones(length(z),1),xx',features(:,2)','color','g','LineWidth',1.5);zlim([0,1]);ylim([0,0.15]);hold on
plot3(3*ones(length(z),1),xx',features(:,3)','color','b','LineWidth',1.5);zlim([0,1]);ylim([0,0.15]);hold on
% plot3([1,1],[89/2000,89/2000],[-1,1],'color','m','LineWidth',1.5);hold on
% plot3([2,2],[89/2000,89/2000],[-1,1],'color','m','LineWidth',1.5);hold on
% plot3([3,3],[89/2000,89/2000],[-1,1],'color','m','LineWidth',1.5);hold on
title('Features');
% 设置其余坐标区属性
set(subplot2,'view',[47.045453086832836,61.441666350410443]);
set(subplot2,'FontSize',15);




subplot3=subplot(2,2,4);
hold(subplot3,'on');
plot(xx',U(1,:),'color','b','LineWidth',1.5);zlim([0,1]);
plot(xx',eps*ones(1,length(z)),'color','r','LineWidth',1.5);
% plot([89/2000,89/2000],[0,1],'color','m','LineWidth',1.5);
plot([xx(index2(1)),xx(index2(1))],[0,1],'--g','LineWidth',1.5);
title('Membership Degree of Signal Clustering');
box(subplot3,'on');
hold(subplot3,'off');
% 设置其余坐标区属性
set(subplot3,'FontSize',15);

subplot4=subplot(2,2,3);
hold(subplot4,'on')
plot(xx',noisez,'color','b','LineWidth',1.5);ylim([-1,1]);
% plot([89/2000,89/2000],[-1,1],'color','m','LineWidth',1.5);
plot(xx(index2)',noisez(index2),'marker','o','color','g','LineWidth',2);
plot(xx(89:150)',noisez(89:150),'color','r','LineWidth',2);
title('Classification Result');
box(subplot4,'on');
hold(subplot4,'off');
% 设置其余坐标区属性
set(subplot4,'FontSize',15);

% 创建 textbox
annotation(figure1,'textbox',...
    [0.749053344432307 0.818856718634001 0.0301165344722385 0.0222717149220476],...
    'Color','r',...
    'String','P',...
    'FontSize',15,...
    'FontAngle','italic',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);
annotation(figure1,'textbox',...
    [0.779111219893651 0.793615441722346 0.0163886516168337 0.0200445434298439],...
    'Color','g',...
    'String','L',...
    'FontSize',15,...
    'FontAngle','italic',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1],...
    'BackgroundColor',[1 1 1]);
annotation(figure1,'textbox',...
    [0.842783213751383 0.73199703043801 0.0185241000610045 0.0259836674090548],...
    'Color','b',...
    'String','S',...
    'FontSize',15,...
    'FontAngle','italic',...
    'FitBoxToText','off',...
    'EdgeColor',[1 1 1]);





