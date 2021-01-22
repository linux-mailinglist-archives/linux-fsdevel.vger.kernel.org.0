Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311BD2FFC8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhAVGYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:24:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51039 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbhAVGYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296655; x=1642832655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nil00kLlHevsN5SD0h2AjqhEQMomGPW36drmXXKfdl0=;
  b=QaEi2Ch+nxa5tdTz31I7g33Vvr5paftPVcY6fbCvKI4hbUjnYvXH80VJ
   6uuLV3oKSSOmCp/3tMvVY4dFUksBLEFol1JEZexJkrx6XNZc6af/5D1TO
   EqSp71I/BVc0u1XaDnNGvzvIw4DtTUmZddvs4RNmvVInetVhUi49jjUSg
   fyaklS6RhptKcs0Kl8V3RWJ014nEL8b3w67+dWMG8I42dyAtaXflRPDKU
   Jxjupj83uSFD7hcFd3G2R4hA65k6YzNrSKyiY6biiZjPGyPonMsNdv8Hs
   DjUd+LBDVB7krynHVK5awxCryi/LDU1JuPjU4j0NpD0TPByyxziMnuQJb
   g==;
IronPort-SDR: c5efJD6VYGed+8P0og0nxmYywMGVa003Nux2x5NVwG5CFXv/suf4EpieV24yukTJtsS8kPfqgh
 +VwD6GEoaeJqpMoLUv1kdEO/tKuTHUYp0PhxTU3AZEeyCkn5ZLFZ+ory3U5/+eWrcu8Mrs758e
 aNHhUPrkZRWtZjvoeN7QofSJpnXZXyNMx6bL1E7Y7c2WNFMrm8WzjDJ7VSBw8JWZ9rgMK38bLS
 vlhxYYn49XXuLNoQdeIW/8KpacA5wUZx3asx58Os7MmHI1WgatAZeMgdTs9FA5EkxYtmp4R34H
 Njc=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391954"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:30 +0800
IronPort-SDR: VxuExwLe3AzIIzCcUGC+Pq4ORhfkqsag5Jmp6Qc6NDWeEDUoxfHLQkxITWCAWorWPFA5Qdy2pv
 91pgEDnlIReVSZroFSUAe4xwzGMyapE4Und0vhyCY+VcBzJpebizJJzoLvW8agE9Yi4o5qaoQl
 scPUXzbrNs4+D4NBk9KIKqM0vet97oaR5YclV5T79QTuJK5UsLS3YHuW7eR2wEOp/Vw+UOKbzO
 VcFRNPRp9ZEoQkIS2fIwWmMzoquW8cQcJzLtrq4+JzeJamXarKBgp9ucvBI6wcbz/D+CAoixP9
 xh8NngrMJ2ZBeZ/RwoM1blOi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:02 -0800
IronPort-SDR: WnjyAS7JSb9zz5BR6c9pWZlBNsvZ4vm1kzYzqUmhkF8AD60X2Ux4fSabw4lmc6UMn6IRkHAqTL
 4C9k2azNuvAnXd2g29DiwrAXOTQLTvRRIVwxiY3cMKKYkTMZIC2WFi9b52eOV/ul9aUQm6WuIU
 OlLhUlto9DBK9+r20wG5dQVq/ljNvDgnmUlWlyIY6zXsiYfiVZiN15xDbBMDDZ3yTxipkXC24f
 HJoKv3JmeBDF0CDB3CO0T4TqNtQPp5wzWbU7GRmihRdNb+84DH9eFhiLBRMKN0zmrQeAecPR14
 gMg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v13 06/42] btrfs: do not load fs_info->zoned from incompat flag
Date:   Fri, 22 Jan 2021 15:21:06 +0900
Message-Id: <44c5468ccdca173216967582abde007af9c3cc9e.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't set the zoned flag in fs_info when encountering the
BTRFS_FEATURE_INCOMPAT_ZONED on mount. The zoned flag in fs_info is in a
union together with the zone_size, so setting it too early will result in
setting an incorrect zone_size as well.

Once the correct zone_size is read from the device, we can rely on the
zoned flag in fs_info as well to determine if the filesystem is running in
zoned mode.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/zoned.c   | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 39cbe10a81b6..76ab86dacc8d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3136,8 +3136,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
-	fs_info->zoned = (features & BTRFS_FEATURE_INCOMPAT_ZONED);
-
 	/*
 	 * flag our filesystem as having big metadata blocks if
 	 * they are bigger than the page size
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 87172ce7173b..315cd5189781 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -431,6 +431,14 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	fs_info->zone_size = zone_size;
 	fs_info->max_zone_append_size = max_zone_append_size;
 
+	/*
+	 * Check mount options here, because we might change fs_info->zoned
+	 * from fs_info->zone_size.
+	 */
+	ret = btrfs_check_mountopts_zoned(fs_info);
+	if (ret)
+		goto out;
+
 	btrfs_info(fs_info, "zoned mode enabled with zone size %llu", zone_size);
 out:
 	return ret;
-- 
2.27.0

