Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8E3034CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbhAZF2P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:15 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33036 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731793AbhAZC3u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:29:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628189; x=1643164189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fUVTGy0Bi9cRVthbe+jEVQeQBcaicfUle3JY11JdKm0=;
  b=cNKweC9b83jdHXtmVnf9CvdDBqwKracOGa/SYAAn9zMLfjZFF2CuCbtO
   p7DG3rp5pKqilvZ474S0Cn84E2o/erjO50uQ4Yoa+tf3fGcDcOnHxZKMW
   ZigWZOvZ7nlTXjpekKmttRsHmJ+tE3ETPYdXceLl4Gkhuj3KxMyMJNsLq
   B509nN5Z+zTkmSqi82/bFeiyZefPQosWls0MN+l4r7eD948YJEZmBbmK/
   KM5n4sBAfVzWV7OovKtvH9PdU6Zl4Gesn62kfB0UF4QAxWJwFmCprzE4d
   el9F1PTWHabROSz8rdzEcvTXtsX/9rSQAaw0t88WsVV1cmpgldHLazqGt
   w==;
IronPort-SDR: nYsvmXWaojjp2tx9MpeSj1NYGGYnowy+8cAZsbuwshKfnc+WXzuyfdBhS74TncGUBUVK+DgWi+
 Rbg1ogUKLB5WXS8MY3hW5bocLQFm5/D1KBdo/VaxQSnebQunRLJ/pH0Lo6DKYQoyy+dCh6t7dw
 WrOJHEGDp3idHMVHdGYEvsHlb1lTO/p6y1tbNPNCXXJpJEigHGlfh1vFSc4pjyjjAu9ffYoLbS
 /CEP85Dt+eYZHeS5R26S0IkecFEKyMoOyHiqzizpcp+Xjbc9WiYPEyhsCWZma7/SGg59PGPdu7
 RUg=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483516"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:11 +0800
IronPort-SDR: qYoeKXZ2vWkS0smhCd/DvAEhwyX3DVHdwZpn57hbDgC18oup99zbwzf80Qz/RiSFm6L6gNT5Rc
 wgHZh+R2SbxA4MQl0z3Twb4cUHwHRgkkwOzAgJEqRFKWYIVyC1iG7QGFY7Art3QAJ/j8XDMzVe
 hFPEbNWXp3NLlJoLMA11spx+ua224kDBZYU/WHgkeIc0Ljmd1hxUHoSG95F6BBznP5QSGl9+Nz
 Af7fFewQf7WO8n6mnmd8NpycBRbMCt2yIqcbxzoks1FkqLji3ZR2nE1c4UnzEDVGDSqBUabXsY
 mOHspeILL0mm9ASPE4jIf4Qt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:10:37 -0800
IronPort-SDR: mrtHJB+oP20vk+8uCo3Ck54/lrUjbqvR+wmebpBiYSI6bEVbm5x2+i+xmKXWshRt6vVQ5hfry/
 V+KXw7frJDF3jn/wvbKF4awTN7bpGj2hhxdBkNYlKgTQUlaYPpjJ9VGTglGaG1z0l0oL4Zu5sQ
 pEpg6TJMgoh3hE9brTdbW8gABoIuJDCGJ0g/PWHRPxrAdUv+pguDNQAeqpsjjHSdwbLmHxVGTP
 KxvjSRpTph30SFt9cdtagMSP3Qb/IpUJQGKFPHINnCO1vB3oUH3Fk6O2PvuUjfidIAAJ0tZeD4
 r+w=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:09 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 07/42] btrfs: disallow fitrim in ZONED mode
Date:   Tue, 26 Jan 2021 11:24:45 +0900
Message-Id: <dd9f9b5930072bfb64b727f5e2380f37f4fb46fb.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The implementation of fitrim is depending on space cache, which is not used
and disabled for zoned btrfs' extent allocator. So the current code does
not work with zoned btrfs. In the future, we can implement fitrim for zoned
btrfs by enabling space cache (but, only for fitrim) or scanning the extent
tree at fitrim time. But, for now, disallow fitrim in ZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7f2935ea8d3a..f05b0b8b1595 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -527,6 +527,14 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/*
+	 * btrfs_trim_block_group() is depending on space cache, which is
+	 * not available in ZONED mode. So, disallow fitrim in ZONED mode
+	 * for now.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		return -EOPNOTSUPP;
+
 	/*
 	 * If the fs is mounted with nologreplay, which requires it to be
 	 * mounted in RO mode as well, we can not allow discard on free space
-- 
2.27.0

