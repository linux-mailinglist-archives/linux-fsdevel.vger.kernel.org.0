Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4530F0AA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhBDK0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:26:51 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhBDK03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434388; x=1643970388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=siSfsR28G71DWO9yF0vS8Zn+MRrW/89+EczZivcJR7k=;
  b=XQU5UAYypxmpGWOBNjcdVALNFZc17ufEYbV6LDFwLiaO+q8mcaUS/ERU
   QsyQUmKlrUKNrsaNxb0oIWH8uNBIbqJx8um/+IbbXhW6MFVoUG7AL64Ou
   Z6FVoKcTj6mLeAfY8Iy/TpmRX9Mbj117hBESDt/11pSi8eWtUzkKPGGBB
   1DjOBY0FIQ2OAUlwh84oIhyrjYmsH3CAG9+ISKhLV5j8dRYxYUwmrEYPG
   i6P9DXKFDtbuiwH4LJY6ldAAHEDvGqqDwfxa/vc0s1NuACQu96RdxS3M8
   rONr8jxtaHjL0o04IFeQem9o/Uv4ngqfPZthfzM59LoarThhVXkaH0ZmA
   g==;
IronPort-SDR: jGrYDHppvBc1GoZhNo1LOrp52BNXAAVTDCe6/3hR/+KtrCxUQ0Uh2N1uywmUh6JkJfHkbESn0b
 IMHmnEaUBhLFoXJVV6R0Jeqfs7uSI04UNvtzguJnWXlgep0341+37IZkhBNgCcHsN6c6xndVLy
 9PJgicPpwczKh5q3A1tJnLB03Gt1uDp9h9lo84VH02TdayDweXG3qnxQdtCESR44LrFp1l6gNH
 WhwbFBcZTK0eRV2CoU8hwi4RAFzedUu8O/HAxr/nkYMLAcT1fPx+2yo8wb3qCZyFsv6K55HCdO
 juY=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108001"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:19 +0800
IronPort-SDR: wkiLr7ld+ARp6/vAzjwMnhOBRVWU/8YfiYvN3TVQXEyskGBEknPBQykVJVlOXfayMwc+NNZ0kM
 BkBERfBA32QsSi68gDW1DkeIh4gNvsrvLbbYxdC1EhHOTznCFc5DsIP9PN3SDS4yamGaWYBJfJ
 pcxLdQ2o3+Cs41i9Dbl7awFoa7r1/zjeHwsM/2eKOk9x9KPDnMNiU2btvlxjg4tA3w9Rt0Eh/f
 XkJ7b2FGFsLpIIV/gzI7U+zScIB/+Ck/8qIdMUKGkjcS95JptYnqUXpFLrMB8lJBPfMlQg7NK2
 i27BUymrV49Zd7/IJ7OJbOKK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:22 -0800
IronPort-SDR: pvAHaGwQ5NgGnDDO95RTHlfXY/zlcZQKWZ74q3gRtX5VF1nZ4uSVEzkcnbDC6+DVs39jiXJ2H6
 XaNMGid+jEifavGjMnCFSedfIw8baHoqug1VOyhobmSndu0NEBGFR0YtI+FFHZlmyPiwPwZAv2
 s/gk2+YxwE9xQY9VZLhA0Yidhlq04FXxNuPomEiL1uC59KSWchi79SSm7VPC/oZ5yMlb/2eZwT
 TNYsSO2U/zya0qarEKI2raO/SOIS4JxFjSnh/yP2zfqGU0y0PyosBapfwUpVrrtP2tGNV3RjSv
 02s=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v15 17/42] btrfs: zoned: reset zones of unused block groups
Date:   Thu,  4 Feb 2021 19:21:56 +0900
Message-Id: <e617f0e990243a11f9186e789d1a3819c9d102c8.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We must reset the zones of a deleted unused block group to rewind the
zones' write pointers to the zones' start.

To do this, we can use the DISCARD_SYNC code to do the reset when the
filesystem is running on zoned devices.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  8 ++++++--
 fs/btrfs/extent-tree.c | 17 ++++++++++++-----
 fs/btrfs/zoned.h       | 15 +++++++++++++++
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 63093cfb807e..70a0c0f8f99f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1408,8 +1408,12 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if (!async_trim_enabled && btrfs_test_opt(fs_info, DISCARD_ASYNC))
 			goto flip_async;
 
-		/* DISCARD can flip during remount */
-		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
+		/*
+		 * DISCARD can flip during remount. On zoned filesystems, we
+		 * need to reset sequential-required zones.
+		 */
+		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC) ||
+				btrfs_is_zoned(fs_info);
 
 		/* Implicit trim during transaction commit. */
 		if (trimming)
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4d48a773bf9c..a717366c9823 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1298,6 +1298,9 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 		stripe = bbio->stripes;
 		for (i = 0; i < bbio->num_stripes; i++, stripe++) {
+			struct btrfs_device *dev = stripe->dev;
+			u64 physical = stripe->physical;
+			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
 
@@ -1305,14 +1308,18 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
 				continue;
 			}
+
 			req_q = bdev_get_queue(stripe->dev->bdev);
-			if (!blk_queue_discard(req_q))
+			/* Zone reset on zoned filesystems */
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
index b250a578e38c..c105641a6ad3 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -209,4 +209,19 @@ static inline bool btrfs_check_super_location(struct btrfs_device *device, u64 p
 	return device->zone_info == NULL || !btrfs_dev_is_sequential(device, pos);
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
+	if (!IS_ALIGNED(physical, zone_size) || !IS_ALIGNED(length, zone_size))
+		return false;
+
+	return true;
+}
+
 #endif
-- 
2.30.0

