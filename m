Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFC8715A1B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgBLHVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLHVC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492063; x=1613028063;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rrs1IxCVFhT+utMagPkDYWaurfisiAV/cxE++oBN2Pc=;
  b=euxG0phg9jHq0BTXx+a+yL6HpmebmNpn9juhHZV7vA+l0sCTY77JvWTn
   AACtsPLRmxMxYHblCxPVRAgvbDFKPad5D15446pZqhFHiXYTr0SYZeIMo
   kfV8kVOVpM3mE9H9uhwzL4YIlR7crrVBSr6y8T6I5LFPYPr8NQXcFDM1s
   kevVesL4hLP2Ic7sGMyzzGE0IYm0v2dK3ez09stwXIBsAWnT6id3acxDo
   NJNOp5P7ke3kngeZ7IPJMocPX2LZaFpc/MYK/a0J9hATXvx2WKQm4JckY
   W5mNj7mUaJhHUXNlVZcCdxznOBEtmmpXZGSwHyQvueDXdKsPXsIKILdry
   A==;
IronPort-SDR: xRD45+cnoUE2tz+ompH0p6L5MppypSY9HKvnoZDydoo8GB+p3dniRb83dCyxeeQz+QKgcx2dTM
 VAio4NNfnhutoxa3TVxdlpm4upFQgUHQ3G5P9805u611VCD+Y+aeXHsrZuahP39cDCG+ujbeNA
 Mdi+3zo5ey7FA+KlirHX3YWEPGJihpTeMhpN/ozv8nWvVaA5bXf7YPhFCa5+c17LaRGJIN+qLn
 Bg42jPDis8yp1qagdwvFy7p5Wb52FQwG76PyGVx5acI+EuwqIvpsp/Pb4sEXB6TSS1paD71EvQ
 nMg=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448895"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:03 +0800
IronPort-SDR: hH6bS46+1DiK06inmBoSMAx+pKTkToiNUuFPgitqkS0Rial3/qOhXew9IDJ/HH0bIVTAjWhhi5
 eLsd0CM2vNHCp2UG9EGM9GD6LV3R1feZK1+IwTr8XgpG66udtE5fEZaIfuRYCLvP0k/y4zYFEY
 MbhoBGZ05h8/e+WhhEkObVlTWsSVGndyYCOJ3L5eSOfV6E/YyMxhvT8nOh7/dijcen6exk5UkU
 kY0qTZaGAvVob4ISEBpXmRTMYOotnd/DTm8f9ikwjN6Tw9ZZKv1iEJoOYuuV3HN9TWmTSL8yt9
 P/LrPYZhfyZPMAxYVlIDXLDj
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:51 -0800
IronPort-SDR: azjS0I6T1A5C/SZTHI6nZWsHm3m4KCXLJZCCyBTzZbK79szA/+9gbk2UA+HiNZu757tvXIVOuD
 pl+5oyW1bZNuoJb8uTIcJJ9ux/8m1l1wawh4TLQapdd7qNK3smtc1IMGYWoBeWmFrB6/iSF6Xj
 7fc4klFgV5caiV+5Sr/lf8YRlu1gM/VeRjKOrbbOnplKo+oBGWnZ29KjK4pFqqTgiw4WViBNY7
 D17/SreAvpZY5ccD5faaNSn92C/oU9bAJTmej7O95rEjtjic5jETILdYiwJSowg3wlD0oSQs1f
 17M=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:00 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 03/21] btrfs: introduce chunk allocation policy
Date:   Wed, 12 Feb 2020 16:20:30 +0900
Message-Id: <20200212072048.629856-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces chunk allocation policy for btrfs. This policy
controls how btrfs allocate a chunk and device extents from devices.

There is no functional change introduced with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 1 +
 fs/btrfs/volumes.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 911c6b7c650b..9fcbed9b57f9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1209,6 +1209,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 	fs_devices->opened = 1;
 	fs_devices->latest_bdev = latest_dev->bdev;
 	fs_devices->total_rw_bytes = 0;
+	fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_REGULAR;
 out:
 	return ret;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 690d4f5a0653..f07e1c4240b9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -209,6 +209,10 @@ BTRFS_DEVICE_GETSET_FUNCS(total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(disk_total_bytes);
 BTRFS_DEVICE_GETSET_FUNCS(bytes_used);
 
+enum btrfs_chunk_allocation_policy {
+	BTRFS_CHUNK_ALLOC_REGULAR,
+};
+
 struct btrfs_fs_devices {
 	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
@@ -259,6 +263,8 @@ struct btrfs_fs_devices {
 	struct kobject fsid_kobj;
 	struct kobject *devices_kobj;
 	struct completion kobj_unregister;
+
+	enum btrfs_chunk_allocation_policy chunk_alloc_policy;
 };
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
-- 
2.25.0

