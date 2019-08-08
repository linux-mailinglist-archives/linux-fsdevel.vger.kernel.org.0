Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17E85E63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbfHHJbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:34 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbfHHJbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256694; x=1596792694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jYKsL/1OlXFJUZhZp6NAR8UoqS9vZgr4waQTYzZT8kw=;
  b=KFPe+ABRz2qXW5I1WhYxyQxQz7sXnLp53u+ib0k89CJ31bLkCavPnksY
   Gc3umDUw8D2T6M4vgxPchB80n9Zd6c29OJqqDmwMKeZsIWmjp6Pw2aZW6
   QSNGSPBsIj2NIgMCAA+Dv2qrG2JfOXpb7Tv769O5f4Qu+rudGw7w6N7Jq
   zKyZie/4LSznGayY3pt9bg8sSzaz0cLffuOmGAZaP2HvC3TFFrM5ZZOU0
   1BgJboms/ThxvRn3SkogjCVPLqL9eeCA2BQBRk2o1/dQ64B+mvzuwCUMe
   8O8Nan/bBR46fCbX0r9gzE7USs5R8szMtoQIKXvkdrTluKq4fXYRWesWz
   A==;
IronPort-SDR: l24Il5RaSN7Q2/niocy0ZOUWwQyGzW3XdN6BynZUCJnQHnvebhbU1keeAKE4ow+jWsS/vfWW+U
 zb3+bvV89bccR3EYWpVRuUPMWAW1j7akkcnDidYUOcMW5i3L2p8MYfC5Vosq4aigREv6AKWenb
 vBdeEq062PjgDfM7GFMoj3/ovemauyja1xySto6vFrvfGNlz3FHQY28EVzAC+wEiZaA7lqsBxW
 fLYQYl35pviGP3YW7tYEiaMVmgAFjLoxgRBWWTaDiX8zaPL7/m8F2VBZfqo1kGeb5eSTOxgui2
 HTE=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363360"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:34 +0800
IronPort-SDR: AeNpXHToLNrM4YLUKW/n2eXSkrGiHPGuuAh9yhV8NKR7NONBSck127MHzt8M4RpTofMc9NCbIi
 73lp/2TN6FBX2r7UK8jOm4e1jvjfWJ/uEtzUEvZykBuMlLRwDw7qsb+gyRwpWRCvQYSVNAa/dl
 WelbNjDj8+Y26ggW1OgcjJHgQo+7/f83fm+0lUPqA4uoi7b6sFCiqpEoKX10nF5TFTWoYFK0tQ
 ktX7sZY4x0zbTDRgsglPsLmiEDG8zNrtKQAyDj+aJdQJ4SR5I/JeJn7OqK2ZI2iiYyH2S3bNaG
 UIuj7VM7QcSfRlRTpYFJA/nf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:18 -0700
IronPort-SDR: jWCrIph+cwuyVi7MfHyfleyB7RA7JSlsd4mwUa/mOF1Hx0cOwg0U2ufBJWABgQAFLErDs6ZBRH
 LZA5010Cz3b9bXSYqO4o3W+nam18IeY6XrHCB62aLG7L0eYoYFf/CibTjXD+C5XFbTOmox34G+
 qJaH04kaJZ80rUyTHyT3vnp7f3qlnO/k9zieTliP3wH9RWWzmFjAAvMBBUYZRxeAjLW2LRbkM6
 QzRd54n+c6AcCKhVbdwjnKeoDMU8dvWJYp0L3gDPi1IIkemEjmkN7I/poihBshudfMdmbhCOi1
 Ar8=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 11/27] btrfs: make unmirroed BGs readonly only if we have at least one writable BG
Date:   Thu,  8 Aug 2019 18:30:22 +0900
Message-Id: <20190808093038.4163421-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
full device, the write pointers of corresponding zones of written BG
differ. We mark such block group as "wp_broken" and make it read only. In
this situation, we only have read only RAID1 BGs because of "wp_broken" and
un-mirrored BGs are also marked read only, because we have RAID1 BGs. As a
result, all the BGs are now read only, so that we cannot even start the
rebalance to fix the situation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d2aacffe14d6..d0d887448bb5 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8142,6 +8142,27 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+/*
+ * have_mirrored_block_group - check if we have at least one writable
+ *                             mirrored Block Group
+ */
+static bool have_mirrored_block_group(struct btrfs_space_info *space_info)
+{
+	struct btrfs_block_group_cache *cache;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		if (i == BTRFS_RAID_RAID0 || i == BTRFS_RAID_SINGLE)
+			continue;
+		list_for_each_entry(cache, &space_info->block_groups[i],
+				    list) {
+			if (!cache->ro)
+				return true;
+		}
+	}
+	return false;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -8329,6 +8350,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		       BTRFS_BLOCK_GROUP_RAID56_MASK |
 		       BTRFS_BLOCK_GROUP_DUP)))
 			continue;
+
+		if (!have_mirrored_block_group(space_info))
+			continue;
+
 		/*
 		 * avoid allocating from un-mirrored block group if there are
 		 * mirrored block groups.
-- 
2.22.0

