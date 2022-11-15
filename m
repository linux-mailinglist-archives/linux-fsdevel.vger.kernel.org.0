Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6FE628F36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiKOBav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKOBat (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:30:49 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53485FDA
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:48 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c203so1594748pfc.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRbCKOeEzaINPi28mkymmnvdjm9021B1BlIXQDG3kyg=;
        b=w6QrD1tRY+J5ZkwFK9ZX+G4Rt/2yPVQZoD0dbLbepFH5SuLO1KAAjZeq7Qb1AUqJyt
         4c3/j2omnChCoLxxtTjT2tqLiQmMtuESJkzcmvj9EpZj+mTAc0Kie9ccf/g47O4yhDZl
         pAoEH2wJPDAX1GyUG0uXtSc2hsL/SecqTcx6WuKNrYBqW0nq+khenr161SNF7KVa5XRn
         KLClCBYCkFP9vdokQN8WBCKws7oj3uOMXg7YCYtc/f3qjaqPIH3Azr+8Mn38e598Hned
         olK9TePB+WvV7AgUzJ3637H2oohlCYpXP86GphkDV7lJ0U7/FcuiQdkSfsz9vWg6cm+4
         RUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRbCKOeEzaINPi28mkymmnvdjm9021B1BlIXQDG3kyg=;
        b=pIQIrboo5NXTfJLeF8rLwBc7nsCAP4zr+D8WTm+G3BEdVy43uacO09v9YoyvoU2TiG
         taAKcQrYm3ALpd7MIl8doI7JQHhTpYLJqgpc/4WmAHM/HCDc5Ww5gKKrzW1JCpo+ypu0
         e+ZN2GVoYpMgLFVYT+vjQ1uewTjaklVNehb5eKCOqsXL0MCfbp+V4bZtlyrYMJGqqRnS
         7dh5YHwD8j0MFtN2AL8K1ZDnmQRw0ZJsYgx8X3oH/zKGqcrRmH3fX/itDhiTrUWJcIyt
         CgFtHUYMewPBVwFHJ0I92SQXFSry66Kciqb0vt8y7DaXZmIve2DkS/n7BYpk1EbobqLY
         ZBQg==
X-Gm-Message-State: ANoB5pm+dz6dk+EnZO2hupzbP3Opbbr9U7jJNBpX4eqRcBc4XhXq/JZd
        kaam0dnrGzg6Z07fPzfb6P4tJMxmotazRg==
X-Google-Smtp-Source: AA0mqf7UjzuHUARnNssJHidYHv6IsqjUDGTSoPPpjTwRymVju/Gxhkqsrl0nYg2Vw5pGFC0Bl/4mtw==
X-Received: by 2002:a63:40d:0:b0:470:514e:1f12 with SMTP id 13-20020a63040d000000b00470514e1f12mr13964475pge.353.1668475848378;
        Mon, 14 Nov 2022 17:30:48 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902c79200b001754064ac31sm8143681pla.280.2022.11.14.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:47 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKG5-Dw; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001Vpb-1H;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 6/9] xfs: xfs_bmap_punch_delalloc_range() should take a byte range
Date:   Tue, 15 Nov 2022 12:30:40 +1100
Message-Id: <20221115013043.360610-7-david@fromorbit.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221115013043.360610-1-david@fromorbit.com>
References: <20221115013043.360610-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

All the callers of xfs_bmap_punch_delalloc_range() jump through
hoops to convert a byte range to filesystem blocks before calling
xfs_bmap_punch_delalloc_range(). Instead, pass the byte range to
xfs_bmap_punch_delalloc_range() and have it do the conversion to
filesystem blocks internally.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_aops.c      | 16 ++++++----------
 fs/xfs/xfs_bmap_util.c | 10 ++++++----
 fs/xfs/xfs_bmap_util.h |  2 +-
 fs/xfs/xfs_iomap.c     | 21 ++++-----------------
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 5d1a995b15f8..6aadc5815068 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -114,9 +114,8 @@ xfs_end_ioend(
 	if (unlikely(error)) {
 		if (ioend->io_flags & IOMAP_F_SHARED) {
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
-			xfs_bmap_punch_delalloc_range(ip,
-						      XFS_B_TO_FSBT(mp, offset),
-						      XFS_B_TO_FSB(mp, size));
+			xfs_bmap_punch_delalloc_range(ip, offset,
+					offset + size);
 		}
 		goto done;
 	}
@@ -455,12 +454,8 @@ xfs_discard_folio(
 	struct folio		*folio,
 	loff_t			pos)
 {
-	struct inode		*inode = folio->mapping->host;
-	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
 	struct xfs_mount	*mp = ip->i_mount;
-	size_t			offset = offset_in_folio(folio, pos);
-	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, pos);
-	xfs_fileoff_t		pageoff_fsb = XFS_B_TO_FSBT(mp, offset);
 	int			error;
 
 	if (xfs_is_shutdown(mp))
@@ -470,8 +465,9 @@ xfs_discard_folio(
 		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
 			folio, ip->i_ino, pos);
 
-	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
-			i_blocks_per_folio(inode, folio) - pageoff_fsb);
+	error = xfs_bmap_punch_delalloc_range(ip, pos,
+			round_up(pos, folio_size(folio)));
+
 	if (error && !xfs_is_shutdown(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 }
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index 04d0c2bff67c..867645b74d88 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -590,11 +590,13 @@ xfs_getbmap(
 int
 xfs_bmap_punch_delalloc_range(
 	struct xfs_inode	*ip,
-	xfs_fileoff_t		start_fsb,
-	xfs_fileoff_t		length)
+	xfs_off_t		start_byte,
+	xfs_off_t		end_byte)
 {
+	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_ifork	*ifp = &ip->i_df;
-	xfs_fileoff_t		end_fsb = start_fsb + length;
+	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
+	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
 	struct xfs_bmbt_irec	got, del;
 	struct xfs_iext_cursor	icur;
 	int			error = 0;
@@ -607,7 +609,7 @@ xfs_bmap_punch_delalloc_range(
 
 	while (got.br_startoff + got.br_blockcount > start_fsb) {
 		del = got;
-		xfs_trim_extent(&del, start_fsb, length);
+		xfs_trim_extent(&del, start_fsb, end_fsb - start_fsb);
 
 		/*
 		 * A delete can push the cursor forward. Step back to the
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index 24b37d211f1d..6888078f5c31 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -31,7 +31,7 @@ xfs_bmap_rtalloc(struct xfs_bmalloca *ap)
 #endif /* CONFIG_XFS_RT */
 
 int	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip,
-		xfs_fileoff_t start_fsb, xfs_fileoff_t length);
+		xfs_off_t start_byte, xfs_off_t end_byte);
 
 struct kgetbmap {
 	__s64		bmv_offset;	/* file offset of segment in blocks */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2d48fcc7bd6f..04da22943e7c 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1120,20 +1120,6 @@ xfs_buffered_write_iomap_begin(
 	return error;
 }
 
-static int
-xfs_buffered_write_delalloc_punch(
-	struct inode		*inode,
-	loff_t			start_byte,
-	loff_t			end_byte)
-{
-	struct xfs_mount	*mp = XFS_M(inode->i_sb);
-	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
-	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
-
-	return xfs_bmap_punch_delalloc_range(XFS_I(inode), start_fsb,
-				end_fsb - start_fsb);
-}
-
 /*
  * Scan the data range passed to us for dirty page cache folios. If we find a
  * dirty folio, punch out the preceeding range and update the offset from which
@@ -1172,8 +1158,9 @@ xfs_buffered_write_delalloc_scan(
 			if (offset > *punch_start_byte) {
 				int	error;
 
-				error = xfs_buffered_write_delalloc_punch(inode,
-						*punch_start_byte, offset);
+				error = xfs_bmap_punch_delalloc_range(
+						XFS_I(inode), *punch_start_byte,
+						offset);
 				if (error) {
 					folio_unlock(folio);
 					folio_put(folio);
@@ -1267,7 +1254,7 @@ xfs_buffered_write_delalloc_release(
 	}
 
 	if (punch_start_byte < end_byte)
-		error = xfs_buffered_write_delalloc_punch(inode,
+		error = xfs_bmap_punch_delalloc_range(XFS_I(inode),
 				punch_start_byte, end_byte);
 out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
-- 
2.37.2

