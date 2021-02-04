Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFA30F0B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbhBDK2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:28:13 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhBDK1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434451; x=1643970451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6mD6KGXYIqq4AlpFryLdPvhIfjgM86x/lbMTwNm6PY=;
  b=Csig+VJyEbFWvDvzhsxW24mq4ybGQ5uNJuCWW89qAP/ZviDVXlSVm9Du
   M6mlPkIsmmnOGK+AdMXnHdXPKvNNFNZumnqCJYfi1zKGDcrV1Dv6tP8r8
   A/sFpgNztbYbJMjrPMNJfh+EgHrdhlU9kOMjXxCEBi1DZXnrgD4CRoHke
   MgqubMEYCZUO6SadSodg/gxJBQnfQ+YIhnSARPqUY8Jxuuo8ZHQhQYcyc
   Ok0rf+PVF8NYDMnTWkLsFV0nVrpYeVRFoUPE6K7XiDTaIHcFSXJs24cKs
   7tS7H/fAWtuhitlyoawf1uyilFaoRZrvR/x3BGVqi+BlQ739RLjHpM0++
   g==;
IronPort-SDR: PeUfwyiq5CiKf+XMyXnBSl/Nw7hD9FOdo9WePRDQGcXmLMlXY4thyiWYv6h446F/owY1vfgNpX
 r3jM5hyawlA6TLgyFoG8VRrHJMtDEEa8PZWVnMAclHcbqHN8R2+fzI4hMeZu0fwhwgL4zx2R2f
 8+kRqLHaAIC3agNfjXjy6ZsLs0bt9WwgXUpx6ROL6kazJfc6PjzmTqW5Hmc3hO/cjxQZV/FNiA
 bmJO58F4hXsbZUlRoeksYIHn36PL2vX5FGvKA23cLgZJMeTBlrM5GfuBN80Lb7lHhRTomICDp7
 KGQ=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108026"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:28 +0800
IronPort-SDR: eo/k+7RZpTd4Tj9Skj6KYgPh5kszll+GHqa6mYOAucd9fn9WwQnY4vp6DBkrBVHCoZtWuAVa+h
 dCe3H3eFPBx0cto8IcAGiUQeyLodvNdHxF+5Zh1OvRa6g6Jqi5HVduRvMF0U7rJDIx1/yQcAQs
 nsilbKpNnt+M2FNxdsvpTr22y+eQrSFHA8Qu2NKqmoJHGSaw4rS6FV8GH14eyljsDfjF3wWj86
 Y3l+fhLyUZt2zUiTYgN4GJFCriYCi70j32I7azvUcemv4dY7FU5LM3Oy08yixDUK/5sOWrC4IX
 70+7QpvzDu+NFN3qt6CmPw0/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:32 -0800
IronPort-SDR: HQwWMnu/EoHRbD37xrEKRzPuJKTv2uPWOy7Lh+wqM/CTEqnHdQbK28rtqs17Y9GzFXqG/KcbTx
 4Azc8gjI3piwtkk+WblhK9pzMdohvCTVuMnzuXTkvDNzv0eC+c8Z/zYWbr62Y58NegRcfGNMdb
 16V9HoQZ7bv/cWD8CNDffQBZeJKKGhXzjPff63oj4xi4dsl6X/A7jkctsHlrzA9aG0TRpDFlhg
 z+c0CUZCnR+Ybms11ifeVGibRcx+gofus5l7Juua9tlwLKp+vIYhb7UhLUfyf50PAlqPSZ6qy/
 5ts=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:27 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 24/42] btrfs: zoned: cache if block-group is on a sequential zone
Date:   Thu,  4 Feb 2021 19:22:03 +0900
Message-Id: <feee22c518293509876c89ac766a09786d566973.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

On a zoned filesystem, cache if a block-group is on a sequential write
only zone.

On sequential write only zones, we can use REQ_OP_ZONE_APPEND for writing
of data, therefore provide btrfs_use_zone_append() to figure out if I/O is
targeting a sequential write only zone and we can use REQ_OP_ZONE_APPEND
for data writing.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.h |  3 +++
 fs/btrfs/zoned.c       | 29 +++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  6 ++++++
 3 files changed, 38 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index d14ac03bb93d..31c7c5872b92 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -181,6 +181,9 @@ struct btrfs_block_group {
 	 */
 	int needs_free_space;
 
+	/* Flag indicating this block group is placed on a sequential zone */
+	bool seq_zone;
+
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1de67d789b83..f6c68704c840 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1101,6 +1101,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 	}
 
+	if (num_sequential > 0)
+		cache->seq_zone = true;
+
 	if (num_conventional > 0) {
 		/*
 		 * Avoid calling calculate_alloc_pointer() for new BG. It
@@ -1218,3 +1221,29 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	}
 	spin_unlock(&trans->releasing_ebs_lock);
 }
+
+bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_block_group *cache;
+	bool ret = false;
+
+	if (!btrfs_is_zoned(fs_info))
+		return false;
+
+	if (!fs_info->max_zone_append_size)
+		return false;
+
+	if (!is_data_inode(&inode->vfs_inode))
+		return false;
+
+	cache = btrfs_lookup_block_group(fs_info, em->block_start);
+	ASSERT(cache);
+	if (!cache)
+		return false;
+
+	ret = cache->seq_zone;
+	btrfs_put_block_group(cache);
+
+	return ret;
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index c105641a6ad3..14d578328cbe 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -46,6 +46,7 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
+bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -133,6 +134,11 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
+static inline bool btrfs_use_zone_append(struct btrfs_inode *inode,
+					 struct extent_map *em)
+{
+	return false;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.30.0

