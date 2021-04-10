stroke_data_tab = healthcaredatasetstrokedata;

smokes = find(stroke_data_tab.smoking_status=='smokes');
f_smokes = [find(stroke_data_tab.smoking_status=='formerly smoked'); find(stroke_data_tab.smoking_status=='Unknown')];
n_smokes = find(stroke_data_tab.smoking_status=='never smoked');
male = find(stroke_data_tab.gender=='Male');

stroke_features = zeros(height(stroke_data_tab),6);
stroke_features(male,1) = 1;
stroke_features(:,2:6) = [stroke_data_tab.age,stroke_data_tab.hypertension,...
    stroke_data_tab.heart_disease,stroke_data_tab.avg_glucose_level,stroke_data_tab.bmi];
stroke_features(smokes,7) = 2;
stroke_features(f_smokes,7) = 1;
stroke_features(n_smokes,7) = 0;

stroke_labels = stroke_data_tab.stroke;
yes = stroke_labels==1;
no = stroke_labels==0;
%%
r=rand(5110,1);
train=find(r<0.7);
test = find(r>=0.7);
tr_labels=stroke_labels(train,:);
ts_labels=stroke_labels(test,:);
tr_features=stroke_features(train,:);
ts_features=stroke_features(test,:);
writematrix(ts_labels,'ts_stroke_labels.csv')
writematrix(ts_features, 'ts_stroke_features.csv')
writematrix(tr_labels,'tr_stroke_labels.csv')
writematrix(tr_features, 'tr_stroke_features.csv')
%%
shorten_features=stroke_features(1:2*249,:);
shorten_labels=stroke_labels(1:2*249,:);
r=rand(2*249,1);
train=find(r<0.7);
test = find(r>=0.7);
tr_labels=shorten_labels(train,:);
ts_labels=shorten_labels(test,:);
tr_features=shorten_features(train,:);
ts_features=shorten_features(test,:);
writematrix(ts_labels,'ts_short_labels.csv')
writematrix(ts_features, 'ts_short_features.csv')
writematrix(tr_labels,'tr_short_labels.csv')
writematrix(tr_features, 'tr_short_features.csv')
%%
rand_f = stroke_features(uh, :);
figure;
plot(rand_f(no,5),'.')
hold on
plot(rand_f(yes,5),'ro')
%%
writematrix(stroke_labels,'stroke_labels.csv')
writematrix(stroke_features, 'stroke_features.csv')