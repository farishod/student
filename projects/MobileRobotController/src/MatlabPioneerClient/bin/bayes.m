function world = bayes(world, model, offset)
prev = world(offset(1)+1:offset(1)+length(model), offset(2)+1:offset(2)+length(model));
idx = find(~isnan(model));
new = prev;
new(idx) = (model(idx) .* prev(idx)) ./ (model(idx) .* prev(idx) + (1 - model(idx)) .* (1 - prev(idx)));
world(offset(1)+1:offset(1)+length(model),offset(2)+1:offset(2)+length(model)) = new;