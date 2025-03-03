# wireguard_server_ui

WireGuard GUI for Server

실행 후 + 버튼을 눌러 서버를 추가함
ip 주소는 본인의 외부 ip 주소를 입력할 것

![image](https://github.com/user-attachments/assets/e7d02e9e-d8e1-4601-9a97-83e21116c798)
![image](https://github.com/user-attachments/assets/4476a340-1983-4049-a063-cdf477da3cff)

서버를 추가하게 되면 사용자/AppData/Roaming/wireguardserverui 폴더에 서버 이름의 폴더가 생성되고 docker-compose.yml, config, modules이 추가됨
config, modules는 도커 컨테이너 내부의 폴더와 마운트 되어 있음

![image](https://github.com/user-attachments/assets/7f7f8699-c862-4d0f-932d-7fdbc4a0ec1a)
![image](https://github.com/user-attachments/assets/f8de952e-7848-4f46-9c3a-1f527252043d)
![image](https://github.com/user-attachments/assets/7924daa8-8df7-4abe-a1d5-2dc347fd01a1)


서버 추가가 완료되면 유저 추가 버튼을 클릭하여 사용자를 추가함

![image](https://github.com/user-attachments/assets/5982e24b-ce3b-4520-97a1-1cc324599121)
![image](https://github.com/user-attachments/assets/f89da843-a60c-4744-b8e8-b62963a8327f)
![image](https://github.com/user-attachments/assets/c5711c5e-a454-4f65-adc8-d0c7460db8bf)
![image](https://github.com/user-attachments/assets/31203e32-7146-4ec4-9cd1-70d467cce841)

사용자 추가시 config 폴더 내부에서 정상적으로 사용자 정보가 생성된 것을 확인할 수 있음
사용자 정보가 있는 conf 파일과 해당 파일을 바탕으로 생성된 qr 코드 사진이 생성되며 conf 파일 생성 시 필요한 암호화 키가 생성됨

![image](https://github.com/user-attachments/assets/020eaa6e-7b57-4930-8619-895085979397)
![image](https://github.com/user-attachments/assets/3ac6cdf5-c56f-4823-b92e-2e6678e0e8a5)

wireguard 공식 앱에서 qr 코드를 이용해 접속할 수 있음 

![1q](https://github.com/user-attachments/assets/232ee89f-f7f4-4cff-b04f-53b6bbdaaf3f)
![2q](https://github.com/user-attachments/assets/d08433c5-f094-46de-8e4c-c60e53309ef5)
![3q](https://github.com/user-attachments/assets/409a088e-371e-4ce8-9a5f-101432ae2392)
