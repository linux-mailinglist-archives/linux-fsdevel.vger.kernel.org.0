Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27BA65031F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfFXHXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:23:42 -0400
Received: from sonic311-23.consmr.mail.gq1.yahoo.com ([98.137.65.204]:45160
        "EHLO sonic311-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbfFXHXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361017; bh=YC0Yp26U653djngawgp4vOZPD3bDFaurgseZ424HJIU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=Jfgm6BJ7399mpm8c+ZSnm2kYuTrXDGs9IRtXnypTiju/CAh13p/wTdwnw3MtWK8fU620yaWMW2Wscdq0b/Inoi78ipxgMshfVFMpUzG8iIAHWMMieG1ncFKWG5Ki83lXrQmyM9amCVMxEVRC35qU4F35A/oufIMmRhaplXTJOM0PeQFpVzoKOyay+5WLssuIhTIJul2CsXiu+7lLlqa+E+kDVF4EHn0v5ZNN9LL3l93mdhRl/21O2XwvNP+12+cxZ+2N8QgjrKwXMIEhKi/uyUNK5HvOh1oBMI5zFqCHl4v5qTN/f+TSRlh3PPUFzQfWJV1VZZCFUbKnjVZXLDZF/A==
X-YMail-OSG: 7AkFUd8VM1l73fK1rlXtndVYs0pYgF.bggr38IDr9_CIgPap..wHJZaAzaeu7KP
 PS9mosv4HfFx_y_QgBgs4nURHCOHnA1CaVdDQaiV4R3dxE6UpXuwxrqyEkHlJD0wj6Xa3jyByzR3
 5j5SlnXSkiVXaGoEdisqQlY.8g6rSMbdf4D.pbUV1kPWCQSntuydr5KS.NA48xUoHDobJUDDC1Iw
 2njxb7jpv1PSbmYQypb5VkynevKrJ828_99RSXZUPCHtc7w8GP7.uL8819SgMlXwZPjWuDOHEmnj
 7Tsv4XM6ODTpLhfYXZZK7EZDr6lndtWDvH9JyJh.0tk3jx3KZb1wGqQd5A_rb8O8XuoAm5VogjnG
 GsiRR.X7VzBfyJb0m2NpIWG.jKSW9UecQMSh_mrdcOgDnc0MdlIESoHzSEPWFB5kcRzQMX.B4zKw
 9ZC5rLrpw0GPaF3LAcQlGkeTVsyHJ2ML0HlTpLkAgyCRb1hVa3yth2XrcgTdVvIxN3VJD.SlCXTU
 xBuIR.vxc_Xtp9Gr7cgrBsoajlsIdGRPrdRWqTeQkTXdtN9bJ7oDdjGKi.D1GUGwk42OYi1XJ51I
 KortHOA3nnTzffd3GzgKgcTB87sUq9SuGzwxlySSQiF9dd0gW77XLg9Pv4HqF7e99wGAj3NPcbFh
 XXEnjWVBatgMSNRf54ZHdLhpolaNbhBURAo6JemUffR6hqkafhdqLeOeX_U2DLOymPSNr5.S2xXM
 B2FkLvnVmgZdi3R9wo2Th88u0JhmqHYbwO8E3Lcr_jmpD9zR_EvPB99dUPE1VEyvudApv6bpX5Vz
 yCCs2.qUew9Tfq71EqUPW5gQRYx_Rp8QkMCsAhfQQNN8QTrAk6zeUYP.2i3asrWqzPXkpGyyJHnt
 uk_ms3KR96PxrFeGje0iMvtzuoddAlyIKh5Tqp2qbNQzzpD2NCjuVpUfSHlVtw8E.xXlazfOElM2
 GlgPgidP4f17amSo4aEIE_HOP.Y0QHLJg01PEmdkXgkeS_htKiZkSbFJxtoDeQyoUSkzd4dFzAvx
 5CXLvUtfcDfD1U8SKfbrK3oOQ6lMI8NDqOk7xMeOVp3o.BXF6wqxowqH.XR_PrOHSftBple6xVny
 oHsKfceXg1uz910c2GmCAeJqrSj2eMUomVS0LVzYFt9nTH3rvS3omAiLVMMOoKZSCBsTkZpe5ZCV
 0YCYNSjtYoCI2VO1Gt95TQ9JKfrJOvB2sxo4bXzjTfLI5S7E7VvbNeFJKhqVqb_o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:23:37 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:23:32 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 2/8] staging: erofs: add compacted compression indexes support
Date:   Mon, 24 Jun 2019 15:22:52 +0800
Message-Id: <20190624072258.28362-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch aims at compacted compression indexes:
 1) cleanup z_erofs_map_blocks_iter and move into zmap.c;
 2) add compacted 4/2B decoding support.

On kirin980 platform, sequential read is increased about
6% (725MiB/s -> 770MiB/s) on enwik9 dataset if compacted 2B
feature is enabled.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v3:
 - wrap up offset for better readability pointed out by Chao.

 drivers/staging/erofs/Makefile    |   2 +-
 drivers/staging/erofs/inode.c     |   7 +-
 drivers/staging/erofs/internal.h  |  18 +-
 drivers/staging/erofs/unzip_vle.c | 286 ------------------
 drivers/staging/erofs/zmap.c      | 462 ++++++++++++++++++++++++++++++
 5 files changed, 480 insertions(+), 295 deletions(-)
 create mode 100644 drivers/staging/erofs/zmap.c

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index a34248a2a16a..84b412c7a991 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_EROFS_FS) += erofs.o
 ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o unzip_vle_lz4.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o unzip_vle_lz4.o zmap.o
 
diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
index 3539290b8e45..1d467322bacf 100644
--- a/drivers/staging/erofs/inode.c
+++ b/drivers/staging/erofs/inode.c
@@ -210,12 +210,7 @@ static int fill_inode(struct inode *inode, int isdir)
 		}
 
 		if (is_inode_layout_compression(inode)) {
-#ifdef CONFIG_EROFS_FS_ZIP
-			inode->i_mapping->a_ops =
-				&z_erofs_vle_normalaccess_aops;
-#else
-			err = -ENOTSUPP;
-#endif
+			err = z_erofs_fill_inode(inode);
 			goto out_unlock;
 		}
 
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index c851d0be6cf6..f3063b13c117 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -339,9 +339,11 @@ static inline erofs_off_t iloc(struct erofs_sb_info *sbi, erofs_nid_t nid)
 
 /* atomic flag definitions */
 #define EROFS_V_EA_INITED_BIT	0
+#define EROFS_V_Z_INITED_BIT	1
 
 /* bitlock definitions (arranged in reverse order) */
 #define EROFS_V_BL_XATTR_BIT	(BITS_PER_LONG - 1)
+#define EROFS_V_BL_Z_BIT	(BITS_PER_LONG - 2)
 
 struct erofs_vnode {
 	erofs_nid_t nid;
@@ -356,8 +358,17 @@ struct erofs_vnode {
 	unsigned xattr_shared_count;
 	unsigned *xattr_shared_xattrs;
 
-	erofs_blk_t raw_blkaddr;
-
+	union {
+		erofs_blk_t raw_blkaddr;
+#ifdef CONFIG_EROFS_FS_ZIP
+		struct {
+			unsigned short z_advise;
+			unsigned char  z_algorithmtype[2];
+			unsigned char  z_logical_clusterbits;
+			unsigned char  z_physical_clusterbits[2];
+		};
+#endif
+	};
 	/* the corresponding vfs inode */
 	struct inode vfs_inode;
 };
@@ -447,11 +458,14 @@ struct erofs_map_blocks {
 /* Flags used by erofs_map_blocks() */
 #define EROFS_GET_BLOCKS_RAW    0x0001
 
+/* zmap.c */
 #ifdef CONFIG_EROFS_FS_ZIP
+int z_erofs_fill_inode(struct inode *inode);
 int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags);
 #else
+static inline int z_erofs_fill_inode(struct inode *inode) { return -ENOTSUPP; }
 static inline int z_erofs_map_blocks_iter(struct inode *inode,
 					  struct erofs_map_blocks *map,
 					  int flags)
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index ae62293d5a82..8aea938172df 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1600,289 +1600,3 @@ const struct address_space_operations z_erofs_vle_normalaccess_aops = {
 	.readpages = z_erofs_vle_normalaccess_readpages,
 };
 
-/*
- * Variable-sized Logical Extent (Fixed Physical Cluster) Compression Mode
- * ---
- * VLE compression mode attempts to compress a number of logical data into
- * a physical cluster with a fixed size.
- * VLE compression mode uses "struct z_erofs_vle_decompressed_index".
- */
-#define __vle_cluster_advise(x, bit, bits) \
-	((le16_to_cpu(x) >> (bit)) & ((1 << (bits)) - 1))
-
-#define __vle_cluster_type(advise) __vle_cluster_advise(advise, \
-	Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT, Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS)
-
-#define vle_cluster_type(di)	\
-	__vle_cluster_type((di)->di_advise)
-
-static int
-vle_decompressed_index_clusterofs(unsigned int *clusterofs,
-				  unsigned int clustersize,
-				  struct z_erofs_vle_decompressed_index *di)
-{
-	switch (vle_cluster_type(di)) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		*clusterofs = clustersize;
-		break;
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
-		*clusterofs = le16_to_cpu(di->di_clusterofs);
-		break;
-	default:
-		DBG_BUGON(1);
-		return -EIO;
-	}
-	return 0;
-}
-
-static inline erofs_blk_t
-vle_extent_blkaddr(struct inode *inode, pgoff_t index)
-{
-	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
-	struct erofs_vnode *vi = EROFS_V(inode);
-
-	unsigned int ofs = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(vi->inode_isize +
-							  vi->xattr_isize) +
-		index * sizeof(struct z_erofs_vle_decompressed_index);
-
-	return erofs_blknr(iloc(sbi, vi->nid) + ofs);
-}
-
-static inline unsigned int
-vle_extent_blkoff(struct inode *inode, pgoff_t index)
-{
-	struct erofs_sb_info *sbi = EROFS_I_SB(inode);
-	struct erofs_vnode *vi = EROFS_V(inode);
-
-	unsigned int ofs = Z_EROFS_VLE_LEGACY_INDEX_ALIGN(vi->inode_isize +
-							  vi->xattr_isize) +
-		index * sizeof(struct z_erofs_vle_decompressed_index);
-
-	return erofs_blkoff(iloc(sbi, vi->nid) + ofs);
-}
-
-struct vle_map_blocks_iter_ctx {
-	struct inode *inode;
-	struct super_block *sb;
-	unsigned int clusterbits;
-
-	struct page **mpage_ret;
-	void **kaddr_ret;
-};
-
-static int
-vle_get_logical_extent_head(const struct vle_map_blocks_iter_ctx *ctx,
-			    unsigned int lcn,	/* logical cluster number */
-			    unsigned long long *ofs,
-			    erofs_blk_t *pblk,
-			    unsigned int *flags)
-{
-	const unsigned int clustersize = 1 << ctx->clusterbits;
-	const erofs_blk_t mblk = vle_extent_blkaddr(ctx->inode, lcn);
-	struct page *mpage = *ctx->mpage_ret;	/* extent metapage */
-
-	struct z_erofs_vle_decompressed_index *di;
-	unsigned int cluster_type, delta0;
-
-	if (mpage->index != mblk) {
-		kunmap_atomic(*ctx->kaddr_ret);
-		unlock_page(mpage);
-		put_page(mpage);
-
-		mpage = erofs_get_meta_page(ctx->sb, mblk, false);
-		if (IS_ERR(mpage)) {
-			*ctx->mpage_ret = NULL;
-			return PTR_ERR(mpage);
-		}
-		*ctx->mpage_ret = mpage;
-		*ctx->kaddr_ret = kmap_atomic(mpage);
-	}
-
-	di = *ctx->kaddr_ret + vle_extent_blkoff(ctx->inode, lcn);
-
-	cluster_type = vle_cluster_type(di);
-	switch (cluster_type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		delta0 = le16_to_cpu(di->di_u.delta[0]);
-		if (unlikely(!delta0 || delta0 > lcn)) {
-			errln("invalid NONHEAD dl0 %u at lcn %u of nid %llu",
-			      delta0, lcn, EROFS_V(ctx->inode)->nid);
-			DBG_BUGON(1);
-			return -EIO;
-		}
-		return vle_get_logical_extent_head(ctx,
-			lcn - delta0, ofs, pblk, flags);
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		*flags ^= EROFS_MAP_ZIPPED;
-		/* fallthrough */
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
-		/* clustersize should be a power of two */
-		*ofs = ((u64)lcn << ctx->clusterbits) +
-			(le16_to_cpu(di->di_clusterofs) & (clustersize - 1));
-		*pblk = le32_to_cpu(di->di_u.blkaddr);
-		break;
-	default:
-		errln("unknown cluster type %u at lcn %u of nid %llu",
-		      cluster_type, lcn, EROFS_V(ctx->inode)->nid);
-		DBG_BUGON(1);
-		return -EIO;
-	}
-	return 0;
-}
-
-int z_erofs_map_blocks_iter(struct inode *inode,
-			    struct erofs_map_blocks *map,
-			    int flags)
-{
-	void *kaddr;
-	const struct vle_map_blocks_iter_ctx ctx = {
-		.inode = inode,
-		.sb = inode->i_sb,
-		.clusterbits = EROFS_I_SB(inode)->clusterbits,
-		.mpage_ret = &map->mpage,
-		.kaddr_ret = &kaddr
-	};
-	const unsigned int clustersize = 1 << ctx.clusterbits;
-	/* if both m_(l,p)len are 0, regularize l_lblk, l_lofs, etc... */
-	const bool initial = !map->m_llen;
-
-	/* logicial extent (start, end) offset */
-	unsigned long long ofs, end;
-	unsigned int lcn;
-	u32 ofs_rem;
-
-	/* initialize `pblk' to keep gcc from printing foolish warnings */
-	erofs_blk_t mblk, pblk = 0;
-	struct page *mpage = map->mpage;
-	struct z_erofs_vle_decompressed_index *di;
-	unsigned int cluster_type, logical_cluster_ofs;
-	int err = 0;
-
-	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
-
-	/* when trying to read beyond EOF, leave it unmapped */
-	if (unlikely(map->m_la >= inode->i_size)) {
-		DBG_BUGON(!initial);
-		map->m_llen = map->m_la + 1 - inode->i_size;
-		map->m_la = inode->i_size;
-		map->m_flags = 0;
-		goto out;
-	}
-
-	debugln("%s, m_la %llu m_llen %llu --- start", __func__,
-		map->m_la, map->m_llen);
-
-	ofs = map->m_la + map->m_llen;
-
-	/* clustersize should be power of two */
-	lcn = ofs >> ctx.clusterbits;
-	ofs_rem = ofs & (clustersize - 1);
-
-	mblk = vle_extent_blkaddr(inode, lcn);
-
-	if (!mpage || mpage->index != mblk) {
-		if (mpage)
-			put_page(mpage);
-
-		mpage = erofs_get_meta_page(ctx.sb, mblk, false);
-		if (IS_ERR(mpage)) {
-			err = PTR_ERR(mpage);
-			goto out;
-		}
-		map->mpage = mpage;
-	} else {
-		lock_page(mpage);
-		DBG_BUGON(!PageUptodate(mpage));
-	}
-
-	kaddr = kmap_atomic(mpage);
-	di = kaddr + vle_extent_blkoff(inode, lcn);
-
-	debugln("%s, lcn %u mblk %u e_blkoff %u", __func__, lcn,
-		mblk, vle_extent_blkoff(inode, lcn));
-
-	err = vle_decompressed_index_clusterofs(&logical_cluster_ofs,
-						clustersize, di);
-	if (unlikely(err))
-		goto unmap_out;
-
-	if (!initial) {
-		/* [walking mode] 'map' has been already initialized */
-		map->m_llen += logical_cluster_ofs;
-		goto unmap_out;
-	}
-
-	/* by default, compressed */
-	map->m_flags |= EROFS_MAP_ZIPPED;
-
-	end = ((u64)lcn + 1) * clustersize;
-
-	cluster_type = vle_cluster_type(di);
-
-	switch (cluster_type) {
-	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
-		if (ofs_rem >= logical_cluster_ofs)
-			map->m_flags ^= EROFS_MAP_ZIPPED;
-		/* fallthrough */
-	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
-		if (ofs_rem == logical_cluster_ofs) {
-			pblk = le32_to_cpu(di->di_u.blkaddr);
-			goto exact_hitted;
-		}
-
-		if (ofs_rem > logical_cluster_ofs) {
-			ofs = (u64)lcn * clustersize | logical_cluster_ofs;
-			pblk = le32_to_cpu(di->di_u.blkaddr);
-			break;
-		}
-
-		/* logical cluster number should be >= 1 */
-		if (unlikely(!lcn)) {
-			errln("invalid logical cluster 0 at nid %llu",
-			      EROFS_V(inode)->nid);
-			err = -EIO;
-			goto unmap_out;
-		}
-		end = ((u64)lcn-- * clustersize) | logical_cluster_ofs;
-		/* fallthrough */
-	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
-		/* get the correspoinding first chunk */
-		err = vle_get_logical_extent_head(&ctx, lcn, &ofs,
-						  &pblk, &map->m_flags);
-		mpage = map->mpage;
-
-		if (unlikely(err)) {
-			if (mpage)
-				goto unmap_out;
-			goto out;
-		}
-		break;
-	default:
-		errln("unknown cluster type %u at offset %llu of nid %llu",
-		      cluster_type, ofs, EROFS_V(inode)->nid);
-		err = -EIO;
-		goto unmap_out;
-	}
-
-	map->m_la = ofs;
-exact_hitted:
-	map->m_llen = end - ofs;
-	map->m_plen = clustersize;
-	map->m_pa = blknr_to_addr(pblk);
-	map->m_flags |= EROFS_MAP_MAPPED;
-unmap_out:
-	kunmap_atomic(kaddr);
-	unlock_page(mpage);
-out:
-	debugln("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
-		__func__, map->m_la, map->m_pa,
-		map->m_llen, map->m_plen, map->m_flags);
-
-	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
-
-	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
-	DBG_BUGON(err < 0 && err != -ENOMEM);
-	return err;
-}
-
diff --git a/drivers/staging/erofs/zmap.c b/drivers/staging/erofs/zmap.c
new file mode 100644
index 000000000000..1e75cef11db4
--- /dev/null
+++ b/drivers/staging/erofs/zmap.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * linux/drivers/staging/erofs/zmap.c
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ */
+#include "internal.h"
+#include <asm/unaligned.h>
+#include <trace/events/erofs.h>
+
+int z_erofs_fill_inode(struct inode *inode)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct super_block *const sb = inode->i_sb;
+
+	if (vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+		vi->z_advise = 0;
+		vi->z_algorithmtype[0] = 0;
+		vi->z_algorithmtype[1] = 0;
+		vi->z_logical_clusterbits = EROFS_SB(sb)->clusterbits;
+		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
+		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
+		set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
+	}
+
+	inode->i_mapping->a_ops = &z_erofs_vle_normalaccess_aops;
+	return 0;
+}
+
+static int fill_inode_lazy(struct inode *inode)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct super_block *const sb = inode->i_sb;
+	int err;
+	erofs_off_t pos;
+	struct page *page;
+	void *kaddr;
+	struct z_erofs_map_header *h;
+
+	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
+		return 0;
+
+	if (wait_on_bit_lock(&vi->flags, EROFS_V_BL_Z_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	err = 0;
+	if (test_bit(EROFS_V_Z_INITED_BIT, &vi->flags))
+		goto out_unlock;
+
+	DBG_BUGON(vi->datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+
+	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
+		    vi->xattr_isize, 8);
+	page = erofs_get_meta_page(sb, erofs_blknr(pos), false);
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto out_unlock;
+	}
+
+	kaddr = kmap_atomic(page);
+
+	h = kaddr + erofs_blkoff(pos);
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		errln("unknown compression format %u for nid %llu, please upgrade kernel",
+		      vi->z_algorithmtype[0], vi->nid);
+		err = -ENOTSUPP;
+		goto unmap_done;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 3) & 3);
+
+	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
+		errln("unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
+		      vi->z_physical_clusterbits[0], vi->nid);
+		err = -ENOTSUPP;
+		goto unmap_done;
+	}
+
+	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 5) & 7);
+unmap_done:
+	kunmap_atomic(kaddr);
+	unlock_page(page);
+	put_page(page);
+
+	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
+out_unlock:
+	clear_and_wake_up_bit(EROFS_V_BL_Z_BIT, &vi->flags);
+	return err;
+}
+
+struct z_erofs_maprecorder {
+	struct inode *inode;
+	struct erofs_map_blocks *map;
+	void *kaddr;
+
+	unsigned long lcn;
+	/* compression extent information gathered */
+	u8  type;
+	u16 clusterofs;
+	u16 delta[2];
+	erofs_blk_t pblk;
+};
+
+static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
+				  erofs_blk_t eblk)
+{
+	struct super_block *const sb = m->inode->i_sb;
+	struct erofs_map_blocks *const map = m->map;
+	struct page *mpage = map->mpage;
+
+	if (mpage) {
+		if (mpage->index == eblk) {
+			if (!m->kaddr)
+				m->kaddr = kmap_atomic(mpage);
+			return 0;
+		}
+
+		if (m->kaddr) {
+			kunmap_atomic(m->kaddr);
+			m->kaddr = NULL;
+		}
+		put_page(mpage);
+	}
+
+	mpage = erofs_get_meta_page(sb, eblk, false);
+	if (IS_ERR(mpage)) {
+		map->mpage = NULL;
+		return PTR_ERR(mpage);
+	}
+	m->kaddr = kmap_atomic(mpage);
+	unlock_page(mpage);
+	map->mpage = mpage;
+	return 0;
+}
+
+static int vle_legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					     unsigned long lcn)
+{
+	struct inode *const inode = m->inode;
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	const erofs_off_t ibase = iloc(EROFS_I_SB(inode), vi->nid);
+	const erofs_off_t pos =
+		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
+					       vi->xattr_isize) +
+		lcn * sizeof(struct z_erofs_vle_decompressed_index);
+	struct z_erofs_vle_decompressed_index *di;
+	unsigned int advise, type;
+	int err;
+
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+
+	m->lcn = lcn;
+	di = m->kaddr + erofs_blkoff(pos);
+
+	advise = le16_to_cpu(di->di_advise);
+	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	switch (type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		m->clusterofs = 1 << vi->z_logical_clusterbits;
+		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
+		break;
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		m->pblk = le32_to_cpu(di->di_u.blkaddr);
+		break;
+	default:
+		DBG_BUGON(1);
+		return -EIO;
+	}
+	m->type = type;
+	return 0;
+}
+
+static unsigned int decode_compactedbits(unsigned int lobits,
+					 unsigned int lomask,
+					 u8 *in, unsigned int pos, u8 *type)
+{
+	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
+	const unsigned int lo = v & lomask;
+
+	*type = (v >> lobits) & 3;
+	return lo;
+}
+
+static int unpack_compacted_index(struct z_erofs_maprecorder *m,
+				  unsigned int amortizedshift,
+				  unsigned int eofs)
+{
+	struct erofs_vnode *const vi = EROFS_V(m->inode);
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int vcnt, base, lo, encodebits, nblk;
+	int i;
+	u8 *in, type;
+
+	if (1 << amortizedshift == 4)
+		vcnt = 2;
+	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+		vcnt = 16;
+	else
+		return -ENOTSUPP;
+
+	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	base = round_down(eofs, vcnt << amortizedshift);
+	in = m->kaddr + base;
+
+	i = (eofs - base) >> amortizedshift;
+
+	lo = decode_compactedbits(lclusterbits, lomask,
+				  in, encodebits * i, &type);
+	m->type = type;
+	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		m->clusterofs = 1 << lclusterbits;
+		if (i + 1 != vcnt) {
+			m->delta[0] = lo;
+			return 0;
+		}
+		/*
+		 * since the last lcluster in the pack is special,
+		 * of which lo saves delta[1] rather than delta[0].
+		 * Hence, get delta[0] by the previous lcluster indirectly.
+		 */
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * (i - 1), &type);
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			lo = 0;
+		m->delta[0] = lo + 1;
+		return 0;
+	}
+	m->clusterofs = lo;
+	m->delta[0] = 0;
+	/* figout out blkaddr (pblk) for HEAD lclusters */
+	nblk = 1;
+	while (i > 0) {
+		--i;
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			i -= lo;
+
+		if (i >= 0)
+			++nblk;
+	}
+	in += (vcnt << amortizedshift) - sizeof(__le32);
+	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
+	return 0;
+}
+
+static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					    unsigned long lcn)
+{
+	struct inode *const inode = m->inode;
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = ALIGN(iloc(EROFS_I_SB(inode), vi->nid) +
+					vi->inode_isize + vi->xattr_isize, 8) +
+		sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	unsigned int compacted_4b_initial, compacted_2b;
+	unsigned int amortizedshift;
+	erofs_off_t pos;
+	int err;
+
+	if (lclusterbits != 12)
+		return -ENOTSUPP;
+
+	if (lcn >= totalidx)
+		return -EINVAL;
+
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = (32 - ebase % 32) / 4;
+	if (compacted_4b_initial == 32 / 4)
+		compacted_4b_initial = 0;
+
+	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+	else
+		compacted_2b = 0;
+
+	pos = ebase;
+	if (lcn < compacted_4b_initial) {
+		amortizedshift = 2;
+		goto out;
+	}
+	pos += compacted_4b_initial * 4;
+	lcn -= compacted_4b_initial;
+
+	if (lcn < compacted_2b) {
+		amortizedshift = 1;
+		goto out;
+	}
+	pos += compacted_2b * 2;
+	lcn -= compacted_2b;
+	amortizedshift = 2;
+out:
+	pos += lcn * (1 << amortizedshift);
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
+}
+
+static int vle_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+				      unsigned int lcn)
+{
+	const unsigned int datamode = EROFS_V(m->inode)->datamode;
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return vle_legacy_load_cluster_from_disk(m, lcn);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_load_cluster_from_disk(m, lcn);
+
+	return -EINVAL;
+}
+
+static int vle_extent_lookback(struct z_erofs_maprecorder *m,
+			       unsigned int lookback_distance)
+{
+	struct erofs_vnode *const vi = EROFS_V(m->inode);
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn = m->lcn;
+	int err;
+
+	if (lcn < lookback_distance) {
+		DBG_BUGON(1);
+		return -EIO;
+	}
+
+	/* load extent head logical cluster if needed */
+	lcn -= lookback_distance;
+	err = vle_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		return vle_extent_lookback(m, m->delta[0]);
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		map->m_flags &= ~EROFS_MAP_ZIPPED;
+		/* fallthrough */
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		break;
+	default:
+		errln("unknown type %u at lcn %lu of nid %llu",
+		      m->type, lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EIO;
+	}
+	return 0;
+}
+
+int z_erofs_map_blocks_iter(struct inode *inode,
+			    struct erofs_map_blocks *map,
+			    int flags)
+{
+	struct erofs_vnode *const vi = EROFS_V(inode);
+	struct z_erofs_maprecorder m = {
+		.inode = inode,
+		.map = map,
+	};
+	int err = 0;
+	unsigned int lclusterbits, endoff;
+	unsigned long long ofs, end;
+
+	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
+
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (unlikely(map->m_la >= inode->i_size)) {
+		map->m_llen = map->m_la + 1 - inode->i_size;
+		map->m_la = inode->i_size;
+		map->m_flags = 0;
+		goto out;
+	}
+
+	err = fill_inode_lazy(inode);
+	if (err)
+		goto out;
+
+	lclusterbits = vi->z_logical_clusterbits;
+	ofs = map->m_la;
+	m.lcn = ofs >> lclusterbits;
+	endoff = ofs & ((1 << lclusterbits) - 1);
+
+	err = vle_load_cluster_from_disk(&m, m.lcn);
+	if (err)
+		goto unmap_out;
+
+	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
+	end = (m.lcn + 1ULL) << lclusterbits;
+
+	switch (m.type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		if (endoff >= m.clusterofs)
+			map->m_flags &= ~EROFS_MAP_ZIPPED;
+		/* fallthrough */
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (endoff >= m.clusterofs) {
+			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			break;
+		}
+		/* m.lcn should be >= 1 if endoff < m.clusterofs */
+		if (unlikely(!m.lcn)) {
+			errln("invalid logical cluster 0 at nid %llu",
+			      vi->nid);
+			err = -EIO;
+			goto unmap_out;
+		}
+		end = (m.lcn << lclusterbits) | m.clusterofs;
+		m.delta[0] = 1;
+		/* fallthrough */
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		/* get the correspoinding first chunk */
+		err = vle_extent_lookback(&m, m.delta[0]);
+		if (unlikely(err))
+			goto unmap_out;
+		break;
+	default:
+		errln("unknown type %u at offset %llu of nid %llu",
+		      m.type, ofs, vi->nid);
+		err = -EIO;
+		goto unmap_out;
+	}
+
+	map->m_llen = end - map->m_la;
+	map->m_plen = 1 << lclusterbits;
+	map->m_pa = blknr_to_addr(m.pblk);
+	map->m_flags |= EROFS_MAP_MAPPED;
+
+unmap_out:
+	if (m.kaddr)
+		kunmap_atomic(m.kaddr);
+
+out:
+	debugln("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
+		__func__, map->m_la, map->m_pa,
+		map->m_llen, map->m_plen, map->m_flags);
+
+	trace_z_erofs_map_blocks_iter_exit(inode, map, flags, err);
+
+	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
+	DBG_BUGON(err < 0 && err != -ENOMEM);
+	return err;
+}
+
-- 
2.17.1

