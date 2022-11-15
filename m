Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA69628F40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 02:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiKOBbS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 20:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKOBav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 20:30:51 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B807E62DC
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:50 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b62so11918814pgc.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Nov 2022 17:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgZL4Q6/hiN7SK0U+fxjQpeeWJPO0+rsmSJULzaGQ0k=;
        b=UUqPu/qLFSsKkqibdIyWpzTl7kJ0392Arsqxv5eqI2K6kcKDlIPK26OhDQtPxdgLk6
         NmBy3VVOPc9exNJwbPMYA/O1J5+2B3/QWN36xbCtHZFo1XS7tAziLiwIwM1I4ZSIMSfz
         ya5v3sLA5e4ngF5cW55rzN6yyHLIdJP385ok87P7w4GraXHJfZkCQd0rd9WUT3aIz21m
         kZBez5immZ36uVk6aLtli7nW9CxMyY3g627gqnkAHVEJgAzsGAheJkioxNrm6Xx9p+yi
         0q0KykfQMpzuWtFoq8of5+MbNVzqwkjdjnt0CdGcSJOfNkZKtS97NnGEg+ruJCBe2siW
         uJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgZL4Q6/hiN7SK0U+fxjQpeeWJPO0+rsmSJULzaGQ0k=;
        b=oXZ3O8rPitE1iMBW/uWPKnAuVDf5xPtksFZp9+cQbTBIOz5b4n/Q9iZkGUb4LxGNsO
         6PbBPEyvjC3Gn/BI33HnVRqXfwNTE0lbCgOAL7JHpSct1VQtPd7uzEoKymC/8O4D0cg0
         ARLcGWyS0Fw5MPGfbnyo17jtb5TJtpvsH81aLgSxJsT4ZVxaEJ7O/s6Rik/GO3WuQ6Rp
         AcMtkr0xQu04JnSPr3pGJXYuyn6MM/FH2KSMrz3NEm4hOYxsTMqMm7lU0aTilz7nd4aW
         FizFtIT2WRnIdYmAsuBEvd44aR5KCJGwN6jo7IaHKDmkXJAVKEFWGt60JczkjfwSvZRZ
         BlaA==
X-Gm-Message-State: ANoB5pmPqTYPvsbRbkSMRPdkXfUu4RKg5W5m7lB2tJH0BAm28OSvNQ7C
        OFaQ7iCcEMlRtiyXcKZ34uSnQQ==
X-Google-Smtp-Source: AA0mqf53q+Ed2oyN1jbck8d7rOoRUBqjIi3l7i6bP6FZ3exURtjovulj7jav8V30tqIY2/ycTy12og==
X-Received: by 2002:aa7:814e:0:b0:572:6e9b:9fa2 with SMTP id d14-20020aa7814e000000b005726e9b9fa2mr1008065pfn.8.1668475850202;
        Mon, 14 Nov 2022 17:30:50 -0800 (PST)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au. [49.181.106.210])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b001868ed86a95sm8290720plg.174.2022.11.14.17.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 17:30:48 -0800 (PST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-00EKGJ-Hn; Tue, 15 Nov 2022 12:30:45 +1100
Received: from dave by discord.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1oukmj-001Vpr-1d;
        Tue, 15 Nov 2022 12:30:45 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 9/9] xfs: drop write error injection is unfixable, remove it
Date:   Tue, 15 Nov 2022 12:30:43 +1100
Message-Id: <20221115013043.360610-10-david@fromorbit.com>
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

With the changes to scan the page cache for dirty data to avoid data
corruptions from partial write cleanup racing with other page cache
operations, the drop writes error injection no longer works the same
way it used to and causes xfs/196 to fail. This is because xfs/196
writes to the file and populates the page cache before it turns on
the error injection and starts failing -overwrites-.

The result is that the original drop-writes code failed writes only
-after- overwriting the data in the cache, followed by invalidates
the cached data, then punching out the delalloc extent from under
that data.

On the surface, this looks fine. The problem is that page cache
invalidation *doesn't guarantee that it removes anything from the
page cache* and it doesn't change the dirty state of the folio. When
block size == page size and we do page aligned IO (as xfs/196 does)
everything happens to align perfectly and page cache invalidation
removes the single page folios that span the written data. Hence the
followup delalloc punch pass does not find cached data over that
range and it can punch the extent out.

IOWs, xfs/196 "works" for block size == page size with the new
code. I say "works", because it actually only works for the case
where IO is page aligned, and no data was read from disk before
writes occur. Because the moment we actually read data first, the
readahead code allocates multipage folios and suddenly the
invalidate code goes back to zeroing subfolio ranges without
changing dirty state.

Hence, with multipage folios in play, block size == page size is
functionally identical to block size < page size behaviour, and
drop-writes is manifestly broken w.r.t to this case. Invalidation of
a subfolio range doesn't result in the folio being removed from the
cache, just the range gets zeroed. Hence after we've sequentially
walked over a folio that we've dirtied (via write data) and then
invalidated, we end up with a dirty folio full of zeroed data.

And because the new code skips punching ranges that have dirty
folios covering them, we end up leaving the delalloc range intact
after failing all the writes. Hence failed writes now end up
writing zeroes to disk in the cases where invalidation zeroes folios
rather than removing them from cache.

This is a fundamental change of behaviour that is needed to avoid
the data corruption vectors that exist in the old write fail path,
and it renders the drop-writes injection non-functional and
unworkable as it stands.

As it is, I think the error injection is also now unnecessary, as
partial writes that need delalloc extent are going to be a lot more
common with stale iomap detection in place. Hence this patch removes
the drop-writes error injection completely. xfs/196 can remain for
testing kernels that don't have this data corruption fix, but those
that do will report:

xfs/196 3s ... [not run] XFS error injection drop_writes unknown on this kernel.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/libxfs/xfs_errortag.h | 12 +++++-------
 fs/xfs/xfs_error.c           | 27 ++++++++++++++++++++-------
 fs/xfs/xfs_iomap.c           |  9 ---------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
index 5362908164b0..580ccbd5aadc 100644
--- a/fs/xfs/libxfs/xfs_errortag.h
+++ b/fs/xfs/libxfs/xfs_errortag.h
@@ -40,13 +40,12 @@
 #define XFS_ERRTAG_REFCOUNT_FINISH_ONE			25
 #define XFS_ERRTAG_BMAP_FINISH_ONE			26
 #define XFS_ERRTAG_AG_RESV_CRITICAL			27
+
 /*
- * DEBUG mode instrumentation to test and/or trigger delayed allocation
- * block killing in the event of failed writes. When enabled, all
- * buffered writes are silenty dropped and handled as if they failed.
- * All delalloc blocks in the range of the write (including pre-existing
- * delalloc blocks!) are tossed as part of the write failure error
- * handling sequence.
+ * Drop-writes support removed because write error handling cannot trash
+ * pre-existing delalloc extents in any useful way anymore. We retain the
+ * definition so that we can reject it as an invalid value in
+ * xfs_errortag_valid().
  */
 #define XFS_ERRTAG_DROP_WRITES				28
 #define XFS_ERRTAG_LOG_BAD_CRC				29
@@ -95,7 +94,6 @@
 #define XFS_RANDOM_REFCOUNT_FINISH_ONE			1
 #define XFS_RANDOM_BMAP_FINISH_ONE			1
 #define XFS_RANDOM_AG_RESV_CRITICAL			4
-#define XFS_RANDOM_DROP_WRITES				1
 #define XFS_RANDOM_LOG_BAD_CRC				1
 #define XFS_RANDOM_LOG_ITEM_PIN				1
 #define XFS_RANDOM_BUF_LRU_REF				2
diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
index c6b2aabd6f18..dea3c0649d2f 100644
--- a/fs/xfs/xfs_error.c
+++ b/fs/xfs/xfs_error.c
@@ -46,7 +46,7 @@ static unsigned int xfs_errortag_random_default[] = {
 	XFS_RANDOM_REFCOUNT_FINISH_ONE,
 	XFS_RANDOM_BMAP_FINISH_ONE,
 	XFS_RANDOM_AG_RESV_CRITICAL,
-	XFS_RANDOM_DROP_WRITES,
+	0, /* XFS_RANDOM_DROP_WRITES has been removed */
 	XFS_RANDOM_LOG_BAD_CRC,
 	XFS_RANDOM_LOG_ITEM_PIN,
 	XFS_RANDOM_BUF_LRU_REF,
@@ -162,7 +162,6 @@ XFS_ERRORTAG_ATTR_RW(refcount_continue_update,	XFS_ERRTAG_REFCOUNT_CONTINUE_UPDA
 XFS_ERRORTAG_ATTR_RW(refcount_finish_one,	XFS_ERRTAG_REFCOUNT_FINISH_ONE);
 XFS_ERRORTAG_ATTR_RW(bmap_finish_one,	XFS_ERRTAG_BMAP_FINISH_ONE);
 XFS_ERRORTAG_ATTR_RW(ag_resv_critical,	XFS_ERRTAG_AG_RESV_CRITICAL);
-XFS_ERRORTAG_ATTR_RW(drop_writes,	XFS_ERRTAG_DROP_WRITES);
 XFS_ERRORTAG_ATTR_RW(log_bad_crc,	XFS_ERRTAG_LOG_BAD_CRC);
 XFS_ERRORTAG_ATTR_RW(log_item_pin,	XFS_ERRTAG_LOG_ITEM_PIN);
 XFS_ERRORTAG_ATTR_RW(buf_lru_ref,	XFS_ERRTAG_BUF_LRU_REF);
@@ -206,7 +205,6 @@ static struct attribute *xfs_errortag_attrs[] = {
 	XFS_ERRORTAG_ATTR_LIST(refcount_finish_one),
 	XFS_ERRORTAG_ATTR_LIST(bmap_finish_one),
 	XFS_ERRORTAG_ATTR_LIST(ag_resv_critical),
-	XFS_ERRORTAG_ATTR_LIST(drop_writes),
 	XFS_ERRORTAG_ATTR_LIST(log_bad_crc),
 	XFS_ERRORTAG_ATTR_LIST(log_item_pin),
 	XFS_ERRORTAG_ATTR_LIST(buf_lru_ref),
@@ -256,6 +254,19 @@ xfs_errortag_del(
 	kmem_free(mp->m_errortag);
 }
 
+static bool
+xfs_errortag_valid(
+	unsigned int		error_tag)
+{
+	if (error_tag >= XFS_ERRTAG_MAX)
+		return false;
+
+	/* Error out removed injection types */
+	if (error_tag == XFS_ERRTAG_DROP_WRITES)
+		return false;
+	return true;
+}
+
 bool
 xfs_errortag_test(
 	struct xfs_mount	*mp,
@@ -277,7 +288,9 @@ xfs_errortag_test(
 	if (!mp->m_errortag)
 		return false;
 
-	ASSERT(error_tag < XFS_ERRTAG_MAX);
+	if (!xfs_errortag_valid(error_tag))
+		return false;
+
 	randfactor = mp->m_errortag[error_tag];
 	if (!randfactor || prandom_u32_max(randfactor))
 		return false;
@@ -293,7 +306,7 @@ xfs_errortag_get(
 	struct xfs_mount	*mp,
 	unsigned int		error_tag)
 {
-	if (error_tag >= XFS_ERRTAG_MAX)
+	if (!xfs_errortag_valid(error_tag))
 		return -EINVAL;
 
 	return mp->m_errortag[error_tag];
@@ -305,7 +318,7 @@ xfs_errortag_set(
 	unsigned int		error_tag,
 	unsigned int		tag_value)
 {
-	if (error_tag >= XFS_ERRTAG_MAX)
+	if (!xfs_errortag_valid(error_tag))
 		return -EINVAL;
 
 	mp->m_errortag[error_tag] = tag_value;
@@ -319,7 +332,7 @@ xfs_errortag_add(
 {
 	BUILD_BUG_ON(ARRAY_SIZE(xfs_errortag_random_default) != XFS_ERRTAG_MAX);
 
-	if (error_tag >= XFS_ERRTAG_MAX)
+	if (!xfs_errortag_valid(error_tag))
 		return -EINVAL;
 
 	return xfs_errortag_set(mp, error_tag,
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index fa578c913323..bf1661410272 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1335,15 +1335,6 @@ xfs_buffered_write_iomap_end(
 	if (iomap->type != IOMAP_DELALLOC)
 		return 0;
 
-	/*
-	 * Behave as if the write failed if drop writes is enabled. Set the NEW
-	 * flag to force delalloc cleanup.
-	 */
-	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_DROP_WRITES)) {
-		iomap->flags |= IOMAP_F_NEW;
-		written = 0;
-	}
-
 	/* If we didn't reserve the blocks, we're not allowed to punch them. */
 	if (!(iomap->flags & IOMAP_F_NEW))
 		return 0;
-- 
2.37.2

