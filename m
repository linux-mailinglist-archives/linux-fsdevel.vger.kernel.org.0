Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D54DE15A1D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBLHVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:35 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgBLHVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492106; x=1613028106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kWMimSL+EvQzwLYXZN9p24BrPKUYLHK6E7qqKA+7cpA=;
  b=IVMT/3aVnElWoXFVCwiIRjMIHmJClPhUUg4oqZE4XYN45HUq0VYmKHwm
   jTH/l5J3Pn7IsIvrrqOK80vRZlBhVtJl8UvY6jmofoyQSBjwox3jMbMaW
   1lM15wdDAtUx99tZeob/EEoef1nfL84WjHqzFX9oiy6oBYnh9a9s8Xiiu
   e+PO7DFYillwm/vg56f6xO2jpSkSMbY9imhk/6lLz6sDfJEuM7WdAMP1N
   p9gJ3Api0n5wDZD+kJiWx1K4eV4yoiATIqRo9ZqpcskbLuJjft5oZ8fUq
   HE75u8HAnj/bL0vTgVQBkZJ3iumoiNck+FZceYrepab/t+GjVuZ6tqD07
   A==;
IronPort-SDR: BsABXUwmKmibiF1dmJKaEsvYvsv5HXrgrAse96HxsCO8OBuGk7/eL4smJkRUX/dvPddNFkM+FG
 4BeWeSQQtP1SpA8BUjj8jPVLT7mzVEBjQ/l5aZt91jCRdyUkqpU4xJYL36OpT9aT0lBqysrjGC
 Tq2ubr+9lI/9oqsuzrXM/DfkMyvJt6hUEaIF4vXGRK5mW1SF4Aaf+veSNtaLHs0cUiMSLiEvyw
 9V1n5f/njQ1kou0T4U9FkHR+F5BmYYDwX0C/924liaxPWuUVjh+Y/gkyM1bbPDrfaRZmufxR80
 Xc4=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448947"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:46 +0800
IronPort-SDR: l0dO09+TBCYtwUqZB9unCQux/cJloe/8eDBFckxDJY/a5pi7wc00vji5fOyLUpd4Yp35/aIE1X
 IFIXwOsg9PmxebGDtArj+EljPDbMkt5jOyEW0miDU3iMdS9ALi8yWTCs07u8j+r8XsZBGfTq7L
 lCgbLU+r8C1gnyjPP1KEcgmhZbD47L2+GFl9QZ18PAl0h6BfmMjg63qxmwcf2Wholo+Nn/Q4gv
 Tl9SpOFq/01bvmiqXC/WOoT0+oIu6fnOkoQF8Rbf0QRo3LwEZSfJN+3XBNYf2Y9Bi/l++hmY9F
 3TdsUwAkLetQ9on/Z8jO+s+K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:23 -0800
IronPort-SDR: p5NDzplQQ0Xhy9iPh/JevzEr5BvgXIVy1lXFXmDL93tjb5mG3j6AAz2ErzB0NVgIsI77pPYBi+
 mVmrL4G4iAgtfsuoddWEfity+SoAQUfSMVTEvURz85nbmoCqFaeWb8sfXsBxAlkDDRZfx2RSij
 GGdFnr00tKcmtK0NBE8zi6fm/ne/RRPj6c4UJpa3JkMQSZgPKYrmFv2pYwQZ9y634UTjuqN/s4
 GJWUpVELE8mVvx+MtmAeD7+zINLUW1dy3k6O92c6acSMpO7AR8GFnetn65sOxxU26wi8neW+zs
 Erk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 19/21] btrfs: factor out chunk_allocation_failed()
Date:   Wed, 12 Feb 2020 16:20:46 +0900
Message-Id: <20200212072048.629856-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out chunk_allocation_failed() from find_free_extent_update_loop().
This function is called when it failed to allocate a chunk. The function
can modify "ffe_ctl->loop" and return 0 to continue with the next stage.
Or, it can return -ENOSPC to give up here.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index efc653e6be29..8f0d489f76fa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3748,6 +3748,21 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
 	}
 }
 
+static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		/*
+		 * If we can't allocate a new chunk we've already looped through
+		 * at least once, move on to the NO_EMPTY_SIZE case.
+		 */
+		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
+		return 0;
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3819,19 +3834,12 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE);
 
-			/*
-			 * If we can't allocate a new chunk we've already looped
-			 * through at least once, move on to the NO_EMPTY_SIZE
-			 * case.
-			 */
 			if (ret == -ENOSPC)
-				ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
+				ret = chunk_allocation_failed(ffe_ctl);
 
 			/* Do not bail out on ENOSPC since we can do more. */
 			if (ret < 0 && ret != -ENOSPC)
 				btrfs_abort_transaction(trans, ret);
-			else
-				ret = 0;
 			if (!exist)
 				btrfs_end_transaction(trans);
 			if (ret)
-- 
2.25.0

