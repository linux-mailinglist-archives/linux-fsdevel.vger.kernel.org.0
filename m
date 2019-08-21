Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8C972A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHUGmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:42:51 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10396 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbfHUGmu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:50 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190821064246epoutp01f336c57160295cfc9140dd15fa7737e1~83QEHMPPx1005210052epoutp01e
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190821064246epoutp01f336c57160295cfc9140dd15fa7737e1~83QEHMPPx1005210052epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369766;
        bh=5IRlHuEkcQOCy+sESryaGK2Vl6raRZeU9YxYhLk96AY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TVv8ux+xnM0kzSu9X5T+yL6124jIoIZhVT908IdSRYCpRjPYXl2fk0Bj7h7uTDBhc
         PlUPwkm3fhUR/DK7QcL6f28c+CAh6IrqMYEKTdNsmM3VR5hCTXIfETB6Vffx7cIS/W
         h93zUelUxLBuQwgmbOisxoaJZMq96xBqAzSILO2Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190821064246epcas2p46aa2363c453d0816b5eae31671ceaab1~83QDXRLKm1664716647epcas2p44;
        Wed, 21 Aug 2019 06:42:46 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 46CylS647jzMqYkb; Wed, 21 Aug
        2019 06:42:44 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.3F.04112.4E7EC5D5; Wed, 21 Aug 2019 15:42:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821064244epcas2p1e3d77667eed99670611d9353cf365f8b~83QB6TTuq0242202422epcas2p1e;
        Wed, 21 Aug 2019 06:42:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821064244epsmtrp29678be437d037ce9caa184fdd262a64c~83QB5MerG2242122421epsmtrp2o;
        Wed, 21 Aug 2019 06:42:44 +0000 (GMT)
X-AuditID: b6c32a48-f1fff70000001010-de-5d5ce7e49cf8
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.12.03706.4E7EC5D5; Wed, 21 Aug 2019 15:42:44 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064243epsmtip1e5ee582abd1b9fa164ad5cc11fb9592e~83QBWXge90467104671epsmtip1E;
        Wed, 21 Aug 2019 06:42:43 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Chao Yu'" <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Cc:     "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Chao Yu'" <chao@kernel.org>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>,
        "'Theodore Ts'o'" <tytso@mit.edu>, <dm-devel@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 9/9] fs: f2fs: support diskcipher
Date:   Wed, 21 Aug 2019 15:42:43 +0900
Message-ID: <004501d557eb$a31dd4f0$e9597ed0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6LxzK3qdVI3wS/yWqol0XSZg9A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbdRjH/d1d7465mluH+lt9qzeJbpPS6yj+MGO+ke3itojxjykb4oWe
        lHh9Sa/FsahjZnSAxG4mYtsVsuA0W80EC2LdKCFdXTMEayQssKBzAdGxwUwZxM1NbXss8t/n
        efJ8n+f55slD45oApaVrbC7RaRMkllxB9J5Zh/Knft9dYfCeNaCF640E6hw8i6MvfvaS6PuP
        hzEUTB4gUHTuiAqd7LuFow9mHkRTnQEcjd30qJB38gqOkskuCoUnz6tQ9MIGdPGXGxjyt0+Q
        6KeOrWimfZFAfdFzBBo5FSRR/F8vQL5kP4Y8Xy0A1NByg0KJkzufXcP3nBjH+APdb/O9A3n8
        yLCbD4eaSH7ifB/Jdx/bx58+Oo/x7w99h/PX+kdJ/sOeEODnww+XrSyXNllEwSw6daKtym6u
        sVWXsNteqXyh0lRk4PK5YvQUq7MJVrGELd1elr+lRkp7Z3W1guROp8oEWWYLNm9y2t0uUWex
        y64SVnSYJQfHOfSyYJXdtmp9ld36NGcwGE3pyjcky+TVi8ARf2bPYEOHqh7MbGwGOTRkCuHk
        6I+gGaygNUwEwOZEw1KQAjA2348rwSKAvtBV4o4kmPSTGdYwUQAXw1qFLwMYP1GbYZLZALsT
        oWynXKYXwIH9o0QmwJl/KDiVimU7rWY4eKi9PssEkwe/jXVhGVYzxfDv4ACh8Cp4zj+VZZx5
        BH4zG8SVLXQwMnwFZDiX0cPOnjim1OTCI02e7NqQ2U/D2YNNS4JS+Ov1SyqFV8OZRA+lsBbO
        z0VJhffB0c8/pRRxC4BDNz1LRRthYPpgehqdnrAOdp4qyCBk1sL4haXd7oGNZ25TSloNGz0a
        RfgYbEuNYEpaC/9seU9J8/DWJ73gEHg0sMxkYJnJwDIzgf/HHgVECNwnOmRrtSgbHYXLjx0G
        2b9Yz0fAwA/bY4ChAbtSHRnfVaFRCbVynTUGII2zueo9wfIKjdos1O0VnfZKp1sS5RgwpW9w
        GNfeW2VPf5nNVcmZjEVFhmITMhUZEXu/Onz3+G4NUy24xLdE0SE67+gwOkdbD3aqce/ruo5W
        O+Ur3TGWNO3Fy9800nGtPvlR/9w79gJ5hzS4NpKcmE7dHupY89Clx6Uq77acxHHQ5p7b6p5d
        5Q8eX9gy3faZ47D0ZGnhc1+2YiaKvusP21+pJy57TrcOtXzNbH6Xu/Yi43v1eX1X3kuW+G/8
        2GvGB3y7zP6Xjw3WsYRsEbj1uFMW/gMNo7CALQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSnO6T5zGxBnM/iFl8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBlPH5zn7HgiH3FqdZFrA2Mr4y7GDk5
        JARMJOacn8nWxcjFISSwm1Fi9f4fzBAJKYmt7XugbGGJ+y1HWEFsIYHnjBLH+rJBbDYBbYnN
        x1cxgjSLCOxilDi6s5sNJMEsMI1DYtcHcRBbWMBQYsK8BhYQm0VAVWLnoQ1MIDavgKXE7zkH
        WCBsQYmTM58A2RxAvXoSbRsZIcbIS2x/OwfqBgWJHWdfg8VFgErWbznCBFEjIjG7s415AqPg
        LCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgQnAS3NHYyX
        l8QfYhTgYFTi4d1xMzpWiDWxrLgy9xCjBAezkghvxZyoWCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYp387Uzvve4emXIrU/YToF0zq/051vg7NYSlT
        qDRWr9TJELWe3mih13/ukJJZ7tJ7F4/ULTpzQTQx2k6lwXqnwonfE3Jz77o1Vrh+PvldI6Z3
        890tbEEzXHPM73Y9+LDtwcxJv3/xWehoTf8wr53ZaWpYn2CZ1cQrAr/mbTr9/efZBct+z5Pc
        o8RSnJFoqMVcVJwIAG6nrC7+AgAA
X-CMS-MailID: 20190821064244epcas2p1e3d77667eed99670611d9353cf365f8b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064244epcas2p1e3d77667eed99670611d9353cf365f8b
References: <CGME20190821064244epcas2p1e3d77667eed99670611d9353cf365f8b@epcas2p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

F2FS checks the crypto properties of the inode, and if it is a diskcipher,
sets it to BIO before submitting the BIO.
When using diskcipher, F2FS does not encrypt the data before submitting
the bio and decrypt the data on complete of the BIO.

F2FS uses DUN(device unit number) as the IV(initial vector)
for cryptographic operations.
DUN can support the Garbage collection of f2fs.
Even if a data is moved in the storage device by garbage collection,
the data has same DUN, so that the data can be decrypted.
F2FS calculates DUN of data and sets it to BIO.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 fs/f2fs/data.c | 98
++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/f2fs.h |  2 +-
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3dfefab..c8252bf 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -85,6 +85,52 @@ struct bio_post_read_ctx {
 	unsigned int enabled_steps;
 };
 
+/* device unit number for iv sector */
+#define PG_DUN(i, p)	\
+	((((i)->i_ino & 0xffffffff) << 32) | (p & 0xffffffff))
+
+static inline bool f2fs_may_encrypt_bio(struct inode *inode,
+		struct f2fs_io_info *fio)
+{
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	if (fio && (fio->type != DATA || fio->encrypted_page))
+		return false;
+
+	return (f2fs_encrypted_file(inode) &&
+			fscrypt_disk_encrypted(inode));
+#else
+	return false;
+#endif
+}
+
+static inline bool f2fs_bio_disk_encrypted(unsigned int bi_opf)
+{
+	if (bi_opf & REQ_CRYPT)
+		return true;
+	else
+		return false;
+}
+
+static bool f2fs_mergeable_bio(struct bio *bio, u64 dun, void *ci,
+				bool bio_encrypted)
+{
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	if (!bio)
+		return true;
+
+	/* if both of them are not encrypted, no further check is needed */
+	if (!f2fs_bio_disk_encrypted(bio->bi_opf) && !bio_encrypted)
+		return true;
+
+	if (bio->bi_aux_private == ci)
+		return bio_end_dun(bio) == dun;
+	else
+		return false;
+#else
+	return true;
+#endif
+}
+
 static void __read_end_io(struct bio *bio)
 {
 	struct page *page;
@@ -174,6 +220,9 @@ static void f2fs_read_end_io(struct bio *bio)
 		bio->bi_status = BLK_STS_IOERR;
 	}
 
+	if (f2fs_bio_disk_encrypted(bio->bi_opf))
+		goto end_io;
+
 	if (f2fs_bio_post_read_required(bio)) {
 		struct bio_post_read_ctx *ctx = bio->bi_private;
 
@@ -182,6 +231,7 @@ static void f2fs_read_end_io(struct bio *bio)
 		return;
 	}
 
+end_io:
 	__read_end_io(bio);
 }
 
@@ -362,7 +412,10 @@ static void __submit_merged_bio(struct f2fs_bio_info
*io)
 	if (!io->bio)
 		return;
 
-	bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
+	if (f2fs_bio_disk_encrypted(io->bio->bi_opf))
+		bio_set_op_attrs(io->bio, fio->op, fio->op_flags |
REQ_CRYPT);
+	else
+		bio_set_op_attrs(io->bio, fio->op, fio->op_flags);
 
 	if (is_read_io(fio->op))
 		trace_f2fs_prepare_read_bio(io->sbi->sb, fio->type,
io->bio);
@@ -476,6 +529,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	struct bio *bio;
 	struct page *page = fio->encrypted_page ?
 			fio->encrypted_page : fio->page;
+	struct inode *inode = fio->page->mapping->host;
 
 	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
 			fio->is_por ? META_POR : (__is_meta_io(fio) ?
@@ -502,6 +556,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
 			__read_io_type(page): WB_DATA_TYPE(fio->page));
 
+	if (f2fs_may_encrypt_bio(inode, fio))
+		fscrypt_set_bio(inode, bio, PG_DUN(inode,
fio->page->index));
+
 	__submit_bio(fio->sbi, bio, fio->type);
 	return 0;
 }
@@ -604,6 +661,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
 	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
 	struct page *bio_page;
+	struct inode *inode;
+	bool bio_encrypted;
+	u64 dun;
 
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
@@ -624,6 +684,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	verify_fio_blkaddr(fio);
 
 	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
+	inode = fio->page->mapping->host;
+	dun = PG_DUN(inode, fio->page->index);
+	bio_encrypted = f2fs_may_encrypt_bio(inode, fio);
 
 	/* set submitted = true as a return value */
 	fio->submitted = true;
@@ -633,6 +696,10 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
 			io->last_block_in_bio, fio->new_blkaddr))
 		__submit_merged_bio(io);
+
+	if (!f2fs_mergeable_bio(io->bio, dun,
+			fscrypt_get_diskcipher(inode), bio_encrypted))
+		__submit_merged_bio(io);
 alloc_new:
 	if (io->bio == NULL) {
 		if ((fio->type == DATA || fio->type == NODE) &&
@@ -644,6 +711,9 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		io->bio = __bio_alloc(sbi, fio->new_blkaddr, fio->io_wbc,
 						BIO_MAX_PAGES, false,
 						fio->type, fio->temp);
+		if (bio_encrypted)
+			fscrypt_set_bio(inode, io->bio, dun);
+
 		io->fio = *fio;
 	}
 
@@ -691,7 +761,7 @@ static struct bio *f2fs_grab_read_bio(struct inode
*inode, block_t blkaddr,
 	bio->bi_end_io = f2fs_read_end_io;
 	bio_set_op_attrs(bio, REQ_OP_READ, op_flag);
 
-	if (f2fs_encrypted_file(inode))
+	if (f2fs_encrypted_file(inode) && !fscrypt_disk_encrypted(inode))
 		post_read_steps |= 1 << STEP_DECRYPT;
 
 	if (f2fs_need_verity(inode, first_idx))
@@ -731,6 +801,10 @@ static int f2fs_submit_page_read(struct inode *inode,
struct page *page,
 	}
 	ClearPageError(page);
 	inc_page_count(sbi, F2FS_RD_DATA);
+
+	if (f2fs_may_encrypt_bio(inode, NULL))
+		fscrypt_set_bio(inode, bio, PG_DUN(inode, page->index));
+
 	__submit_bio(sbi, bio, DATA);
 	return 0;
 }
@@ -1665,6 +1739,8 @@ static int f2fs_read_single_page(struct inode *inode,
struct page *page,
 	sector_t last_block_in_file;
 	sector_t block_nr;
 	int ret = 0;
+	bool bio_encrypted;
+	u64 dun;
 
 	block_in_file = (sector_t)page_index(page);
 	last_block = block_in_file + nr_pages;
@@ -1734,6 +1810,15 @@ static int f2fs_read_single_page(struct inode *inode,
struct page *page,
 		__submit_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
+
+	dun = PG_DUN(inode, page->index);
+	bio_encrypted = f2fs_may_encrypt_bio(inode, NULL);
+	if (!f2fs_mergeable_bio(bio, dun, fscrypt_get_diskcipher(inode),
+				bio_encrypted)) {
+		__submit_bio(F2FS_I_SB(inode), bio, DATA);
+		bio = NULL;
+	}
+
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
 				is_readahead ? REQ_RAHEAD : 0, page->index);
@@ -1742,6 +1827,8 @@ static int f2fs_read_single_page(struct inode *inode,
struct page *page,
 			bio = NULL;
 			goto out;
 		}
+		if (f2fs_may_encrypt_bio(inode, NULL))
+			fscrypt_set_bio(inode, bio, dun);
 	}
 
 	/*
@@ -1870,6 +1957,9 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	f2fs_wait_on_block_writeback(inode, fio->old_blkaddr);
 
 retry_encrypt:
+	if (fscrypt_disk_encrypted(inode))
+		return 0;
+
 	fio->encrypted_page = fscrypt_encrypt_pagecache_blocks(fio->page,
 							       PAGE_SIZE, 0,
 							       gfp_flags);
@@ -2804,6 +2894,10 @@ static void f2fs_dio_submit_bio(struct bio *bio,
struct inode *inode,
 	if (!dio)
 		goto out;
 
+	if (dio->inode && fscrypt_has_encryption_key(dio->inode))
+		fscrypt_set_bio(inode, bio, PG_DUN(inode,
+				file_offset >> PAGE_SHIFT));
+
 	dio->inode = inode;
 	dio->orig_end_io = bio->bi_end_io;
 	dio->orig_private = bio->bi_private;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0cbf1d4..8447542 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3706,7 +3706,7 @@ static inline bool f2fs_force_buffered_io(struct inode
*inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (f2fs_post_read_required(inode) &&
!fscrypt_disk_encrypted(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.7.4

