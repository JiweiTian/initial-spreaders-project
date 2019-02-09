
topology = ["SF-SF" "ER-ER" "SW-SW" "ER-SF" "SF-SW" "ER-SW" "SF-ER" "SW-SF" "SW-ER"  ] ;
inter = [ "sparse&random" "dense&random" "sparse&designed-max_max" "sparse&designed-max_min" "sparse&designed-min_min" "dense&designed-max_max" "dense&designed-max_min" "dense&designed-min_min" ];
scen = ["scenari-11&12n=500" "scenari-21&22n=500"] ; 

n = 1000;

%function average1(n)

files = dir;

disp(length(files))

size_doc = length(files) ;

%for k =3:size

%   fprintf('%s \n', files(k).name) ;
%   load(files(k).name);

for i = 1:8
    curr_name =[ "a" ] ;
    

    for j = 1:size_doc
        if(size(strfind(files(j).name,strcat(scen(2),inter(i))))~=0)
            curr_name = [curr_name ;
                files(j).name ];
            % disp(files(j).name);
        end
        %     disp(strcat(scen(2),inter(i)));
        
    end
    
    check_size = size(curr_name);
    check = check_size(1);
    
    
    if(check>3)
        
        
        curr_name = curr_name(2:length(curr_name));
        files_in_order = [];
        for j = 1:9
            
            for z = 1:9
                if(size(strfind(curr_name(z),topology(j)))~=0)
                    files_in_order = [  files_in_order;
                        curr_name(z)] ;
                end
                
            end
        end
        
    else
        msg = 'could not parse';
        disp(inter(i))
        
        error(msg) ;
        
        
    end
    
   name =strcat(scen(2),inter(i),'-k=3%');
   fig = figure('Name',name,'NumberTitle','off');
   
    for k= 1:9
        disp(files_in_order(k));
        load(files_in_order(k)) ;
        avg_n_fail_time=0;
        avg_n_fail_time2=0;
        

        
        if(size(vector_adjx{1})~=n/2)
            msg = 'Adjx matrix not valid';
            disp(size(vector_adjx{1}));
            error(msg);

        end
        
        for i = 1:200
            sum=0;
            
            for j =1:100
                a= vector_n_fail_time3{j};
                
                sum = sum + a(i);
                
            end
            avg_n_fail_time=[avg_n_fail_time (sum/100) ];
            
            
        end
        
        for i = 1:200
            
            sum2=0;
            for j =1: 100
                
                b = vector_n_fail_time4{j};
                
                sum2 = sum2 + b(i);
            end
            
            avg_n_fail_time2=[avg_n_fail_time2 (sum2/100) ];
            
        end
        
      
          
          
          
      
        
        avg_n_fail_time=avg_n_fail_time(2:length(avg_n_fail_time));
        avg_n_fail_time2=avg_n_fail_time2(2:length(avg_n_fail_time2));
        

        
        t = 1:length(avg_n_fail_time);
        t2=1:length(avg_n_fail_time2);
        a = k;
        disp(a);
        subplot(3,3,a);
        
        plot(t,avg_n_fail_time);
        y=ylabel('avg No. of failed nodes');
        set(y,'FontSize',8);
        
        if a==1
            %legend('SF-SF' );
            x=xlabel('time(SF-SF)');
            set(x,'FontSize',8);
            
        elseif a==2
            %legend('ER-ER');
            x=xlabel('time(ER-ER)');
            set(x,'FontSize',8);
            
        elseif a==3
            % legend('SW-SW');
            x=xlabel('time(SW-SW)');
            set(x,'FontSize',8);
            
        elseif a==4
            %legend('ER-SF');
            x=xlabel('time(ER-SF)');
            set(x,'FontSize',8);
        elseif a==5
            %legend('SF-SW');
            x=xlabel('time(SF-SW)');
            set(x,'FontSize',8);
        elseif a==6
            %legend('ER-SW');
            x=xlabel('time(ER-SW)');
            set(x,'FontSize',8);
            
        elseif a==7
            %legend('SF-SF' );
            x=xlabel('time(SF-ER)');
            set(x,'FontSize',8);
            %legend(' 6 spreaders in A' , ' 3 in A & B');
        elseif a==8
            %legend('ER-ER');
            x=xlabel('time(SW-SF)');
            set(x,'FontSize',8);
        elseif a==9
            % legend('SW-SW');
            x=xlabel('time(SW-ER)');
            set(x,'FontSize',8);
            
        end
        
        %legend(' graph1')
        
        hold on
        
        plot(t2,avg_n_fail_time2);
        axis([0 200 0 n]) ;

        
        if a==3
%         if a == 11
           % legend('|F_0| spreaders in A' , ' |F_0|/2 spreaders in each of A & B');
        end
        
        
        hold off
        
        
    end
    
    saveas(fig,strcat(name,'.pdf'))
    
    
end

% For each data: output/save a .csv file that contains the average number
% of failure in one row, the lower error bound in one row, and upper error 
% bound in another row.

%end