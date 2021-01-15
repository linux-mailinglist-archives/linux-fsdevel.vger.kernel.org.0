Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABE82F7315
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 07:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbhAOG4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:56:52 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41647 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOG4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693811; x=1642229811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6NMYHMWkWnYQESyXK/o0VVftEdCB2HRA05izQsfXKGU=;
  b=c5x7s0DwohjCG74DBKdDkvVT++koC7UKM05bmXg1xpK/T9Fx+249sVQD
   j3+YkR2BPD/GK/p970/5KXuGxOHrtM1oKCSGP1efMSp1lrtfq7KLqulxH
   pXgc14il00Jht5IXdZ7S83il6qUJiW14oO71w7iN3AsqwZUt6ye/KxlZV
   eO8uXAey9lRDPC4qQ+0j9DE4NjcAL2u4U4U4F/ieuVSiUUvNxn88a1gFo
   7oQsKe/TamN2seOfL5V7IIr1N4+BEnvp0VPN/hgzddSB7GOSpMPkFRjYK
   HBnC5L/eQR02i+8RO7BJIhaYu5FzcSOg5uY+xBdWpp/WtCCVpmKRJM5d3
   A==;
IronPort-SDR: Q0mwnt9f+e1zVJqb0EDUxwsp7FUu6MfCPtt55ESeE+diQZHO50EtorupFq8+T+I7I1XEtvViVO
 6ecit8Cifu9bOmqlmxDIbzVgDT5iMth+J2XaI8oWoT3ey9hg5to0Nu4O4LtOQK1CbaAmaRZaJd
 PrWEy26h96SGgjc3Xteo0Kfw9Ys3t/uDr7Ove4rNqtUsclRWSuvdVac+aL6fj6ogZRhN3ZkPk7
 aMOmc5qg8rfbERJBmsXVhWJlPdJolRkDM0LMDGz+Z/Yf/EUxHtx+1tHNuQP3JL7oXILqJSGYgg
 CSQ=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928188"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:11 +0800
IronPort-SDR: xuVNWJEQznZByNdzyu1XHZGoqmCopYprKXbSRnlT4PLhDhAIKxeQxHWbZLfRMaIZKKwVATdjjg
 rSDijMxjHJO1oirhq875qSjUsfyfqekrDWE/zYNdEiCX/Kz7rnxHRB36jLV0oSE7N/ln4xaMMw
 JP6RjUTuZsn8cOiVRuxfzJpV2spjdcmZFoOhSlasg6wfpJ7uA75JHXcGdyT2Zbsyb1v9NboT7Y
 lH032eKKZAUzXNnCWaQygV+eZzmml7iJSvi5noVvWUQlzIw3aAM222O2j9dDs8K4E4vRxNg6LB
 NlcSRHV7qVILqhZFnGmLONqM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:39:53 -0800
IronPort-SDR: XbYC1y12tPXtMASpB9imPeu1wb0BFiD9dK+N16lqYqQit8VE3U7O5nspgyHhiOxS11HfnIAFui
 GtcdOMSzgIBAaoht5YISIDOK939WYPK/MWjJBQJgpSJJzPnq8J3uhEjR12i1TfaSp9UF7B1RCP
 6ioBQkovFkOTMtXS0I9nfyMeYZLDC+pd2n7ccNfO36c90eSvsdCTTimlqA73aJw6EY5O88b0IA
 Lq/4wuSkGHxt6fHVKKpui3Rudn1NCIcZPPWFRKHcO0ugnGIFBkyoZplRHc0xW0bS3wEPGSR4wb
 XQ4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:10 -0800
Received: (nullmailer pid 1916426 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v12 04/41] btrfs: use regular SB location on emulated zoned mode
Date:   Fri, 15 Jan 2021 15:53:07 +0900
Message-Id: <30ac9e674289d206ec9299228d38cd7d03cd16c4.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zoned btrfs puts a superblock at the beginning of SB logging zones
if the zone is conventional. This difference causes a chicken-and-egg
problem for emulated zoned mode. Since the device is a regular
(non-zoned) device, we cannot know if the btrfs is regular or emulated
zoned while we read the superblock. But, to load proper superblock, we
need to see if it is emulated zoned or not.

We place the SBs at the same location as the regular btrfs on emulated
zoned mode to solve the problem. It is possible because it's ensured
that all the SB locations are at a conventional zone on emulated zoned
mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 90b8d1d5369f..49148e7a44b4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -553,7 +553,13 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
 	u32 zone_num;
 
-	if (!zinfo) {
+	/*
+	 * With btrfs zoned mode on a non-zoned block device, use the same
+	 * super block locations as regular btrfs. Doing so, the super
+	 * block can always be retrieved and the zoned-mode of the volume
+	 * detected from the super block information.
+	 */
+	if (!bdev_is_zoned(device->bdev)) {
 		*bytenr_ret = btrfs_sb_offset(mirror);
 		return 0;
 	}
-- 
2.27.0

