clear

###PARAMS
cmap = "viridis";
#Function surface
maxLikes=60;
maxDislikes=15;
surfDiv=1;

#Level analysis
maxNum=30;
levelN=24;
ratioN=50;
evolDiv=1;

###Function

function rating = rank(_pos,_neg);
  #--------------------------------------------#
  neg = _neg;
  n = _pos.+neg+2.4;
  z = 0.76;
  p = (_pos+2.2)./n;
  N=5;
  r0=0.625;
  n0=_neg+_pos;
  
  #Shite
  #rating = (_pos+3)./(_neg+3);
  #Bernoulli - Wilson Interval Lower bound
  rx = (p.+(z.*z)./(2.*n).-z.*sqrt((p.*(1-p).+z.*z./(4.*n))./n ))./(1.+z.*z./n);
  rating = rx.*n0./(n0+N) + r0.*N./(n0+N);
  #Bernoulli - Arcsine transformation
  #rating = sin(asin(sqrt(p))-z./(2*sqrt(n))).^2;
endfunction

##########

likes=linspace(0,maxLikes,(maxLikes/surfDiv)+1);
dislikes=linspace(0,maxDislikes,(maxDislikes/surfDiv)+1);

ratio = linspace(0,1,ratioN+1);
num = linspace(1,maxNum,(maxNum/evolDiv)+1);

[_ratio,_num]=meshgrid(ratio,num);
[_likes,_dislikes]=meshgrid(likes,dislikes);

_pos=_ratio.*_num;
_neg=(1-_ratio).*_num;

fevolution = rank(_pos,_neg);
fsurface = rank(_likes,_dislikes);

figure(1)

colormap(cmap);
s1 = surf(_likes,_dislikes,fsurface);
xlabel "Likes";
ylabel "Dislikes";
zlabel "Rating";
title "z = Rating(Likes,Dislikes)"
M = max(maxLikes,maxLikes);
axis([0,M,0,M,0,1],"square");
view (225,15);

figure(2)

colormap(cmap);
s2 = contour(_likes,_dislikes,fsurface,levelN);
xlabel "Likes";
ylabel "Dislikes";
zlabel "Rating";
title "Rating(Likes,Dislikes)"
axis("square");
c=colorbar("westoutside");
set(c,"ylabel","Rating");

figure (3)

colormap(cmap);
[s,s3] = contour(_ratio*100,fevolution,_num,levelN);
#¦set(s3,"LineColor","none");
xlabel '% of likes';
ylabel 'Rating';
title("Evoluzione della curva del rating in funzione di like% all'aumentare dei voti totali");
axis([0,100,0,1],"square");
c=colorbar("westoutside");
set(c,"ylabel","tot N. of votes");

figure(4)

colormap(cmap);
[s,s4] = contourf(_num,_ratio*100,fevolution,levelN);
set(s4,'LineColor','none');
xlabel 'N. of total votes';
ylabel '% of likes';
title("Linee di livello del rating all'aumentare del numero di voti");
axis("square");
c=colorbar("westoutside");
set(c,"ylabel","Rating");

