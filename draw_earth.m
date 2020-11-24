function draw_earth()
    Re = 6.371e+6;
    [X,Y,Z] = sphere(30);
    X=X*Re; Y=Y*Re; Z = Z*Re;
    surf(X,Y,Z);
end

