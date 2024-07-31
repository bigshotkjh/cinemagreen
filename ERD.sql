/* DROP SEQUENCE */
DROP SEQUENCE x_user_seq;
DROP SEQUENCE post_img_seq;
DROP SEQUENCE post_seq;
DROP SEQUENCE access_seq;
DROP SEQUENCE like_seq;
DROP SEQUENCE review_seq;
DROP SEQUENCE pay_seq;
DROP SEQUENCE mam_seq;
DROP SEQUENCE mdm_seq;
DROP SEQUENCE seat_type_seq;
DROP SEQUENCE occupied_seat_seq;
DROP SEQUENCE runtime_seq;
DROP SEQUENCE movie_seq;
DROP SEQUENCE user_seq;

/* DROP TABLE */
DROP TABLE moviepost_img_t;
DROP TABLE moviepost_comment_t;
DROP TABLE like_t;
DROP TABLE moviepost_t;
DROP TABLE review_t;
DROP TABLE payment_t;
DROP TABLE occupied_seat_t;
DROP TABLE seat_t;
DROP TABLE seat_type_t;
DROP TABLE ticketing_t;
DROP TABLE x_user_t;
DROP TABLE access_t;
DROP TABLE user_t;
DROP TABLE runtime_t;
DROP TABLE movie_actor_match_t;
DROP TABLE movie_director_match_t;
DROP TABLE movie_t;
DROP TABLE actor_t;
DROP TABLE director_t;

/* CREATE SEQUENCE */
CREATE SEQUENCE user_seq START WITH 1;
CREATE SEQUENCE movie_seq START WITH 1;
CREATE SEQUENCE runtime_seq START WITH 1;
CREATE SEQUENCE occupied_seat_seq START WITH 1;
CREATE SEQUENCE seat_type_seq START WITH 1;
CREATE SEQUENCE mdm_seq START WITH 1;
CREATE SEQUENCE mam_seq START WITH 1;
CREATE SEQUENCE pay_seq START WITH 1;
CREATE SEQUENCE review_seq START WITH 1;
CREATE SEQUENCE like_seq START WITH 1;
CREATE SEQUENCE access_seq START WITH 1;
CREATE SEQUENCE post_seq START WITH 1;
CREATE SEQUENCE post_img_seq START WITH 1;
CREATE SEQUENCE x_user_seq START WITH 1;

/* CREATE TABLE */

-- 감독 director_t 테이블
CREATE TABLE director_t (
    director_id    VARCHAR2(10) NOT NULL PRIMARY KEY,
    director_nm    VARCHAR2(100),
    director_en_nm VARCHAR2(100)
);

-- 배우 actor_t 테이블
CREATE TABLE actor_t (
    actor_id    VARCHAR2(10) NOT NULL PRIMARY KEY,
    actor_nm    VARCHAR2(100),
    actor_en_nm VARCHAR2(100)
);

-- 영화 movie 테이블
CREATE TABLE movie_t (
/*       */  movie_no    NUMBER NOT NULL PRIMARY KEY,
/* kobis */  movie_cd    VARCHAR2(10)  NOT NULL UNIQUE,
/* kobis */  movie_nm    VARCHAR2(100),
/* kobis */  audi_acc    NUMBER,
/* kobis */  sales_acc   NUMBER,
/* kobis */  open_dt     VARCHAR2(8),
/* kmdb  */  title_eng   VARCHAR2(100),
/* kmdb  */  title_org   VARCHAR2(100),
/* kmdb  */  plot        CLOB,
/* kmdb  */  runtime     NUMBER,
/* kmdb  */  rating      VARCHAR2(30),
/* kmdb  */  genres      VARCHAR2(100),
/* kmdb  */  keywords    VARCHAR2(200),
/* kmdb  */  still_urls  VARCHAR2(2000),
/* kmdb  */  poster_urls VARCHAR2(2000)
);

-- 영화-감독 매칭 movie_director_match_t(mdm) 테이블
CREATE TABLE movie_director_match_t (
    mdm_no      NUMBER NOT NULL PRIMARY KEY,
    movie_no    NUMBER,
    director_id VARCHAR2(10),
    CONSTRAINT fk_mdm_movie FOREIGN KEY(movie_no) REFERENCES movie_t(movie_no) ON DELETE SET NULL,
    CONSTRAINT fk_mdm_director FOREIGN KEY(director_id) REFERENCES director_t(director_id) ON DELETE SET NULL
);

-- 영화-배우 매칭 movie_actor_match_t(mam) 테이블
CREATE TABLE movie_actor_match_t (
    mam_no   NUMBER NOT NULL PRIMARY KEY,
    movie_no NUMBER,
    actor_id VARCHAR2(10),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
    CONSTRAINT fk_mam_movie FOREIGN KEY(movie_no) REFERENCES movie_t(movie_no) ON DELETE SET NULL,
    CONSTRAINT fk_mam_actor FOREIGN KEY(actor_id) REFERENCES actor_t(actor_id) ON DELETE SET NULL
);

-- 상영시간표 runtime_t 테이블
CREATE TABLE runtime_t (
    time_no    NUMBER NOT NULL PRIMARY KEY,
    movie_no   NUMBER,
    start_time VARCHAR2(100),
    CONSTRAINT fk_runtime_movie FOREIGN KEY(movie_no) REFERENCES movie_t(movie_no) ON DELETE SET NULL
);

-- 사용자 user_t 테이블
CREATE TABLE user_t (
    user_no        NUMBER NOT NULL PRIMARY KEY,
    email          VARCHAR2(100) NOT NULL UNIQUE,
    pw             VARCHAR2(64) NOT NULL,
    name           VARCHAR2(100),
    gender         VARCHAR2(5),
    mobile         VARCHAR2(13),
    grade          VARCHAR2(5),
    sns            NUMBER,
    pw_modify_dt   DATE,
    signup_dt      DATE,
    birthyear      VARCHAR2(6),
    age            NUMBER,
    postcode       VARCHAR2(10),
    address        VARCHAR2(100),
    detail_address VARCHAR2(100),
    extra_address  VARCHAR2(100),
    profile_name   VARCHAR2(100),
    profile_path   VARCHAR2(100)
);

-- 접속 기록 access_t 테이블 생성
CREATE TABLE access_t (
    access_no  NUMBER NOT NULL PRIMARY KEY,
    email      VARCHAR2(100),
    ip         VARCHAR2(50),
    user_agent VARCHAR2(150),
    signin_dt  DATE,
    CONSTRAINT fk_user_access FOREIGN KEY(email) REFERENCES user_t(email) ON DELETE CASCADE
);

-- 탈퇴 고객 x_user_t 테이블 생성
CREATE TABLE x_user_t (
    x_user_no  NUMBER NOT NULL PRIMARY KEY,
    email      VARCHAR2(100),
    leave_dt   DATE,
    reason     VARCHAR2(4000)
);

-- 티켓팅 ticketing_t 테이블
CREATE TABLE ticketing_t (
    ticketing_no VARCHAR2(20) NOT NULL PRIMARY KEY,
    user_no      NUMBER,
    time_no      NUMBER,
    movie_no     NUMBER,
    ticket_dt    DATE,
    person_count NUMBER,
    CONSTRAINT fk_ticketing_user FOREIGN KEY(user_no) REFERENCES user_t(user_no) ON DELETE SET NULL,
    CONSTRAINT fk_ticketing_runtime FOREIGN KEY(time_no) REFERENCES runtime_t(time_no) ON DELETE SET NULL,
    CONSTRAINT fk_ticketing_movie FOREIGN KEY(movie_no) REFERENCES movie_t(movie_no) ON DELETE SET NULL
);

-- 좌석 종류 seat_type_t 테이블
CREATE TABLE seat_type_t (
    seat_type_no NUMBER NOT NULL PRIMARY KEY,
    seat_type    VARCHAR2(50)
);

-- 좌석 seat_t 테이블
CREATE TABLE seat_t (
    seat_no      VARCHAR2(50) NOT NULL PRIMARY KEY ,
    seat_code    VARCHAR2(10),
    seat_type_no NUMBER,
    CONSTRAINT fn_seat_seat_type FOREIGN KEY(seat_type_no) REFERENCES seat_type_t(seat_type_no) ON DELETE CASCADE
);

-- 예약좌석 occupied_seat_t 테이블
CREATE TABLE occupied_seat_t (
    occupied_seat_no NUMBER NOT NULL PRIMARY KEY,
    seat_no          VARCHAR2(50),
    time_no          NUMBER,
    ticketing_no     VARCHAR2(20),
    age              NUMBER,
    price            NUMBER,
    CONSTRAINT fk_occupied_seat_runtime FOREIGN KEY(time_no) REFERENCES runtime_t(time_no) ON DELETE CASCADE,
    CONSTRAINT fk_occupied_seat_ticket FOREIGN KEY(ticketing_no) REFERENCES ticketing_t(ticketing_no) ON DELETE CASCADE
);

-- 결제 payment_t 테이블
CREATE TABLE payment_t (
    pay_id        VARCHAR2(50) NOT NULL PRIMARY KEY,
    user_no       NUMBER,
    ticketing_no  VARCHAR2(20),
    pay_method    VARCHAR2(50),
    amount        NUMBER,
    pay_dt        DATE,
    pay_state     VARCHAR2(50),
    cancel_dt     DATE,
    cancel_status VARCHAR2(50),
    CONSTRAINT fk_payment_user FOREIGN KEY(user_no) REFERENCES user_t(user_no) ON DELETE SET NULL,
    CONSTRAINT fk_payment_ticketing FOREIGN KEY(ticketing_no) REFERENCES ticketing_t(ticketing_no) ON DELETE SET NULL
);

-- 리뷰 review_t 테이블
CREATE TABLE review_t (
    review_no    NUMBER NOT NULL PRIMARY KEY,
    movie_no     NUMBER,
    user_no      NUMBER,
    review_score NUMBER,
    review       VARCHAR2(2000),
    review_dt    DATE,
    ticketing_no VARCHAR2(20),
    CONSTRAINT fk_review_movie FOREIGN KEY(movie_no) REFERENCES movie_t(movie_no) ON DELETE SET NULL,
    CONSTRAINT fk_review_user FOREIGN KEY(user_no) REFERENCES user_t(user_no) ON DELETE SET NULL,
    CONSTRAINT fk_review_ticketing FOREIGN KEY(ticketing_no) REFERENCES ticketing_t(ticketing_no) ON DELETE SET NULL
);

-- 무비포스트 moviepost_t 테이블
CREATE TABLE moviepost_t (
    post_no   NUMBER NOT NULL PRIMARY KEY,
    title     VARCHAR2(1000),
    contents  CLOB,
    hit       NUMBER,
    create_dt DATE,
    modify_dt DATE,
    movie_no  NUMBER,
    user_no   NUMBER,
    CONSTRAINT fk_moviepost_movie FOREIGN KEY(movie_no) REFERENCES movie_t(movie_no) ON DELETE CASCADE,
    CONSTRAINT fk_moviepost_user FOREIGN KEY(user_no) REFERENCES user_t(user_no) ON DELETE CASCADE
);

-- 좋아요 like_t 테이블
CREATE TABLE like_t (
    like_no   NUMBER NOT NULL PRIMARY KEY,
    user_no   NUMBER,
    review_no NUMBER,
    post_no   NUMBER,
    CONSTRAINT fk_like_review FOREIGN KEY(review_no) REFERENCES review_t(review_no) ON DELETE CASCADE,
    CONSTRAINT fk_like_post FOREIGN KEY(post_no) REFERENCES moviepost_t(post_no) ON DELETE CASCADE
);

-- 무비포스트댓글 moviepost_comment_t 테이블
CREATE TABLE moviepost_comment_t (
    comment_no  NUMBER,
    contents    VARCHAR2(4000),
    user_no     NUMBER,
    post_no     NUMBER,
    create_dt   DATE,
    state       NUMBER,
    depth       NUMBER,
    group_no    NUMBER,
    group_order NUMBER,
    CONSTRAINT fk_moviepost_review_user FOREIGN KEY(user_no) REFERENCES user_t(user_no) ON DELETE SET NULL,
    CONSTRAINT fk_moviepost_review_moviepost FOREIGN KEY(post_no) REFERENCES moviepost_t(post_no) ON DELETE SET NULL
);

-- 무비포스트 이미지 moviepost_img_t 테이블
CREATE TABLE moviepost_img_t (
    post_img_no NUMBER NOT NULL PRIMARY KEY,
    post_no     NUMBER,
    img_name    VARCHAR2(100),
    img_path    VARCHAR2(100),
    CONSTRAINT fk_moviepost_img_moviepost FOREIGN KEY(post_no) REFERENCES moviepost_t(post_no) ON DELETE CASCADE
);