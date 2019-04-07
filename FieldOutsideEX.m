function FieldOutsideEX = FieldOutsideEX(N_max, Const,k_0, p, x0, y0, x, y)
m  = [-N_max:N_max];
if(N_max == 0) m = 0; end
q = sqrt(1 - p.^2);
q = q.* (2*(imag(q) <= 0)-1);
FieldOutsideEPHI = zeros(2001,2001);
FieldOutsideERHO = zeros(2001,2001);
for ii = 1:2001
    for ij = 1:2001
        dx = x(ii)-x0;
        dy = y(ij)-y0;
        rho = sqrt(dx.^2 + dy.^2);
        phi1 = atan(abs(dy)/abs(dx));
        phi    = (phi1).* (dx>0).* (dy>0); 
        phi    = phi + (pi - phi1).* (dx<=0).* (dy>0); 
        phi    = phi + (pi + phi1).* (dx<=0).* (dy<=0); 
        phi    = phi + (2*pi - phi1).* (dx>0).* (dy<=0);

        Q = k_0.* rho * q;
    
        H2m  = besselh(N_max, 2, Q);
        dH2m = (H2m.* N_max)./ Q  - besselh(N_max + 1, 2, Q); 
    
        FieldOutsideEPHI(ii,ij) = -1i*Const(3)*dH2m-1i*Const(4)*p*N_max*H2m/Q;
        FieldOutsideERHO(ii,ij) = p*Const(4)*dH2m+Const(3)*N_max*H2m/Q;
        FieldOutsideEX(ii,ij) = cos(phi)*FieldOutsideERHO(ii,ij) - sin(phi)*FieldOutsideEPHI(ii,ij);
    end
end
 
    
        




