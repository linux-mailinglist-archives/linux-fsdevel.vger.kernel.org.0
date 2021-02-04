Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E530F08E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhBDKZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:25:02 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhBDKYq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434285; x=1643970285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qpUfcyJz0ETmW7m5EHZ0mNntFqrL1+/NKpO/9cRcCas=;
  b=Ba8McwchA0YeUDRtg44TNSIrP54BGmyURkGXgct8kLtIAu6B7UUj7Ulx
   OQilF8qXcMVa2Z48GYoAh/KC+M5ZNGs1NVltzqT/e6n8aXdhQ5FH3c1t0
   YtGkkoIwS8P3ime/MMOQyo0OrdFtlMKUoavHWsqZhA8zpfza2gFsvMjD6
   /H++L9LKa1s9Bkx7ofBN96+WbQhzGvROKJ5t6RD3MGzTIKF0T+dEmMiBo
   pTiz2nw8C7XUAjHHdfekchks8DrbAZQmgPCeyPzo8ppytloY+Q45M6pKL
   b1vdruSOlm9SNbXlnBQrPxChM6o7rNZnfC2bRx+H0GRMCJLTStAW0yOnI
   w==;
IronPort-SDR: CbufNk0Nt6Q3qwnC8LKOGxNruCDPv5uvCVmMdHlMLA8ZhzJjvxqg8vEV/vhsJ2B9MOdU2NOzfO
 dKCHW+EMh+Pb4fsIMCutQstnuBFSEzJSoq9X4x8DpEG6slYK3O8r7oWSJpt/NmcDEbdQvvPmT8
 g5UMs6ARfd8AgYpIoXWkpiD9Bcew20Jjvgcs4aXc4mVatQpWoRh0lwC1KIpBjXGV+qSUecB652
 DoXCgvrRk+xQtucjodKDgAUaXScyGCFcXAdNLIMsM7qnh6HXI5BSmCglSSbfXnRavk1ZFnGyrM
 I1c=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107963"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:04 +0800
IronPort-SDR: XdjxP13to6yRqpA9+HpC4VGNLN5A5NZuomFUn/jXAetjJx2AzVQtVQn4PZoANz4GSixu/HUGPM
 hKZG9zcCcj6h6RXsmtoWt5J+CeRgXwpj/eU3WQ132fp4gFyuHeuBwKQuF/ZKNUUB8JZ1MCSO2L
 LOYNrxihbRdvUD1nM+iW+cy3r7joVo2VX/0xJWIu2phOckJC9oJDxrtBL0K2FJEhJNg4wDigGZ
 F7u1t2QYF32Xa9cD4uZ39bZabDyO71S1myP24m15JWkDEy097k3vl9jcsszo2M2I2N+xr3kK9u
 Pdds4S0JUl2ShmKXDmh1FHUQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:08 -0800
IronPort-SDR: CMD2FnSEUezPbjcXxW2Q7Fc/Ui6JM7ZeyPIoftLz7qhmMQsyYHexhpUpIDSJlFiklAN8fVtm5P
 Tt3xpT9S2ngbuL1jS1EXiWD0KcuAk9kEOohGq2hrlQ9o32GgFXARzIDbMmI8429nAb7CPjztsS
 jTgBXurnm3D2h3ggwE32fmlrEwqYPp4v7+y7TAio+7gXY5VeXMiTbXTxibr6N6dB72uSO7gdcA
 nFUBzPRF90wLaauWSqYNo0Bg2iS+fnREjdispr45U6d5lr+WXqyOmf2NJmt2nThT8jrS+J0dYC
 YH4=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:03 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 07/42] btrfs: zoned: disallow fitrim on zoned filesystems
Date:   Thu,  4 Feb 2021 19:21:46 +0900
Message-Id: <0fe38cc20347fd835887cdd8b979dc266dffa6bf.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The implementation of fitrim depends on space cache, which is not used
and disabled for zoned extent allocator. So the current code does not
work with zoned filesystem.

In the future, we can implement fitrim for zoned filesystems by enabling
space cache (but, only for fitrim) or scanning the extent tree at fitrim
time.  For now, disallow fitrim on zoned filesystems.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e6a63f652235..a8c60d46d19c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -527,6 +527,14 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/*
+	 * btrfs_trim_block_group() depends on space cache, which is not
+	 * available in zoned filesystem. So, disallow fitrim on a zoned
+	 * filesystem for now.
+	 */
+	if (btrfs_is_zoned(fs_info))
+		return -EOPNOTSUPP;
+
 	/*
 	 * If the fs is mounted with nologreplay, which requires it to be
 	 * mounted in RO mode as well, we can not allow discard on free space
-- 
2.30.0

