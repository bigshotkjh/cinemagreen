/************************* 시퀀스 *************************/
DROP SEQUENCE user_seq;
DROP SEQUENCE access_seq;
DROP SEQUENCE x_user_seq;
DROP SEQUENCE bbs_seq;
DROP SEQUENCE blog_seq;
DROP SEQUENCE blog_comment_seq;

CREATE SEQUENCE user_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE access_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE x_user_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE bbs_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE blog_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE blog_comment_seq START WITH 1 INCREMENT BY 1;


/************************* 테이블 *************************/
DROP TABLE blog_comment_t;
DROP TABLE image_t;
DROP TABLE blog_t;
DROP TABLE bbs_t;
DROP TABLE x_user_t;
DROP TABLE access_t;
DROP TABLE user_t;

-- 회원
CREATE TABLE user_t (
  user_no      NUMBER             NOT NULL,
  email        VARCHAR2(100 BYTE) NOT NULL UNIQUE,
  pw           VARCHAR2(64 BYTE),
  name         VARCHAR2(100 BYTE),
  gender       VARCHAR2(5 BYTE),
  mobile       VARCHAR2(20 BYTE),
  sns          NUMBER,  /* 가입형태(0:직접,1:네이버) */
  pw_modify_dt DATE,
  signup_dt    DATE,
  postcode     NUMBER,
  address      VARCHAR2(100 BYTE),
  detailAddress VARCHAR2(100 BYTE),
  extraAddress VARCHAR2(100 BYTE),
  CONSTRAINT pk_user PRIMARY KEY(user_no)
);

-- 접속 기록
CREATE TABLE access_t (
  access_no  NUMBER             NOT NULL,
  email      VARCHAR2(100 BYTE),
  ip         VARCHAR2(50 BYTE),
  user_agent VARCHAR2(150 BYTE),
  session_id VARCHAR2(32 BYTE),
  signin_dt  DATE,
  CONSTRAINT pk_access PRIMARY KEY(access_no),
  CONSTRAINT fk_access_user FOREIGN KEY(email)
      REFERENCES user_t(email) ON DELETE CASCADE
);

-- 탈퇴 회원
CREATE TABLE x_user_t (
  x_user_no NUMBER             NOT NULL,
  email         VARCHAR2(100 BYTE) NOT NULL UNIQUE,
  leave_dt      DATE,
  CONSTRAINT pk_x_user PRIMARY KEY(x_user_no)
);

-- 계층형 게시판 (N차 답글)
CREATE TABLE bbs_t (
  bbs_no      NUMBER              NOT NULL,
  contents    VARCHAR2(4000 BYTE) NOT NULL,
  user_no     NUMBER              NOT NULL,
  create_dt   DATE                NULL,
  state       NUMBER              NULL,  -- -1:삭제, 1:정상
  depth       NUMBER              NULL,  -- 0:원글, 1:답글, 2:답답글, ...
  group_no    NUMBER              NULL,  -- 원글과 원글에 달린 모든 답글들은 동일한 GROUP_NO를 가짐
  group_order NUMBER              NULL,  -- 같은 GROUP_NO 내부에서 표시할 순서
  CONSTRAINT pk_bbs PRIMARY KEY(bbs_no),
  CONSTRAINT fk_bbs_user FOREIGN KEY(user_no)
    REFERENCES user_t(user_no) ON DELETE CASCADE
);

-- 블로그 (댓글형 게시판)
CREATE TABLE blog_t (
  blog_no   NUMBER               NOT NULL,
  title     VARCHAR2(1000 BYTE)  NOT NULL,
  contents  CLOB,
  hit       NUMBER,
  user_no   NUMBER               NOT NULL,
  create_dt DATE,
  modify_dt DATE,
  CONSTRAINT pk_blog PRIMARY KEY(blog_no),
  CONSTRAINT fk_blog_user FOREIGN KEY(user_no)
      REFERENCES user_t(user_no) ON DELETE CASCADE
);

-- 블로그 만들 때 사용한 이미지 목록
CREATE TABLE image_t (
  blog_no         NUMBER             NOT NULL,
  upload_path     VARCHAR2(100 BYTE),
  filesystem_name VARCHAR2(100 BYTE),
  CONSTRAINT fk_blog_image FOREIGN KEY(blog_no)
    REFERENCES blog_t(blog_no) ON DELETE CASCADE
);

-- 블로그 댓글
CREATE TABLE blog_comment_t (
  comment_no  NUMBER NOT NULL,
  user_no     NUMBER,
  blog_no     NUMBER,
  contents    VARCHAR2(1000 BYTE),
  create_dt   DATE,
  state       NUMBER,
  depth       NUMBER,
  group_no    NUMBER,
  group_order NUMBER,
  CONSTRAINT pk_comment PRIMARY KEY(comment_no),
  CONSTRAINT fk_comment_user FOREIGN KEY(user_no)
    REFERENCES user_t(user_no) ON DELETE CASCADE,
  CONSTRAINT fk_comment_blog FOREIGN KEY(blog_no)
    REFERENCES blog_t(blog_no) ON DELETE CASCADE
);

/************************* 트리거 *************************/
/*
  1. DML (INSERT, UPDATE, DELETE) 작업 이후 자동으로 실행되는 데이터베이스 객체이다.
  2. 행 (ROW) 단위로 동작한다.
  3. 종류
    1) BEFORE : DML 동작 이전에 실행되는 트리거
    2) AFTER  : DML 동작 이후에 실행되는 트리거
  4. 형식
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE | AFTER
    INSERT OR UPDATE OR DELETE
    ON 테이블명
    FOR EACH ROW
    BEGIN
      트리거본문
    END;
*/

/*
  user_t 테이블에서 삭제된 회원정보를 x_user_t 테이블에 자동으로 삽입하는
  x_trigger 트리거 생성하기
*/
CREATE OR REPLACE TRIGGER x_trigger
  AFTER
  DELETE
  ON user_t
  FOR EACH ROW
BEGIN
  INSERT INTO x_user_t (
      x_user_no
    , email
    , leave_dt
  ) VALUES (
      x_user_seq.NEXTVAL
    , :OLD.email
    , current_date
  );
  -- COMMIT;  트리거 내에서는 오류가 있으면 ROLLBACK, 없으면 COMMIT 자동 처리
END;
