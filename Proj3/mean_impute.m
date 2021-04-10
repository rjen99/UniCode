bmi = stroke_features(:,6);
non_nan = ~isnan(bmi);
mean_bmi = mean(bmi(non_nan));

t_bmi = bmi(1:249);
f_bmi = bmi(250:end);

true_non_nan = non_nan(1:249);
true_nan = ~true_non_nan;
false_non_nan = non_nan(250:end);
false_nan = ~false_non_nan;

t_mean_bmi = mean(t_bmi(true_non_nan));
f_mean_bmi = mean(f_bmi(false_non_nan));

bmi_fix_1 = bmi;
bmi_fix_1(isnan(bmi_fix_1)) = mean_bmi;

t_bmi_fix = t_bmi;
f_bmi_fix = f_bmi;
t_bmi_fix(true_nan) = t_mean_bmi;
f_bmi_fix(false_nan) = f_mean_bmi;
bmi_fix_2 = [t_bmi_fix;f_bmi_fix];
%{
true_non_nan = ~isnan(bmi(1:249));
true_nan = isnan(bmi(1:249));
false_non_nan = ~isnan(bmi(250:end));
false_nan = isnan(bmi(250:end));
f_bmi = bmi(250:end);
true_mean_bmi = (mean(bmi(true_non_nan)));
false_mean_bmi = (mean(f_bmi(false_non_nan)));
bmi_fix_1 = bmi;
bmi_fix_2 = bmi;
bmi_fix_1(isnan(bmi_fix_1)) = mean_bmi;
bmi_fix_2(true_nan) = true_mean_bmi;
bmi_fix_2(false_nan) = false_mean_bmi;
%}