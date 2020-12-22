Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1318C2E0510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLVDyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46487 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgLVDyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609271; x=1640145271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNwDccOmGOQz7MgHjfTb/oJgwO37jM+ib/FFOJnV5UM=;
  b=PnkUtq885nZ8wEFZxQ15267tajcV6hNjvFNJdmHMd2dTtwXac/fgxrjI
   VvDNHoyEEQ2+76xSC88JS1CzF77FLz6SVfwRZH0QrUKT77qYlOYNiSbtv
   f0QaNzDxfmJnmlkW6T2ARzEKbsRqitEJUR8mw5Ce5msU25YUmGStEYO5x
   /+jxdPJQFMhkwzsy5xlkW5bAXbcPmalRtENonN4RrPLdr5EMlHtRfrFnz
   pbLbMXLrGeApuhIw/KW8zB3jtsBRz1014dEnGtKeIHBpng7flaX3Nm9Kk
   utD/fI0n6PUPAjarZ4aGg/AoUNCuL38h7JDxfM62EDG2poKJvuvFDH1Iq
   Q==;
IronPort-SDR: t8V2velhHmPKG/jxoIw/zPzqNMK2wKsI+cZCYUqe7CBImI9LvdlaDTs4FC7r1FWFnAVoON0nKg
 xX96E+2Nt2hK352jhv1UjRD+lYcAfEfqXLYhbdhL7sgQHLVdu54pBTJ1DPaiFZerVLwfQXpan6
 ef36CV6HEIshL2oIf2UmqhUt9CRRJ56/GOBa8yRZXmUzjKt+4dMP5WwmtYmeRzOvACqWyn9Lnu
 cprcwtHfrMUa/19jrk/6RrHEvK2Ff3h48osE6HDsRKl5e6APVsw0qETg3PQ1SNgwmuqAgDOJoh
 61g=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193813"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:02 +0800
IronPort-SDR: TAmC8j8OZYItONk2k2wYs3jIr5CSz4k+cVUGm6oxbG+oCKV8QegLlVyc7tw3FmS1XmbD9mes9k
 rcs8mwxkKpWGKzmtwzpn8qZxtnBqTjI+g3fbRIU8O/SxVhh7QPXRVjELTv1+gZY5nKQpvlSrO0
 vlUo+x5wkOteSsXAaDlBHHrNY4va6UfhnZGlqDg09u297GUfCWeIekdwnP72WbkP/THhSznI9a
 x9vagrplmA8quy4g8USxzOwLRL5sYUvywNV0nXjxDH3uY8ZfjmvvLgDfl17KShgmdzrajB+YFT
 +FHh9e/6MfKSa3/Q2hDaC8my
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:13 -0800
IronPort-SDR: c1MWcVe2NBnfZ4sLdxcnIQTCRMpEMTFSWtt9dDSppbNBzsWf6pCRhYRvyKb4piqkET7TQf2/p0
 Cr02Ym1qJx9ZQDNYetxYUey5WnwNLTm+fSEs41lJ1kufOQq7odt1NTXrSldvWgluTR+Fi7TrTA
 2aSQRvXROQmxKBJgT9HynklW/In5mZREMGN5Jrlg39y4hjno5YSimUCMPIKnBoAoXYa6maBiDb
 KTE9zpvV4Z110sRXrQEFNKaCr+6We1ohXXcGKuI7smM/F+zMgPqI+tRutgkfp9Z0FGYtHMXnWZ
 EuQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 24/40] btrfs: cache if block-group is on a sequential zone
Date:   Tue, 22 Dec 2020 12:49:17 +0900
Message-Id: <8fe22c91f24d5e79c8dbc349538908d7ba0bb2a4.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

In zoned mode, cache if a block-group is on a sequential write only zone.
On sequential write only zones, we can use REQ_OP_ZONE_APPEND for writing
of data, therefore provide btrfs_use_zone_append() to figure out if I/O is
targeting a sequential write only zone and we can use said
REQ_OP_ZONE_APPEND for data writing.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.h |  2 ++
 fs/btrfs/zoned.c       | 29 +++++++++++++++++++++++++++++
 fs/btrfs/zoned.h       |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9df00ada09f9..a1d96c4cfa3b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -184,6 +184,8 @@ struct btrfs_block_group {
 	/* Record locked full stripes for RAID5/6 block group */
 	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
 
+	/* Flag indicating this block-group is placed on a sequential zone */
+	bool seq_zone;
 	/*
 	 * Allocation offset for the block group to implement sequential
 	 * allocation. This is used only with ZONED mode enabled.
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 73e083a86213..72735e948b6e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1068,6 +1068,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 	}
 
+	if (num_sequential > 0)
+		cache->seq_zone = true;
+
 	if (num_conventional > 0) {
 		/*
 		 * Avoid calling calculate_alloc_pointer() for new BG. It
@@ -1188,3 +1191,29 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
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
index 331951978487..92888eb86055 100644
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
@@ -134,6 +135,10 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
+bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
+{
+	return false;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

