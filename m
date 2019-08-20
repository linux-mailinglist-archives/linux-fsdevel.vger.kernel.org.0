Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE15A9563F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfHTExI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTExH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276787; x=1597812787;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5X6DLB2CfRgFLonMj3pABXYl/oqPE52q61YLSYp3yXM=;
  b=UPBNiqUWRPQPIO+/T49WbhdeOSmnFFaMo4r6dqTwipkUGuLL3yau98Ei
   MR/uSNkY/1mjyhXsjPpjsJrWUn3vw4PvtQYXTz1VgheQFewo1WMBTimZt
   r2Ek1Jfk5dompSou4Z1WgMHWahF6gy0yIKnmpvP61OdUEEjgRg4llFq+P
   w/XR+xM7tnLY6TWhTRg1WyfQ5+UeLde5Kq8bRJKC3s2dnN9Y7d2z5Nrwj
   Je9G27j+jQlZ3gPmMfBfqWIYyECT3MsIxVVPciNLZnixGAp+/knsGgJWQ
   aqbir2nELHgflAyxkyPQ8THRH1FOhAwoH2JWo9GaZbW7OCUiRkcx3zviU
   g==;
IronPort-SDR: ATUrjxdxbA6rxUlfsliqvLmPbmObRjcYxLuuqX3UHWddoHc1G6XlpKd8iUorjpXvW/s0CxPv+J
 dwvghyMkVuzikpBGEAH86LBOkxlqdLID+mcu8JOMZpqle5kadEk6Eu835Lz0QmB07OeYKTP9iq
 k+Zgr5Q0l1fPjuTvDnHmfTQJ0FuYg7nJ9ZrTeT801XNIZhVrNiIFe41nXmgKMVNk0d2NDFueFH
 6Y4YNLRStjr/LE7awgJf5dfXtrOpRYxOGQokiqOAXMiihyRd2husIu93ZmlGHcYWiouh/pB3Hf
 H5o=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136285"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:07 +0800
IronPort-SDR: TdQ8YFsytzClU5ZmLsVFdVrZ3GVAR87wCxQ2ldwRgxBHqBMtNqRwsPIoP4iKw4tAc/h73xpqLA
 9Hmg9TSq2m6P1gtGAgQgAAWDG7m31tPm6l+pMLJhW67ObYRzAxCuUxbmWzG8hkjpVtLy4JXYT7
 PLr/RyuG07zjQvp7+TwzIeh7Vj95+kM2ypwEvsg38ZVkNbHb9nBgLzC7kby8juLAXFVQOoVIf5
 JUtjEisZYFvy+iQHJADws2kfsJAffjzbMVKb1CS3GQqnyI/ikTTc1bZbpkkPEbZlht4SVkEBMh
 rIK5xGx5g0Ea+QFoPgmXYq+C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:31 -0700
IronPort-SDR: VkOr8AkTfNQl2ui+rC9B6PKsGaNYrreLz7JWW3bOQ6ITGUZzF7dcYA08v89+AYfiUG22Etbrby
 w3QKZfQ67DGIoRYpdUav7Qqk++LMrjZqHbOhSZ1cNPgdjKWkjNCFBqOvBOzvxXbV9vGhpr5zK0
 4ENmisSgqWvNX4W+mq494PU25TLvzUOy43/9Zr+Lfnp3y0jzdg+JzOKtwE55/8ZC/eY+Kk2qiy
 Ov1xrVMI03+IZj1saitEhifrKOxLker0a93+JvCwTin6bq+Qf8yK/B6lgw0d5U+iBg6ITUB1Z8
 eVY=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:04 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 02/15] btrfs-progs: introduce raid parameters variables
Date:   Tue, 20 Aug 2019 13:52:45 +0900
Message-Id: <20190820045258.1571640-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Userland btrfs_alloc_chunk() and its kernel side counterpart
__btrfs_alloc_chunk() is so diverged that it's difficult to use the kernel
code as is.

This commit introduces some RAID parameter variables and read them from
btrfs_raid_array as the same as in kernel land.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 volumes.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/volumes.c b/volumes.c
index 0e6fb1dbce15..f99fddc7cf6f 100644
--- a/volumes.c
+++ b/volumes.c
@@ -993,7 +993,19 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int num_stripes = 1;
 	int max_stripes = 0;
 	int min_stripes = 1;
-	int sub_stripes = 0;
+	int sub_stripes;	/* sub_stripes info for map */
+	int dev_stripes __attribute__((unused));
+				/* stripes per dev */
+	int devs_max;		/* max devs to use */
+	int devs_min __attribute__((unused));
+				/* min devs needed */
+	int devs_increment __attribute__((unused));
+				/* ndevs has to be a multiple of this */
+	int ncopies __attribute__((unused));
+				/* how many copies to data has */
+	int nparity __attribute__((unused));
+				/* number of stripes worth of bytes to
+				   store parity information */
 	int looped = 0;
 	int ret;
 	int index;
@@ -1005,6 +1017,18 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -ENOSPC;
 	}
 
+	index = btrfs_bg_flags_to_raid_index(type);
+
+	sub_stripes = btrfs_raid_array[index].sub_stripes;
+	dev_stripes = btrfs_raid_array[index].dev_stripes;
+	devs_max = btrfs_raid_array[index].devs_max;
+	if (!devs_max)
+		devs_max = BTRFS_MAX_DEVS(info);
+	devs_min = btrfs_raid_array[index].devs_min;
+	devs_increment = btrfs_raid_array[index].devs_increment;
+	ncopies = btrfs_raid_array[index].ncopies;
+	nparity = btrfs_raid_array[index].nparity;
+
 	if (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 		if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
 			calc_size = SZ_8M;
@@ -1051,7 +1075,6 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		if (num_stripes < 4)
 			return -ENOSPC;
 		num_stripes &= ~(u32)1;
-		sub_stripes = 2;
 		min_stripes = 4;
 	}
 	if (type & (BTRFS_BLOCK_GROUP_RAID5)) {
-- 
2.23.0

