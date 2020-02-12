Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569C615A1D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgBLHVh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgBLHVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492109; x=1613028109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mlx2XiH4jsI9oCo5Mgx50W092nbMH4e0Zr+MYrOXpOs=;
  b=YTKDyTFw0IWxG7Xho9yUZxbfgrAfKpdShZQBwZuLwvAhR9p0hFavaWaT
   fI7L53x5JGA8sqlcxo5/rytRz2DrQObAtaCpEf0HLq41DLSUqE664mSY0
   pwXwfIhUQFErqf0HIDm5BjZOrojHuIFYilWTKwUZLGit6+yBF2NIwo1v9
   yR8U+p/Fx4LlUq7/RjYNxjomh8vBA5C0Nysa47mgr0Sxy4Bmybm825pAt
   HRfgZvONsAW68AtjXsnhZB8FV66Gecvhtw1Uftn9v8lHa7IL6sP8wlxxq
   588ejT8x1PP7K+XrV0SlQyKBvjgbL5lg0B/UmBeNqouHjaEu0K5QHkUbw
   Q==;
IronPort-SDR: 9XXXiwhEj66s6CPm47vltL6azC203WXjJQk900yqi1krm6tQH5+slJ02kY4LyLvfJEFtmrGuP0
 lTOaDxkrllqB8hvm7T4k7SB97dBCqx/0THeCOmDTYUGxxLYP2xXcfkG6E59Ayv6llOzljK+t/S
 3N6eMRlOueGzE/KospXdO/KgmztjspRuTjRPSAtwxKS3JmWP3xjHXinhFlChp4ie11c03NiPN6
 eEshpG3LbNVIDKyuG4cdWhvMX2OSKTuu07nRdqt5LMGC5rCBtPSzDNC08Irc2r/+kd1Y5R4lis
 ZDc=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448950"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:49 +0800
IronPort-SDR: GrBogoIPtUMlio/hw2fL9x+EKzye7mUfb0OR+UmATxWtSfhkNhrNAl88VUvV6gUJZ0cZIBeGMT
 Ew9YXKlFs0CFgbEV83iW1pbRHdxHwv1XzijaiP9aurMbr6Nw9YkXwk8huQXDJvCEPuITX+bocv
 cmKna5KmMChLJL5ytc/wAfwyfwdW2Hc9jDA9KnpyzWTSklHXAAgpQvS6NhE4W25kSzU4WeDN2X
 T2K9S0KytHuzv7zBaJ2UrZ5HUZb0pvwcjQt7vImwJgz6n0roiseSmdo8pK5EI+QyqqnBzcYntF
 +IE3ltU1LGVijG5sZo2EzyvQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:25 -0800
IronPort-SDR: 3fgLK+iSnyaYHbRGkiRJXmPP7tQ1CtwntQi6M7Q1rPvyhSD4Hc4Mu7yTxKyqeMeVB7RmQfoSuT
 KQGJZ4RrRR3AuKPEwcSFnmRN4qJkmcujnkVuAVDbAl0R7PjXNP5PvTw4MEIgkoHZ/rmDwMwlQj
 3e229oUuFh7/7U82GUWcH6NENChP7qROuDy5mpxZ17NZqJPSR+gJtvN916180tuwZtLNLfsUWv
 gM0+ZdaoEb0KxUg/YjHYoiQNnFRZ1Ab9R++Uh7wotWvG59i63oftXGPiRPPpsMyurWZYC5qH47
 ONY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 20/21] btrfs: skip LOOP_NO_EMPTY_SIZE if not clustered allocation
Date:   Wed, 12 Feb 2020 16:20:47 +0900
Message-Id: <20200212072048.629856-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

LOOP_NO_EMPTY_SIZE is solely dedicated for clustered allocation. So,
we can skip this stage and go to LOOP_GIVEUP stage to indicate we gave
up the allocation. This commit also moves the scope of the "clustered"
variable.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8f0d489f76fa..3ab0d2f5d718 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3373,6 +3373,7 @@ enum btrfs_loop_type {
 	LOOP_CACHING_WAIT,
 	LOOP_ALLOC_CHUNK,
 	LOOP_NO_EMPTY_SIZE,
+	LOOP_GIVEUP,
 };
 
 static inline void
@@ -3847,6 +3848,11 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		}
 
 		if (ffe_ctl->loop == LOOP_NO_EMPTY_SIZE) {
+			if (ffe_ctl->policy != BTRFS_EXTENT_ALLOC_CLUSTERED) {
+				ffe_ctl->loop = LOOP_GIVEUP;
+				return -ENOSPC;
+			}
+
 			/*
 			 * Don't loop again if we already have no empty_size and
 			 * no empty_cluster.
-- 
2.25.0

