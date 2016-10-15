clear, clc, close all
file='G:\6th semester\CSE 4632 Digital Signal Processing Lab\Project\song for DSP lab\';
total_song = 1;
downsample_rate=10;
fid = fopen(strcat(file,'all_song_name.txt'));
tline = fgets(fid);
i=1;
song=[];
song_length=[];
while ischar(tline)
    disp(tline)
    [new_song,fs]=audioread(strcat(file,tline));
    new_song = new_song(:,1);
    new_song = downsample(new_song,downsample_rate);
    m = max(abs(new_song));    
    new_song = new_song/m; 
    song=[song;new_song];
    song_length=[song_length;length(new_song)];
    tline = fgets(fid);
end
fclose(fid);
save song_data song song_length
