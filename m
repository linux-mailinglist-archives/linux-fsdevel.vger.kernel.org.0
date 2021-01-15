Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DD2F734A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbhAOG7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:59:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41752 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbhAOG7a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693969; x=1642229969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DF0s6vOXeJuIWmLbfvjbkqoi5OpIHuh6ergiXOjz52s=;
  b=FW9IvLiFb1um4i6m+bDsr5LKGdP0OILZY1afwUU+qnfdZuqOO+1XBXFP
   tCyyboVrVmLCD0xUHuVCwkMm2zOR0g0wQ+TwFKV+AbQtglOPcldom4voM
   IpanowfW24jNPgSi8xv0Ab12UEOh3r65jKSuM2dZq/w90DKjrSflDKt1e
   ZdJ9VuvrkrcZGUK+C2ejE0OrL0Cp0fc8V9LMf5uVZe46SvLCprlbFFxzZ
   SNw6ujzzy6yCuKb1BGbgZhcs83RXc+FXbNem9CfXlrrzsSaKf3TuUnKAY
   5xiGvaetgbSKwflzWWuc3Kvss50H/d4jzPiR2juiCg5EoLmH2tsYPmesS
   Q==;
IronPort-SDR: 5FBbL+q0qw8fBLzWXnasDYKtJBdvtlFtiybXY64Rt4oXGcCUxf3JXvMSNyF3psIQdG+c5WwW5o
 Z1SUdesLZi2i0eP5tGJ6AUGXrdAbYjPMOIz79+eK0hbUjlt2lLRkzQJ9A5bYnW0QTWFHDSGaez
 cb/zdRsTindgGbF+ha4qhJpSYsaz50g6hcVtHjoKKn6uWq6+XWPLeiJ9SpdHC7zZoLgROKqx6K
 4oS2iiGzIL3CYry+OXR6lDZXO0FApmyU+p8qt0Yk+zIFccodS5CL1VW6Qjb9X8eWpoWmytGjq7
 qzo=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928279"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:55 +0800
IronPort-SDR: Z65y+lkfWQ7BqRClAZGFIUuXUs6UqXLyKsGJT7TuGZ52F631qqgsLXGXGi6SeVbyGa6vDZKwWy
 CcdNwhe8PcK0BUtgr/rNxB2qMNxTnvF29817/TbDs+jDNTePbP/CQQQvG7mX7QCMSa280SPAaD
 sop18Ni5An0Nv+aSIh8+cPpzeO02vrht1RV8IcLcGfpZ81U6AwoCqMFVQlVLszOJA4wA2/WTYF
 fBAUlqr3kYBI4WYBwd9jX4/EdSmMUwQmiQrjAXeiT3nc0sgEorcf+PraTT7yRyfNirL26PSGFx
 N3bmd4zZeiRjb3TfgyFgvzHd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:37 -0800
IronPort-SDR: OOhquzltL2FZ/EvuPnANPZezul+pQOgk2KX54cVVB2v7ynNan7wHTCcA8gGYWCy14sEvUcvIoB
 3+abYazFfh3AnklduQJag2jtNDsWJBJ9922roLlvkuv023bBCMgyGekPw+KaQ64fS/hyHwju6Y
 0xNwK4+MlrmeYXPKnGmkeJIQDIt2F2Vy6ivbQN8Rz5gAKxbGC+sxWVx38UQt8KkiUYrAcfkJNS
 D8X9iHC5cceBs5dBa/a+QXmb88ljpGR6ybcftvet35lCkBZiljUtEYTv3x19RTgBCtrUSBrJeM
 Mlo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:54 -0800
Received: (nullmailer pid 1916470 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v12 25/41] btrfs: save irq flags when looking up an ordered extent
Date:   Fri, 15 Jan 2021 15:53:29 +0900
Message-Id: <2006d10556749769d73fde4958dde0d844bb4f8d.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/ordered-data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6e4ffb3861e7..5c0df39d0503 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -745,9 +745,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
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
@@ -758,7 +759,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	if (entry)
 		refcount_inc(&entry->refs);
 out:
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irqrestore(&tree->lock, flags);
 	return entry;
 }
 
-- 
2.27.0

