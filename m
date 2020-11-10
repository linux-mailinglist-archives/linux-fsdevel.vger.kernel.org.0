Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352A22AD52F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgKJL2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:28:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11943 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgKJL2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:28:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007705; x=1636543705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmhEYe4FQn2hKciTrSoqULPqx/1dV3UQO8AYYi+tRAQ=;
  b=nzhnKOp2cqfDU9nywwVzBBs1u3LUVHambSlGGFTwszEiN0fG8ggEgv9Y
   4BWGnvaf0zmtYkGbpvHE8HBdoLjxERpqkeZQwZqsC7fIueUYCXOTWur/s
   KK3v+IugiVI8v7Uo0YcmG6tS5paraDtMn04BWCwl5LStPwUOz5pS5Mco8
   ufbsHpTZX89OFQwJTXn0f2o1W3e1tGyCo7hwN0rdXNbvlkCBLy5kUH5Jx
   TDlF40hwdqv3iDmz5Sax512fsfbFzzLuHf5FEjSSKdbcuLHy3bYFU645Q
   Cq8aYm/EDpqCEsyozvRw+dUnjGsJO2RtC2rPwwZxl4ctgWlwhr96gkFtM
   A==;
IronPort-SDR: vYU6jjs+Yh84tg6y9UJZ2wMmVdiGP2dxo5CAm30ryrUrbT24d4S5KmgYd6+bOsniVsXtiErzzO
 +D9ny+Yb4FU9baNIiWGDMWrf3YEvL3OarAYWOdq99JEUwV/jG97hQ+KQqEtrqeJcVGtvwzlYpJ
 ycSlywNQTPMwDKNCYFAEv2/8fR8AwM69RM3qr00S7r6OCYpiZiAr/kERbRrakjRKghX7mH4TfY
 jkC38rW4vvS8W39jkQ/6/fw1rjI4G5bYbN+gsg07VQaz6un1ik7yz3aNrJLdd1cOOH6q099CZP
 ktE=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376435"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:19 +0800
IronPort-SDR: ciu2TAvjxPjrI9cYpMJq+N+70rWbsvqKFs1677orTGf0Z9+n/4gpS923qjCc2Rj6f3o4IPMAiP
 TN3MP1mxGCZcZoOIBpzNsKzaXB5dSZb1hpFmDt+Kq3aAmg2rtX5P6tJrOnyhWmycuPAJEz3XNb
 i1rOeFH3AgokQ9iMkIyTm4m1tDPuFAbPw9pLvNB7XrLFZQEkcOR8OzM9Lac4NXpaGlXdBdFwgo
 pPTWlw0QeKL/cHLgduxD0aDufzRI1SlW0yRe3W7ooqV4Tsg6Ay9CHJsLej6JB9FkfXdhSFSkOI
 LzbxDx7IBR8N1YljRKpe4OHB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:20 -0800
IronPort-SDR: 3rRZGCBdHAv3BfMTlNd/l3D4Avuk26fAH8DD2/SN6biLCwn9A4FkgSBO+5VWdj8R+9K4I4YbOT
 bNW98gnJ4uQgbfjPurswL4loMzZpVajmytFqXkRaTlHasFO4SObDZcV6Op/oe4j7lAZxZIj5MW
 DvXXn++5Cmb1nF/zORT22fkMvrBto47oAL/2SPBxPssaOaUXo2a2Q3YCmsf3KRHGx2NVVTwtiD
 VBcCWcHVkb9WAP5FUu8dqZcSMrED6boblt0fgS8ha0K5rCOyChyPEX2maK/b/MFq/pLh5fjJfm
 fe0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 09/41] btrfs: disable fallocate in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:12 +0900
Message-Id: <5136fb8ba2a9746bfc55247c93b86e33bdd7eb7b.1605007036.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in ZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in ZONED
mode by utilizing space_info->bytes_may_use or so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0ff659455b1e..68938a43081e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3341,6 +3341,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in ZONED mode */
+	if (btrfs_is_zoned(btrfs_sb(inode->i_sb)))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.27.0

