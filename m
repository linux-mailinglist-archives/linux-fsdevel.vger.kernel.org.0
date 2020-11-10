Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746582AD512
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgKJL3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:19 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgKJL3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007749; x=1636543749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Od3cczacg0iwa+hP7gcge78uvy1r9Vofbv4BmzlKqqw=;
  b=bGM9OLnmKf8To/fU7wLPypYQrFVYduB1KlexKorvptVlYDiM28ebuPlk
   oiAhPt/7mgPdn/XDAxH03nPIXY0q01298nZPYlNit0E0Fb/8PDMdcQvi4
   zyHRiCIaEHobL/DNJVgiGZziBb+D7PzJ/+trVPx501EyNremKv4lXig0h
   lbaV7UjUd/huhW8dzt/VlbpQVPgzaty5U+Z/JjnXUM+RQRJuFc1/eJvD6
   xUbRC0th525iLFXKPkB5AlJI2sz2eyBPeSVmkuGzOxBBDnDyEztXZqu5d
   HjkXGHoGFys9D+F06Wrmp9JyPfwofgEj3otavRnWzgmqfS6UhDWsXL0eY
   w==;
IronPort-SDR: 0Uf/amAoazw+RHeZRFypL09E5AAoLq59jAbxM6VkNfNc0rIihFfODayMOVSpnyANx3rpSWhmyQ
 Pu7FYaAaA6cIxO2AodvCsWRfq2aj0i6Fba6c6w/zKSwOHqDBozvcjnEAPFSQ3BoXcL73qnUxF2
 M5cM/bRzx/lsiJA1MMdmRdtGbUYAatDwswr/P/3MBrFotmB63mTXoUzGyESsaoZ32mrYe4OcZ2
 kT1x+cTcQ9VCsgCGgxviX5Wdz5J+oid2caEW+E1Qg92KxsBGOUuhosxwQCTg7HGPkBIUvWnWYB
 Llc=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376610"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:49 +0800
IronPort-SDR: idppTa8cuF/msrApj4ATR7NUOknpUS5Y42hBCejpaUGxZvPWrQ8/rftwCJVIEUu1kz1VKZlxUU
 bLPvxHMF+Yd5lyhPlVBJRiOhAE7pGCbfQka9Vzf0wtx20BOak4OdGumMoO/CoAVQeJS9/jPW6G
 6X3Amavla+fLUdyLOuxRnMLKwDEQEmUZBygm+GYNJNtYAlkNa0k9+cMsjW2aZDpy6yjFycDUNU
 e1JktZXj+BJ/jjhjIwHSZEFj7jsAjwBAX+I0OgsCmLoHJgsW3R+ISnInxKUSLZtMqZPqLhOfHZ
 Q2cNDJuVOjROonYDsiBpk87r
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:50 -0800
IronPort-SDR: mpMNz9ABdCkNS0Jh13dX/Ol/kgabC1uEBnAluxgfzBIQy/RLHu/jn/9DCZScjJrgqJRqvoezSN
 oig0HLQX26YqkoZMxPBWINUeZLLCbKuJf8POvT1oxHxRmYcmPNt4TEaSGJ6GD3LBy2vYB3hEpA
 zDLmh9O2gbVtLN/AW+C283RvMNzKTEjb1sE67kJJcmHtF5finZaAJ0R0mS3lUaEYl5SbGDbzUf
 h9I/2ID2uY1/PUtiBPM7y2d+O6AAiUAUKIcfI5XmlOmVYL57Rf3eXyHzxjWjrt94qGmA1wb4tv
 gEI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:48 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 27/41] btrfs: introduce dedicated data write path for ZONED mode
Date:   Tue, 10 Nov 2020 20:26:30 +0900
Message-Id: <446f278b547d02adf1e0fa564d7b6ac76c89b57f.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If more than one IO is issued for one file extent, these IO can be written
to separate regions on a device. Since we cannot map one file extent to
such a separate area, we need to follow the "one IO == one ordered extent"
rule.

The Normal buffered, uncompressed, not pre-allocated write path (used by
cow_file_range()) sometimes does not follow this rule. It can write a part
of an ordered extent when specified a region to write e.g., when its
called from fdatasync().

Introduces a dedicated (uncompressed buffered) data write path for ZONED
mode. This write path will CoW the region and write it at once.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/inode.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 445cb6ba4a59..991ef2bf018f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1350,6 +1350,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 	return 0;
 }
 
+static noinline int run_delalloc_zoned(struct btrfs_inode *inode,
+				       struct page *locked_page, u64 start,
+				       u64 end, int *page_started,
+				       unsigned long *nr_written)
+{
+	int ret;
+
+	ret = cow_file_range(inode, locked_page, start, end,
+			     page_started, nr_written, 0);
+	if (ret)
+		return ret;
+
+	if (*page_started)
+		return 0;
+
+	__set_page_dirty_nobuffers(locked_page);
+	account_page_redirty(locked_page);
+	extent_write_locked_range(&inode->vfs_inode, start, end, WB_SYNC_ALL);
+	*page_started = 1;
+
+	return 0;
+}
+
 static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 					u64 bytenr, u64 num_bytes)
 {
@@ -1820,17 +1843,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
+	const bool do_compress = inode_can_compress(inode) &&
+		inode_need_compress(inode, start, end);
+	const bool zoned = btrfs_is_zoned(inode->root->fs_info);
 
 	if (inode->flags & BTRFS_INODE_NODATACOW && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 1, nr_written);
 	} else if (inode->flags & BTRFS_INODE_PREALLOC && !force_cow) {
+		ASSERT(!zoned);
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!do_compress && !zoned) {
 		ret = cow_file_range(inode, locked_page, start, end,
 				     page_started, nr_written, 1);
+	} else if (!do_compress && zoned) {
+		ret = run_delalloc_zoned(inode, locked_page, start, end,
+					 page_started, nr_written);
 	} else {
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-- 
2.27.0

