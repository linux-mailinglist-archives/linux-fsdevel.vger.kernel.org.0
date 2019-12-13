Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30511DCE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbfLMELF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:05 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11896 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731720AbfLMELD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210262; x=1607746262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvg0IqZ/70mmiMou4MCSFBUNqZKh0c6d/vjtjdV79yg=;
  b=N0778BxgafNcaLRA7F1clmPxPjpkq/qqJMLs1amFEy0wioHtln2Xw4HG
   uqPN4mfQVXAODPb2gMtorxHvK4qwxqpgftbvXHvzBfY9UrIJFSTnpyfVs
   JggVkdxH6pYJL5ccB1acOy9hd/eFG2711ebLDakt2mRa0t5xwwxkKjXuF
   7O2DS6d8Knl9/1914dkMPIC/42TEQfAtvtIsf0s1kZrL2yRN6uMx+EZTO
   0agfwNH7POCIhuYMnjC6eSD3oWmbbJvfLO893vKXVymLyopouoX9T/pco
   tIjJJSLlG2mV9oa1pCkJW0ga7x5dJzcLE6MiesT0Bmo+YciEFdgoQYY5X
   w==;
IronPort-SDR: uBN/x6ArYHFpsQX8C/+okmi/xI+CJfLiZakGCcSPLfq8N70TqoGcPk3pYnQvND2yCTHoYP2NTL
 h0atHtafwJSjv/Xcd0oKqAMYHq0Orv/PcbxIopXGWxD9lwCVyj0WjdMYejyOpHYZ6aRKZYDBXt
 g1UqPy1++uNFzl/yhIyXJooZGfUXMY4lQHYqOQmPSYZx8akV/w9HaBRJQQFCswtJudZ+29TW/u
 8Us46FmOqaEFC0NukD0bd7AEU2m/FyjYdIuyGw+AQrr5lOsnpciHP7CcF2oShngTFE4Fn71WKM
 F1k=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860128"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:02 +0800
IronPort-SDR: qRH64oRzn0mcoju/WJAd7RlE8ObCsHO04a7UEQwT8fIVAUCUvumOAsiqLFTRlF2xOZ3z2B4n3I
 lhCYCsYqJIYOE4Aiwra1RWnaeB6uhT1V6N0qzXpGPflp/5tj45kENM4LJsao77/rOrlzCDIX37
 uJQN4P2xhlp7u1GsaGx0MQywvuNmnYGYoV624VCF1fBdu7URSTGR9gULxgz5bsioizDxUu8K7z
 nFj8y7Fm8iqd/qu/X94qBn5aHc+Q0yOUTDj8z78ghbO1nAW1SWi8h3G3IFTalznhuw2cl+/Ieg
 237RdC7X1NQ5u/u8NSSMvEaZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:34 -0800
IronPort-SDR: advJTC2F+cIL0F/CGVSBlz/BmJPjJSBp+XhfONNQdFrhvi8g3UkOu99vmSIAkgVPMo6gGileHl
 A6ilSUgGjLYyxZPSxElINJyoVxLCmQG9OGdeCwWTH1yPPXo/2ZH7Hh3uca5Bo04TZ8uUMBcnmM
 5AY9RSmNpzoYtLqY7x6QkVa3PCCFNgtYVeYjZxUL4KvZIyCDAa0Mj+eielN33kJSzcpt5PFAvW
 3k+672ld1ff5k4yE+fYPU5gaKaalcssAfuH5vo6AXYaheSthGWfdjLYz+QNxPcHiyXUBvsOMAo
 bx0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:10:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 11/28] btrfs: make unmirroed BGs readonly only if we have at least one writable BG
Date:   Fri, 13 Dec 2019 13:08:58 +0900
Message-Id: <20191213040915.3502922-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the btrfs volume has mirrored block groups, it unconditionally makes
un-mirrored block groups read only. When we have mirrored block groups, but
don't have writable block groups, this will drop all writable block groups.
So, check if we have at least one writable mirrored block group before
setting un-mirrored block groups read only.

This change is necessary to handle e.g. xfstests btrfs/124 case.

When we mount degraded RAID1 FS and write to it, and then re-mount with
full device, the write pointers of corresponding zones of written block
group differ. We mark such block group as "wp_broken" and make it read
only. In this situation, we only have read only RAID1 block groups because
of "wp_broken" and un-mirrored block groups are also marked read only,
because we have RAID1 block groups. As a result, all the block groups are
now read only, so that we cannot even start the rebalance to fix the
situation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5c04422f6f5a..b286359f3876 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1813,6 +1813,27 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	return ret;
 }
 
+/*
+ * have_mirrored_block_group - check if we have at least one writable
+ *                             mirrored Block Group
+ */
+static bool have_mirrored_block_group(struct btrfs_space_info *space_info)
+{
+	struct btrfs_block_group *block_group;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		if (i == BTRFS_RAID_RAID0 || i == BTRFS_RAID_SINGLE)
+			continue;
+		list_for_each_entry(block_group, &space_info->block_groups[i],
+				    list) {
+			if (!block_group->ro)
+				return true;
+		}
+	}
+	return false;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -1861,6 +1882,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		       BTRFS_BLOCK_GROUP_RAID56_MASK |
 		       BTRFS_BLOCK_GROUP_DUP)))
 			continue;
+
+		if (!have_mirrored_block_group(space_info))
+			continue;
+
 		/*
 		 * Avoid allocating from un-mirrored block group if there are
 		 * mirrored block groups.
-- 
2.24.0

