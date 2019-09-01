Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BBBA47BD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 07:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfIAFxM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 01:53:12 -0400
Received: from sonic302-20.consmr.mail.gq1.yahoo.com ([98.137.68.146]:45111
        "EHLO sonic302-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725263AbfIAFxM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 01:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1567317191; bh=do/5RPNfrD0Lp3NVbuZg4ow1onuAYFOW2VlQOz+kvis=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=hzi2iebSTtKQ/BqpYJ96U9mRf3g0FqbKuirOzzqYcyL+MNsK1auCJoafXKbVP1mnm+S9i9F8W1TZhj/+wtUl+dXAm09375rbUjo3iP7bFC4rcH+tX6uz+n15oXCuaU16mIwEcJvFSHsYUC/tbuFIZMsygMRHNI8iwpI7pqYCJUTqkVhkTyTG+ig5en1ba6RnBSmHZsuSxK3SG12b0o93D9xVg4+EJE7fDgnJi2ySu6ltAby3HeT2aZKf6zdu/6nX0+6TmtFD0EgawTRxXPi4WggDILlLMNA0ERNzNNM1ZI9grg6ScctNmaOAe97QDCNONnTxFnKM5GQJpHGADfyAYQ==
X-YMail-OSG: mr4XzB4VM1maQtrlLT0tHscNhI3Wcc64WGYEIb7Mcj6jEkJ.Stm_nncgg6Nni.i
 r2qjg9Prqcfy0Zaoio5NsNf8e0ikNwPxo3QDXwWGBzdlOSr_0X.Ri_m0WtodjYeGvMKrrl7LEOk9
 q2th4uvHii_osBWQvq66cBa6BTMax9LUIhymfVe_bD1V7gVH8ksE6CpgRraNKtDsTsTeFa7LLuyk
 U2PHP.v0CdS1q_JMialXa1N01fqavpGHjd2WZqqCucqnTn5vhfZsedHH74.iHtdltqC6VZ47nIdz
 0goqh09cOogkLybZ0cxx8jhOkbVMNMFseT5YV8yT.EHrYAgjmmjWTWZKh8BD1NH315z6eBxskrih
 AlKdOXDTX0rHAn4SiAazo4PxIFvsFOp6CpvgLa3k7ao5naH3Vs1XZuPPje2riTdS7_e8JoybX7Ju
 v.mezk72jmla7GnxnimXGO4Z2hGNK9.2_lGa_NALn.bINXzESpAEMGL_Lr_lq.YuOoZ0i41plbRw
 NKl2XUw9uiWx4PtH26MODcBRHvMMUGrjxanqEFa5Dd4Po7K1qTJS5l_0K2_SFOmiRncBqxJGyYOe
 p4oRj9tycqBQTcZqjDekfwAGXn5vrWnpg1AjjgnnaxhRl1QVjVN6gfGYe1nDHK332NwfZxElcScg
 BH6gfLRWIDrBl3hdh23dStgl6TpO4w9D.vEHlHA4vtvZhp6uG.f7OQNrqjfFOlX6H0ylEVGnu63K
 QEcaGdBAp72TQ3OyczOHWEcwKBptlDxN0NLjvZ.Ka5lLKDLs6R0j1Ey.bs8C1CTd6IPX9oypNzk6
 Qz4DGKZ_VfYtxumjSZHe9JG2JAlJVEbGvvu6R4YriT7xehnyRWBxAHi0DVQbeLbxie1vTqlu2fVk
 FKTJ9ERrUSNhWQ_ulk8Zgu3Cxyda_hl5zNTIq4IFkjH_Vt2H8eaTy8dOBVfajKY_NMFx7M51K60H
 lOViOjHQYW.1MLxI8tIXxXPaNQ74BZjaa9Atu46VWFpUpThCinyI8KlIFms9jsoAhevMz28ndJd0
 NRG6Hd5M3DN.y0H8bdbNmouehTS7iFQ8A4Tkelm_m7TS8LygT0zpi7HL5VXNRbfo24t36PVS.cF1
 55_pN7lBlqihn2wY_UbJb9RwxtKS38VzvGfSFXoUpWUMilm_Fv7xAbUlPqZoQibZkOUFvS8KmvCw
 J7NItqqtbWEZ5bprGnvkxE70IZcNr0tcaews9HIX.v3JdgJpLSddn7IQm7Eiw9hySyF8jSdlpWkZ
 lmsRPP2VTUpl62wrmtHrCMyFURW_BlgJxPmjD1.GJkPnwP71X
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:53:11 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 426e3b5ec1af9e36f409445c51071a70;
          Sun, 01 Sep 2019 05:53:09 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 16/21] erofs: kill magic underscores
Date:   Sun,  1 Sep 2019 13:51:25 +0800
Message-Id: <20190901055130.30572-17-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph said [1], "
> +	vi->datamode = __inode_data_mapping(advise);

What is the deal with these magic underscores here and various
other similar helpers? "

Let avoid magic underscores now...
[1] https://lore.kernel.org/lkml/20190829102426.GE20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/inode.c    |  8 ++++----
 fs/erofs/internal.h | 14 ++++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 19a574ee690b..2ca4eda6e5bf 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -16,7 +16,7 @@ static int read_inode(struct inode *inode, void *data)
 	const unsigned int advise = le16_to_cpu(v1->i_advise);
 	erofs_blk_t nblks = 0;
 
-	vi->datamode = __inode_data_mapping(advise);
+	vi->datamode = erofs_inode_data_mapping(advise);
 
 	if (vi->datamode >= EROFS_INODE_LAYOUT_MAX) {
 		errln("unsupported data mapping %u of nid %llu",
@@ -25,7 +25,7 @@ static int read_inode(struct inode *inode, void *data)
 		return -EOPNOTSUPP;
 	}
 
-	if (__inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
+	if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V2) {
 		struct erofs_inode_v2 *v2 = data;
 
 		vi->inode_isize = sizeof(struct erofs_inode_v2);
@@ -58,7 +58,7 @@ static int read_inode(struct inode *inode, void *data)
 		/* total blocks for compressed files */
 		if (erofs_inode_is_data_compressed(vi->datamode))
 			nblks = le32_to_cpu(v2->i_u.compressed_blocks);
-	} else if (__inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
+	} else if (erofs_inode_version(advise) == EROFS_INODE_LAYOUT_V1) {
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 		vi->inode_isize = sizeof(struct erofs_inode_v1);
@@ -91,7 +91,7 @@ static int read_inode(struct inode *inode, void *data)
 			nblks = le32_to_cpu(v1->i_u.compressed_blocks);
 	} else {
 		errln("unsupported on-disk inode version %u of nid %llu",
-		      __inode_version(advise), vi->nid);
+		      erofs_inode_version(advise), vi->nid);
 		DBG_BUGON(1);
 		return -EOPNOTSUPP;
 	}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 15545959af92..4a35a31fd454 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -308,16 +308,14 @@ struct erofs_inode {
 #define EROFS_I(ptr)	\
 	container_of(ptr, struct erofs_inode, vfs_inode)
 
-#define __inode_advise(x, bit, bits) \
-	(((x) >> (bit)) & ((1 << (bits)) - 1))
+#define erofs_bitrange(x, bit, bits) (((x) >> (bit)) & ((1 << (bits)) - 1))
 
-#define __inode_version(advise)	\
-	__inode_advise(advise, EROFS_I_VERSION_BIT,	\
-		EROFS_I_VERSION_BITS)
+#define erofs_inode_version(advise)	\
+	erofs_bitrange(advise, EROFS_I_VERSION_BIT, EROFS_I_VERSION_BITS)
 
-#define __inode_data_mapping(advise)	\
-	__inode_advise(advise, EROFS_I_DATA_MAPPING_BIT,\
-		EROFS_I_DATA_MAPPING_BITS)
+#define erofs_inode_data_mapping(advise)	\
+	erofs_bitrange(advise, EROFS_I_DATA_MAPPING_BIT, \
+		       EROFS_I_DATA_MAPPING_BITS)
 
 static inline unsigned long inode_datablocks(struct inode *inode)
 {
-- 
2.17.1

