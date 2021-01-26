Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DA7304911
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbhAZF3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:52 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732136AbhAZCiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628701; x=1643164701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TPIdQDn9DfTnmfdGppIQ7mhUm11+1iLGE3pAmciGZjM=;
  b=K4r9oiwU+MfVQdwFJK7332hiU5+V/qAmjC9TAPo/3DBv/T5lHnNcsUSK
   R/tDtr9Q/16KkPSVCzBXAhcysRZ0Wf/pjR7bBwIjTJowA95AlRwjofGDD
   JmwOqV+iDNYeU8Rs+TpC7JCG3HX/2RWp07oXpNZ5MbpXLx5qYYGyA8xKZ
   vgDGKV8SZhvsEcAXAnEuorIedSaxPz356qEYZyK135uvXPFa22lAQl+Pa
   Yi8e2jNxoIBjj5ctzahV5doLi4PxEuB8GTNOHEkokSS5Emj1VuYF4ZM3k
   Guupcng/QJYYh9b9LmirgAjIs2FJAm4CI6gUa4jB9Ifb/jh8S4bchvr8S
   Q==;
IronPort-SDR: raoLNe2xct/YVZgEb3wzsFelkEk5Bxe9EDofDwxZpWvMUbxwcjqGVPw75fZin5gPNB/BTzvzpU
 6A+3+mMHiKm7dyGYb3ljpeKN2lfUSR2sSQAaEoyVVQj4KB/Ab0E0hLcy7xlnkVakqP/6wHcw1F
 vEI2iaVU7FBg6UE2xXpgOrnDJFwLvucyn+WkMpKA89ZcdyK5SA6zI/iuo779fL6UtEUdsq07cr
 iIftDzVp65Dl0PTBwZNLwlXES/3ClsqITEGdN8anZvgNxAs2a62pDlqZWWmXE/I10+BH8AEVF0
 /Ic=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483558"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:42 +0800
IronPort-SDR: 7kMGEyTaXm9TWn1YvpZbqrp4MFHS7D7j3fg+7CdriszOCP7gmpbr4KBSTaZdIT5Cd3u6ziRK+H
 HIJUGcMLAy6Ck8CSP7FcVUFDgIAa9N4ULW7D8rQYnN5/Ed3hpYU/1Z1RSRqVzq+IJwtnEqbdMH
 dHkZGaM3ejlPVGdzWxoqIEh1LHiyU489S8YRuzmOJUhhw1cc3bOqGN2WLU5DPXXgLT1LYItwoV
 nNLh5nrQ12Sl+3hxUmWSQTFwTosH5Rdj+4IyJCKZMUAzEzR3v5aAhmtAg/3Ol/p1hgjERwRfho
 24Vsyb5W9V+8n9pDzWZg+dP1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:08 -0800
IronPort-SDR: VB8H1rMRHfe5tUzN4+dQ8JfGDwB/YcfLi/OkEn6wv7OE+bWddWRJ9WNyXyI3cLFAnzMJrdx+AO
 a+THcKHwQWskEvwt9wDq7ZYLGeUSko5QltHqwTNB6qlj0LVFLMQPQgmdPiMRsRUw+6tYAcWaoE
 u8eh2JXIalpdUrnDsF3KsSK6AZZ+bGMXbHDLP7A390bYYLTNRz11v1IZEPphLiffrqUEFIJueA
 1R3B0tqCI2kFkmk7Tp1GsZxEyjWgKRIi7FZlHWaru1b6uCnZ5SN9ffRPwFEpkL6vEABDu71xo4
 1tA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:40 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 25/42] btrfs: cache if block-group is on a sequential zone
Date:   Tue, 26 Jan 2021 11:25:03 +0900
Message-Id: <bbc251e8d71f081b6f8baabd5f0a67c19b401f57.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index db6cb0070220..abe6b415de98 100644
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

