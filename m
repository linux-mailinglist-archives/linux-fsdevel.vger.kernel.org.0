Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89D2A06EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgJ3NxD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21997 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgJ3Nwy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065973; x=1635601973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QQGbEtdKYhE6rWKNVcyaLM+Ube5SIByZddq0G034/rY=;
  b=RzXiCMOYIWJOLFdZEg7lgY0FkKPGfxtC8D6v7kOnl4Cq+dYP6Nq/WfBo
   vLpu9FCAE8u0cAPCoW/623wR/1808ayLlk+xCZqdwDdfKkBfhuLETJRRB
   ALbagrSw3QC3q5jcBemGXzKEWhVBWNKTKTF0+Uj56Rn5SbrdnqziacuCQ
   Zhk5oPBd5/RpuP4V/WCTnq7uNqdTOkY1hglugGdXptduNUDAG78o444py
   K+aILZUFk5IuqQpoahw2a46wnai5ojbxi3weyS2QhFB3IaCx9BQZh9Mfr
   aqLk0LbYH5WguI7EtyEZYydQ0eb/Gu62eanO6jGnzt3WbVbuPMKJVc/qa
   A==;
IronPort-SDR: mhPQhj5ImoX9UG2xh+pTTgeMnU4kX9Bk512NPQrUqViT+cL6v/H2d0W5YY/nt/nB2iBTI3uMNp
 pIQnEMXcA/eQKRi9yI34wiTsoYJPWseglzQcZARwna1+EMmgcYHAi+dkD9cpf86dcfDoMYjiyx
 RhBZf3wwPm44TTnqLbztUVtFd66pQmiezmY4rfJtCIb5/aCdoB3nmHQ4x6+YJ3f6kCuZsQ4l3p
 Wc/gXgaRFVFydihlrro4JfcKTxCowdHx/SQg4k/8KyQfvdzdR5vDzy+vdKuB+JSgL0cLfCyVNp
 bgQ=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806612"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:43 +0800
IronPort-SDR: HQVOYAKVL2Dcy8KPUEbuxZI3qMN270GVcnPONSaN4QqNloLPq/b3IDGAOQl6JcKPTnWzsmbX7n
 IE9L9F+O6cz5FPVcZsu5zkKypQHFOpPhtWlx9nTtJuKd7Vk+BNiRM9pmsOtwziLRMQEyPqoje0
 mNNlhS6qatijaNBu1U1tjDsEEmFpG15HUAbSR5Bhq2FwvnLyaCD0O1hiOUQrZ1ORivbGOc39w9
 INy949KeSwpTuf3KtHM+Jqh/r6XpXR5YcBjxone7+mNOfDXN6Wj4pwKQ08bSobcUrNp5uU8Bkw
 +Nl7SGEdZOofoCAfmyPR1oLC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:58 -0700
IronPort-SDR: a8n9AzINFsib9qfupn2kw+5yaMgdiIQNK1obqZocNCNqLVKJspmUm4Q/a7U5ENBWDQVAfOUP2y
 b7+RU+v7Y0IaNxYkwE5CubEVKCgFZSybGwy0W1B6XYqHqLRx8+JMtH/RZze8e3TIVYAtEt3mmC
 mHQ3/YLXNLO3kH8Rn6FXP3SEDtbbklx3hmaRFclzlJWQm4LJ39APtWyZatpwDglH10AHEF4bOj
 7J3T3kMb1QvOLugnBr9ibDuufWAyaWNX1n7d/kVkDmKDMudMOZXRYVWGDOD7NwzxOrmqFSJHjm
 2Fk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:43 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 18/41] btrfs: reset zones of unused block groups
Date:   Fri, 30 Oct 2020 22:51:25 +0900
Message-Id: <575e495d534c44aded9e6ae042a9d6bda5c84162.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For an ZONED volume, a block group maps to a zone of the device. For
deleted unused block groups, the zone of the block group can be reset to
rewind the zone write pointer at the start of the zone.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/zoned.h       | 16 ++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d67f9cabe5c1..82d556368c85 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1468,8 +1468,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
 			goto flip_async;
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
+		/*
+		 * DISCARD can flip during remount. In ZONED mode, we need
+		 * to reset sequential required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+				btrfs_is_zoned(fs_info);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5e6b4d1712f2..c134746d7417 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1331,6 +1331,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1338,14 +1341,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+			/* zone reset in ZONED mode */
+			if (btrfs_can_zone_reset(dev, physical, length))
+				ret = btrfs_reset_device_zone(dev, physical,
+							      length, &bytes);
+			else if (blk_queue_discard(req_q))
+				ret = btrfs_issue_discard(dev->bdev, physical,
+							  length, &bytes);
+			else
 				continue;
 
-			ret = btrfs_issue_discard(stripe->dev->bdev,
-						  stripe->physical,
-						  stripe->length,
-						  &bytes);
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 42b1a4217c6b..d13bc6d70ea4 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -193,4 +193,20 @@ static inline u64 btrfs_zone_align(struct btrfs_device *device, u64 pos)
 	return ALIGN(pos, device->zone_info->zone_size);
 }
 
+static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
+					u64 physical, u64 length)
+{
+	u64 zone_size;
+
+	if (!btrfs_dev_is_sequential(device, physical))
+		return false;
+
+	zone_size = device->zone_info->zone_size;
+	if (!IS_ALIGNED(physical, zone_size) ||
+	    !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 #endif
-- 
2.27.0

