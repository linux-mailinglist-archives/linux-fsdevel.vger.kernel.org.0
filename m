Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3482E154215
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgBFKoV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgBFKoU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985860; x=1612521860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q3UpyLr0QmBvQMYnAKQmQhFsS12QjUo7UuYiDwZC2Lw=;
  b=AZ2hpyJwhy5tpD+RsQbUkYx+9G46nIiDaez0fkqYx7jaWGcGzjIH5Wrl
   N9i67J2rIBlAKs0OHvkoXDMgNwTnAAQNMUfYeUL8BtFhBXlOj0lcNMtsf
   Dc+iUHXl3boPbzLp++ejXrycq044XhEvsgYxu+N2L9bvyMtVqU7T6+ITQ
   9fyNg83zzuFHvbLon3rfHbWwXYaZMzBPh9qPud9z/TeI9oruwqfv1Cmrz
   nEDLlkj0qKe5hd5/TfIpLT/Ht1lD73P3kJY8u+Mp+bp2inG0MDSFgBPyJ
   +QigfNEhlivteAg8V007O0MlPGXFOm6NjtBKsvS/YcHJy+6ZHahTz49gr
   A==;
IronPort-SDR: r/YBgQ5rRT0i2Gdg6AitChvSy3T4VZY/BLQ38J7fnYZ7Rt4Aicih3Ij+xp2myZ9HSd/Zya393k
 lDgJvMc4B7IqeMr3P9Zh+QCLqPap9gRbTn0kJ/4QuD3h+YoZ8HFsO6IQFkm2A1ZMlm8gDc6pXD
 g6FVIg/Mw1NIHw4u+9Zh3JrCUAICDA0z/rlxcuMkKonEp69Vb7pjFPJErh1Ux3mUoL1fzOi5X9
 Q5hfVC6DC0c0NWScxGxzsCjGDCqa0fp422xMKdl9sH7Sz4Ruo+MGJBswEiwRGrpJdfgAeZ3O39
 F7o=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209484"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:20 +0800
IronPort-SDR: Myw9wV9bT+Qi8WpInQOawHZXqPk3YzB9jpQ02FlyDkCg+4EohSI1iHnuQVMdjACaH9nDswf9BQ
 ldyVEMN4tFjs06wRnzXTkb+eeMKm6XBikMDRtCK1JGRlT4EXCTkBuhGC0OzYz8Fq/J/yq9GecR
 XCDyEHvfWWblUTF8338Ew3oDoKcjuDlY+L7d3hF20GRAfVf1sXJ7uiPDpEcjAjyVPKMr4FDA4C
 REdSVXZIQ+OyZrIk33UIaXzEvfqp9ctpxiRO3q+DRCydY7P8erWffEul5mx3hzCV3/k8Hipdf1
 NlXgKfXd/MfRb7K/O8OsUAdb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:19 -0800
IronPort-SDR: sF6F3tlHp6djiwRseeSE3jzFAX3K3zfA526WVRQozQOgmyrN/X663coTxPpra/bDL1RO0/Ay4O
 jNrQFY/Jr/ERY/LvOsqNC84FO490EO6tk3fJICjFqPc60rHzSjf8bTwqnfAs9LPMBgDBd+l995
 dqHHIO6OCx5CHXyJsYxMnhyYFRxSRR+H+K4Lzs8wx5rmnhmn9uUrpzlr4WEvJRGyODQsNOz/nq
 VtQlfbynerAyZNMOhpTZleDaQRUf7pONLjStteT6+tqxuFEUFK59htjpxRf0aSEDVOAtau755x
 Hrw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 02/20] btrfs: introduce chunk allocation policy
Date:   Thu,  6 Feb 2020 19:41:56 +0900
Message-Id: <20200206104214.400857-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit introduces chuk allocation policy for btrfs. This policy
controls how btrfs allocate a chunk and device extents from devices.

There is no functional change introduced with this commit.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 1 +
 fs/btrfs/volumes.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cfc668f91f4..beee9a94142f 100644
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

