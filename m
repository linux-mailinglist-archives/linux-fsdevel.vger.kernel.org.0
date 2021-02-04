Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6217130F0BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhBDK3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:29:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhBDK1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434455; x=1643970455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uPWaXkJRIOWqRbtNMZ5jK69QnjJnbxkr+9UN06Wk/i8=;
  b=nZZzTm8riB4QsRxitOM3vAKNBAkbTnsXcyhGCObVv+1z69KVPBRkBJpb
   XkIWJXmkzDwQ8spFx8MpSJU8xip9zh0u+4v8509YBNjlHE54jV7gbth9Q
   w9FTsTQGWDq2w8D+Lr/vs7CJqC55i2UJAZBByf7q0vg0pyfw12lo8PsTq
   MRT6hCia42OhaQW5zPjUNZA4QNPsyJuE3WK8+7WlJKfmDp15lsdwK/OST
   aFLfJPUFxj3oDQu8FS51iinbzsE7nsVkXDeOpcoi68J1z0oJGTR3/tKAA
   r2Nw92rRySUl9JQxyolLPkI2MWWsVSIrm5GtzlG5qTNaG1og089e8o+cF
   g==;
IronPort-SDR: xJLNE4saM7nChl0BJbvh4LjZ9HZa8TipfkH/NZJT7ke6G0+wWDoZqHgYLvtH0UEBzV4aaYeF8n
 +YYW/PZLnE6jJCJp81pLkPTqhw0uCjbQuy4Fd5qkVwYPq23uNlTXSRYHtfzpxqZY4lIziIzns7
 26y9kIPT3UgsFT6WmswvV1X8otnT3nF5XkUgZyRweXPbBFtAjq2qNb+bE44gnU2oTC65VFXSKM
 g8fivzRyRZSnFV1QyY4WWSM917pByew1oy+rERLR3Pp6AHsfcz9XaTb3oFdwtksO1t2Oi5t7hT
 UTk=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108031"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:30 +0800
IronPort-SDR: tONe54oGgUv1Sn6EhLz8uVsBhJypPBxOlp27UyAYeGL5b4/fCxAVd2vKAcRkeiPAx54K7keb4U
 KFGP4PRZIUHqOmu5UAvbsaNw5EnHWxT00bMKTSp3mezYHiAjyu8kQDK1XKLmrr+A/v3dpJamKg
 HiZFS51Y2nr9oU74N+BkegJSbkv2xRxWMGByqz/UpfMEtX4fORbDPD8JTz6XtRbhxu/Dxl3moJ
 CXbflUVvJwsI7xu/+tAtw7BLkzbrOr5SJAN/0ZR6KN97ldU6ehe4YjOot3dH6DVcZTAR8LoYzm
 mmDDakXI9DLuXt1BpV7UVvHV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:33 -0800
IronPort-SDR: zWviRoaZUZA93NQjTmBupbU6X26GBYBeb9CftuikEhbHnOPWQagmz40y5/dh+aF7DhG7wCk6tD
 ttrIKchjCOrtc60w3kNZbfjCBYStac14mGwJ3HwfZ7ja75FVd7QBxzHVsbhuQLz2iIH1RPY7gA
 2QXkO5fdWjEmEzX56vN6sGAklgiLEMKlAell3v5HXreorPbGUNjjTYIASjOH2dbDc0oGYbntsC
 HfJBEZm2XFBmw02CDKYa0UZgdhG8HRphoToOvTmGRecf7qkCkkZh/dMgdidq2v8NVd7WyjS3BG
 VFU=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 25/42] btrfs: save irq flags when looking up an ordered extent
Date:   Thu,  4 Feb 2021 19:22:04 +0900
Message-Id: <e29ea7fc41c784596bccaaa6983894d8397aae82.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

A following patch will add another caller of
btrfs_lookup_ordered_extent(), but from a bio's endio context.

btrfs_lookup_ordered_extent() uses spin_lock_irq() which unconditionally
disables interrupts. Change this to spin_lock_irqsave() so interrupts
aren't disabled and re-enabled unconditionally.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2dc707f02f00..fe235ab935d3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -767,9 +767,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	struct btrfs_ordered_inode_tree *tree;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
+	unsigned long flags;
 
 	tree = &inode->ordered_tree;
-	spin_lock_irq(&tree->lock);
+	spin_lock_irqsave(&tree->lock, flags);
 	node = tree_search(tree, file_offset);
 	if (!node)
 		goto out;
@@ -780,7 +781,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	if (entry)
 		refcount_inc(&entry->refs);
 out:
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irqrestore(&tree->lock, flags);
 	return entry;
 }
 
-- 
2.30.0

