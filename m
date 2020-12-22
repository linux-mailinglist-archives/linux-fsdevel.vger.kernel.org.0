Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2B2E04FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgLVDxc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:53:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46382 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVDxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609211; x=1640145211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KU5h2l6r10zE208M43rRcVxNWqUINjImzSjBF+rEi1E=;
  b=af1/BzxzzRyy0OJlvRYe09xp/tiGT8T+2VONfjKubS2piG3xTJaL+0N4
   cKtOFdbSXzGzhMnA7KqHfSnhI3YqupxlgpOg62jqMGc1aOeOUi0jUfTT6
   PgDhqQoyd77rXyS1BIJ+3IJnqP1OXi+8k5y/Z6qEmn63Efg38YtWciUou
   9+z66+QyJ+JwEe/oEVRhW7AP0O4X2OZ8qkRpaxeAN5FgbYzsiVd2uORYc
   MsmdmAV4fbfDqM+8BCFwg9t2WF8R2cxQ/lD3eYI4pfNmqamOcwf70NrVw
   W03bptM4Zc6JxQ8hoy4zjVZkkViUuL0HmN2a+IQFYKDrnM0yW8yd/Lq+v
   w==;
IronPort-SDR: bEC5U7xAixhwuApe96Aijd1gP6pLFswXCxLGmo1Ri+YBk0789KiLSwYZNxFSQy/a+alLRxlMrq
 5tYVKyt3XhrxdYUbSQlUK3lJuB4g76UWNv7SxQii91rCOomQZa+GOopF4IfhTFSWjZe9/KKt+6
 DnHJqLZqhtBIyuExSGvqRTUtteKKsqF1XJUK81IWVXMzz7G7KG7rbWCBpxS8oNiIbpaC4lZGhx
 UsAX9sBqDfh3dW6jG+tnVVSG/BZIyL+QGExYmBruZSOEXGce6F1InOZu5S22CG2o377tKQC+qx
 AUs=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193778"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:49 +0800
IronPort-SDR: iVgvwIjeeoAb9AUwqLqFogL/GxQ9E7Z6oiEYmryNV4vnEUDn1jiU9kgKd24TZp7KJyODbLeACF
 yhZWES12L8db+9/kSD8/lWT4MniSck45Z8xDLT8StZLtxYJdmkYTtsBhv6tqPE1gw8G7YldSFD
 PUu/c1vv7CWyWwgAkMAy4zjep7FyjDKaqfdoM/LXFDlUTLmaxwIheGJMo5eqTvALy1Kzq9jHDU
 oX6vujG2vGpU2/sVHUpT9sV2FTFIv7MlYeVVz8g4fCiuRZD4QWq5tUT3Zl7e56+mx18FIJ5L2I
 JANE1qPPs3QSKct2H7TfT5Q7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:00 -0800
IronPort-SDR: N34iGXJxQquJejSW3+Ms3zJaePtHAVssTMN0e4arofeTf9eCUSANpwRIcgIf0WQDi7BLy0U7g8
 0Ghov4Y6xuv8EXYQwYwkswUmYkCaXeHFQXzcxi6P1Dwxq3H7Nvf2b2AMksTecJdvDRkrDp0pML
 TyA+4p96gIV708GvJiXKZPEn5TVfoa04/My4sCY9bP8ynDPYcCyqvD3cDCCsGquQ+gmV7saHNl
 mcW7YYCTYtl6k0+cqQYimIEUpNaeJbC2K6n0AuZvf2PIMAYpBTRNDLm9/vl8EzkOmijNt6zy7B
 tw8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:49 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 16/40] btrfs: advance allocation pointer after tree log node
Date:   Tue, 22 Dec 2020 12:49:09 +0900
Message-Id: <a26bdfd95d5416bbaf49411cea69bee2f06e947e.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the allocation info of tree log node is not recorded to the extent
tree, calculate_alloc_pointer() cannot detect the node, so the pointer can
be over a tree node.

Replaying the log call btrfs_remove_free_space() for each node in the log
tree. So, advance the pointer after the node.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 757c740de179..ed39388209b8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2616,8 +2616,22 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 	int ret;
 	bool re_search = false;
 
-	if (btrfs_is_zoned(block_group->fs_info))
+	if (btrfs_is_zoned(block_group->fs_info)) {
+		/*
+		 * This can happen with conventional zones when replaying
+		 * log. Since the allocation info of tree-log nodes are
+		 * not recorded to the extent-tree, calculate_alloc_pointer()
+		 * failed to advance the allocation pointer after last
+		 * allocated tree log node blocks.
+		 *
+		 * This function is called from
+		 * btrfs_pin_extent_for_log_replay() when replaying the
+		 * log. Advance the pointer not to overwrite the tree-log nodes.
+		 */
+		if (block_group->alloc_offset < offset + bytes)
+			block_group->alloc_offset = offset + bytes;
 		return 0;
+	}
 
 	spin_lock(&ctl->tree_lock);
 
-- 
2.27.0

