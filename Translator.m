classdef Translator
    properties
        Url;
        I;
        language_source;
        language_destination;
        text_source;
        text_destination;
        
        
    end
    
    
    methods
        
        function  T=Translator(Url,language_source,language_dest)
            
            T.Url=Url;
            if(nargin<2)
                T.language_source='nl';
                T.language_destination='en';
                
            else
                if(nargin<3)
                    T.language_source=language_source;
                    
                    T.language_destination='en';
                else
                    
                    T.language_source=language_source;
                    T.language_destination=language_dest;
                    
                end
                
            end
            
            
        end
        
        
        
        function T=stream(T)
            
            
            ss  = imread(T.Url);
            fh = image(ss);
            set(fh,'CData',ss);
            drawnow;
            T.I=ss;
            
        end
        
        
        function T=translate(T)
            T=T.ocrcall(T.I);
            
            
        end
        
        function T=ocrcall(T,I)
            
                results = ocr(I);
                if(isempty(results.Words)||strcmp(results.Words{1},' '))
                x='No Words Detected';
                else
                    
               
                for i=1:length(results. Words)
                    s=results.Words{i};
                    if(i~=1)
                        x=[x ,'  ',s];
                    else
                        x=s;
                    end
                end
                
                end
                fileID = fopen('trans.txt','w');
                fprintf(fileID,'%s',x);
                fclose(fileID);
                
                
                
                system('python trans1.py');
                
                fileID = fopen('trans.txt','r');
                s=fscanf(fileID,'%c');
                fclose(fileID);
                disp(s);
                T.text_source=x;
                T.text_destination=s;
                imshow(I);
                
        end
        
        
        
    end
    
end