Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DAB2A06E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgJ3Nw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21971 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgJ3Nw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065945; x=1635601945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JURNtChtu4jU2Kkb/XX8ESd3HK5ZuzHxwYwetvjZgvM=;
  b=KaYgFfEe+OlVzcXbKvkRVEFBfxsCugMhNgCW1V/7TWYlVsOzgfQDP9Fb
   F0x3/rrCM02GlNt3RRybPIfcfjkt/VkUMC40hFehLdy2dLOW1oSBfQWGg
   sHqDNW02tgLnX/bzdQ432H3P4Mn7aXvsoPvwcp5UlU5XRPn8PZKUiqUx7
   pfxA0k9EkURux7DU5/SjcSoV+Fo1vhQ9oTAAQZzFrOXIATqSL1kOMUuLQ
   YULa7GO4Sa1wIIo6tiSSP+eiTzUYjvESNTVTBH8F2OVquqPvsKWa8q7mz
   i++elXznb5gUbrWIYkOJOVwbjMqZKGxCadKTiIvfsemDPwuHJGl+Mu7kf
   g==;
IronPort-SDR: IFtpAChb7/Op4ku3LNqPL3/KnbsZzOaGw0vM4DvoXfthlAKUQ371tSch+G7CMdLGxhDYPIH3lG
 Ej3wk0ZiDmLeSuNZeP6V1doMCfAh9jD99ERASresqTq2t8lC57NgK00bb+jChuByngC1XwYIX/
 ZxuPd5S7NDJzVHgI+FnB7ctei9PiDkMAW4q10Pobw6aTjTSDtM6Kd02nGFw9P4R1ZIcbcb56/G
 A4/zY7fnOGeAE8DJPvzEM25dzpbSB+1EFHcDY0bPa9+MmSLXcyvWntYkDU4Gc28YN/RCI/xMQo
 u0k=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806575"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:25 +0800
IronPort-SDR: TO1PllebxaXdDRrF+DKy9mt17G5iT3fdvj5TkBUq6pUsWRk/iV2CHouC0dUbfPzrFbw7XO7UGR
 UMAwMGzOswSFV8mEoXqaOQ8QATinYNySaMeMg7DPhgNbc7oSjNaAGSocL1QClD4vA9o7nL3Q/9
 30VsGcjP23gdJ5ERxWZnVIF2j4UuYK+FF9omo/m4L/yceT6tMfuI7gzabeo6hgkYR2A8bm1C45
 ySXJkTBdgrH/qSj7Smojg+yMKInKoeyW25Is6mRc/f8lVkSuVSt3UvVpIhu0USJ61HlWVbEBf1
 hxXsjb8GzTR5B2XC9ooWbPWQ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:39 -0700
IronPort-SDR: UZcBDI6LSnPh6yTruXKpN60LM6cfP+FqbuIclkJvZxBcZaeDlnlXH/O3U9N9BtvUmh+46ni2cM
 n9xInb2vIEEkx4cnuzmqGWH/yRnbvr0gEea4CIH9Z87u6OqG/Adaol0WmDr/TO2r5i4zXf5Yaa
 VSouM7eEPlHE3vS+wC8dpvs+SGEytl4CbZjH4CLmTtQETYXAfiwV0W6UXQ1YwngCZPkIp9ncxc
 Cd9SDGaQReK399RzB30p4AlAntXcqwd5q/rTovT8RZOBPj27U557o6G52v/dVzJlQGzgZ9zoR4
 qnk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:24 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v9 03/41] btrfs: introduce ZONED feature flag
Date:   Fri, 30 Oct 2020 22:51:10 +0900
Message-Id: <2b5ff5d6f08e483f71cfdeff47267c0dbe2acf4e.1604065694.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the ZONED incompat flag. The flag indicates that the
volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 279d9262b676..828006020bbd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -263,6 +263,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -278,6 +279,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(zoned),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 2c39d15a2beb..5df73001aad4 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -307,6 +307,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.27.0

