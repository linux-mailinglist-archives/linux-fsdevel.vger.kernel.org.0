Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1978A30490F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbhAZF3p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:45 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732135AbhAZCiT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628698; x=1643164698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PzKrK+/EaIAWaAVbsVXNTR19q/xbdDY3gO/u9Gs5HxI=;
  b=al5MRWWOWX+ganXxPF4fGSZ08w9YrJ1JUx/ihIHYD/W5uWHscz0/fFYU
   cTu3Lbq1/bsFzMv3DKiqnPMTwYYKN3IJpBXi7RrFTnBQn186R9PIwolay
   pUT6KbeubwAnlDiy6mYhYpy06jpDg+QYh4mrH9oQn/A3bbw4JmahB1t0P
   gTxMaSpsszC+Vyb34onojd2mk5lW3GDSvI8wV2xc4VPMoXwwS/+M9MIkK
   eTZUMBl7u76I0JihA3SgmBN0AhqxCCe0BmZtwyPWNebot0tw0N0FJVqGJ
   aXaYLz4D2OzWc/9nwFaqtfWPJt0qOAFP0ioPR4m3MscUmYHECrWtr9vfu
   A==;
IronPort-SDR: s6kB/mrcJQS3hMrOD8w6YzmHYSIVkjcBOGlu/TS2Jf3CsFw2tS7Yk6ehd8cI1GFHiK3fAPopQ/
 GqPbPrTGztA1Rmcwp2UyhhIxFvnwqJNaA7rRM87QPnPTl7cAzKyJnPYIvqvkly/qjcHTlc9e7g
 fI26FghZJ9kgoYvS2wrlIKWaYsM1KzVWkx7L1bwopqlUMn8dTSpXcTdi3qWlYnMlZSHsdeT8P4
 8j0B8/IafcjqPautlrZCGFE4YBXPsa3rvS/dLQtm0VBFoqnGOd9JkPOc8OsoKmtfA21IR3av8H
 DRQ=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483560"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:43 +0800
IronPort-SDR: dXdjsie99ZTF1mhznwTjD46mbzYzQn7VVue/ULPKyf+l+RhNKgb9fOKphV24RZy3RUFgSCDWYg
 AEpdTPfTq7BXpPYPNUKXyXWAAlNIn8y6ycrVUTqqKqA4sMFTHk2Bz7tQmuSZWr5g5Zj1FYKCla
 xGjBp9Fc4jiT7Yqjob7GvSQr7MIGK3SExyg6RNaJQbz6SPAkXHV4W0fi58ey73WAKEsFQIFQrL
 BNb8h9WeR7kcYP6qkDgezWcNGvGS6G8vMQZHAO0y56DnZI/7MNlpdYK/jPCCc2d2n7jgdBRFgG
 bsC9GsEVuBLimdeih9aV63G1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:10 -0800
IronPort-SDR: GqNM1ae1aOnsw80gVOcTeh/lB/EXYHMdwjPaITkGBlGqUqz+CPqEBK4zL2WU0+zcySCd1Cyk5E
 sPzJv8KwN2rNgJJW8WbV++zVvM9cxMsEbcwxF39tfdb3lk4sCPBfte7jbITYel4amS5c2epxn5
 /q1mfxgyDFFdmc9GfKxUZbFrRy7qL7j2xhi/kbtB1u/VY3wM/my+NzL/uIwNV9aEX+M4Y0E/5q
 IlX5z3Po2M2UZnlutDgKHaKAzR/BacVoTQxvaL60qjAOP2iDm4KiYsdAjlrKZ+U9UXnzDz8sVA
 IDw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:41 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 26/42] btrfs: save irq flags when looking up an ordered extent
Date:   Tue, 26 Jan 2021 11:25:04 +0900
Message-Id: <a4b8f87040376a80df0899d922d7aa3de5491a5a.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

A following patch will add another caller of
btrfs_lookup_ordered_extent() from a bio endio context.

btrfs_lookup_ordered_extent() uses spin_lock_irq() which unconditionally
disables interrupts. Change this to spin_lock_irqsave() so interrupts
aren't disabled and re-enabled unconditionally.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 23aae67fe9e9..7c061146ead9 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -768,9 +768,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
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
@@ -781,7 +782,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	if (entry)
 		refcount_inc(&entry->refs);
 out:
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irqrestore(&tree->lock, flags);
 	return entry;
 }
 
-- 
2.27.0

