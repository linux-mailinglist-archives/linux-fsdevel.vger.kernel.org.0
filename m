Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF330F0CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhBDKa4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:30:56 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbhBDK3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434589; x=1643970589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p7GEv6HHHgKj1qej7nbXUcprZAlz1nalK06yluiEITI=;
  b=fD7yGo2InraRzUFGJr2qvGKSm8ZA2CHjWa+Zp40nTN6zbFvam9pPX33G
   Izk0NVJ/Ow1MESKs1odokGrVcXZI41z8smwt0Tx1VXqx+D9kS+5DQRN94
   lDMLL/fNY5d4lfmhhpn733Q3lIF5MsDUtFORDEJHi1JVQacEY0jAiRcb4
   eFOKivXMRDQzo534/j6cU5+9/m0/AE691eoiVJeRjnNGHwMrFh/QtZRQh
   rY/WcXX8ZjwnxaKcq8SzlZYIE+A9ctRFzJhdm+MSJWY2GtU+/tXAIzf6S
   xbNtfzg4+f+RG/oJNX22AlKYnB9J23ljZc49p2o9rrM/lgNAN+qKi2Dzf
   Q==;
IronPort-SDR: XR6k3tUD6M6DFxT0GJLkBhABzWCtkdboDKN76x8XUMav7G+mECt5LxKdV6CupPLLOKzpx4nvnP
 BLMRV2gOukUVMIDu9PVfzW8IeLJokwEOEKW1adw9113pgJan0xXWL7kZMaWnQfA7xaMKAVDH3K
 K00dKNJtOP937FrhkSNeM1go6M3m1hL8eMAX4HgdzlOVpUjZumKE7Gu2JH8eG6elh+JvQuFrlB
 y8THHkYzuuWG1y3FVni5/Or8Fj22J/W6j7KvoT77vlOz7Hz1SaHExtXVGfX8zH4y5+xKyfALxW
 BVY=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108047"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:38 +0800
IronPort-SDR: V15c2XA5WXdln/k3t6DwRVs5ovBupzKGMYZd5xBQVTgnnGZjt9UehsvMuXQhqGi4UBs4bU3GlU
 AGy3XHbh6C4965A2U3wDm/y/k86aSJHoEqNm+9enRlbu4CqF5gSuhQWsQ6jfQlUpFM/n0DV/FI
 oB4ZzxtJZPiih8wU3jtZoHw8u332VREfpTD8UIsEdZ5huLQOKOKuCmefowvHkM2JoCLBzwYyig
 HE0V4ZS0TRg1/cST+RnOYJM0ZAPxL2Igr4zxw6kaFqW8do6JHLNluPZXQjZrr9UmrWQfp4sbKB
 cMz26VpeJ59/ywpcFixSHMDL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:41 -0800
IronPort-SDR: ggq4VC0f1xpAZGPTIoJTKvCFdxTZD038MCQ9FwYn9nwpppuZTxwyDJGxB1/jGtZIYSKOHbNs6C
 s8WH2S78NsW83XdlILJPFch1mlAMfuU3oEutSqfWxHE9Fq1MxFNy3tpU3+UavRKdPD/5jNsjdn
 NMxuY7M7DUnDG45siRK0G3olEMc+cqtPkK3fkK5fQkJ8lX/r+l4o6vO3yJPulP72T23r4rH6Lo
 DPnRn4jD5aV5QsTd3+Z0otH+RykNDVJiuao2j2si1NbH0lbb04nXODxP2Lx/Uuqogpe7f5zNgI
 f9k=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:37 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 31/42] btrfs: zoned: do not use async metadata checksum on zoned filesystems
Date:   Thu,  4 Feb 2021 19:22:10 +0900
Message-Id: <09123e44380218e0a642320848b924377e74ba9a.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On zoned filesystems, btrfs uses per-FS zoned_meta_io_lock to serialize
the metadata write IOs.

Even with this serialization, write bios sent from btree_write_cache_pages
can be reordered by async checksum workers as these workers are per CPU and
not per zone.

To preserve write BIO ordering, we disable async metadata checksum on a
zoned filesystem. This does not result in lower performance with HDDs as a
single CPU core is fast enough to do checksum for a single zone write
stream with the maximum possible bandwidth of the device. If multiple zones
are being written simultaneously, HDD seek overhead lowers the achievable
maximum bandwidth, resulting again in a per zone checksum serialization not
affecting the performance.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 458bb27e0327..6e16f556ed75 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -871,6 +871,8 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 static int check_async_write(struct btrfs_fs_info *fs_info,
 			     struct btrfs_inode *bi)
 {
+	if (btrfs_is_zoned(fs_info))
+		return 0;
 	if (atomic_read(&bi->sync_writers))
 		return 0;
 	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
-- 
2.30.0

