stroke_features(:,6) = bmi_fix_2;
for i = 1:size(stroke_features,2)
    curr = stroke_features(:,i);
    stroke_features(:,i) = rescale(curr);
end
stroke_all = [stroke_features,stroke_labels];
stroke_true=stroke_all(yes,:);
stroke_false=stroke_all(no,:);
%%
writematrix(stroke_all,'stroke_all.csv')
writematrix(stroke_true,'stroke_true.csv')
writematrix(stroke_false,'stroke_false.csv')