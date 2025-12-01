function [P1,P2,P3,P4,P5,P6] = parse_swat(data, sampling_interval)
% data: timetable or table שחוזר מ-load_swat (עם VariableNamingRule='preserve')
% sampling_interval: דילול דגימה (ברירת מחדל: 1)

if nargin < 2
    sampling_interval = 1;
end

% בחר את העמודות הרלוונטיות לכל פאנל + עמודת התווית "Normal/Attack"
P1 = data(1:sampling_interval:end, {'LIT101','MV101','P101','P102','Normal/Attack'});
P2 = data(1:sampling_interval:end, {'AIT201','AIT202','AIT203','FIT201','MV201','P201','P202','P203','P204','P205','P206','Normal/Attack'});
P3 = data(1:sampling_interval:end, {'DPIT301','FIT301','LIT301','MV301','MV302','MV303','MV304','P301','P302','Normal/Attack'});
P4 = data(1:sampling_interval:end, {'AIT401','AIT402','FIT401','LIT401','P401','P402','P403','P404','UV401','Normal/Attack'});
P5 = data(1:sampling_interval:end, {'AIT501','AIT502','AIT503','AIT504','FIT501','FIT502','FIT503','FIT504','P501','P502','PIT501','PIT502','PIT503','Normal/Attack'});
P6 = data(1:sampling_interval:end, {'FIT601','P601','P602','P603','Normal/Attack'});

% המרה: "Normal/Attack" (טקסט) -> "Normal" (0/1) והסרת העמודה הישנה
P1 = convertLabel(P1);
P2 = convertLabel(P2);
P3 = convertLabel(P3);
P4 = convertLabel(P4);
P5 = convertLabel(P5);
P6 = convertLabel(P6);

end

% --- helper local function ---
function T = convertLabel(T)
    % ודא שהעמודה קיימת
    vn = T.Properties.VariableNames;
    assert(ismember('Normal/Attack', vn), 'Expected label column "Normal/Attack" not found.');

    % המרה לטיפוס string ואז לוגי/מספרי
    lbl = T.('Normal/Attack');
    if iscell(lbl)
        lbl = string(lbl);
    elseif ischar(lbl)
        lbl = string(lbl);
    elseif isstring(lbl)
        % ok
    else
        % אם משום מה לא טקסט, נסיים כאן (או נהפוך לדאבל)
        lbl = string(lbl);
    end

    % יצירת עמודה Normal: 1=Normal, 0=Attack
    isNormal = strcmpi(lbl, "Normal");
    T.Normal = double(isNormal);

    % מחיקת עמודת הטקסט
    T.('Normal/Attack') = [];
end
