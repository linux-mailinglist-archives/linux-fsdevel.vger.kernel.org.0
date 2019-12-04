Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7F71124E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLDI15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDI14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448085; x=1606984085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGA303FlVuqj2COxIAsnFqsYcyGVrobi6DD536IWbss=;
  b=bJZuiL/oqvG2j+jX+fkSHLwTkKSchF9LTTk4N3L1gV82IFCDlN5kNVGw
   K8GjrCnbuiiARrtddC8e+KEn3rylmOM/WK+6R4sYNriVWa5nn0/AMKnIe
   L5Iz2K59gxZRvgaoJGbW+8CBl21ZSeXHaDs9qD78oLpjWIrSsXFgVxoJU
   5Na4uP/ic5yDn/sxv3Il9ce8mNXDXKE2VtLGUpBGhEiIY9XKS+Nsp8zgw
   XEwOwoNKmYe3Bs0H6mv9SZz+KumQ3aKW1uUDaguQIyi/WN3JkocYARgxZ
   Yd022QkraQClllTMtRr5XvPhh/Q+J+/Rj1cDO7fE6mToQBaR4KdomYabY
   A==;
IronPort-SDR: YJ9g58t8RbZ5ixLXHzIWgxo1Jd6V7L8fr7fvoo4gYwY2WDxfiv2tAqlOdZnKi3vQmVvgi9q9la
 ARYCWQeikvnWDj5H+lRGX6UPVT+xa38+DZe/tXuezu+tXG+XaBKW12Q1PwX9WG8oi4iFzq4k9k
 1Kvc9UhBqNwLPYuWkEDxV8O+AeBgoOvSHvD+87CSymR/yL5U90y95fyaWUa6nwXcl3GEYT8cj4
 WGYIKkq0mvsbQQUt2DqHyXpXVMb+SCS1yupyWI9/imJjYhxQK6FklaD0ukr8kvop3/CK1m/Pez
 Jl4=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031764"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:28:04 +0800
IronPort-SDR: j2zWLUFF1fD/S2G77FKP9XLkzuuiqUNqRxYx+uIE0sSTeF7C4nbYq/3oIpuAFD8PC3PUaAqI0p
 rAyRrVLutAOCviKn1i4JEx8dIepw6UpqDGZCoH/d9rq14NxZp5b1RB4TpV/Tfgz1v3wuK7UNBw
 l0eqrwd8nBF4MUt5j2u8JtVNQHKV6XN20vqWXB/tXiblqb0Y1addAU9tdDjsqbmhZbF8of+s5E
 AuWJX+tJHpjysXHwOvt1AZHRRJzofBlcP9BAMSOixTxyU17xAD8YLkC0UYlbI7cewdL/HehL55
 KKG+SHm0Y+inAsgNZgi9CoCZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:43 -0800
IronPort-SDR: vivBBb04zd08TabTTqniljCl2lTynxK9caNuJ34VHHljCAy4iHoejKDyLA611sQMsckR+7HpWq
 9BOocTRh7tPi71Vx5WQy83hjPEIllSuw0kclUg6BIiG9AKDnjUHr0kP4WLaZhPyL23AZA55ZWD
 tzDRoxusI/KkgxzMBv46cBme6rhR3ND/UdcrxN+NfpNOBYrb3PTTEK7aQ+pTn0LdlYqopThyXb
 7GYJddHVQfp6VSFl5TKSGUYuKYM6VUnSKiQjnVoZ5ZFjyVHRoF4ZTyKFusnD0N2l2vapL3uy0c
 B7g=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 12/15] btrfs-progs: redirty clean extent buffers in seq
Date:   Wed,  4 Dec 2019 17:25:10 +0900
Message-Id: <20191204082513.857320-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tree manipulating operations like merging nodes often release
once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
node are not uselessly written out. On HMZONED drives, however, such
optimization blocks the following IOs as the cancellation of the write out
of the freed blocks breaks the sequential write sequence expected by the
device.

This patch check if next dirty extent buffer is continuous to a previously
written one. If not, it redirty extent buffers between the previous one and
the next one, so that all dirty buffers are written sequentially.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/hmzoned.c | 30 ++++++++++++++++++++++++++++++
 common/hmzoned.h |  7 +++++++
 ctree.h          |  1 +
 transaction.c    |  7 +++++++
 4 files changed, 45 insertions(+)

diff --git a/common/hmzoned.c b/common/hmzoned.c
index f268f360d8f7..53c9e1cfd472 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -907,10 +907,40 @@ out:
 	if (num_conventional && emulated_offset > cache->alloc_offset)
 		ret = -EIO;
 
+	if (!ret)
+		cache->write_offset = cache->alloc_offset;
+
 	free(alloc_offsets);
 	return ret;
 }
 
+bool btrfs_redirty_extent_buffer_for_hmzoned(struct btrfs_fs_info *fs_info,
+					     u64 start, u64 end)
+{
+	u64 next;
+	struct btrfs_block_group_cache *cache;
+	struct extent_buffer *eb;
+
+	if (!fs_info->fs_devices->hmzoned)
+		return false;
+
+	cache = btrfs_lookup_first_block_group(fs_info, start);
+	BUG_ON(!cache);
+
+	if (cache->key.objectid + cache->write_offset < start) {
+		next = cache->key.objectid + cache->write_offset;
+		BUG_ON(next + fs_info->nodesize > start);
+		eb = btrfs_find_create_tree_block(fs_info, next);
+		btrfs_mark_buffer_dirty(eb);
+		free_extent_buffer(eb);
+		return true;
+	}
+
+	cache->write_offset += (end + 1 - start);
+
+	return false;
+}
+
 #endif
 
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
diff --git a/common/hmzoned.h b/common/hmzoned.h
index a6b16d0ed35a..ee2fab311967 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -72,6 +72,8 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
 int btrfs_load_block_group_zone_info(struct btrfs_fs_info *fs_info,
 				     struct btrfs_block_group_cache *cache);
+bool btrfs_redirty_extent_buffer_for_hmzoned(struct btrfs_fs_info *fs_info,
+					     u64 start, u64 end);
 #else
 static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
 				      u64 bytenr)
@@ -112,6 +114,11 @@ static inline int btrfs_load_block_group_zone_info(
 {
 	return 0;
 }
+static inline bool btrfs_redirty_extent_buffer_for_hmzoned(
+	struct btrfs_fs_info *fs_info, u64 start, u64 end)
+{
+	return false;
+}
 
 #endif /* BTRFS_ZONED */
 
diff --git a/ctree.h b/ctree.h
index fe72bd8921b0..7418627cade3 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1125,6 +1125,7 @@ struct btrfs_block_group_cache {
 	 * enabled.
 	 */
 	u64 alloc_offset;
+	u64 write_offset;
 };
 
 struct btrfs_device;
diff --git a/transaction.c b/transaction.c
index 45bb9e1f9de6..7b37f12f118f 100644
--- a/transaction.c
+++ b/transaction.c
@@ -18,6 +18,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "delayed-ref.h"
+#include "common/hmzoned.h"
 
 #include "common/messages.h"
 
@@ -136,10 +137,16 @@ int __commit_transaction(struct btrfs_trans_handle *trans,
 	int ret;
 
 	while(1) {
+again:
 		ret = find_first_extent_bit(tree, 0, &start, &end,
 					    EXTENT_DIRTY);
 		if (ret)
 			break;
+
+		if (btrfs_redirty_extent_buffer_for_hmzoned(fs_info, start,
+							    end))
+			goto again;
+
 		while(start <= end) {
 			eb = find_first_extent_buffer(tree, start);
 			BUG_ON(!eb || eb->start != start);
-- 
2.24.0

