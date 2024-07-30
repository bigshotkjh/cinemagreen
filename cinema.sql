/************************* ������ *************************/
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


/************************* ���̺� *************************/
DROP TABLE blog_comment_t;
DROP TABLE image_t;
DROP TABLE blog_t;
DROP TABLE bbs_t;
DROP TABLE x_user_t;
DROP TABLE access_t;
DROP TABLE user_t;

-- ȸ��
CREATE TABLE user_t (
  user_no      NUMBER             NOT NULL,
  email        VARCHAR2(100 BYTE) NOT NULL UNIQUE,
  pw           VARCHAR2(64 BYTE),
  name         VARCHAR2(100 BYTE),
  gender       VARCHAR2(5 BYTE),
  mobile       VARCHAR2(20 BYTE),
  grade        VARCHAR2(20 BYTE),
  sns          NUMBER,  /* ��������(0:����,1:���̹�) */
  pw_modify_dt DATE,
  signup_dt    DATE,
  birthyear    VARCHAR2(100 BYTE),
  age          NUMBER,
  postcode     NUMBER,
  address      VARCHAR2(100 BYTE),
  detailAddress VARCHAR2(100 BYTE),
  extraAddress VARCHAR2(100 BYTE),
  CONSTRAINT pk_user PRIMARY KEY(user_no)
);

-- ���� ���
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

-- Ż�� ȸ��
CREATE TABLE x_user_t (
  x_user_no NUMBER             NOT NULL,
  email         VARCHAR2(100 BYTE) NOT NULL UNIQUE,
  leave_dt      DATE,
  CONSTRAINT pk_x_user PRIMARY KEY(x_user_no)
);

-- ������ �Խ��� (N�� ���)
CREATE TABLE bbs_t (
  bbs_no      NUMBER              NOT NULL,
  contents    VARCHAR2(4000 BYTE) NOT NULL,
  user_no     NUMBER              NOT NULL,
  create_dt   DATE                NULL,
  state       NUMBER              NULL,  -- -1:����, 1:����
  depth       NUMBER              NULL,  -- 0:����, 1:���, 2:����, ...
  group_no    NUMBER              NULL,  -- ���۰� ���ۿ� �޸� ��� ��۵��� ������ GROUP_NO�� ����
  group_order NUMBER              NULL,  -- ���� GROUP_NO ���ο��� ǥ���� ����
  CONSTRAINT pk_bbs PRIMARY KEY(bbs_no),
  CONSTRAINT fk_bbs_user FOREIGN KEY(user_no)
    REFERENCES user_t(user_no) ON DELETE CASCADE
);

-- ��α� (����� �Խ���)
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

-- ��α� ���� �� ����� �̹��� ���
CREATE TABLE image_t (
  blog_no         NUMBER             NOT NULL,
  upload_path     VARCHAR2(100 BYTE),
  filesystem_name VARCHAR2(100 BYTE),
  CONSTRAINT fk_blog_image FOREIGN KEY(blog_no)
    REFERENCES blog_t(blog_no) ON DELETE CASCADE
);

-- ��α� ���
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

/************************* Ʈ���� *************************/
/*
  1. DML (INSERT, UPDATE, DELETE) �۾� ���� �ڵ����� ����Ǵ� �����ͺ��̽� ��ü�̴�.
  2. �� (ROW) ������ �����Ѵ�.
  3. ����
    1) BEFORE : DML ���� ������ ����Ǵ� Ʈ����
    2) AFTER  : DML ���� ���Ŀ� ����Ǵ� Ʈ����
  4. ����
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE | AFTER
    INSERT OR UPDATE OR DELETE
    ON ���̺��
    FOR EACH ROW
    BEGIN
      Ʈ���ź���
    END;
*/

/*
  user_t ���̺��� ������ ȸ�������� x_user_t ���̺� �ڵ����� �����ϴ�
  x_trigger Ʈ���� �����ϱ�
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
  -- COMMIT;  Ʈ���� �������� ������ ������ ROLLBACK, ������ COMMIT �ڵ� ó��
END;
