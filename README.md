# 용선 변경사항(2021.01.05)
목차:
* Clone both repos to respective folders
* npm install in both directories
* Go through Semantic UI installer steps (auto)
* In `./ui` folder `gulp build-docs` (builds files to ./docs)
* In `./docs` folder `docpad install` then `docpad run`
* Go to http://localhost:9778/ docs should be there
* Optionally run `gulp serve-docs` in ./ui to serve any changes from ./ui/src to ./docs

### 변경사항(poom.xml)
```
<!-- https://mvnrepository.com/artifact/commons-beanutils/commons-beanutils -->
<!-- 마이바티스 -->
<dependency>
	<groupId>commons-beanutils</groupId>
	<artifactId>commons-beanutils</artifactId>
	<version>1.8.0</version>
</dependency>

<!-- https://mvnrepository.com/artifact/org.apache.tiles/tiles-core -->
<!--타일즈 관련 라이브러리
타일즈는 웹 페이지의 상단이나 하단 메뉴와 같이 반복적으로 사용되는 부분들에 대한 코드를 분리해서 예쁘게 한 곳에서 관리를 가능하게 해주는 프레임워크이다.
<dependency>
<groupId>org.apache.tiles</groupId>
	<artifactId>tiles-core</artifactId>
	<version>2.2.2</version>
</dependency>
```
```
<properties>
	<java-version>1.6</java-version>
	<org.springframework-version>4.0.0.RELEASE</org.springframework-version>
	<org.aspectj-version>1.6.10</org.aspectj-version>
	<org.slf4j-version>1.6.6</org.slf4j-version>
</properties>

하단으로 변경
<properties>
	<java-version>1.8</java-version>
	<org.springframework-version>4.2.5.RELEASE</org.springframework-version>
	<org.aspectj-version>1.6.10</org.aspectj-version>
	<org.slf4j-version>1.6.6</org.slf4j-version>
</properties>
```


### 변경사항(kr.or.bit.common.interceptor 패키지 생성)
Java Resources
src/main/java
kr.or.bit.common.interceptor 패키지 생성
ViewNameInterceptor class java파일 생성
```

```

<!-- https://mvnrepository.com/artifact/commons-io/commons-io -->
<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.4</version>
</dependency>

