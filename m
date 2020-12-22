Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CC2E0516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgLVDyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46443 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgLVDyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609284; x=1640145284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IT+w7E9xT1lSCDrMBt2X0Qgo8oL+9wbBL7fpKIJFd+I=;
  b=C6HuIX069PTzxxonlsv4yayx+vcEaEAqWV/ZlLmgMVE0nw+i50AcS6LE
   scjCvzM0hlePM+qwg5Yjlpa2BbdX/3I2anDWir4RDxrwfft5iuqeaXRD/
   8puYd/N6Zfs7U+gfTsm0blgwIpJaB8os7yjnE30VLsIJ68A5TsXvyoWkK
   0Gsq0uqDOSh8SqsfgnhKNrVt1GlrdZbc9tQUOt6eKPRTyxgM80av9sGLj
   Wp62JBL75UeEG8ZJecIA7nPzfhuIE7MRe98wRGL6GWME1JBtxS6qnXA4e
   pOQawEwtyLeWZBpJQNPNMNoLmvtGIB5iRapxxH8qe96Ms66kvgTJQXBKm
   w==;
IronPort-SDR: dN89SUPhp+MbBfyjXC0D3l9l0OFAzLfLiEkLLunGULqyNZwYh1j3n+K2FBIOT8b1qciqnc8kvW
 UvrN8rRLCu52iQGgsJ3Djjeibt1b6wG4WIsM97gwmiak1hSKpluhruXXNYsoqP4+48dbcAswyE
 39AAC3EqWXLVZ61ry3jzGDaw9zTbP1CioAVSCHqqooaB7dfnYVjm1Yl8Mgf3YY3w1pWqtgC/Or
 hkbQ7ckR5Ex7jLGTBuAi1WiKZ9EFW+h7HayW4fR0M2fx2XxcNeVuQ/HCxuH1jxY1KhR/Vt3JdH
 K0E=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193828"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:07 +0800
IronPort-SDR: xuidMcm8Gfapz7FSbKlF+gDHo/rHb9Dg8l5/PC8F5kFYZcuIbGQGWGcvZjcAIJsXl2pXh/dT6n
 MUaeCu6xccOEaN48WhuWq2i6w1bNrYgts5+8euahhLW1HikQDTukeQiIj/kwDjlW/a3ZNHED2X
 ytdSPGCu6cnDep5q8maYyYhzt+KtUrLJLHosw0WPSnXjZtW/Yg9AbtXJuO1BaEOdovxn2XQSK4
 I4ieakSt94cKRo53hZa9zdn39Db//KLqj+zEaB3WmQB+ik1b6Aid+B7MSFjXsco3JrBeVsZHHM
 cm2dBHyA+YZNf+/nlP2zPfJV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:19 -0800
IronPort-SDR: /bIPPa1IQCt2ryTRcrGNjbUB51KjCoqq7XtkXTe1TNdgbjtl4IJa+/DeNFSESirMTPt7AqWHoQ
 pFRdCna1RI0oHkIOCSY12PTFx9sCzUGomT4ugq9MSRz7G7U4A/RQ7v319nFOG4h39b3md0Fcad
 4KyXFhw7HRHR11RC4o8LJJzzXQ6VIbwSAUQAGGLWSatTooi/odoWGIq3n2Iro/jHdatF2qnX68
 wFVqzcOWn+ugKG3kb3IHo3pu7fN1V/d5Vv1Psy+0z8A3UmkiB4b1hbh2gifAlBKrcJPQtvOP1b
 IYk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:07 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 27/40] btrfs: introduce dedicated data write path for ZONED mode
Date:   Tue, 22 Dec 2020 12:49:20 +0900
Message-Id: <2b4271752514c9f376b1fc6a988336ed9238aa0d.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index 5e96d9631038..5f4de6ebebbd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1400,6 +1400,29 @@ static int cow_file_range_async(struct btrfs_inode *inode,
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
@@ -1879,17 +1902,24 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
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

