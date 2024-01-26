
load('E:\workspace\TimePicking\PFCM_TimePicking\MicroseismicData3D\segy_mat\300.mat');
%三分量归一化时
data3=data3(1:800,:);
data=yc_scale(data3,2);
% figure;
% plotseis(data);

dB=-5;
q=31;
for i=1
        x=data(:,1);noisex=awgn(x,dB,'measured');%归一化并加噪
        y=data(:,2);noisey=awgn(y,dB,'measured');
        z=data(:,3);noisez=awgn(z,dB,'measured');
        xx=linspace(0,length(z)/2000,length(z)); 
        % [features,U] = Feature_ext([noisex,noisey,noisez],5,0,'Power','L','Mean',{'StaLta',10,50});%特征提取
        features = Feature_ext([noisex,noisey,noisez],q,0,'Power','Std','L');%特征提取并归一化
        [~,U,~]=yc_fcm(features,2);
        if sum(U(1,:))>sum(U(2,:))
            t=U(1,:);
            U(1,:)=U(2,:);
            U(2,:)=t;
        end
%         figure;
%         plot(U(1,:));
        eps=0.5;
        index1 = find(U(1,:)>eps);%找初至
        O=index1(1);
end
%%
load('QF.mat');
% subplot(121)
plot(q_f(:,1),q_f(:,2));hold on
% subplot(122)
plot(q_f(:,1),q_f(:,3));
