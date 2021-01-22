Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A2E2FFCAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbhAVG1S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:27:18 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbhAVG0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296794; x=1642832794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iTDApfHjxNn23xXxCjyrWAIv04B+IUUueksYv/jar9g=;
  b=cuM/wDqcVIf/l1PQ7+78R571wLMUZ1EOqbEdWCWmCQeRHZB3XEj4AVqB
   QP4/N8XGi69kdlpOaa3HxHKNsxV9jOE2HuVLypS/GVO50MGJcRszYl3y6
   XWeBX7CemOaSJcMHA1f+rvgR8o7qrV1SheZA8Rzd4tuiv163+7X3MDXJl
   eLrvV9oqrdcIS8W7ICQs2r3GKreKTzk2dHg9RArw8EKeW2Ef8fyetEjjV
   Z61/HDbNfHqzuSZEQ9sIQp1N/dyZghyx8rprSM7WB6WfLt2eNfO2rBXXD
   FFXWtbRw7tfMotSGsbq5nahqLDkhsSuvfVWEJiOd1nK8yHhhlATs5kSHI
   A==;
IronPort-SDR: UpGmvzFH4Uu2yhRPxZOqlo7C1WSwGy6PdsHTCsROMLQww5qRy7vdbNv50Qhw58K2CguI4MCzR2
 caGoQcKWuXRbNpE+kdtX1uSl6j4vhweT1bBfStkIdcMqI6S2fKRt5pmytb7ULez2/6HQuD+w0B
 1r00bnGRH0gkeqy7hXRqS3EbQ1Oi/nupbmcRyHZ27MNVLI69xlxCVj9YIfU8wE6ujlIWjcTTKr
 TRk824WOsq+vMZIhoyl0fhE03dEeokYPzMAt6Gu+jfP4poYGZaA62z7uqReh+DUpf8Bqy8/Mmo
 opw=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392019"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:02 +0800
IronPort-SDR: ob+xaI1PAxC6a1ZKr8/hksjmIuRRmD+m7E8Ok+8awhZ0TiUfu7Z5a4Fpqe0E9wCilN+sTE35df
 sYun6s+F+2tfwKVly44U5JaFh0iw0mccp9UCNfAhIj2BZtfHsQI/5O3UZY+GL51Qdo3vqzi6FV
 9ZNmS1HYfgTcd81vxprbzrkCOVTOdhE8mGWe9JAYdzQE1mGZQwi89eRqct/FQg4wa/RMDTtsI+
 Kppv5s6joMgBd1ee2f0oOMFE7Q8oe0YkUyQ9pCEvz92JSqYAAXuBYNDfWEbQhqp5h+lEwU4GW2
 BQHPJto94rluH8/Lx2dcFtcs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:34 -0800
IronPort-SDR: JYIMXcBteC4EIruOzeouzp7Oh6z+ER6Lt8NPCUeGH40AlQGIQaohiVQCMpTiNmTakbM58H2/a7
 EmWn9FmE1DJBGKJvG/J3KphkUJ3yob9xejZlxQ1k4ZBTJDnJdz9WQZHMVivB0EClJuP559HIPn
 BcXEGmSigv3Y1VL1xeJ61fSS9snXVmSUJYWBjILvj60MUoxGBDto/ZsHKoHHBFxmbQsTevjb0A
 KGu0odMt6N+QqZZDIj1VqJOw68Mfxg/vsSJ78y6YwpPdoWqZPOxRnaCX0tScAlpSrZ6jmky3Nv
 itc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:01 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 25/42] btrfs: cache if block-group is on a sequential zone
Date:   Fri, 22 Jan 2021 15:21:25 +0900
Message-Id: <7ff0091533246b3b30d692de42aff19a3fc5f72d.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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
index 77ebc4cc5b07..d026257a43a9 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1103,6 +1103,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 	}
 
+	if (num_sequential > 0)
+		cache->seq_zone = true;
+
 	if (num_conventional > 0) {
 		/*
 		 * Avoid calling calculate_alloc_pointer() for new BG. It
@@ -1223,3 +1226,29 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
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

