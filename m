Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5689C2FFCB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAVG20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:28:26 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51138 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbhAVG05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296816; x=1642832816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H2b0mafCGrW4jffVCyQfF4Y3rcmtTeWec/wt7UOlYEM=;
  b=Qe7RWhpwqnBHPNne+sqcvqDXZy/kpcN5mGv8Nkn/GXPPYAqJIkpi6QuO
   XjuN1QTnI2UtldAk77of7leVLWmC6etcTRY2PCtk4/SNI0iI0mnthqwof
   eOSl2gHYnZiKfMlTT9v8heTu2sBOLo7jewlQ4SSON2qK+1zXSoec/RzY0
   G9gDQzvy3yP6DHSeG+1KTtAhDTwv8OWJ5Z1/PaGiWY9xOyAxGJ56IVxDz
   2IFvFc5sIKqndjrmhKpjzz11edJZvKeobor7DgPmmDNAebLiWui64OT+Z
   2cN0IgtvRx4Ml3IyKFo1QW85Xt75a8VTfMZRKM44Wv/SB4H9n67lTyqum
   w==;
IronPort-SDR: s1soo1O9Iugvvme1BWM5yCWRgH8hl+ilrcbq+0gPmBaJjQ0tFSvL3zsW74+x1hAav+hp+CLfdK
 Ob+gEfK8ChmGrMQJrxVL/ZJhCkvFOp7dHxF6T8VlyjSDt4oLQrtJ+ekn4Wf070PtQi4M9LQQWk
 mlwPi9QjmsfBT00G651stOiSmeDXNFGh+mBnELS3I5JDkuZ6CVNAgzUMzB0NnbkDixrPrh5yvz
 wIfjn+GRfmGU2p8IDaHdntJZNV7c2WVEW9ZH+m8NmslF+jShlkSakJ42fOjPHoy6Unofen5mEM
 Ns4=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392021"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:04 +0800
IronPort-SDR: QmWVN/vCGX3KdvPgMdJp7veAIGcKpcNoEebNG0YPFaa7mJekr5S/Mb2yub/rAfmMct+Pr/1H8H
 Zd+m/XJz6HnB4dfpkET5fGucjyCvIIXyoIDUVBYtEPXTXjus6b5ucuV2cbNuRUEu3Gr4lMDQpF
 wUtsgU/HMGm0h2W5Qzawv+DKPsVGd+FUizg4d92VK+xkUah39AGNTpY+XOLmFI53YXjaB9ZRSl
 xcbz3fwMJZzBM9gQ5kVwSoLuW2JPjvP6Co5iuXtVXask/VtR1jfDgK5tbaXs4VrF8ofpSha0hS
 mwdNrlEhaYHQDiuZG4pac/Jq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:35 -0800
IronPort-SDR: pVje8odUPz2yW/xu5oReEBJ8xQ30amRlzip9LTpvvwqqx9bmVb3Bj3WQIQm6R+y2ic58+4E8gi
 9qFhb4VDN9w+uHTrlYN6q7KW4D9rjwUff6gfD6Nb5BGrz9wNtR8CT9DCT8mF9zk6ni1bmoQkn5
 4xvNYbaf3rvYp6xn+Ho948xGBzCoKOn9+Mj0PyoUyVDqFUn4Kz0CI4BX46smAgAHfVGSmcFnZJ
 zrR9vH+J6K/e/AZuDFyvHu3Q81MiUDYnvLDkfcTHbw8OYtUJ4pRGKa001swPSDs51wi+ynOkGx
 Gas=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 26/42] btrfs: save irq flags when looking up an ordered extent
Date:   Fri, 22 Jan 2021 15:21:26 +0900
Message-Id: <8537c12ab50510bf029ff6c780a0ce2a850fa603.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
index 4dd935d602b8..538378fe0853 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -757,9 +757,10 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
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
@@ -770,7 +771,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 	if (entry)
 		refcount_inc(&entry->refs);
 out:
-	spin_unlock_irq(&tree->lock);
+	spin_unlock_irqrestore(&tree->lock, flags);
 	return entry;
 }
 
-- 
2.27.0

