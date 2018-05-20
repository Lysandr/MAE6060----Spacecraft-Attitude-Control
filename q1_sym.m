%% symbolss



syms w1 w2 w3 h1 h2 h3 hd1 hd2 hd3
I = I_b;
w = [w1 w2 w3].';
h = [h1 h2 h3].';
hd = [hd1;hd2;hd3];

wd = simplify(-inv(I)*hd - inv(I)*crs(w)*I*w - inv(I)*crs(w)*h);
vpa(wd(1),5)
