# Lambda code for EC2 Auto Start/Stop

## Description
特定のタグがある EC2 を起動/停止する Pythonスクリプトを lambda に登録し、CloudWatchEvent で実行するサンプル

## Test Sample
テストといっても、実際に環境に対して実行されてしまうので注意
```
# cd source/
# pip install python-lambda-local
# pip install -r requirements.txt -t lib
# python-lambda-local --function lambda_handler --library lib --timeout 30 main.py event.json
```
```
# cat event.json
{
  "Action": "Start"
}
```

## EC2 Tags
|key  |value  |動作  |
|---|---|---|
|Ec2StartStop  |Auto  |起動・停止を実行  |
|Ec2StartStop  |Start  |起動を実行  |
|Ec2StartStop  |Stop  |停止を実行  |

## Event
CloudWatchイベント側でスケジュールを作成し、`Action`として`Start / Stop`どちらかを指定

## Remark
* EC2インスタンスを業務時間外は停止しておきたい場合などに利用