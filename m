Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1212A47BA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfIAFw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 01:52:58 -0400
Received: from sonic301-20.consmr.mail.gq1.yahoo.com ([98.137.64.146]:41759
        "EHLO sonic301-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfIAFw6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 01:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567317177; bh=iKgK3mvVxGQeB6KnRecyHZqxODhGiQC6k6vY5xVKgJQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=nsaedDEnzvXROlfGZibbv/xQVVjG64uU/kX5L2/HF8o1Eu0GISGT2a4pLr1iQo2Mxq4c1xgFfZYlzhyYxbjQmndm/k0x6xSd9RzCCNT6VXOMEkMEcaCxG3czmKUXHDqYLVdV4RAc/S2x/+GQ+4rJU7ma6aA6+lu3Nobq1t59ZhtzUKxmx3DBmyBORKFtP+0avT1qMNcNEj0YrNcHOQZtPr9mlVIds4kOn+P2Mug7PZGs1yGT9gczna/ik/i1+YsjRdh1cEqmm7u6uVWjYSlccW++oBuniIOSq6vh5ID67by3KPqibvpwfW+wRDUqSIUz5HuOhyl67NepnFIM6t73tg==
X-YMail-OSG: N5YY0GsVM1mQoU9e_xpSw.93T6gRUNB9eblDiKCScDMJUpZ6pfP3WlbCr8BNh2s
 Z3KpSv9dEy7SoJqaEzRU_figupwmshXRvHJAUGCZshA9Rtg9S6qwNQkoX659TD5BYauDsW6x5UJ4
 Le9FYRBQA.9IkF3Avg3klqkmQZgzNRt5_4eFcFFH5ywRC.LShIPQ_wPZT2EJKIwz4E9xZWCLuZeu
 xhAdxiZWNsjXNVqi3ebbUOgYlwszNbkjLF1zXPQev0oSNDSnjpHTNtZcedGk.khRIw_CuxaCSV2n
 0KsWf7uqOlzvL6_Q3ZcM2or7HPaDOb8l6tLa7IG_WQ8sL45TkN_DQsOH2QkF3PvRvE86XFJZdVV8
 NAdhL1APBeIA9DSqECsuzqcEdqY5hY1yAnI9GMXXolyMnsvgEvYks7uQdYvH88S93U4flVBgPlf1
 OwAJtjwp6YCreMhQXU.lKE.3syy.9M0.OKJnM00PQzq2E3nr1yjYbYg.tPeyYwn2OTfiLrhl8ENQ
 r8DISzzJFmVwyu8tMRmMpCkWGFvg0P94kWQhOqJJtm64nmCLAFjHyY4EOEdAP.w6cH1y9oF469Io
 U._AC5a8rGkZ4kdE5ayZiNIkUORq7U8BO.HGrcHoQdyCFNsNo.ZiYnFvgDsUECO9VIZB4IpdKTpQ
 oSzsWgwuyc4r5jurgKlIH2TayVcOeqdAUkCnoIiCkHSI3nfYDctUN_V7hBFmzQkK_vU5gYq7okAN
 eyd0YYsPezjqTkrCwpbkLe3M4_c86EM7tCD_BCWY7Mj77GcWmMtJHnZ3fFE8OaO2qiRW1z_J700P
 btSREr2mzdx4XyYJ216bGKaPpb_3yraNwzlwcKY7g38200AetT.exN09JrPbzNeFFmFmht4TTMKI
 3.Y4hY1h_PE09Wc.KVJtRE3KKmVvzeUssWO872SO_dFZfn09xgvYxkkvajQjuZyBkc.9D0sDU2KZ
 0Rac3RLbVnfhzBKCBWX4w0SdvbMHhGp9wEr8vmIJ_EbjIk_e0jCTipFzKEKYRNyjLk_KVlIOB_mU
 8hVKqi7Yw6LbNeQDgNayzSRtAg0hj1etiowfn.dX.46s4w9QGBptCIFjatduGgrSXcDj3Zt2L6_X
 PaDPd0O5nj6qjI1lBQFzSWz7l7dWPGL8nmXK7FSzPoy.B4U4OVghj0NN7oGVSCDP91UbiPg8tqg1
 SllE.nGHXwNEbqD2mlBI06Ayubz9qg40pI6jmajwX08lyoHhamBN.xkIgVZ0OJeEWk0tFTutQPur
 KyDgTw8OI5yQEkdXkIacwvSbZc5P.fD44Xp6u6KDe7RejDDKHEQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:57 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426e3b5ec1af9e36f409445c51071a70;
          Sun, 01 Sep 2019 05:52:52 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 13/21] erofs: simplify erofs_grab_bio() since bio_alloc() never fail
Date:   Sun,  1 Sep 2019 13:51:22 +0800
Message-Id: <20190901055130.30572-14-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph pointed out [1], "erofs_grab_bio tries to
handle a bio_alloc failure, except that the function will
not actually fail due the mempool backing it."

Sorry about useless code, fix it now.

[1] https://lore.kernel.org/lkml/20190830162812.GA10694@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     | 15 ++-------------
 fs/erofs/internal.h | 19 ++-----------------
 fs/erofs/zdata.c    |  2 +-
 3 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e2e40ec2bfd1..621954d4fb09 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -62,12 +62,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 	if (!PageUptodate(page)) {
 		struct bio *bio;
 
-		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio, nofail);
-		if (IS_ERR(bio)) {
-			DBG_BUGON(nofail);
-			err = PTR_ERR(bio);
-			goto err_out;
-		}
+		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio);
 
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 			err = -EFAULT;
@@ -275,13 +270,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = erofs_grab_bio(sb, blknr, nblocks, sb,
-				     read_endio, false);
-		if (IS_ERR(bio)) {
-			err = PTR_ERR(bio);
-			bio = NULL;
-			goto err_out;
-		}
+		bio = erofs_grab_bio(sb, blknr, nblocks, sb, read_endio);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6bd82a82b11f..01749be24f3d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -410,24 +410,9 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 static inline struct bio *erofs_grab_bio(struct super_block *sb,
 					 erofs_blk_t blkaddr,
 					 unsigned int nr_pages,
-					 void *bi_private, bio_end_io_t endio,
-					 bool nofail)
+					 void *bi_private, bio_end_io_t endio)
 {
-	const gfp_t gfp = GFP_NOIO;
-	struct bio *bio;
-
-	do {
-		if (nr_pages == 1) {
-			bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
-			if (!bio) {
-				DBG_BUGON(nofail);
-				return ERR_PTR(-ENOMEM);
-			}
-			break;
-		}
-		bio = bio_alloc(gfp, nr_pages);
-		nr_pages /= 2;
-	} while (!bio);
+	struct bio *bio = bio_alloc(GFP_NOIO, nr_pages);
 
 	bio->bi_end_io = endio;
 	bio_set_dev(bio, sb->s_bdev);
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f06a2fad7af2..abe28565d6c0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1265,7 +1265,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		if (!bio) {
 			bio = erofs_grab_bio(sb, first_index + i,
 					     BIO_MAX_PAGES, bi_private,
-					     z_erofs_vle_read_endio, true);
+					     z_erofs_vle_read_endio);
 			++nr_bios;
 		}
 
-- 
2.17.1

