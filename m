Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD7F154236
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgBFKov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:51 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbgBFKot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985888; x=1612521888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3h1CSjZZLmCI3DhjysXKyq9iW4sGpjRPXgPn7a2r0W4=;
  b=hfKU3lLApvFjdQnyk4MHEIEOZvS4C5Emfza9B7GR/yVcSlZFjvvJEBKp
   xFW2F+JLA4+JJsuWgsmKGJrCZ2wMS8fylDAUItXQoOb1mmnIwHDLTx/2v
   fOIqCfRnXuzmdyYUjuY3sSLx4LSOYzrGmqzY1LNeqoHcdK31r97qM7Tum
   22St79I+aWF8G5Z8P6ob2STfyMBshi+a32n2wRgr0YgR84CJFm94LOmtm
   zu68DnVIUC+SV0RDDrwPM04Ou1T5cVqh+Z9vgQHUwAXxiZkeHIaB8ewsr
   138Thu308xmsndkQaVseZZEiLnvsyAOKYGPqak6UyVkunqF8pl+wzJeWM
   g==;
IronPort-SDR: iivgiH93mfSWxaU6lZ0q/MTm8kAZfK1Lzmz3H0ZkwYRquBkLUS/p729C75pRXiMXP5ULwsjStg
 2hlET3hZ24ueCw5GI+hh2dIyaFSrMtbDwpgTdXqIRKpgBzSE5P9JLSDItgmo71iPbllvds6jOF
 AMYJUsJBQopUNIxDKMiyg74lrCAu7Y5Y53CrgQJ5IpB3IZRKjFB1fkQWSVNP99gCQxb5iAuIyz
 vB9Nm/BlqiYar+RLt4KgSrZqHaIHN2PdeEEidPk4i+jpTDwjMl6+/WK3apw8HEY17jNiwcxp2G
 v+0=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209557"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:48 +0800
IronPort-SDR: llF9NmpMW6FSPrk+h/U93mw7r8scoIOhf1G+pm0Pt1zNEA/dAJTJkP13Fmgq0x5qzbc7z3MNkt
 bo0Pzzb0ZNlLqGK8n+hYAjsXWDWy6h2mrLZrzxvzR+uzbvf7gTu7o3vyRJ+jxa4+PxuPXWin4M
 BzKXf9PCL9a+qvAmPXdFOsgCFJwH04MhFKIjy0TznW5ZKrZC4jJWeNe9ShYk+eUeOfKaiOtQxE
 h063/iduVnBXGdAqsmR2JUZDYGXqC/xZnNlzvyapkRt8SkusjYC4XZWdqn6wwO2OkSBl6BYoK7
 WuDBviYf3GjnRisdH3gsztJt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:48 -0800
IronPort-SDR: szBchehUERUTxKfhe2Ty9MpB+1G1WiFYg5D1aCpG3PQ17YWoPlcgA67GRGihg+GNxdlDXaDDUs
 GaUwXJ9SVr4mWET+8O+k3X0hKXfBN/8d+DvYvVtmmf4KMqyLUnftMnsk5HzPEpfay9mTUr/qaI
 ZdtAHQCX2zjJ/1kc5XG+wQDdE0DIp9ZTC9Wq6HYTDDov5Y8gkHJiwUoaYFNV4sri62S40N1DuG
 9JLS443zKgp/1hOmkiSANAdAxwPkbUu/6dEb+pIv8WNzAph2n690hU9rp+YXEIyaxnADalLWlI
 fDQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:47 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 16/20] btrfs: factor out found_extent()
Date:   Thu,  6 Feb 2020 19:42:10 +0900
Message-Id: <20200206104214.400857-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out found_extent() from find_free_extent_update_loop(). This
function is called when a proper extent is found and before returning from
find_free_extent().  Hook functions like found_extent_clustered() should
save information for a next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9f01c2bf7e11..d70ef18de832 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3737,6 +3737,32 @@ static void release_block_group(struct btrfs_block_group *block_group,
 	btrfs_release_block_group(block_group, delalloc);
 }
 
+static void found_extent_clustered(struct find_free_extent_ctl *ffe_ctl,
+				   struct btrfs_key *ins)
+{
+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
+	struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
+	bool use_cluster = clustered->use_cluster;
+
+	if (!use_cluster && last_ptr) {
+		spin_lock(&last_ptr->lock);
+		last_ptr->window_start = ins->objectid;
+		spin_unlock(&last_ptr->lock);
+	}
+}
+
+static void found_extent(struct find_free_extent_ctl *ffe_ctl,
+			 struct btrfs_key *ins)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		found_extent_clustered(ffe_ctl, ins);
+		break;
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3764,11 +3790,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 1;
 
 	if (ins->objectid) {
-		if (!use_cluster && last_ptr) {
-			spin_lock(&last_ptr->lock);
-			last_ptr->window_start = ins->objectid;
-			spin_unlock(&last_ptr->lock);
-		}
+		found_extent(ffe_ctl, ins);
 		return 0;
 	}
 
-- 
2.25.0

