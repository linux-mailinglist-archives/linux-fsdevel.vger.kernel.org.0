Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ADC6CBB56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 11:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjC1Jm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbjC1Jmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:42:32 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881C3619E;
        Tue, 28 Mar 2023 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1679996548; i=@fujitsu.com;
        bh=DvG7cRSgB7lZ0BGGr7ietTdkp3pRAONypLIpc1jUDRI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=KR0YlhLNmfeznAU00X6GjQVPskhXJgBpe2kRJCkELzhua4FKlgt8jU7TjmBLmUdOK
         qjJ5VZQBp4kOj6faq2sBaV8MO6TGtx5J/yMfph67/epKcc5ZT47eb/fOvzIxGwaUal
         VSLYOnWhq7ENi9+e1m1B+kDagbpkorItL+qWMtqvBFDuC8UZxiIFbALzrCCr7MVqGs
         3l0snwNXTw67zLZp8SWLqeot+dv9K3DzTSH5Khjq09L2zMiGj5jOiVToL7M+a60Lew
         +6clHi1DS21H1Bn2dIUawJUi9at+Znr1KrSq8/jEeFfNlKB8dGhIkunqE+tXK+1s/d
         LATvabOvf4Wuw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsViZ8ORpNuyTSn
  FYO8dRos569ewWUyfeoHR4vITPovZ05uZLPbsPclicW/Nf1aLXX92sFus/PGH1eL3jzlsDpwe
  m1doeSze85LJY9OqTjaPTZ8msXucmPGbxePF5pmMHmcWHGH3+LxJLoAjijUzLym/IoE149/9f
  awFj20qDq/tZW1gnGvUxcjFISSwkVGidc9pxi5GTiBnCZPEoqPmEIljjBLffzxlBUmwCehIXF
  jwF8wWESiU2LP0HQuIzSxQIdG46B8ziC0s4CVx6eltsEEsAqoSn95uZwexeQWcJV7N6gGLSwg
  oSEx5+B6snlPAReLtlxYgmwNombPEtW57iHJBiZMzn0CNl5A4+OIFM0SrksTFr3dYIWygtdMP
  MUHYahJXz21insAoOAtJ+ywk7QsYmVYxmhWnFpWlFukamuglFWWmZ5TkJmbm6CVW6SbqpZbql
  qcWl+ga6SWWF+ulFhfrFVfmJuek6OWllmxiBMZSSrHKix2Mz/r+6h1ilORgUhLl7edUTBHiS8
  pPqcxILM6ILyrNSS0+xCjDwaEkwauyRSlFSLAoNT21Ii0zBxjXMGkJDh4lEd5rq4HSvMUFibn
  FmekQqVOMuhxrGw7sZRZiycvPS5US503fClQkAFKUUZoHNwKWYi4xykoJ8zIyMDAI8RSkFuVm
  lqDKv2IU52BUEuYN3Aw0hSczrwRu0yugI5iAjvhWoAByREkiQkqqgelU5nHh2w5VZ54EMn5bc
  7yXQyLk7785Nj/vfOeNjz3/n+dDcIqHqvLjO/5norgfqs0uDD9yaZcxE1tL9uZc5fA7kqxHeD
  w8bCSeKnuVcP51OPfHko1bxuLLw1bP/n+CLRaZwoWft37rdzLY3yB69E5ns7/Vrfqnl/Z/P60
  +S9aoandL/O3ES54qPA9VGiNDs6oO3Jvm8WcKe7+C6G79JH1PCQa3sHfhU+R+/9BY3iBoH5zw
  0oethftpoHHLiqbq3iKFzbGy34SsyyfNkZA5zhXjlvSsRMvix7K5SmcXa1/7VXG0cMU25UVi1
  yd/9Lpz4r6C5H+XRtfEjvsCUg4HtR5J3Gtl2N9XVqc2XyVQiaU4I9FQi7moOBEADk8C/KwDAA
  A=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-23.tower-571.messagelabs.com!1679996547!1164934!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10280 invoked from network); 28 Mar 2023 09:42:28 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-23.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Mar 2023 09:42:28 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A43E51B3;
        Tue, 28 Mar 2023 10:42:27 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9840C1AF;
        Tue, 28 Mar 2023 10:42:27 +0100 (BST)
Received: from 692d629b0116.g08.fujitsu.local (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 28 Mar 2023 10:42:23 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>
Subject: [PATCH v11 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Tue, 28 Mar 2023 09:41:46 +0000
Message-ID: <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1679996506-2-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch is inspired by Dan's "mm, dax, pmem: Introduce
dev_pagemap_failure()"[1].  With the help of dax_holder and
->notify_failure() mechanism, the pmem driver is able to ask filesystem
(or mapped device) on it to unmap all files in use and notify processes
who are using those files.

Call trace:
trigger unbind
 -> unbind_store()
  -> ... (skip)
   -> devres_release_all()
    -> kill_dax()
     -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
      -> xfs_dax_notify_failure()
      `-> freeze_super()
      `-> do xfs rmap
      ` -> mf_dax_kill_procs()
      `  -> collect_procs_fsdax()    // all associated
      `  -> unmap_and_kill()
      ` -> invalidate_inode_pages2() // drop file's cache
      `-> thaw_super()

Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
event.  Freeze the filesystem to prevent new dax mapping being created.
And do not shutdown filesystem directly if something not supported, or
if failure range includes metadata area.  Make sure all files and
processes are handled correctly.  Also drop the cache of associated
files before pmem is removed.

[1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c         |  3 +-
 fs/xfs/xfs_notify_failure.c | 56 +++++++++++++++++++++++++++++++++----
 include/linux/mm.h          |  1 +
 mm/memory-failure.c         | 17 ++++++++---
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c4c4728a36e4..2e1a35e82fce 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
 		return;
 
 	if (dax_dev->holder_data != NULL)
-		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
+		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
+				MF_MEM_PRE_REMOVE);
 
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 1e2eddb8f90f..1b4eff43f9b5 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -22,6 +22,7 @@
 
 #include <linux/mm.h>
 #include <linux/dax.h>
+#include <linux/fs.h>
 
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
@@ -73,10 +74,16 @@ xfs_dax_failure_fn(
 	struct xfs_mount		*mp = cur->bc_mp;
 	struct xfs_inode		*ip;
 	struct xfs_failure_info		*notify = data;
+	struct address_space		*mapping;
+	pgoff_t				pgoff;
+	unsigned long			pgcnt;
 	int				error = 0;
 
 	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
 	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		/* The device is about to be removed.  Not a really failure. */
+		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
 		notify->want_shutdown = true;
 		return 0;
 	}
@@ -92,10 +99,18 @@ xfs_dax_failure_fn(
 		return 0;
 	}
 
-	error = mf_dax_kill_procs(VFS_I(ip)->i_mapping,
-				  xfs_failure_pgoff(mp, rec, notify),
-				  xfs_failure_pgcnt(mp, rec, notify),
-				  notify->mf_flags);
+	mapping = VFS_I(ip)->i_mapping;
+	pgoff = xfs_failure_pgoff(mp, rec, notify);
+	pgcnt = xfs_failure_pgcnt(mp, rec, notify);
+
+	/* Continue the rmap query if the inode isn't a dax file. */
+	if (dax_mapping(mapping))
+		error = mf_dax_kill_procs(mapping, pgoff, pgcnt,
+				notify->mf_flags);
+
+	/* Invalidate the cache anyway. */
+	invalidate_inode_pages2_range(mapping, pgoff, pgoff + pgcnt - 1);
+
 	xfs_irele(ip);
 	return error;
 }
@@ -164,11 +179,25 @@ xfs_dax_notify_ddev_failure(
 	}
 
 	xfs_trans_cancel(tp);
+
+	/* Unfreeze filesystem anyway if it is freezed before. */
+	if (mf_flags & MF_MEM_PRE_REMOVE) {
+		error = thaw_super(mp->m_super);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * Determine how to shutdown the filesystem according to the
+	 * error code and flags.
+	 */
 	if (error || notify.want_shutdown) {
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		if (!error)
 			error = -EFSCORRUPTED;
-	}
+	} else if (mf_flags & MF_MEM_PRE_REMOVE)
+		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
+
 	return error;
 }
 
@@ -182,6 +211,7 @@ xfs_dax_notify_failure(
 	struct xfs_mount	*mp = dax_holder(dax_dev);
 	u64			ddev_start;
 	u64			ddev_end;
+	int			error;
 
 	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
@@ -196,6 +226,8 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
@@ -209,6 +241,12 @@ xfs_dax_notify_failure(
 	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
 	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
 
+	/* Notify failure on the whole device. */
+	if (offset == 0 && len == U64_MAX) {
+		offset = ddev_start;
+		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
+	}
+
 	/* Ignore the range out of filesystem area */
 	if (offset + len - 1 < ddev_start)
 		return -ENXIO;
@@ -225,6 +263,14 @@ xfs_dax_notify_failure(
 	if (offset + len - 1 > ddev_end)
 		len = ddev_end - offset + 1;
 
+	if (mf_flags & MF_MEM_PRE_REMOVE) {
+		xfs_info(mp, "device is about to be removed!");
+		/* Freeze the filesystem to prevent new mappings created. */
+		error = freeze_super(mp->m_super);
+		if (error)
+			return error;
+	}
+
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..ac3f22c20e1d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3436,6 +3436,7 @@ enum mf_flags {
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
 	MF_NO_RETRY = 1 << 6,
+	MF_MEM_PRE_REMOVE = 1 << 7,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index fae9baf3be16..6e6acec45568 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -623,7 +623,7 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
  */
 static void collect_procs_fsdax(struct page *page,
 		struct address_space *mapping, pgoff_t pgoff,
-		struct list_head *to_kill)
+		struct list_head *to_kill, bool pre_remove)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
@@ -631,8 +631,15 @@ static void collect_procs_fsdax(struct page *page,
 	i_mmap_lock_read(mapping);
 	read_lock(&tasklist_lock);
 	for_each_process(tsk) {
-		struct task_struct *t = task_early_kill(tsk, true);
+		struct task_struct *t = tsk;
 
+		/*
+		 * Search for all tasks while MF_MEM_PRE_REMOVE, because the
+		 * current may not be the one accessing the fsdax page.
+		 * Otherwise, search for the current task.
+		 */
+		if (!pre_remove)
+			t = task_early_kill(tsk, true);
 		if (!t)
 			continue;
 		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
@@ -1732,6 +1739,7 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 	dax_entry_t cookie;
 	struct page *page;
 	size_t end = index + count;
+	bool pre_remove = mf_flags & MF_MEM_PRE_REMOVE;
 
 	mf_flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
 
@@ -1743,9 +1751,10 @@ int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		if (!page)
 			goto unlock;
 
-		SetPageHWPoison(page);
+		if (!pre_remove)
+			SetPageHWPoison(page);
 
-		collect_procs_fsdax(page, mapping, index, &to_kill);
+		collect_procs_fsdax(page, mapping, index, &to_kill, pre_remove);
 		unmap_and_kill(&to_kill, page_to_pfn(page), mapping,
 				index, mf_flags);
 unlock:
-- 
2.39.2

