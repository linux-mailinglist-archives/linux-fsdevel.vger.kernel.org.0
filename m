Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D412F7348
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbhAOG7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730008AbhAOG7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693961; x=1642229961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GAnczFidO7iFYKvl2xGT3RTr3YtuD9PBLHPuewv8gkY=;
  b=NlnSofVHnW7AtWx2krNhYIKttq2LVoAPvPjra0LgHpAxQWL1yD8Fbdce
   qUERWqKG0dI+v8sMWGHU9/Opel3d7J9EvODq1GvRb7jsMshql0mhSOH/F
   jWdVj6CKWZ5NMkeAo+yow9aulO5MCsIhaUVWqo6+AMueIBX2P2a6Z8cXS
   O/pLuKgHW5u/7cxZLeUi1PwbzGnXvl8AT7OZhvRR3A/y0v7dLwiDjv4pU
   YN67qAiVepLwEChbmrx4hc2SGqosz/1Yo7/iGPYWp+KdVKP+lBQK8x6we
   iOJW6E9XfYi5bR1cP8qlbQ2cdPVwesMVBRfN6Wnt7/QIy+3tlpeaQucDO
   g==;
IronPort-SDR: GKy95HN+m2tQ3Jz1iDUHP+8N2ftR5gbQioZDc3QeONmHpMpfYNF6zUYbAXNV/AQCyvE0uUwN2E
 oBlJ/lTczfYlK6JLopBIpn6h17cbRcAehVyX+Jr8rJigdboXIVaIl5zRFGg+pb/VTQeoL+KuyP
 jyCR3ILO/exfctlHUMXcJhsIgcSzmDN0bz8ea6NtqPl28vJlvkRgqHkYsnEAXECzh4CXLIOJsZ
 rtFjZxIWsfiEmTXIz+o1H8J39J5eEGy4cXNCyHwwCNUr5gV6UgkWDEP+xcYR1OZNlC4pcSKjZs
 vw4=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928276"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:53 +0800
IronPort-SDR: 3WJLzoHWF9r1MXFb+Mqa8gtQp3MRxrY+xGDgkgO/nru89+AklOKZJEJz8sXzoOWO7J021Ev3qI
 kjCpb+ghZJ8jvsjp4Um5gGGo9t25N6Hpi2Zgf7GLJt8jaHRYbrqHelsX7SMB3UQlEMl2cyPmLN
 9bTrAJxUxGZT/YsYPFNuB3rGxm1C26biKU3OxqFONMWHoNOX3ElYkM7VafWBc73PXcg+ertKTl
 B/O4Uqq/TNmJ8YQRFvEX2LfpIuRHkREhLgiF9HaaTqroBNyj/yuejdh1ACqaHP15zTrtUJB/3X
 G2IwMkg7IkCcEOmILk4lv3fx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:35 -0800
IronPort-SDR: RjPpNew1xyFprClUzFU6Mu+UhTt8Svniorc11O05rzxWy9zojjPK3vWwFDMnu2DbWBo5oKAAUY
 ed7AqCA/C7L8gHTw8g6xNE1Hjbl6zVh5HRJ7k66eGQRoZxCHIDSevFI2xMzICVDzBXeUp0XyTU
 MRG6ufQ8S1KjvMGbSaw8GXoqu36OL/vK4dZ30BNkaXT9Bp6cLmz4Q9i1rabL4InUE71LTOxRTk
 r3f7lFad7hKO2mF6mECH2KlEygyqVeF24rfA1aAFh8CImTa8izJKgF5ofL8AujE2ybxtELhX8v
 sv8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:52 -0800
Received: (nullmailer pid 1916468 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 24/41] btrfs: cache if block-group is on a sequential zone
Date:   Fri, 15 Jan 2021 15:53:28 +0900
Message-Id: <327e5c00dd98a9bdb70e3ec7da74a315fd08c551.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
index 2b02a38b11f9..fed014211f32 100644
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

