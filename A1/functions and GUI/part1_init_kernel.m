%% 
% Inputs:
% name  = name of kernel (sobel, gaussian, haar_1, haar_2, haar_3, haar_4, haar_5)
% s     = scale of kernel
% sig   = sigma value for gaussian kernel only

% Outputs:
% mat   = matrix of kernel with appropriate scale 

%%
function mat = part1_init_kernel(name,s,sig)
s = round(s);
switch name
    case 'sobel'
        % Formula for bigger Sobel filters taken from:
        % Expansion and Implementation of a 3x3 Sobel and Prewitt Edge Detection Filter to a 5x5 Dimension Filter
        % M.Sc. Rana Abdul Rahman Lateef - Baghdad College of Economic Sciences University
        % https://www.iasj.net/iasj?func=fulltext&aId=52927
        if (mod(s,2) == 0)
            s = s + 1;
        end
        y_mat = zeros(s);
        mid = ceil(s/2);
        for i = mid+1:s
            for j = mid:s
                i2 = i - mid;
                j2 = j - mid;
                y_mat(i,j) = i2 / (i2*i2 + j2*j2);
            end
        end
        y_mat(mid+1:s,1:mid-1) = y_mat(mid+1:s,mid+1:s);
        y_mat(1:mid-1,1:s) = -flip(y_mat(mid+1:s,1:s));
        x_mat = rot90(y_mat,1);
        
        mat = {x_mat, y_mat};
        
    case 'gaussian'
        if (mod(s,2) == 0)
            s = s + 1;
        end
        mat = zeros(s);
        mid = ceil(s/2);
        for i = mid:s
            for j = mid:i
                i2 = i - mid;
                j2 = j - mid;
                mat(i,j) = (1 / (2*pi*(sig^2)) ) * exp(-(j2^2+i2^2) / (2*(sig^2)));
                mat(j,i) = mat(i,j);
            end
        end
        mat(mid:s,1:mid-1) = flip(mat(mid:s,mid+1:s),2);
        mat(1:mid-1,1:s) = flip(mat(mid+1:s,1:s));
        mat = mat/sum(sum(mat));
        
    case 'haar_1'
        mat = ones(s,2*s);
        mat(:,1:s) = -mat(:,1:s);

    case 'haar_2'
        mat = ones(2*s,s);
        mat(1:s,:) = -mat(1:s,:); 
        
    case 'haar_3'
        mat = ones(s,3*s);
        mat(:,s+1:2*s) = -mat(:,s+1:2*s);
        
    case 'haar_4'
        mat = ones(3*s,s);
        mat(s+1:2*s,:) = -mat(s+1:2*s,:);
        
    case 'haar_5'
        mat = ones(2*s);
        mat(1:s,1:s) = -mat(1:s,1:s);
        mat(s+1:end,s+1:end) = -mat(s+1:end,s+1:end); 
        
end

end

