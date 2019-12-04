Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5BEA112461
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLDITk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:40 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfLDITh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447577; x=1606983577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jxw4CEGwoy8t1QezrDvEjaSMaFQakiEMAHs/uxO0A6s=;
  b=GgFUR8SItMEzeEkgVcUiAaS5aiZsQBxgf/uetWHPjhC/BRutm97aDQKp
   pVidrzoPKrYP9o7TW0mdPLssLCI35NQx4zjH49oJQmbskVY2ZeDtbjP7u
   /d1oND6sc/A3YJydklXajgcsdIbpdKfrDAoJ1qXBCk3Yd2R5NitCM0+O4
   GZrQx8tZBr2AiRcOzRlYrIByIxfaErwW+Sk7VX8zfNOD8W1awZjVDe1zS
   oNhc9MK//XxCRW3kHS28OoKEabLFdo1BI2UtxMBuU99w1e/+8suhYcAXW
   AV/Ey5IjR5ds1NQnJzPJXHIvEGz37mg7/NPYbQVXMjEi/miG8GiEt/MSj
   A==;
IronPort-SDR: fyaSEeTcVk48QFnsMZqjO1Qk7Wy05TTWzCRmDtV5FuO7OPm+xRHoqmHJl0cIRWFG190wytrA00
 7zToSkOLaHLI7zQmAWNMZkDqw/0zQIWgDn6upPxyKFg8U6798gTBJKKDIC496tL8B6uPwHcuP6
 wkgzduGC07p/UftAeBz38Uw50dDP+Xs6K7ZXsqylfD/ZRDCOGtDgKa6T9NY9qIBKtgJfCGHPXP
 ubuIOjj6R4Iwv5IZWz4yrorHNurdPtoZllO6DdXV+ZK1Q7hrZYNTyTbq/jizRoA2r9rII504z1
 m9Q=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355047"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:37 +0800
IronPort-SDR: aze5q2GJWXlUO8x8HrPFDpVSsH3kW/Dw8ZE0pDBe0gGfdYsx8UrMJaS2sf7RHvu26nYcso5msX
 AFylg1WquFe7Mq5rMDnZ86MJNzWdO20me1j54iP7Ksyt/uMYWAx/AZjTT4jNL5zGsSEsQbh1ag
 x1OsTx41qX7aTKP/VwWJz3FZ01vtFZj8ALlrZUqx7QAuXp//Sxos/9Ao0zeXWJVqYVxGBMOHbW
 pCmhDAS72tqYuLzSRaDwjieB3GGLvf486hr5qILxdFkAfJQnsDgnKqtOkJnVPmOXms3tgLuqEG
 Vu7VmlIgKv5PPQ51rOkyudYY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:02 -0800
IronPort-SDR: 9O3kZpe57YeEC7ciHDWOz4yHRhJUjwjU6Vz3bwgWbl8qUZdtNwoB6gZS8VuJUpjQNAzHefedKF
 oLMQLcPhmgs+XLzaHAtaeS0nL41P6h7BnPv6V4nhOw31NJ6RUY0oIduqW0y7hb0A+B07l5JwQM
 irBXoFB7F6uF7NbOiz1pjszP6hdglltyO+ZzjSYUtfQBQCeT20uzQjFNT7X0gLKjDynHQLR/5W
 E38VQqYOyRj5uUcEHvTBYTHRsYkSPQ44T5wpRv9OOG3LoRYdei4nrGgLNixcJDZjYvu3ujqTUK
 +uU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:34 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 07/28] btrfs: disable fallocate in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:14 +0900
Message-Id: <20191204081735.852438-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in HMZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in
HMZONED mode by utilizing space_info->bytes_may_use or so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0cb43b682789..22373d00428b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3170,6 +3170,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in HMZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.24.0

