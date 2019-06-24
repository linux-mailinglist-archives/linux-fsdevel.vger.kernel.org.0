Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42DFA50328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfFXHYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:24:00 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30]:43504
        "EHLO sonic308-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727828AbfFXHYA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361039; bh=FJEynATfKJ6xd0ZUUtfTGwYABlX64SzTN7wKLwUjSUQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XFAFuePvgAiDMR1ZEgZQmNmaPqWC+Io05Dq34XhXCG91W4DL3C0oxdrR3eBrSi3Zs//EBKb5SOb3Wh677MJzynO4QTLUYpi0AFPb3o+0cBM69MLRpMPAQaz5DfWbDwC9BdbcZTB0q4f2S5LZo2FBLg4R7kSJ9Wk8AxLE3L/09Y5OExTO5DA6/8I9FPRxp3XLMZtSgpod2jw5S8A31cT0M1jlYBdMWddpYTD+E6gay87fWQY3J32gK3eM/1Tj9A9PH+k+PDkpOrvD0Gno0oJ263q7ycjH+lqu8HvJghlJNhOQaGIKsaH54g1co5DJXx2qsDcq9om04WbtbWqgOQlTmw==
X-YMail-OSG: oRDi.XYVM1kio_XOt2sm4xAB9l0ZQM83N.dZb2PJqyYScJ2P3aeoPA3is211uPY
 dTV3pIwCn1GhuJobnR5Eg4rt1V2VWIm999OsGL3zVlVIYqBAa1mcAN_fjkbB4g2PZIWyfSqO_Ksx
 QW1wlAtuXbHE_WikvHbH2BKYoZSvrEx0hez2xcOFDlOJnWvy7dQavfoQdtVSGTDyTdK7i223zcCF
 ziRj1wOkQ5fiL1uasjdFVSs6nrMeTaGCpuWUincJQzHxc41LOQzxgeifVBtgwXmQa.S_tajjSRCA
 w2eVLrrK0YgsfGziwB2dzBi_Vf0fRK0bCaXU6_XaZKONdeLLMQG8gyYOMYmg2.YYJGn0n5LGQxn3
 bzjih4nhGGMuyIyde4Jop75fFMVgiXr9K6mRwxNY2mwI3pPzyCZFzM9P_iqeYGbakmALpm1jD6hu
 uwEOxddHuHWp_S5RUNoWHZYnbRS16De55U.PL5M..p2Mm.D7_cUOs9.471xmNOSfzxOSwUuQObVB
 n9YD_uuvzR4GqU2sZA6ZW8tFvN79qBFDbI6i2kbc99OIA7CILH0M64zcs_WYYRCxBx0eHM_UAyu7
 qYTHOQh2eWKKqDXZ1UggMAZ81BTwBXw99DbST7CsdG.ZfSuGEYYdJV1X2iIAdSVQYL.wg4Xw9xaW
 0GqT4IrGI9knFpWrbvvvbaAflwpC2jH_Ikfe5xKmCMB.gvwj1uMNePVHT0eijBZh_CnJNLZjZsiw
 3Wckk23e1T1XOkTookcqWQlULeDEMnQfUGxg7GrjZgu4UBfSiB9IKOqsTZJdhW0KRuSE72WB1vSz
 AyeoH.lcp4aj.Zzl07agXaWO2wfiIHH7Dg4Bbk_sKAapTv0vXeXjSDrMqW76wrGxfqsi_FK6Y83j
 wBfOGeuzfojTnMlEdszgDY.rw6G4xvEDqUcyuVEfTVyjze4yw70cwrlecOBXRFlXwrDLQIHeLj9F
 8s6DYgCGDQlfQ4FPRG5UouEYOmb3jDoxfYfPWrvNjAEVO_PCIE8K2TdhPx8YYX9rxaD5CQw0y73f
 LpGu7390mf5uEdhVEYhKMClstvaRjLD5tyH7yl7niJ_.zCl__ZcsYkf6FhgsawAm2pl6_QrEGBum
 64fN7PD_re6SXwEEu5.4H8aYQxF6.Sw3IMcTiJf3Ky4.TPRN0Mj3aEzxksMaDMDGuO.q.b2aq9vf
 kvFiGhE2lh0wYAH8o4ePwilaBjwM35wOM8SzEW7u1ExYs9Gu_Pcab4yhyyJ67BWtw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:23:59 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:23:56 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 6/8] staging: erofs: introduce LZ4 decompression inplace
Date:   Mon, 24 Jun 2019 15:22:56 +0800
Message-Id: <20190624072258.28362-7-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

compressed data will be usually loaded into last pages of
the extent (the last page for 4k) for in-place decompression
(more specifically, in-place IO), as ilustration below,

         start of compressed logical extent
           |                          end of this logical extent
           |                           |
     ______v___________________________v________
... |  page 6  |  page 7  |  page 8  |  page 9  | ...
    |__________|__________|__________|__________|
           .                         ^ .        ^
           .                         |compressed|
           .                         |   data   |
           .                           .        .
           |<          dstsize        >|<margin>|
                                       oend     iend
           op                        ip

Therefore, it's possible to do decompression inplace (thus no
memcpy at all) if the margin is sufficient and safe enough [1],
and it can be implemented only for fixed-size output compression
compared with fixed-size input compression.

No memcpy for most of in-place IO (about 99% of enwik9) after
decompression inplace is implemented and sequential read will
be improved of course (see the following patches for test results).

[1] https://github.com/lz4/lz4/commit/b17f578a919b7e6b078cede2d52be29dd48c8e8c
    https://github.com/lz4/lz4/commit/5997e139f53169fa3a1c1b4418d2452a90b01602

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/compress.h     |  1 +
 drivers/staging/erofs/decompressor.c | 36 ++++++++++++++++++++++++----
 drivers/staging/erofs/erofs_fs.h     |  3 ++-
 3 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/compress.h b/drivers/staging/erofs/compress.h
index ebeccb1f4eae..c43aa3374d28 100644
--- a/drivers/staging/erofs/compress.h
+++ b/drivers/staging/erofs/compress.h
@@ -17,6 +17,7 @@ enum {
 };
 
 struct z_erofs_decompress_req {
+	struct super_block *sb;
 	struct page **in, **out;
 
 	unsigned short pageofs_out;
diff --git a/drivers/staging/erofs/decompressor.c b/drivers/staging/erofs/decompressor.c
index df8fd68a338b..80f1f39719ba 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/drivers/staging/erofs/decompressor.c
@@ -14,6 +14,9 @@
 #endif
 
 #define LZ4_MAX_DISTANCE_PAGES	DIV_ROUND_UP(LZ4_DISTANCE_MAX, PAGE_SIZE)
+#ifndef LZ4_DECOMPRESS_INPLACE_MARGIN
+#define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
+#endif
 
 struct z_erofs_decompressor {
 	/*
@@ -112,7 +115,7 @@ static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 {
 	unsigned int inputmargin, inlen;
 	u8 *src;
-	bool copied;
+	bool copied, support_0padding;
 	int ret;
 
 	if (rq->inputsize > PAGE_SIZE)
@@ -120,13 +123,38 @@ static int lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 
 	src = kmap_atomic(*rq->in);
 	inputmargin = 0;
+	support_0padding = false;
+
+	/* decompression inplace is only safe when 0padding is enabled */
+	if (EROFS_SB(rq->sb)->requirements & EROFS_REQUIREMENT_LZ4_0PADDING) {
+		support_0padding = true;
+
+		while (!src[inputmargin & ~PAGE_MASK])
+			if (!(++inputmargin & ~PAGE_MASK))
+				break;
+
+		if (inputmargin >= rq->inputsize) {
+			kunmap_atomic(src);
+			return -EIO;
+		}
+	}
 
 	copied = false;
 	inlen = rq->inputsize - inputmargin;
 	if (rq->inplace_io) {
-		src = generic_copy_inplace_data(rq, src, inputmargin);
-		inputmargin = 0;
-		copied = true;
+		const uint oend = (rq->pageofs_out +
+				   rq->outputsize) & ~PAGE_MASK;
+		const uint nr = PAGE_ALIGN(rq->pageofs_out +
+					   rq->outputsize) >> PAGE_SHIFT;
+
+		if (rq->partial_decoding || !support_0padding ||
+		    rq->out[nr - 1] != rq->in[0] ||
+		    rq->inputsize - oend <
+		      LZ4_DECOMPRESS_INPLACE_MARGIN(inlen)) {
+			src = generic_copy_inplace_data(rq, src, inputmargin);
+			inputmargin = 0;
+			copied = true;
+		}
 	}
 
 	ret = LZ4_decompress_safe_partial(src + inputmargin, out,
diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 9a9aaf2d9fbb..9f61abb7c1ca 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -21,7 +21,8 @@
  * Any bits that aren't in EROFS_ALL_REQUIREMENTS should be
  * incompatible with this kernel version.
  */
-#define EROFS_ALL_REQUIREMENTS  0
+#define EROFS_REQUIREMENT_LZ4_0PADDING	0x00000001
+#define EROFS_ALL_REQUIREMENTS		EROFS_REQUIREMENT_LZ4_0PADDING
 
 struct erofs_super_block {
 /*  0 */__le32 magic;           /* in the little endian */
-- 
2.17.1

