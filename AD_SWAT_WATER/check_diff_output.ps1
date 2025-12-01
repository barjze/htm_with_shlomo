# === בדיקת שלמות פלט ל-run_learn_mixed_diff.bat ===
$root = ".\HTM_Results"

# מה מצופה לכל בסיס-שם (Base) של ריצה
$expected = @(
  "param.json","param.txt","res.csv","stats.txt",
  "attack.real","raw_anomaly_score.pred","sum_anomaly_score.pred"
)

# נזהה "Base" לפי הדפוס: P{שלב}_{ערוץ}_learn_{always|train_only}_freeze_off
$regex = '^(?<base>P\d+_[A-Z0-9]+_learn_(?:always|train_only)_freeze_off)'

# קובצים
$files = Get-ChildItem -Path $root -File | Where-Object { $_.Name -match $regex }

# פונקציה קטנה למיפוי סיומת ל"לוגי" שלנו
function Get-SuffixType {
    param([System.IO.FileInfo]$f)
    switch -regex ($f.Name) {
        'param\.json$'                 { 'param.json'; break }
        'param\.txt$'                  { 'param.txt'; break }
        '_res\.csv$'                   { 'res.csv'; break }
        '_stats\.txt$'                 { 'stats.txt'; break }
        '_attack\.real$'               { 'attack.real'; break }
        '_raw_anomaly_score\.pred$'    { 'raw_anomaly_score.pred'; break }
        '_sum_anomaly_score\.pred$'    { 'sum_anomaly_score.pred'; break }
        default                        { $null }
    }
}

# קיבוץ לפי ה-Base והפקת דוח חוסרים
$groups = $files | Group-Object { [regex]::Match($_.Name,$regex).Groups['base'].Value }

$report = foreach ($g in $groups) {
    $base = $g.Name
    $have = $g.Group | ForEach-Object { Get-SuffixType $_ } | Where-Object { $_ } | Sort-Object -Unique
    $missing = Compare-Object -ReferenceObject $expected -DifferenceObject $have -PassThru
    [pscustomobject]@{
        Base    = $base
        Missing = ($missing -join ", ")
    }
}

# מציגים רק כאלה שחסר להם משהו
$report | Where-Object { $_.Missing } | Format-Table -AutoSize
