Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFB52FFCE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAVGdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:33:25 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAVGYQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:24:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296655; x=1642832655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W00A4ElYUxWqx3pZQThpqSdlc1PopF9tk891Iam97g0=;
  b=NsyUc4w0DSRMU8xDpMCP/Hw+RVo1bBsJkNdx/VbmhwrljUbr1Lm9/mLL
   FgmPNM8pKVWB8f6IMrT19x21U4UEnfvHzMKdToN4zUhc5iRPSTdrJ6BB/
   mfLpiluV/I1x/14TMpJvVYf0cleF5r/JU9nugNxbofBYh72pPk6ANql6K
   0znP3DmEL8YzKVl85aEM5ZKnxOTGRSIqDFtQOWw+S4kI8XYiX44B/qx4I
   9FBrpVBzS4Q2Vkc/YPPbDYYfOz4qv8SzW++u59OKgIiZdZ/DAiL4uCp/l
   EdNebNEQzIwj5dB9dD9Ruy3c/V4qVmIpGkH5woiCtQ07ZGoYYHgCClTUI
   A==;
IronPort-SDR: sOLIAeJgKsrvuCzlYU3SS5lx4UrmZwmR06EgvzbyIF9RP7IZWnR1Ry24lxnUCdDI8DUHmXWTUR
 TANG3qqAVwA0hGo7LY50QdTmc/TPVDwq66WeUuWDyUtayri4Nq56b9o8I0CO4GDCn3T83yYWhI
 xMWnU/4kFrAdQkxTGM5jyHtcru5DZgCaOL4+Eexo7NE6cIzC1xk83cfNvTpr2iCcfRbH/X1owZ
 dQ3BPqXcG1r80osx2D4Ko6htcDAp0Tfm6HH//8nlc24zN3TtY6Ko2PAtmbA8OikXKR+18gS2dw
 hLQ=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268391956"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:22:32 +0800
IronPort-SDR: FwpCZHtsc9P0qdCtKdx5GRhCUqklPms5xzFGUyUcAQy04qkqt8cgGQMbf25taLf8OdXub5NukV
 gQ2KIqcXpoNS00cdCweuh+Z38eUfxbu1rceg5F3MXVzoJyplaNsVRVoRfcS6Th8LwfGpFU+Z/j
 Yl2Zp/iwOIj50ldH/oy3oHM7hoghY3X3WTnnsqeX7npgAa2Uagaoc8FbFvHEr3snvjDY3AQujb
 nS2vXVEgPSjAP8KpVfOLvjO5B3xv77Xss6bYhpqbeXIIxmQ1qHbKQQjfJODjSQY5yY9urE5TGD
 kjcp3RlZTPX6RC14XSWJfBLT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:04 -0800
IronPort-SDR: FJAjOkRi8Hoiclmmkk/J0XyduzZbt0eNyznGPNmLbYM/Sk+61YiKy1fbjoOSlxpwJnSCyo+zvl
 26uQm4eHkLueVd0UPr7Kwzz1O2ZgywvR1Haw51RBdvfU7kbHUdRlmJiFE8cCiMeu4sKo8aAn+S
 +dQ96RU4d2iCG1M9L3IAEOjMEJQ2zUVbdgZq7zmGNH4pTb8OcgXrDGyXQ/Q+Fmg0t6CbcRDlt4
 UZvL/ABBYsYvHuokXZy6aZyBS9ZgQyT0ibJrfn23N88KT5G21nnRBPwYccHDalBcMkCDWmk6BZ
 Nu4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:22:31 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v13 07/42] btrfs: disallow fitrim in ZONED mode
Date:   Fri, 22 Jan 2021 15:21:07 +0900
Message-Id: <51f6f258af8d5de433c3437c26a98936a69eea7e.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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

