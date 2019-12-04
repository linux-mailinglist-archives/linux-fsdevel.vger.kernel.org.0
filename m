Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727EA112468
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfLDITu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:50 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLDITq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447587; x=1606983587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wvg0IqZ/70mmiMou4MCSFBUNqZKh0c6d/vjtjdV79yg=;
  b=jEcZB9d4eaUujFquU5GM9sfSfruhrn8Zz0olvuFHte9Dl3RalQdhW97R
   kPTUP3Q/RAK7ESuVw+RUWAw/tW3R+pMpNHWdVzMlBoTYIaEKMb6Q/Z5Yf
   MA4oy1hyfHgnu0X8g8ERIRphXXGMSJJjDRWi7TCd9sBPXbHv9wZ1V5EXt
   q9CvkR5LOSOOEqsi7SrUXqI2ecqX30Gc5LQBtG14i+8BdpMck9MsXvS3b
   VU68Y+tmX9EJ3rC0sOFCJ5bxBqxGZfg3qZeUBpUxaqFKc2vR66s3po1Fu
   jbljXBw+Sgnkuj1zgV+VpIZPsCSvo47KiJRZOUZ3uhKdRmnsLhJ44OCYj
   A==;
IronPort-SDR: cTSByzUN4eQQMK099gRon42SkWSS51bc/c1qbSLswi0bu4ypQuoyAyR69lgCedg4Ne2EO8zuHD
 wc1KTe/rAOsd+n9bo+oZ49yhPGzSDNa/vHt4Y6IO6to5LDAEjUSza6gst0LVlbYULUzvr3TBP7
 EP6QfmTCMUeOqnCBXxUtCpWguDrp86BnZG4E8A6Go8GATJFbNhZTJkqe26jWAo9nnay64WQ+E+
 7eBcqh6flpU7ia1zzHum7Ki1HLhJYE9b9Ibvz4y1bPeqSHGSZIjTuZ0hWCJXCglzHBBa5Jz4Kg
 DaM=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355064"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:46 +0800
IronPort-SDR: W3oSlbAGmvsP2wuSgjHZAkMUzonOoC3GwCWZnC8yhmF61bBoAVEmOYIHA0fKnTmoaAYmha1/G7
 CoF/0iPFqg4epmqN002/hZTTVZFLC0jR21eHiB9HOkyiMdc174uNeSaP72njWqS97YQ9+Itw+n
 i2v/+M7LTSsUgVsJQvFCowoHhqc1JrR8o/DGKQcszXDF0OT3E/EQvwlDWatg7vvx0RIBU/I6oY
 wfmGHtjUR6ltCyh9aB6BC5SpMgyZn0iXGK61EjCW4xjRU/5d7pM/HP9LkB66CECQaJmbo3yL1K
 uL6/bjmOqhG/8fs8fao2joP0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:11 -0800
IronPort-SDR: /bk3FznSpO+2nolqNKzEdF82r59p9l8zicp4IBiqgssl3Am8YQE4rl0wunHIM7Fuj9CncurEKn
 pBUH1ydhfz4EF6fZ6VinlxAokDPc67GWOdrt9hBkZwySrefx/lJWVn0KGyg6NyraqRnpfPjLJ+
 9G48j5q6b4Yi5FGWOoZZ1JR8iNgUilplU47gm7MBqZ9DSw25hGR/X0SGDovCBnM0XkGQ4aCxWX
 bJK65ibetdnrrCeiU3NwVfF7BNJa2CpTwk6d+PcSWdK6j5Jr5cpg/LCtX5Z1p17ksNR1wszr5r
 IaI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:44 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 11/28] btrfs: make unmirroed BGs readonly only if we have at least one writable BG
Date:   Wed,  4 Dec 2019 17:17:18 +0900
Message-Id: <20191204081735.852438-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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

