clear

###PARAMS
#Function surface
maxLikes=80;
maxDislikes=40;
surfDiv=1;


#Level analysis
maxNum=40;
levelN=40;
ratioN=25;
evolDiv=1;

###Function

function rating = rank(_pos,_neg);
  #Write function here
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

s1 = surfc(_likes,_dislikes,fsurface);
xlabel "Likes";
ylabel "Dislikes";
zlabel "Rating";
title "z = Rating(Likes,Dislikes)"
M = max(maxLikes,maxLikes);
axis([0,M,0,M],"square");
view (225,15);

figure (2)

s2 = contour(_ratio*100,fevolution,_num,levelN);
xlabel '% of likes';
ylabel 'Rating';
title("Evoluzione della curva del rating in funzione di like% all'aumentare dei voti totali");
axis([0,100,0,1],"square");
c=colorbar("westoutside");
set(c,"ylabel","tot N. of votes");

figure(3)

s3 = contour(_num,_ratio*100,fevolution,levelN);
xlabel 'N. of total votes';
ylabel '% of likes';
title("Linee di livello del rating all'aumentare del numero di voti");
axis("square");
c=colorbar("westoutside");
set(c,"ylabel","Rating");

