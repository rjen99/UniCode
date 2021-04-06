order_true = randperm(size(stroke_true,1));
order_false = randperm(size(stroke_false,1));

stroke_true_shuffled = stroke_true(order_true,:);
stroke_false_shuffled = stroke_false(order_false,:);

stroke_false_sampled = stroke_false_shuffled(1:249,:);

%%
r=rand(5110,1);
train = find(r<0.7);
test = find(r>=0.7);
stroke_train_all = stroke_all(train,:);
stroke_test_all = stroke_all(test,:);

stroke_sampled = [stroke_true_shuffled,stroke_false_sampled];
r=rand(size(stroke_sampled,1),1);
train = find(r<0.7);
test = find(r>=0.7);
stroke_train_sampled = stroke_sampled(train,:);
stroke_test_sampled = stroke_sampled(test,:);
%%
writematrix([stroke_true_shuffled;stroke_false_sampled],'stroke_all_sampled.csv')
writematrix(stroke_train_all,'stroke_train_all.csv')
writematrix(stroke_test_all,'stroke_test_all.csv')
writematrix(stroke_train_sampled,'stroke_train_sampled.csv')
writematrix(stroke_test_sampled,'stroke_test_sampled.csv')
