-- 감독 director_t 테이블
CREATE TABLE director_t (
director_no NUMBER PRIMARY KEY,
director_name VARCHAR2(30 BYTE)
);
CREATE SEQUENCE director_seq START WITH 1;

-- 장르 genre_t 테이블
CREATE TABLE genre_t (
genre_no NUMBER PRIMARY KEY,
genre_name VARCHAR2(100 BYTE)
);
CREATE SEQUENCE genre_seq START WITH 1;

-- 영화-감독 매칭 movie_director_match_t 테이블
CREATE TABLE movie_director_match_t (
movie_no NUMBER,
director_no NUMBER,
CONSTRAINT pk_movie_director_match PRIMARY KEY (movie_no, director_no),
CONSTRAINT fk_movie_director_match_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no),
CONSTRAINT fk_movie_director_match_director FOREIGN KEY (director_no) REFERENCES director_t(director_no)
);

-- 영화 movie 테이블
CREATE TABLE movie_t(
movie_no NUMBER PRIMARY KEY,
title VARCHAR2(100 BYTE),
subtitle VARCHAR2(100 BYTE),
story clob,
grade VARCHAR2(50 BYTE),
ticket_rate NUMBER,
review_score NUMBER,
ticket_sale NUMBER,
opening_dt DATE,
running_time NUMBER
);
CREATE SEQUENCE movie_seq START WITH 1;

-- 영화-장르 매칭 movie_genre_match_t 테이블
CREATE TABLE movie_genre_match_t (
movie_no NUMBER,
genre_no NUMBER,
CONSTRAINT pk_movie_genre_match PRIMARY KEY (movie_no, genre_no),
CONSTRAINT fk_movie_genre_match_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no),
CONSTRAINT fk_movie_genre_match_genre FOREIGN KEY (genre_no) REFERENCES genre_t(genre_no)
);

-- 배우 actor_t 테이블
CREATE TABLE actor_t (
actor_no NUMBER PRIMARY KEY,
actor_name VARCHAR2(100 BYTE)
);
CREATE SEQUENCE actor_seq START WITH 1;

-- 영화-배우 매칭 movie_actor_match_t 테이블
CREATE TABLE movie_actor_match_t (
movie_no NUMBER,
actor_no NUMBER,
CONSTRAINT pk_movie_actor_match PRIMARY KEY (movie_no, actor_no),
CONSTRAINT fk_movie_actor_match_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no),
CONSTRAINT fk_movie_actor_match_actor FOREIGN KEY (actor_no) REFERENCES actor_t(actor_no)
);

-- 영화-포스터 poster_t 테이블
CREATE TABLE poster_t (
poster_url VARCHAR2(400 BYTE),
movie_no NUMBER,
CONSTRAINT pk_poster PRIMARY KEY (movie_no),
CONSTRAINT fk_poster_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no)
);

-- 상영시간표 runtime_t 테이블
CREATE TABLE runtime_t (
movie_no NUMBER PRIMARY KEY,
start_time VARCHAR2(100 BYTE),
CONSTRAINT fk_runtime_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no)
);
CREATE SEQUENCE runtime_seq START WITH 1;

-- 예약좌석 occupied_seat_t 테이블
CREATE TABLE occupied_seat_t (
occupied_seat_no NUMBER PRIMARY KEY,
seat_no VARCHAR2(50 BYTE),
time_no NUMBER,
ticketing_no NUMBER,
age NUMBER,
price NUMBER,
CONSTRAINT pk_occupied_seat PRIMARY KEY (seat_no),
CONSTRAINT pk_occupied_seat PRIMARY KEY (ticketing_no),
CONSTRAINT fk_occupied_seat_runtime FOREIGN KEY (time_no) REFERENCES time_t(time_no),
CONSTRAINT fk_occupied_seat_ticketing FOREIGN KEY (ticketing_no) REFERENCES ticketing_t(ticketing_no),
);
CREATE SEQUENCE occupied_seat_seq START WITH 1;

-- 좌석 seat_t 테이블
CREATE TABLE seat_t (
seat_no VARCHAR2(50 BYTE),
seat_row VARCHAR2(50 BYTE),
seat_col VARCHAR2(50 BYTE),
seat_type_no NUMBER,
CONSTRAINT pk_seat PRIMARY KEY (seat_type_no)
);
CREATE SEQUENCE seat_seq START WITH 1;

-- 좌석 종류 seat_type_t 테이블
CREATE TABLE seat_type_t (
seat_type_no NUMBER,
seat_type VARCHAR2(50 BYTE),
CREATE SEQUENCE seat_type_seq START WITH 1;


-- 티켓팅 ticketing_t 테이블
CREATE TABLE ticketing_t (
ticketing_no NUMBER PRIMARY KEY,
user_no NUMBER,
time_no NUMBER,
movie_no NUMBER,
ticket_dt DATE,
person_count NUMBER
);
CREATE SEQUENCE ticketing_seq START WITH 1;

-- 결제 payment_t 테이블
CREATE TABLE payment_t (
pay_no NUMBER PRIMARY KEY,
user_no NUMBER,
ticketing_no NUMBER,
pay_method VARCHAR2(30 BYTE),
amount NUMBER,
pay_dt DATE,
pay_state DATE,
CONSTRAINT fk_payment_user FOREIGN KEY (user_no) REFERENCES user_t(user_no),
CONSTRAINT fk_payment_ticketing FOREIGN KEY (ticketing_no) REFERENCES ticketing_t(ticketing_no)
);

-- 결제취소 x_payment_t 테이블
CREATE TABLE x_payment_t (
x_pay_no NUMBER PRIMARY KEY,
pay_no NUMBER,
x_pay_dt DATE,
x_pay_status VARCHAR2(30 BYTE),
CONSTRAINT fk_x_payment_payment FOREIGN KEY (pay_no) REFERENCES payment_t(pay_no)
);


-- 좋아요 like_t 테이블
CREATE TABLE like_t (
like_no NUMBER PRIMARY KEY,
user_no NUMBER,
review_no NUMBER,
post_no NUMBER,
CONSTRAINT fk_like_review FOREIGN KEY (review_no) REFERENCES review_t(review_no),
CONSTRAINT fk_like_post FOREIGN KEY (post_no) REFERENCES moviepost_t(post_no)
);

-- 리뷰 review_t 테이블
CREATE TABLE review_t (
review_no NUMBER PRIMARY KEY,
movie_no NUMBER,
user_no NUMBER,
review_score NUMBER,
review VARCHAR2(300 BYTE),
review_dt DATE,
ticketing_no NUMBER,
CONSTRAINT fk_review_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no),
CONSTRAINT fk_review_user FOREIGN KEY (user_no) REFERENCES user_t(user_no)
);

-- 무비포스트 moviepost_t 테이블
CREATE TABLE moviepost_t (
post_no NUMBER,
title VARCHAR2(1000 BYTE),
contents CLOB,
hit NUMBER,
create_dt DATE,
modify_dt DATE,
movie_no NUMBER,
user_no NUMBER,
CONSTRAINT fk_moviepost_movie FOREIGN KEY (movie_no) REFERENCES movie_t(movie_no),
CONSTRAINT fk_moviepost_user FOREIGN KEY (user_no) REFERENCES user_t(user_no),
);

-- 무비포스트 이미지 moviepost_img_t 테이블
CREATE TABLE moviepost_img_t (
post_no NUMBER,
mimg_name VARCHAR2(100 BYTE),
mimg_path VARCHAR2(100 BYTE)
);

-- 무비포스트댓글 moviepost_review_t 테이블
review_no NUMBER,
contents VARCHAR2(4000 BYTE),
user_no Number,
post_no Number,
create_dt DATE,
state Number,
depth Number,
group_no Number,
group_order Number,
CONSTRAINT fk_moviepost_review_user FOREIGN KEY (user_no) REFERENCES user_t(user_no),
CONSTRAINT fk_moviepost_review_moviepost FOREIGN KEY (post_no) REFERENCES moviepost_t(post_no)
);
