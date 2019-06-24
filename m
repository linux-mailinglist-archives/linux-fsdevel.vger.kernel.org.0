Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823775032D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfFXHYQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:24:16 -0400
Received: from sonic308-54.consmr.mail.gq1.yahoo.com ([98.137.68.30]:44531
        "EHLO sonic308-54.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfFXHYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361054; bh=XN4/4Mvu/C7mSe5qfL8p8XSrY/AwGHjOVtbeNaoCeoU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=OPLzPTRiWq/vAyaAy/KRePopVnFkCjp6GT7neMxxViud8D6p5yUE7pvn9KuNtkwDQFvZtwTgpfsU6FlmUf9n1bn55Dc8b37wvISpfaujwDujv363NWncpYQ4+moV1WV/QCeRw2BE7pkEb1tVVFMlfprNuU2K1AoahD20sbhzGf44DsGStlLsVgdIeUsGB6IR30I3E05o1rt4YigjQBqmVZhNh93yWJQ1ycCGxEkPErd2/RT6fzmg+H8YKK24nj/gNIKgXtT36P+5/Ip5uSbnh2tud+T5BbIiV0Wl5slvzoY6S/2/Edug28xGo7tRXVH3NAhMP5LjlArDMFY5rFaMRw==
X-YMail-OSG: U0qtGfoVM1lm2ob0MAZnt3RoHiQSuOYpYGXFrMHsws5KWuEBH61kjNYc.tDVWny
 F3ITfK1tLWI89XIw2WjTexsNGS0jY.ijPmKJbIlnenGs6Q5MW5r6K8KcV10nZACy_d3BsAqEwnq4
 pw3l2GuhmTIrBhZ_0e581dG_SKKJ70hNeh1ahHSBI7fU1C0wlbTvU8_bq66iZ7cL__HSwT4Z.swT
 FVYjneZ91zS3x4fE8GMamiYiLicsZjkYW9JL9OR2gfq.0IAin0MOlLwpPbmytT7hLtTw7LBcHJ.T
 cTfHRXVV8_2qkv4mpWoQ_lyTJzsK3ujdKcpl9y7KywNAVor05vriAUdeLXXnSDS6YtnkNG4vCrMp
 2aDJW663lmF9xjkT.9UICjm8yWACMQQ6TdgDPDiQzcB1xQOa_xPyDs43KfoYwlTRrPFPzHiZqOr3
 3kc.oLZHLqpAHnZmsLVzAYVVQPg8vvTemP4qudjblO2e6V8ptmjKQV1pficM8mtIyhZkhSuj2xnK
 JlYNNnuRtgbvRdaStqAIDo30VRVVR8mfKl.KjzaEHFHrNygcLZypGYxJG2EAZZ.laXbCslV.kqdZ
 gTjZ205wQfmdwuvPhjJ9yY5QVHN9UywHHGtOg3QCh_.Vlus0kL26aa.inJ8tvIHm1CJ86pLXcpW0
 noAAj.WNYbN4l3FCHLwxhYVI5weBmfOj2ZezBokSPtYB22xrlitEEi9AlOnkUk7YaBGHDDIdlcuz
 NgKlE.kgmIzM2F8HupSETKT6rF2s0_lUGpAu2xwNXS2E9BL.qH_GyPL18W7wNN5ZCjtgndvDgIaV
 AkcQC3my28eEo55jKv990wKjAplpvQ0xMfFF0aSFpHddgSOxVRnrJ1i19ukorHXptcrGZJC128JA
 o9vPZ6uJYJnNjI6eDXbfEgKpZh4lxhJWtS66VdjEzQTWGHR1xwaHWvlJBcNXlLhaXi6Op2xyEVSC
 FHoNl1UtVJskDJZMPa2Qtv_N0bsKYDD4ICgKL37rA8S0gsyV4rN.a387bS1k3YJpsZwKdavAbVvt
 LoIjveqPRsMWqsXhhw0jv6DtkAKEhRnMNQhJijjA.A.wbxgKOZgUpxxyGUPEqIGRrLPzama0gBZZ
 R2Fbic0eD.ltBw5lw6oA_vZDQH_rzFgP1dvvZGyzLJjIkDHh7ANT_JNMCfgyhVg9cb9yU7..PJZr
 JP5E18ae3yXHTMpmxftCAk1mMqyk76YLDn_.BNtzKiLf1ZQDOCYgXirvYeFPYWHm_f_E0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:24:14 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:24:09 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 8/8] staging: erofs: integrate decompression inplace
Date:   Mon, 24 Jun 2019 15:22:58 +0800
Message-Id: <20190624072258.28362-9-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

Decompressor needs to know whether it's a partial
or full decompression since only full decompression
can be decompressed in-place.

On kirin980 platform, sequential read is finally
increased to 812MiB/s after decompression inplace
is enabled.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h  |  3 +++
 drivers/staging/erofs/unzip_vle.c | 15 +++++++++++----
 drivers/staging/erofs/unzip_vle.h |  1 +
 drivers/staging/erofs/zmap.c      |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 6c8767d4a1d5..963cc1b8b896 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -441,6 +441,7 @@ extern const struct address_space_operations z_erofs_vle_normalaccess_aops;
  */
 enum {
 	BH_Zipped = BH_PrivateStart,
+	BH_FullMapped,
 };
 
 /* Has a disk mapping */
@@ -449,6 +450,8 @@ enum {
 #define EROFS_MAP_META		(1 << BH_Meta)
 /* The extent has been compressed */
 #define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
 
 struct erofs_map_blocks {
 	erofs_off_t m_pa, m_la;
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index cb870b83f3c8..316382d33783 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -469,6 +469,9 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 				    Z_EROFS_VLE_WORKGRP_FMT_LZ4 :
 				    Z_EROFS_VLE_WORKGRP_FMT_PLAIN);
 
+	if (map->m_flags & EROFS_MAP_FULL_MAPPED)
+		grp->flags |= Z_EROFS_VLE_WORKGRP_FULL_LENGTH;
+
 	/* new workgrps have been claimed as type 1 */
 	WRITE_ONCE(grp->next, *f->owned_head);
 	/* primary and followed work for all new workgrps */
@@ -901,7 +904,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	unsigned int i, outputsize;
 
 	enum z_erofs_page_type page_type;
-	bool overlapped;
+	bool overlapped, partial;
 	struct z_erofs_vle_work *work;
 	int err;
 
@@ -1009,10 +1012,13 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	if (unlikely(err))
 		goto out;
 
-	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen)
+	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen) {
 		outputsize = grp->llen;
-	else
+		partial = !(grp->flags & Z_EROFS_VLE_WORKGRP_FULL_LENGTH);
+	} else {
 		outputsize = (nr_pages << PAGE_SHIFT) - work->pageofs;
+		partial = true;
+	}
 
 	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN)
 		algorithm = Z_EROFS_COMPRESSION_SHIFTED;
@@ -1028,7 +1034,8 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 					.outputsize = outputsize,
 					.alg = algorithm,
 					.inplace_io = overlapped,
-					.partial_decoding = true }, page_pool);
+					.partial_decoding = partial
+				 }, page_pool);
 
 out:
 	/* must handle all compressed pages before endding pages */
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index a2d9b60beebd..ab509d75aefd 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -46,6 +46,7 @@ struct z_erofs_vle_work {
 #define Z_EROFS_VLE_WORKGRP_FMT_PLAIN        0
 #define Z_EROFS_VLE_WORKGRP_FMT_LZ4          1
 #define Z_EROFS_VLE_WORKGRP_FMT_MASK         1
+#define Z_EROFS_VLE_WORKGRP_FULL_LENGTH      2
 
 typedef void *z_erofs_vle_owned_workgrp_t;
 
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
index 1e75cef11db4..9c0bd65c46bf 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -424,6 +424,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			goto unmap_out;
 		}
 		end = (m.lcn << lclusterbits) | m.clusterofs;
+		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
 		/* fallthrough */
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-- 
2.17.1

