Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C889728C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfHUGmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:42:32 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10195 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfHUGmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:32 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190821064229epoutp01eabf21a3161f96a16e4f7e0dc30c1af8~83PzoZ59g1005210052epoutp01C
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190821064229epoutp01eabf21a3161f96a16e4f7e0dc30c1af8~83PzoZ59g1005210052epoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369749;
        bh=b8+pMwnDM1Y+1iXK//zi6ce3SJBaE4H69uXsKujU+38=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fVpFb1vrxLo+foImejemmircRJa4mQ8udZOFQ7x9vDDE2Nn21e6P2qonsSIr0HPnH
         r8stAk3Sg8+o6Bt1znwpmKOjdKvcD0zPYiP8QlxkhsgLjoQs1e6UloCjzrU09PYTdp
         VbTsYXoyowkmnf/DoXHNLdrhos2RB1w2u+/XHqkk=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190821064228epcas2p36798da66a85912049d5fd8f3ff0d2590~83Py-NNHH0923809238epcas2p3y;
        Wed, 21 Aug 2019 06:42:28 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.181]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 46Cyl72R0jzMqYkb; Wed, 21 Aug
        2019 06:42:27 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.03.04149.3D7EC5D5; Wed, 21 Aug 2019 15:42:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20190821064226epcas2p2835b8a9084988b79107e54abfc5e7dab~83PxikxcE1369213692epcas2p2w;
        Wed, 21 Aug 2019 06:42:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821064226epsmtrp2483bd0cead0f3a7919ae583776a72772~83PxhkykF2201622016epsmtrp2a;
        Wed, 21 Aug 2019 06:42:26 +0000 (GMT)
X-AuditID: b6c32a46-fedff70000001035-38-5d5ce7d3d23a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.D2.03638.2D7EC5D5; Wed, 21 Aug 2019 15:42:26 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064226epsmtip2bed414e68869ed8e55860f74e737a0bd~83PxE_0pa2463324633epsmtip2C;
        Wed, 21 Aug 2019 06:42:26 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Jens Axboe'" <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
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
Subject: [PATCH 5/9] block: support diskcipher
Date:   Wed, 21 Aug 2019 15:42:26 +0900
Message-ID: <004101d557eb$98b00060$ca100120$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6NYgX/inL1D6QG+VYW/5L6wNPg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxzee3e9q86aW+2214Zs3TmNSsC2W7sXJ9syjbsFl5AtxviBeIEL
        JetXei2DmU1GWEVGBDVbsGWMCFHAMLQ02Cito+CqSOki0Yk6F2MDG4hTPnQ0qGt7NeO/531+
        z5Pn9+SXV4rLXZRSWmy28zYzZ2TIxUR33xp9xvDYrjz10xNyNDtTRaDOgV9xdPKPWhJd/j6M
        oYZIJYH8990S1NEzj6PvxtNQtNOFo+sxpwTV3p3AUSRyikKeu9ckyH8jHf15ew5DRxtvkejK
        sY/QeOMjAvX4LxFo+GwDifqf1QJUHwlgyHl6FqBva+YoFOrY9sFy1ts2grGVXV+w3b+sZIfD
        DtbTfoBkb13rIdmuln3suaZpjK0YvICz/wSukuxBbztgpz2v5S7ZYdxg4LlC3qbizQWWwmJz
        UTaT81n+xnydXq3J0GShdxiVmTPx2cymLbkZm4uN8e6MqoQzOuJULicIzLr3NtgsDjuvMlgE
        ezbDWwuNVo3GmilwJsFhLsossJjWa9RqrS6u3GM0DJ6uIKx1utKQN0iVA1d6NVgkhfTbsP5g
        TFINFkvltA9At/NnID6mANx/MpSaPAKw7WIl/twye3iASGA57Y9bagtE0d8A1sz1gsSApNNh
        V6g9iRU0D0cfPsMTIpx+SsHoVDDpXkZnwomWY0lM0Cth670ImcAyOgtOnothIn4JXjoaTWpw
        +nV4ZrIhtYUK+sITqYBM2PawSSJqFNB9wJkMg/QcBedvhzHRsAk+HutImZfB8ZCXErESTt/3
        kyLeB68eb6ZEcw2AgzFnSvQWdI3uj6dJ4wlrYOfZdQkI6RWw/0Zqt6Wwqu8JJdIyWOWUi8Y3
        4Y9Tw5hIK+GDmq9FmoXzM/VYHXjDtaCka0FJ14Iyrv9jmwDRDl7hrYKpiBe0Vu3CY3tA8l+s
        3ewDLUNbgoCWAmaJzDeyM08u4UqEMlMQQCnOKGSlDTvy5LJCruxL3mbJtzmMvBAEuvgNDuHK
        lwss8V9mtudrdFq9Xp2lQzq9FjGvyjwvjuyS00Wcnf+c56287bkPky5SloPmZt379wKXvenl
        rdW7/7UGLto/pX7q/m179+rzmFux6nHFhTtbgwOuBz+sMOR9crgpp+TJmPrEV76NvVH4wqR9
        D3NlVSR3/fXjN/cuHT/invhLWRIt3ZvTmBbuvaNoPRJb/W7Fx9Kyb4aWd2zrG/odT6N3a011
        /TcPfQjUga6tdTOnRhlCMHCatbhN4P4DeUtx9C0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRzGe3c+dhRHxyn4aqWxMHDWTDF8BxHddS69CUsTG3lSaZvrHHXa
        RYroTAuVQeHmErFBOhG/P3JTcn5MTRlpmoa6Cy3DZWWmpIXlnJF3P3ie5/e+F38KE7vxECpD
        ncVyaoVSQvriXYOSsPNTqzeTL7x4Hoe2fjzEUfP4CIYaFytI9PrJpACZnEU46vtSTaAm228M
        PVo7iVaajRia29URqGLZjSGns0WI2pZnCdT3PhK5lnYEyFCzQKKpuqtorWYbR7a+MRxN95pI
        NPSnAqAqZ78A6Vq3ACp+vCNEjqaEK8FMR8O8gClq1zJdr8KZ6clsps1SSjILszaSaTfnM9ba
        TQFTODGMMV/7Z0imvMMCmM220Hi/RN9LqawyI4floi7f8k2faC3ENZUXcx0ddmEBMEaWAR8K
        0rFwSz+OlwFfSkxbAdxr7ya8QQjsLLFhXg6ArqIhwltaBbDLpSc9AUlHwnaHBXg4kE6DP1/2
        CjyM0U8p2PstyMMBtAy6zXW4h3E6HNZ/dh5sRbQcrlt3BV72h2OGlf0Otb+VQV0r8GrCYPe6
        6fAPp2HPpPvwKRls2KglvJ1AWF2qwyqBv/GIyfjfZDxiMh5Z1ALcAoJZDa9KU/HRmhg1q5Xx
        ChWfrU6T3c5UtYGDE5BKe8DoaIod0BSQ+Il65pOSxYQih89T2QGkMEmgKNeUmCwWpSry7rNc
        ZgqXrWR5OzhB4ZIgUVjmyA0xnabIYu+yrIbl/qUCyiekAOS/7eeGW7IWEtHutfIH1jl6dsr5
        TholUW7jSfdGO9jFTY05S6tvHIiNFmq1x6z5ef0lDlBneHacnRkqOTu7E3H93J2qrfr4lUG9
        HO+UB0S8WZInhC6Gr8bMa4M4pHN9tIgbNnIM5u1P/nvDcfKBD6fiznyPIMqni82dGb8kOJ+u
        iJZiHK/4C+t4TdD+AgAA
X-CMS-MailID: 20190821064226epcas2p2835b8a9084988b79107e54abfc5e7dab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064226epcas2p2835b8a9084988b79107e54abfc5e7dab
References: <CGME20190821064226epcas2p2835b8a9084988b79107e54abfc5e7dab@epcas2p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch supports crypto information to be maintained via BIO
and passed to the storage driver.

To do this, 'bi_aux_private', 'REQ_CYPTE' and 'bi_dun' are added
to the block layer.

'bi_aux_private' is added for loading additional private information into
BIO.
'REQ_CRYPT' is added to distinguish that bi_aux_private is being used
for diskcipher.
F2FS among encryption users uses DUN(device unit number) as
the IV(initial vector) for cryptographic operations.
DUN is stored in 'bi_dun' of bi_iter as a specific value for each BIO.

Before attempting to merge the two BIOs, the operation is also added to
verify that the crypto information contained in two BIOs is consistent.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 block/bio.c               |  1 +
 block/blk-merge.c         | 19 +++++++++++++++++--
 block/bounce.c            |  5 ++++-
 include/linux/bio.h       | 10 ++++++++++
 include/linux/blk_types.h |  4 ++++
 include/linux/bvec.h      |  3 +++
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5476965..c60eb8e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -588,6 +588,7 @@ void __bio_clone_fast(struct bio *bio, struct bio
*bio_src)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_iter = bio_src->bi_iter;
 	bio->bi_io_vec = bio_src->bi_io_vec;
+	bio->bi_aux_private = bio_src->bi_aux_private;
 
 	bio_clone_blkg_association(bio, bio_src);
 	blkcg_bio_issue_init(bio);
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 48e6725..d031257 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -7,6 +7,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/scatterlist.h>
+#include <crypto/diskcipher.h>
 
 #include <trace/events/block.h>
 
@@ -576,6 +577,8 @@ int ll_back_merge_fn(struct request *req, struct bio
*bio, unsigned int nr_segs)
 	if (blk_integrity_rq(req) &&
 	    integrity_req_gap_back_merge(req, bio))
 		return 0;
+	if (blk_try_merge(req, bio) != ELEVATOR_BACK_MERGE)
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
 		req_set_nomerge(req->q, req);
@@ -592,6 +595,8 @@ int ll_front_merge_fn(struct request *req, struct bio
*bio, unsigned int nr_segs
 	if (blk_integrity_rq(req) &&
 	    integrity_req_gap_front_merge(req, bio))
 		return 0;
+	if (blk_try_merge(req, bio) != ELEVATOR_FRONT_MERGE)
+		return 0;
 	if (blk_rq_sectors(req) + bio_sectors(bio) >
 	    blk_rq_get_max_sectors(req, bio->bi_iter.bi_sector)) {
 		req_set_nomerge(req->q, req);
@@ -738,6 +743,9 @@ static struct request *attempt_merge(struct
request_queue *q,
 	    !blk_write_same_mergeable(req->bio, next->bio))
 		return NULL;
 
+	if (!crypto_diskcipher_blk_mergeble(req->bio, next->bio))
+		return NULL;
+
 	/*
 	 * Don't allow merge of different write hints, or for a hint with
 	 * non-hint IO.
@@ -887,9 +895,16 @@ enum elv_merge blk_try_merge(struct request *rq, struct
bio *bio)
 {
 	if (blk_discard_mergable(rq))
 		return ELEVATOR_DISCARD_MERGE;
-	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) ==
bio->bi_iter.bi_sector)
+	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) ==
+					bio->bi_iter.bi_sector) {
+		if (!crypto_diskcipher_blk_mergeble(rq->bio, bio))
+			return ELEVATOR_NO_MERGE;
 		return ELEVATOR_BACK_MERGE;
-	else if (blk_rq_pos(rq) - bio_sectors(bio) ==
bio->bi_iter.bi_sector)
+	} else if (blk_rq_pos(rq) - bio_sectors(bio) ==
+					bio->bi_iter.bi_sector) {
+		if (!crypto_diskcipher_blk_mergeble(bio, rq->bio))
+			return ELEVATOR_NO_MERGE;
 		return ELEVATOR_FRONT_MERGE;
+	}
 	return ELEVATOR_NO_MERGE;
 }
diff --git a/block/bounce.c b/block/bounce.c
index f8ed677..720b065 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -252,7 +252,10 @@ static struct bio *bounce_clone_bio(struct bio
*bio_src, gfp_t gfp_mask,
 	bio->bi_write_hint	= bio_src->bi_write_hint;
 	bio->bi_iter.bi_sector	= bio_src->bi_iter.bi_sector;
 	bio->bi_iter.bi_size	= bio_src->bi_iter.bi_size;
-
+	bio->bi_aux_private = bio_src->bi_aux_private;
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	bio->bi_iter.bi_dun = bio_src->bi_iter.bi_dun;
+#endif
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 	case REQ_OP_SECURE_ERASE:
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3cdb84c..351e65e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -49,6 +49,12 @@
 #define bio_sectors(bio)	bvec_iter_sectors((bio)->bi_iter)
 #define bio_end_sector(bio)	bvec_iter_end_sector((bio)->bi_iter)
 
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+#define bio_dun(bio)            ((bio)->bi_iter.bi_dun)
+#define bio_duns(bio)           (bio_sectors(bio) >> 3) /* 4KB unit */
+#define bio_end_dun(bio)        (bio_dun(bio) + bio_duns(bio))
+#endif
+
 /*
  * Return the data direction, READ or WRITE.
  */
@@ -143,6 +149,10 @@ static inline void bio_advance_iter(struct bio *bio,
struct bvec_iter *iter,
 {
 	iter->bi_sector += bytes >> 9;
 
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	if (iter->bi_dun)
+		iter->bi_dun += bytes >> 12;
+#endif
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -= bytes;
 	else
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 75059c1..117119a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -160,6 +160,8 @@ struct bio {
 	bio_end_io_t		*bi_end_io;
 
 	void			*bi_private;
+	void			*bi_aux_private;
+
 #ifdef CONFIG_BLK_CGROUP
 	/*
 	 * Represents the association of the css and request_queue for the
bio.
@@ -311,6 +313,7 @@ enum req_flag_bits {
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
 	__REQ_FUA,		/* forced unit access */
 	__REQ_PREFLUSH,		/* request for cache flush */
+	__REQ_CRYPT,		/* request inline crypt */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
 	__REQ_BACKGROUND,	/* background IO */
 	__REQ_NOWAIT,           /* Don't wait if request will block */
@@ -343,6 +346,7 @@ enum req_flag_bits {
 #define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
 #define REQ_IDLE		(1ULL << __REQ_IDLE)
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
+#define REQ_CRYPT		(1ULL << __REQ_CRYPT)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
 #define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a032f01..5f89641 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -30,6 +30,9 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed
in
 						   current bvec */
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	u64                     bi_dun;
+#endif
 };
 
 struct bvec_iter_all {
-- 
2.7.4

