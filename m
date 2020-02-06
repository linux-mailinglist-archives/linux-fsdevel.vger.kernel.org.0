Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 404AB154231
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgBFKos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728604AbgBFKor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985887; x=1612521887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lnVdddzYJtsYF0X/v47ws9xVWfRcDlWcoZiexqrpnuY=;
  b=rTXpXiE0apBcO2rzHXSUleOUBp8MoT4hsaFzeqZeIYRnPyLJFPQ6tAMI
   uDjbyI3qbBsCOaKN4nXa8IsHo/mguOLK1aWEWKs3p+Z1HUpz4sbgs9zSk
   +6OHLUvNWjNJdcW4f+6vXh7VKr6HiTQoxnNBcW98zhvCmVEd4PJp6yuGv
   GSlis0AMAJdwEADsaV41dwtBxKSYHeCBLkeoB3oQcfQplHxHYnm/afQ/k
   urjvBHOdIcHKB5Z49UvsZYCJRHJU6wzSiWmpsfXJ1DAtjPUtMXujb9uPJ
   8GeH0kkVYwzHQwzw7DmsWF82iL4WBCVSYB3Gbf7DBPeUNbOt6hQWU9bVL
   Q==;
IronPort-SDR: /2LaYIF1TOaAgqufXdzMbA7dybwHK1PT2Nke1IYIEdg5IFoB/lyzfMivauhPUv0Hv5Js7ZyE1v
 myBAg3ijnmXHxKu2V/tZxHxfs+VSdAUvFLuqis5P/gLQHGPZrw0BQV3ax2Rlsq611LDFim9wWV
 7SlfjUC+91yUrB8s1EeyotveLduJb/DnXnvoOI9x0eLaE6A5Koji9HVQY0o0RQcw1bw9KT5ejW
 zieM23eZpG2Mexa+OU7ddOBC+Je8JOwWV7AkQWxOwR/LjqemqvHdgapT4g53cYHIVV3RikUPmh
 QSo=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209553"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:46 +0800
IronPort-SDR: mKFsHEMWpDhAKsdZEvKme3O4cCQm+vvHJUuRMM5XIBe/NEnB2qCIeIcxaLyLo4ANwaoX+uJs7a
 nfu68Grbyc9tRNaYRU3zfjuMash5/WKCgsbU9wW1MKbrgPgBYi1AOxTWyilyfRD5luqSAXRxdv
 qMvhNEL3+JDEHhOoJNBMJxAbdwwfqPfl9PTEv+kkFBsttnZjIxCqx/tsZVQMSc5m2yQaGktZ5r
 L6jQuLM7jc3t5t3fq/W0KTlwPEYDZNRDdwbc/MVzOV2TE7gdsbO53qS+VyQCZm4qjqewJBZ6Q2
 JVBQeoKW933xW5Imro3+3Rvi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:46 -0800
IronPort-SDR: b9acYQhvnn+SntN3zRCaDE00y8ocDPZtgRDML1uELSxvGgcj4sc0AhHb1cI815temIvTzi7xji
 DUJ/2k6Uhpd1zc9s7wmCVLGrh62GcWuarA2q0cl0xt5pZaVyEGHWXLpIjY2Yr6CVISr2j6u6CO
 aaiAwKNG/+BNZu3DmXGhJIa1XmXhdKeG+2zGs18syIfBiJyeai0TB1yZxEDUvL4yyRrlW0R7PZ
 Vi4AE80FikvokiQeaCD5KsUiIJB2eWVLtM9cbNum2UTMBmUSbb+AC4MuLr7K51JUcMqLHEFWFj
 1b8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:45 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 15/20] btrfs: factor out release_block_group()
Date:   Thu,  6 Feb 2020 19:42:09 +0900
Message-Id: <20200206104214.400857-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out release_block_group() from find_free_extent(). This function is
called when it gives up an allocation from a block group. Allocator hook
functions like release_block_group_clustered() should reset their
information for an allocation in the next block group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0e1fe83e5d79..9f01c2bf7e11 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3712,6 +3712,31 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	}
 }
 
+static void release_block_group_clustered(struct find_free_extent_ctl *ffe_ctl)
+{
+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
+
+	clustered->retry_clustered = false;
+	clustered->retry_unclustered = false;
+}
+
+static void release_block_group(struct btrfs_block_group *block_group,
+				struct find_free_extent_ctl *ffe_ctl,
+				int delalloc)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		release_block_group_clustered(ffe_ctl);
+		break;
+	default:
+		BUG();
+	}
+
+	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
+		ffe_ctl->index);
+	btrfs_release_block_group(block_group, delalloc);
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -4094,11 +4119,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		btrfs_release_block_group(block_group, delalloc);
 		break;
 loop:
-		clustered->retry_clustered = false;
-		clustered->retry_unclustered = false;
-		BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
-		       ffe_ctl.index);
-		btrfs_release_block_group(block_group, delalloc);
+		release_block_group(block_group, &ffe_ctl, delalloc);
 		cond_resched();
 	}
 	up_read(&space_info->groups_sem);
-- 
2.25.0

