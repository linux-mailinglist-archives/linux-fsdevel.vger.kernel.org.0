Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6070C30F0A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBDK0j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:26:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhBDK0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434375; x=1643970375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s24xRux8e5TSHiHdmYfK90FV8NIaZiwD/kRauqwzvH0=;
  b=D0CTir9Xo2o4CGJ69d1lg0S2Rxfx4C+93ucyMssJqLLnaQN6hxP2TLLD
   X5SG69SGIXcB478iJzAEqd9RJj6wzW+Ym3YlU+CbHmm9S9+3mqkW4enFs
   raKy/sR8s1ytyU29qL45W9eTA99kIWSf+YVZ2dbJl8vgYgbHMqYtmSVCL
   CfcJzl/1wPIo/lg+3mUevIZcyZS65IkWPykuamaiaOWL4oHfv4GSil2Vu
   hy/O7g5vPQydG1Map71L3YIBkGQkqkktGrcudUPx47iae/wlRGH3Bou5A
   apycCeHkl93zI7h5BYOHooFCbRYKe3eyUa/WPFMhf+pwNh0K5zJ3rXwi5
   g==;
IronPort-SDR: IxuyxfqhHSRCHG/0RjKV5FztOK/dF0SxKfnho7MQlGbuBMks377HTdk2z6JEqyZN3ETFQ4BXWW
 qDQEMjWd4ghbggpHi+6VyJtQXyCdgEMjWGRVYy2I1ojS7iB1pqrISIWsPeJ2kSc4alsC7uCItl
 Xu6h0Ky3N464hhwPaofJbiroprTRiHGLEfMjyIQQoj+zuexw7Ga0aPnC/7tqeDOQTdkYaUfZoQ
 zEg+Vh1QKe3C/ohrZcEcWQNyAuQOHQyyOWbsunTyFkr2hswI2NWdNA8HuNt4RtZ/r3twyvEHKz
 wqU=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107998"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:17 +0800
IronPort-SDR: EmexibozaWtvyEmQkpfJI4vxjTN1kOcxsQZhODa/D5UUE72fEUD7q4j7ehh4bcg69J92n0aHl5
 nYPpbSptXiddjEQSxI7P6gHiDoP2eIrpHs2crnuAZEs2YxSx8dILI7E5hTIEZhRt6VpgaLDqai
 XjbFN/wfMmVbskcEHnYWxxtZkT2geDS0hdlXaPf9PJFAIDgo8x63A27V93WiYMuu45xzgcq/bH
 K+mMY6II0Z/Upi60h5u/7SZ+7KOKBwxAXyLdyrCFbOvNsjxKmpj7JKbP/DT5hP9sAqGqecB152
 mZ6Bwa9hlh02SJESi5sWlesK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:21 -0800
IronPort-SDR: lqiRhjk8snWjfe755nsh1kiIsZ1vdIha2bmTFiv15K3YsBaf89pL0zXiBlR4H2smH2bmpv0hBh
 aG/5H3f1qDTH1c2Nsm7gSL1KbDkHRTNIYiQ7BSxnukoot1LhE/Y3pFl+FEhWRUE5HKIThrjxTR
 w4+heG7mNEwjKGhefNe8M9y7s8tRrftZdO2L3t/KeTULqdTSNkyJfDyYajSkulsXitzt6ZO5YQ
 JBR9+uaWtuN+ZdJpYEpRCxVBmteIwmKdxAWLRW+dwj0NPfBVBZDxn+96kw06jM3KHhCuNLnmJe
 YGE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:16 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 16/42] btrfs: zoned: advance allocation pointer after tree log node
Date:   Thu,  4 Feb 2021 19:21:55 +0900
Message-Id: <834b102881cd55d37760c3d6f49319df0ed6efe4.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the allocation info of a tree log node is not recorded in the extent
tree, calculate_alloc_pointer() cannot detect this node, so the pointer
can be over a tree node.

Replaying the log calls btrfs_remove_free_space() for each node in the
log tree.

So, advance the pointer after the node to not allocate over it.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d2a43186cc7f..5400294bd271 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2628,8 +2628,22 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
-	if (btrfs_is_zoned(block_group->fs_info))
+	if (btrfs_is_zoned(block_group->fs_info)) {
+		/*
+		 * This can happen with conventional zones when replaying log.
+		 * Since the allocation info of tree-log nodes are not recorded
+		 * to the extent-tree, calculate_alloc_pointer() failed to
+		 * advance the allocation pointer after last allocated tree log
+		 * node blocks.
+		 *
+		 * This function is called from
+		 * btrfs_pin_extent_for_log_replay() when replaying the log.
+		 * Advance the pointer not to overwrite the tree-log nodes.
+		 */
+		if (block_group->alloc_offset < offset + bytes)
+			block_group->alloc_offset = offset + bytes;
 		return 0;
+	}
 
 	spin_lock(&ctl->tree_lock);
 
-- 
2.30.0

