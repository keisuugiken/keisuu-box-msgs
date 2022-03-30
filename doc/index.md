Package Summary
===============

KEISUU Boxは、ロボットに構成される基本的な装置の制御を行い、またその制御をROSのインターフェースからかんたんに操作できるキットです。

このパッケージでは、複数接続されたブラシレスモーターを制御するノードを実行し、加速度などのパラメータや速度指令などのトピックを使って、モーターへ指令を送ることができます。

## 1. Example

モーター制御ノードの実行

```sh
$ rosrun keisuu_box motor_control_node
```

## 2. Nodes

### 2.1 motor_control_node

KEISUU Boxに接続されたブラシレスモーターは、`速度` / `位置` / `トルク` を指定して制御できます。またエンコーダーから読み取られる現在の回転位置は、自動的にトピックから配信されます。
さらにモーターごとの加速度を設定したい場合は、ノード実行時にパラメータからモーターのIDに対して加速度の値を入力してください。

#### 2.1.1 Subscribed Topics

_/keisuu\_box/motor/enable\_all_ (**[std_msgs/String](http://docs.ros.org/en/api/std_msgs/html/msg/String.html)**)

メッセージは空文字を指定してください。モーターを有効状態にします。有効状態の場合は、モーターに回転指令を送ることができます。静止中の場合でも、モーターはその位置を維持しようとするため、手で回すことができません。

_/keisuu\_box/motor/disable\_all_ (**[std_msgs/String](http://docs.ros.org/en/api/std_msgs/html/msg/String.html)**)

メッセージは空文字を指定してください。モーターを無効状態にします。無効状態の場合は、モーターに回転指令を送ることができません。また無効状態では現在位置を保持するトルクを停止するので、モーターを手で回すことができます。

_/keisuu\_box/motor/stop\_all_ (**[std_msgs/String](http://docs.ros.org/en/api/std_msgs/html/msg/String.html)**)

メッセージは空文字を指定してください。モーターに0\[deg/sec\]の速度指令を送って、回転を停止させます。

_/keisuu\_box/motor/current_ (**[keisuu_box/MotorCmdCurrent](msgs/MotorCmdCurrent.md)**)

電流トルク制御を実行します。メッセージの`iq`に電流値を指定してください。値の範囲は`-2000 ~ 2000`で、単位は`32/2000A`です

_/keisuu\_box/motor/position_ (**[keisuu_box/MotorCmdPosition](msgs/MotorCmdPosition.md)**)

位置制御を実行します。メッセージでは`max_speed`に目標回転角速度(deg/sec)、`position`は絶対位置(deg)を指定してください。角度の範囲は0 ~ 4294967.295(deg/sec)です。回転の方向は、現在の絶対位置と比較して、指令角度の方が大きい場合は正回転、小さい場合は逆回転をします。
また、目標回転角速度の範囲は0 ~ 65535(deg/sec)ですが、電流が32Aを超えるトルクが発生しうる場合は、電流が最大32Aになるように速度が制限されることに注意してください。

_/keisuu\_box/motor/velocity_ (**[keisuu_box/MotorCmdVelocity](msgs/MotorCmdVelocity.md)**)

速度制御を実行します。メッセージの`speed`に角速度を指定してください。値の範囲は`0 ~ 4294967.295`で、単位は`deg/sec`です。ここで速度の最大値は4294967.295(deg/s)ですが、電流が32Aを超えるトルクが発生しうる場合は、電流が最大32Aになるように速度が制限されることに注意してください。

#### 2.1.2 Published Topics

_/keisuu\_box/motor/devices_ (**[keisuu_box/MotorDevices](msgs/MotorDevices.md)**)

接続されたモーターは、ノード実行時に自動で検出されます。モーターにはIDが付与されており、IDを指定して指令を送ったり、モーターのIDに対応する回転位置の情報を取得することができます。

_/keisuu\_box/motor/encoder_ (**[keisuu_box/MotorPosition](msgs/MotorPosition.md)**)

ブラシレスモーターには、アブソルートエンコーダーが組み込まれています。エンコーダーには出荷時に初期位置を設定しており、初期位置からの絶対角度を取得することができます。
`MotorPosition`には、以下の項目が含まれます。

- `motor_id` : モーターのID
- `relative` : ゼロ点を初期位置とした現在の相対角度(deg)