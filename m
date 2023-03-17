Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E556BDFE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 05:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjCQEAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 00:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCQEA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:00:27 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E516310;
        Thu, 16 Mar 2023 21:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679025619; i=@fujitsu.com;
        bh=Czxs+/bMZGsmcQcPN4CLVE+4lrV1LC+Umu+epj/Q7n8=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=rIZzy86+ND2FSlnp/Rs9zhv0yOo3NUBsVQs2EKUGegW91I9fbeVT+6XrqXAEKB6jY
         yb1J3HrXr21j9CNHKYXRlrVuHK1d02n0Bj02RMANK9Urr6DeurB3szkvfmM8gWCAqc
         ZF9aDkngZnu3yht6nTqwSVVsZEvdPNGPw13PH2TZJPdKjtjj2JYDE+JFZtKSZ+hzkv
         gwI4GkHZVOojKEAOxngsNnx4WcHDies10pB/820jE2T+ebOvD7p6J029H/LlCIy6lU
         3abSRKRiFQ52Qbv/jzrHDEZNJwtTrO+yZLm87NGm5LC7JghWn387YXjWRUExfu2kv9
         3n/IMI1C5S35g==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRWlGSWpSXmKPExsViZ8OxWffSU+E
  Ug8k31SzmrF/DZjF96gVGiy3H7jFaXH7CZ7Fn70kWi8u75rBZ7Pqzg91i5Y8/rA4cHqcWSXgs
  3vOSyWPTqk42jxMzfrN4vNg8k9Hj8ya5ALYo1sy8pPyKBNaMrSuXsxe8UqrYeec8UwPjDNkuR
  i4OIYGNjBK7zj5lgXCWMEncnL2XDcLZyyix88lu9i5GTg42AR2JCwv+soLYIgLVErevbmMDsZ
  kFMiSOX/nDDGILC0RJ7H31DijOwcEioCrxeW4ZSJhXwEWiY+c+FhBbQkBBYsrD98wQcUGJkzO
  fsECMkZA4+OIFM0irhICSxMzueIjyConG6YeYIGw1iavnNjFPYOSfhaR7FpLuBYxMqxhNi1OL
  ylKLdE31kooy0zNKchMzc/QSq3QT9VJLdctTi0t0jfQSy4v1UouL9Yorc5NzUvTyUks2MQJDP
  6VYbdcOxgl9f/UOMUpyMCmJ8sZuFE4R4kvKT6nMSCzOiC8qzUktPsQow8GhJMGb/RgoJ1iUmp
  5akZaZA4xDmLQEB4+SCK/LPaA0b3FBYm5xZjpE6hSjMcfahgN7mTk+/rm4l1mIJS8/L1VKnNf
  zCVCpAEhpRmke3CBYerjEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZjX6wHQFJ7MvBK4fa+A
  TmECOoV3ngDIKSWJCCmpBiZxhTUF7vzb47lsMx5lPpSflMJweu2RWqvPHyaIa0V8UTVpy6lQt
  /Rrn3vJx8LxQUDM+ozi3MSlZQU7rnQv07xSvNmn65iCkth+mb/H+1hb60MNmkuc86Ke+Wxfp6
  rFPIdNr6H6s+vB81Ozul2S1+ZP+vdHuCvap9HOJ+LkrKn6PMl7F/34H1z1oSTogGngsgj2xqd
  t8XFqrl3Jn0q6d/D0VX699aZMsCxy4mxHXhnRAyfu2qa7VEwS+95f5J5lbPP8t/Ge6jeylz6H
  lun98GLekqvdp7MrOudUYztXldN9FSfVjbccVPa/8J5fdXuTuLbmjtLTi10ms55Z8mLSwm9Gg
  pn+McFC6ltfHddSYinOSDTUYi4qTgQAw/rCsIoDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-13.tower-571.messagelabs.com!1679025618!299922!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 2250 invoked from network); 17 Mar 2023 04:00:18 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-13.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Mar 2023 04:00:18 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 44543152;
        Fri, 17 Mar 2023 04:00:18 +0000 (GMT)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 3757C150;
        Fri, 17 Mar 2023 04:00:18 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 17 Mar 2023 04:00:14 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [RFC PATCH] xfs: check shared state of when CoW, update reflink flag when io ends
Date:   Fri, 17 Mar 2023 03:59:48 +0000
Message-ID: <1679025588-21-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As is mentioned[1] before, the generic/388 will randomly fail with dmesg
warning.  This case uses fsstress with a lot of random operations.  It is hard
to  reproduce.  Finally I found a 100% reproduce condition, which is setting
the seed to 1677104360.  So I changed the generic/388 code: removed the loop
and used the code below instad:
```
($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
($FSSTRESS_PROG $FSSTRESS_AVOID -d $SCRATCH_MNT -v -s 1677104360 -n 221 -p 1 >> $seqres.full) > /dev/null 2>&1
_check_dmesg_for dax_insert_entry
```

According to the operations log, and kernel debug log I added, I found that
the reflink flag of one inode won't be unset even if there's no more shared
extents any more.
  Then write to this file again.  Because of the reflink flag, xfs thinks it
    needs cow, and extent(called it extA) will be CoWed to a new
    extent(called it extB) incorrectly.  And extA is not used any more,
    but didn't be unmapped (didn't do dax_disassociate_entry()).
  The next time we mapwrite to another file, xfs will allocate extA for it,
    page fault handler do dax_associate_entry().  BUT bucause the extA didn't
    be unmapped, it still stores old file's info in page->mapping,->index.
    Then, It reports dmesg warning when it try to sotre the new file's info.

So, I think:
  1. reflink flag should be updated after CoW operations.
  2. xfs_reflink_allocate_cow() should add "if extent is shared" to determine
     xfs do CoW or not.

I made the fix patch, it can resolve the fail of generic/388.  But it causes
other cases fail: generic/127, generic/263, generic/616, xfs/315 xfs/421. I'm
not sure if the fix is right, or I have missed something somewhere.  Please
give me some advice.

Thank you very much!!

[1]: https://lore.kernel.org/linux-xfs/1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_reflink.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index f5dc46ce9803..a6b07f5c1db2 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -154,6 +154,40 @@ xfs_reflink_find_shared(
 	return error;
 }
 
+int xfs_reflink_extent_is_shared(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*irec,
+	bool			*shared)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_perag	*pag;
+	xfs_agblock_t		agbno;
+	xfs_extlen_t		aglen;
+	xfs_agblock_t		fbno;
+	xfs_extlen_t		flen;
+	int			error = 0;
+
+	*shared = false;
+
+	/* Holes, unwritten, and delalloc extents cannot be shared */
+	if (!xfs_bmap_is_written_extent(irec))
+		return 0;
+
+	pag = xfs_perag_get(mp, XFS_FSB_TO_AGNO(mp, irec->br_startblock));
+	agbno = XFS_FSB_TO_AGBNO(mp, irec->br_startblock);
+	aglen = irec->br_blockcount;
+	error = xfs_reflink_find_shared(pag, NULL, agbno, aglen, &fbno, &flen,
+			true);
+	xfs_perag_put(pag);
+	if (error)
+		return error;
+
+	if (fbno != NULLAGBLOCK)
+		*shared = true;
+
+	return 0;
+}
+
 /*
  * Trim the mapping to the next block where there's a change in the
  * shared/unshared status.  More specifically, this means that we
@@ -533,6 +567,12 @@ xfs_reflink_allocate_cow(
 		xfs_ifork_init_cow(ip);
 	}
 
+	error = xfs_reflink_extent_is_shared(ip, imap, shared);
+	if (error)
+		return error;
+	if (!*shared)
+		return 0;
+
 	error = xfs_find_trim_cow_extent(ip, imap, cmap, shared, &found);
 	if (error || !*shared)
 		return error;
@@ -834,6 +874,10 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
+	error = xfs_reflink_clear_inode_flag(ip, &tp);
+	if (error)
+		goto out_cancel;
+
 	error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	if (error)
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 65c5dfe17ecf..d5835814bce6 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -16,6 +16,8 @@ static inline bool xfs_is_cow_inode(struct xfs_inode *ip)
 	return xfs_is_reflink_inode(ip) || xfs_is_always_cow_inode(ip);
 }
 
+int xfs_reflink_extent_is_shared(struct xfs_inode *ip,
+		struct xfs_bmbt_irec *irec, bool *shared);
 extern int xfs_reflink_trim_around_shared(struct xfs_inode *ip,
 		struct xfs_bmbt_irec *irec, bool *shared);
 int xfs_bmap_trim_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
-- 
2.39.2

