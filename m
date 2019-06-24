Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DFE5031B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfFXHXd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:23:33 -0400
Received: from sonic315-8.consmr.mail.gq1.yahoo.com ([98.137.65.32]:39534 "EHLO
        sonic315-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727376AbfFXHX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361007; bh=FW+/1lb9mfJ20uNCEwlBFLI4AZF2y/hx1vdOnQyhjdY=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EvR93tzXndNWgONwtPEi2l2LpS70yHxK9cTMzSLH2BSAMdGuZfbEIcr9PeuU/LdG7Cs9mk2kZjiPUFi9g71yyFzdWZ6jJEmbn+AYCHksUJz6kb++Eh6e+MLosBfBKw9xDTTbZfHqtV9Zqx2a7llO1oxAUSipJS4W/Y62dWgw9F2suvdgOhUmLvNE0L5rAQmjef+SlTSSnQ03jon4vbJujpoGtngw+W5fyii6DhArXhuMVxItMPZZ5AvnhZt1c1PwJFbigVMRbCWT+6NyOMlf/rYNo2Kwgzq8HTclZlk/ib/L99z5UedDrRXsrWTq10n7Za4zQvQkytDSqgxj8G3uqg==
X-YMail-OSG: BmGNjvUVM1nT2wSiTXeetZovRRa0Nfhz9plJB0Ohgod.dcukqAMfk8m5dmT5y5E
 W7el6iPtA8Dz1Zg.HhCdm74YVEqfNx0IotRCXyz1ZkBhOua_P3q1RujculgVqlynqFGuYOpgwoZI
 4m1s_a4ws4KbcolsN9yNMURLq5wLc9Ycfz7edfLkJzlH6kUSHpNA4UT1jXdJ8Wm6kBjC2V2EIOWk
 HaVeH2xPfMTIuvSBEXqNchvu5hl5FhkFn_5n.Xg9SL4Ya.Usk.IRxerbR7AW9IULcQDbl0SECUJw
 9Et4bdeew81lkhIoKBMGwMk63dj2EUbQhfnGyoXX0Hpzz6bcmgH6VRHuCduKfesuNKnXrwt.fhhe
 UG.TsnMDcLmpqYm19Shsx1itdW1c.WGhg_4pVfA8QV4691sGhfTJ1ic2tGMvLkDjdM1qg3To3sli
 .BWl6QcNy8dutZLZyr9M7BGhHOVGyqm2ZXxxP6X82eiHy9guEBUgVzX5QJeYHfScacC2Tz02QzQM
 5nGPdV8v6jx7bjhaqULksqRekQ0YcU7VyImdaK5X.mIV7j8kjP4dRRGIfIb6oqhjpc2b1tR5TAjm
 RVrdvjXEuUuTCwN5U6cxU5A8hefwo4COc6W2SpybOr5YN_inmypjczJdMkOSzF5FuVwmXPf.Ob3B
 v5Db2eqZhy.1lQH2N4IyMoTgd1XHe7MwRkV27EMZan7inotDX75G6GjQZ4oPZDQuNA2jnlrQYefT
 40RoUnEQk9F1k02GEI4QzUTyt8FTKuCORyWaVH_YYTLuB.SCqul5xh7QroYATYQ9ZSR.2e9h6eYa
 BcvpIjsHFsoyS3UNNb6DFsxVnSdSWM7vhR0dt1yFXk.dkkLEeUSbJKU0GiFiS22X4qqRty_EoP4U
 pidsryxBFCxstJl6u9KUvwI9PgoxIOiJoI0ICQjT9OjhUcw7D8LWuvccQgHMFT7TqR_G91ENHiqT
 zACk8Jw8BAvT79W07YLwJJk4CWjwsOSiCehPYmPjYLoYvFNI6GQTlKdU.yMIGDO8Y48y4bE4Ub3B
 Mowjff0D44teGmriCodFkL_Er.q70e5pJ7gmhxDr8Vor13J9nX08uxIZ1eY8qx.mDP934_2GPVS0
 W1eE.afxwX_jBx6.ml_XMvDrHFubY5pmvJ_IF1IbM7AJfZE7PI7vnVCJ4SMLzqbTJgiVsyvKnhIw
 AgAH1N5UWZwgud4odeE9tt_mfWklWcJPILK._XoCTV.f0xSJpiLQp0b4shKog3g--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:23:27 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:23:25 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 1/8] staging: erofs: add compacted ondisk compression indexes
Date:   Mon, 24 Jun 2019 15:22:51 +0800
Message-Id: <20190624072258.28362-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch introduces new compacted compression indexes.

In contract to legacy compression indexes that
   each 4k logical cluster has an 8-byte index,
compacted ondisk compression indexes will have
   amortized 2 bytes for each 4k logical cluster (compacted 2B)
   amortized 4 bytes for each 4k logical cluster (compacted 4B)

In detail, several continuous clusters will be encoded in
a compacted pack with cluster types, offsets, and one blkaddr
at the end of the pack to leave 4-byte margin for better
decoding performance, as illustrated below:
   _____________________________________________
  |___@_____ encoded bits __________|_ blkaddr _|
  0       .                                     amortized * vcnt
  .          .
  .             .                   amortized * vcnt - 4
  .                .
  .___________________.
  |_type_|_clusterofs_|

Note that compacted 2 / 4B should be aligned with 32 / 8 bytes
in order to avoid each pack crossing page boundary.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v3:
 - wrap up offset for better readability pointed out by Chao.

 drivers/staging/erofs/data.c      |  4 +-
 drivers/staging/erofs/erofs_fs.h  | 65 ++++++++++++++++++++++++-------
 drivers/staging/erofs/inode.c     |  5 +--
 drivers/staging/erofs/internal.h  | 11 ++----
 drivers/staging/erofs/unzip_vle.c |  8 ++--
 5 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
index 746685f90564..cc31c3e5984c 100644
--- a/drivers/staging/erofs/data.c
+++ b/drivers/staging/erofs/data.c
@@ -124,7 +124,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
 
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
-	lastblk = nblocks - is_inode_layout_inline(inode);
+	lastblk = nblocks - is_inode_flat_inline(inode);
 
 	if (unlikely(offset >= inode->i_size)) {
 		/* leave out-of-bound access unmapped */
@@ -139,7 +139,7 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	if (offset < blknr_to_addr(lastblk)) {
 		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
 		map->m_plen = blknr_to_addr(lastblk) - offset;
-	} else if (is_inode_layout_inline(inode)) {
+	} else if (is_inode_flat_inline(inode)) {
 		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
 		struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
diff --git a/drivers/staging/erofs/erofs_fs.h b/drivers/staging/erofs/erofs_fs.h
index 8ddb2b3e7d39..9a9aaf2d9fbb 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/drivers/staging/erofs/erofs_fs.h
@@ -49,19 +49,29 @@ struct erofs_super_block {
  * erofs inode data mapping:
  * 0 - inode plain without inline data A:
  * inode, [xattrs], ... | ... | no-holed data
- * 1 - inode VLE compression B:
+ * 1 - inode VLE compression B (legacy):
  * inode, [xattrs], extents ... | ...
  * 2 - inode plain with inline data C:
  * inode, [xattrs], last_inline_data, ... | ... | no-holed data
- * 3~7 - reserved
+ * 3 - inode compression D:
+ * inode, [xattrs], map_header, extents ... | ...
+ * 4~7 - reserved
  */
 enum {
-	EROFS_INODE_LAYOUT_PLAIN,
-	EROFS_INODE_LAYOUT_COMPRESSION,
-	EROFS_INODE_LAYOUT_INLINE,
+	EROFS_INODE_FLAT_PLAIN,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY,
+	EROFS_INODE_FLAT_INLINE,
+	EROFS_INODE_FLAT_COMPRESSION,
 	EROFS_INODE_LAYOUT_MAX
 };
 
+static bool erofs_inode_is_data_compressed(unsigned int datamode)
+{
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return true;
+	return datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+}
+
 /* bit definitions of inode i_advise */
 #define EROFS_I_VERSION_BITS            1
 #define EROFS_I_DATA_MAPPING_BITS       3
@@ -176,11 +186,39 @@ struct erofs_xattr_entry {
 	sizeof(struct erofs_xattr_entry) + \
 	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
 
-/* have to be aligned with 8 bytes on disk */
-struct erofs_extent_header {
-	__le32 eh_checksum;
-	__le32 eh_reserved[3];
-} __packed;
+/* available compression algorithm types */
+enum {
+	Z_EROFS_COMPRESSION_LZ4,
+	Z_EROFS_COMPRESSION_MAX
+};
+
+/*
+ * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
+ *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
+ *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ */
+#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
+
+#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+
+struct z_erofs_map_header {
+	__le32	h_reserved1;
+	__le16	h_advise;
+	/*
+	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
+	 * bit 4-7 : algorithm type of head 2 (logical cluster type 11).
+	 */
+	__u8	h_algorithmtype;
+	/*
+	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
+	 * bit 3-4 : (physical - logical) cluster bits of head 1:
+	 *       For example, if logical clustersize = 4096, 1 for 8192.
+	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 */
+	__u8	h_clusterbits;
+};
+
+#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
 
 /*
  * Z_EROFS Variable-sized Logical Extent cluster type:
@@ -236,8 +274,9 @@ struct z_erofs_vle_decompressed_index {
 	} di_u __packed;		/* 8 bytes */
 } __packed;
 
-#define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
-	sizeof(struct z_erofs_vle_decompressed_index))
+#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
+	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
+	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
 
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
@@ -270,7 +309,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	BUILD_BUG_ON(sizeof(struct erofs_inode_v2) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
-	BUILD_BUG_ON(sizeof(struct erofs_extent_header) != 16);
+	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
 	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
 	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
 
diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index e51348f7e838..3539290b8e45 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -127,12 +127,9 @@ static int fill_inline_data(struct inode *inode, void *data,
 {
 	struct erofs_vnode *vi = EROFS_V(inode);
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
-	const int mode = vi->datamode;
-
-	DBG_BUGON(mode >= EROFS_INODE_LAYOUT_MAX);
 
 	/* should be inode inline C */
-	if (mode != EROFS_INODE_LAYOUT_INLINE)
+	if (!is_inode_flat_inline(inode))
 		return 0;
 
 	/* fast symlink (following ext4) */
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 1666cceecb3c..c851d0be6cf6 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -382,19 +382,14 @@ static inline unsigned long inode_datablocks(struct inode *inode)
 	return DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
 }
 
-static inline bool is_inode_layout_plain(struct inode *inode)
-{
-	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_PLAIN;
-}
-
 static inline bool is_inode_layout_compression(struct inode *inode)
 {
-	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_COMPRESSION;
+	return erofs_inode_is_data_compressed(EROFS_V(inode)->datamode);
 }
 
-static inline bool is_inode_layout_inline(struct inode *inode)
+static inline bool is_inode_flat_inline(struct inode *inode)
 {
-	return EROFS_V(inode)->datamode == EROFS_INODE_LAYOUT_INLINE;
+	return EROFS_V(inode)->datamode == EROFS_INODE_FLAT_INLINE;
 }
 
 extern const struct super_operations erofs_sops;
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index f3d0d2c03939..ae62293d5a82 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1642,8 +1642,8 @@ vle_extent_blkaddr(struct inode *inode, pgoff_t index)
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	struct erofs_vnode *vi = EROFS_V(inode);
 
-	unsigned int ofs = Z_EROFS_VLE_EXTENT_ALIGN(vi->inode_isize +
-		vi->xattr_isize) + sizeof(struct erofs_extent_header) +
+	unsigned int ofs = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(vi->inode_isize +
+							  vi->xattr_isize) +
 		index * sizeof(struct z_erofs_vle_decompressed_index);
 
 	return erofs_blknr(iloc(sbi, vi->nid) + ofs);
@@ -1655,8 +1655,8 @@ vle_extent_blkoff(struct inode *inode, pgoff_t index)
 	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
 	struct erofs_vnode *vi = EROFS_V(inode);
 
-	unsigned int ofs = Z_EROFS_VLE_EXTENT_ALIGN(vi->inode_isize +
-		vi->xattr_isize) + sizeof(struct erofs_extent_header) +
+	unsigned int ofs = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(vi->inode_isize +
+							  vi->xattr_isize) +
 		index * sizeof(struct z_erofs_vle_decompressed_index);
 
 	return erofs_blkoff(iloc(sbi, vi->nid) + ofs);
-- 
2.17.1

