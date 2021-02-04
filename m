Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5782D30F08C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhBDKYz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:24:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbhBDKYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434283; x=1643970283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U4bs4DJ0P/ScSb3Q6D3WJGlEjJVRorabpYSryLjp8+M=;
  b=ZF34C+8IJT/PcLKhy+BsFVcbSD3+2TSpabTUdlfbrIicakgtRNoacNsE
   q5qkvIo42p5kBWthXOj3MK2kuLn451nLeqVKNVyH8DCDOQI7OyW4OD6Bm
   +So+iuPuM572I5GYGeZt6YBGhQth1DhM4CjpuDI4rmG+56BXC1Bqz6r+h
   5B/oVSNnZBEHaAZd+cdhLaI4ixuzFpq9hToFnZKPisZlOCMOAG+V22nV4
   hz87qrk9jOBwoGrGXMrI1gKUlyQJhFFpH/HsNilQsp+c8x69Mr4Goa83C
   5isNRk0NpRxpGiHN1wNQQiCTYUGYMETvI5dRjbFOJeDBWCcrvWOR+gz/p
   g==;
IronPort-SDR: 6cvzcoV68ziO0hPhfsd1VtExqYrO8BDMEUWH+BKdmQlnPvmwj9qHU41MLM7e+ODOmZ1Xw0veZT
 2Zpxk/nFaJWLwxrztpSype1mjwQ39rcfU9CtjxhvaGRiS4B+TFtWxUHEKxROWNZoNWVMQSYKM8
 TtxSdFXY36tjkUDNUHl2OPDgF7TVbVSxSspY/5iGLJ0g8x/s4qB9mNJjHDyJeUlABUQ+wjjBsu
 m1UcGJBAka530QWV8/N6nqVdutsC3rsUoVvsNHEggEv3pVrzI2NBj6sevbjRk0EhuXDKaai+PN
 pfg=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107958"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:03 +0800
IronPort-SDR: hNEEP3zVU/bk+/Tc+NlJwFtv9CrxjuufjBsioT5ajEdJssiwZBAoadn9qhgHCzEi+k6nSba6NA
 J7AZA7hiSpySXzSX64ZAIgWGE4RGYwP1cdfi3Awso89zXpP8uBQzMXaPlIlj2m+JJX/uoU6Wez
 k8Vm9YybReocSTEo0dKNM+D3uD6NOQ+jEjKpNW45jxpol/4t/jz+QnnfcbIQpAv+UuLyBjl3SQ
 G0lIiNoZi1rgu5oAash3YkiA2dtNx43ds+g0tggdVHy9sp+IoTqqqnz2ZsRBQWwi7qKNT6S6Ek
 jmPIyOpNWxsyGrbRJtYCbT/p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:06 -0800
IronPort-SDR: ckvgsBSoSqum216cYx4doWVsajQEzWpqDlEA03RrH+kNCGwHJvus5v1S6a3O8STdFSSs/q8nRo
 DsMw0aivbGz5bcrNu0nSzhm4Jl7iCnagGbvaXSooeW+qsQotOtAYb7qkjvcAECNQlCs2RnHLCH
 EmaJfx1RLWrkoc71c1Uq2FA8JhoXAxGI9U7w6VG+kjh6D0vTcygxa7nDJagxI5qw/qWQWByi8v
 L3ISR48D4kuEgwyH7+dNxTIa4vv9CGSRyTuMS5QQJ8XEVbVkZ4VWH3dhbkNkThE1n4T6bsssB0
 Xcg=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 06/42] btrfs: zoned: do not load fs_info::zoned from incompat flag
Date:   Thu,  4 Feb 2021 19:21:45 +0900
Message-Id: <7f1f1e2a02db66b3bd65ac1d8cd046de75997b04.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Don't set the zoned flag in fs_info as soon as we're encountering the
incompat filesystem flag for a zoned filesystem on mount. The zoned flag
in fs_info is in a union together with the zone_size, so setting it too
early will result in setting an incorrect zone_size as well.

Once the correct zone_size is read from the device, we can rely on the
zoned flag in fs_info as well to determine if the filesystem is zoned.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 2 --
 fs/btrfs/zoned.c   | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2b6a3df765cd..8551b0fc1b22 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3201,8 +3201,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	if (features & BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA)
 		btrfs_info(fs_info, "has skinny extents");
 
-	fs_info->zoned = (features & BTRFS_FEATURE_INCOMPAT_ZONED);
-
 	/*
 	 * flag our filesystem as having big metadata blocks if
 	 * they are bigger than the page size
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8b3868088c5e..c0840412ccb6 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -432,6 +432,14 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
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
2.30.0

