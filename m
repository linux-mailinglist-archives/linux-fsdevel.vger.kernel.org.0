Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF79D85E69
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732385AbfHHJbm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbfHHJbl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256700; x=1596792700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+gzXoIOCfgUIpJhfW43aVrMMmQdl5D7DVFIt2CZBcYc=;
  b=JRLmrCGEx5y5Ae8Iv7/TbMjcK6MJCe1uPM+1Te9FRBzDMYC6/dcCFpdS
   c/OP7sfkd2gqm4lTjnWvmpO8Du9ZYHTfslIS8OJb1xvJTtSlKZgsspoad
   6yVNHhFq8I/boi6IqLErSFIja0SBPXtpssGETYIykW4dWpS/rsNO/g5OG
   E3Rwwn50Nlgm42rpx4qp10gmGX7H4YpVSrHI1MMoLs43nynzNUrpOdbwE
   gVO8p0zjzjhnFwumYAKCgPxyrfFFR2sveN8g823u/QZ08y7z2KvNR6f+C
   YJwtP9gF97SrEe72DhtQi/aQh8Bkbq5Oi5wxWcyazcclZUPFGdirh3jmI
   w==;
IronPort-SDR: XFeVPViWvHlyigrs8TpOkSlswBzF9ePj8a4ZE8tvEedy1QYKeiYHzYyRSBU08f9/DYAjhz2YqF
 Ww0wshcrWb5zDEXI0OEe1SIfnU1YAqxCXrVUUeyzQAU9Z4waXfFnDoUNt3STWWwmZ8ObcNnJNl
 CTVm5PBRMLosinVBCGTIBPb2xwrodDSCAbNyriT5+NlMOWCg0awO2q03CagREy4mZe5b0T2elz
 SAcIoxw++K/+i7TQl1vX3scpW3EGsev7TZ3242xV/x/rS9lB5vAi3kO0dvA1qRqeaqKoisQVL5
 dHI=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363372"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:40 +0800
IronPort-SDR: TJRHdd60/JYTfzCCah4ilbGwJ4kkm2hAuGk6puUu5C0rsm9rasG/BQkMBnXd6+8j6d0OXXw8Hy
 u/9fAn/sFTQlFzb3alQSTWfNBTH2QVCKhFv/ZeMgYa75GPtEFHoPQ5/Q2o4UXZ/HKhEb8cSANF
 JLMM2M2DcboolZb0xglY7PNaCF4AA0w2xrXCqxX7vqNt99VBpGungrSyj0RmuO4tdQK9ETxf3n
 ENohyMHBomiBFUqZRnSY3C7syEO+dEbe3NQy/XvG3gbdHSOOXEuWHoeQZPk+fc1/cS5ugjDq7I
 l1Y0G48zdzsfkoA6hwhhgtaS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:24 -0700
IronPort-SDR: N5IoBjuvounAwKb8tXBPJiGmGhPCPEu+BPe90a4q8wNRqe/kefR89hR6hhoCg8eeHIRyA3lgXS
 2xwPKUioPegt3HkQHFhpBS5AiVL47FGAEtrQi3YeBu5lWLu5yowG+tuRO6KXY7vpN3pCMNNDBp
 RkLOUUNJEjQiMAZabgPx/79cwtQSgiPOsNMcsxbUorAgcXakTQ6f4ekfITWrgqPJsu0i0sjl4h
 W3r/CdMiq2gCt0M2HvqLZJl9DWqp2+t+0u3lRwVD8rp8evZjYi6wJdjOvYCV1AiYU/VcFUWBdw
 EGU=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:39 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 14/27] btrfs: limit super block locations in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:25 +0900
Message-Id: <20190808093038.4163421-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When in HMZONED mode, make sure that device super blocks are located in
randomly writable zones of zoned block devices. That is, do not write super
blocks in sequential write required zones of host-managed zoned block
devices as update would not be possible.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c     |  4 ++++
 fs/btrfs/extent-tree.c |  8 ++++++++
 fs/btrfs/hmzoned.h     | 12 ++++++++++++
 fs/btrfs/scrub.c       |  3 +++
 4 files changed, 27 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 65b3198c6e83..a0a3709de2e6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3547,6 +3547,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(device, bytenr))
+			continue;
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
@@ -3613,6 +3615,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
 		    device->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(device, bytenr))
+			continue;
 
 		bh = __find_get_block(device->bdev,
 				      bytenr / BTRFS_BDEV_BLOCKSIZE,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8665aba61bb9..de9d3028833e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -238,6 +238,14 @@ static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
 			if (logical[nr] + stripe_len <= cache->key.objectid)
 				continue;
 
+			/* shouldn't have super stripes in sequential zones */
+			if (cache->alloc_type == BTRFS_ALLOC_SEQ) {
+				btrfs_err(fs_info,
+		"sequentil allocation bg %llu should not have super blocks",
+					  cache->key.objectid);
+				return -EUCLEAN;
+			}
+
 			start = logical[nr];
 			if (start < cache->key.objectid) {
 				start = cache->key.objectid;
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 40b4151fc935..9de26d6b8c4e 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -10,6 +10,7 @@
 #define BTRFS_HMZONED_H
 
 #include <linux/blkdev.h>
+#include "volumes.h"
 
 struct btrfs_zoned_device_info {
 	/*
@@ -125,4 +126,15 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 	return true;
 }
 
+static inline bool btrfs_check_super_location(struct btrfs_device *device,
+					      u64 pos)
+{
+	/*
+	 * On a non-zoned device, any address is OK. On a zoned
+	 * device, non-SEQUENTIAL WRITE REQUIRED zones are capable.
+	 */
+	return device->zone_info == NULL ||
+		!btrfs_dev_is_sequential(device, pos);
+}
+
 #endif
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0c99cf9fb595..e15d846c700a 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -18,6 +18,7 @@
 #include "check-integrity.h"
 #include "rcu-string.h"
 #include "raid56.h"
+#include "hmzoned.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -3732,6 +3733,8 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >
 		    scrub_dev->commit_total_bytes)
 			break;
+		if (!btrfs_check_super_location(scrub_dev, bytenr))
+			continue;
 
 		ret = scrub_pages(sctx, bytenr, BTRFS_SUPER_INFO_SIZE, bytenr,
 				  scrub_dev, BTRFS_EXTENT_FLAG_SUPER, gen, i,
-- 
2.22.0

