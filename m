Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00526DF23E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDLKxj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDLKxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:53:38 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50316A68;
        Wed, 12 Apr 2023 03:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1681296814; i=@fujitsu.com;
        bh=9gteb1iXBVQs14/CjE2xQpaLRtKoQGCLoa0k3a+YkBY=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=JyyaABDm2kHiSeRAIGXka228dJMq6PDW1/6Wf8/ZkjDg+/uMFEP/U0YQIs4KxCkVJ
         4VrdtZf0BElvqz+KoRcqOysWRreJOfFTwqcC8dmNEmmXMf0FXuD9ZqcK7KQMgi2ypJ
         XVm/GJIaq8E7idSw9neoiBF4LzkVbO92NSCa0/Kq4sLX4SebHRnqi9Y3x5nuiTWfXD
         iLOR/QjB6cR3D03BKJb3eJ19EQ2prIql8w/dBZC0/oHus2kj9IwuwLiMGXUfFLeQ6T
         agOq32wpHFlclLZQQ6GKRLLytqZffhkRWC2SmtsdRrcyz3T43ulyo5/P1cC9CYUZ6d
         99vm6f+AOUdFg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsViZ8ORqDut1yz
  FYNM8Tos569ewWUyfeoHR4vITPovZ05uZLPbsPclicW/Nf1aLXX92sFus/PGH1eL3jzlsDpwe
  m1doeSze85LJY9OqTjaPTZ8msXucmPGbxePF5pmMHmcWHGH3+LxJLoAjijUzLym/IoE149+DD
  UwFKyMqHm9/ydLAeMKzi5GLQ0hgC6PEpI+fWSCc5UwS8w5cYoRwjjFKLD3dBeRwcrAJ6EhcWP
  CXFcQWESiU2LP0HQuIzSxQIdG46B8ziC0sECCx8eBNNhCbRUBV4uHOjewgNq+As8TB1mNg9RI
  CChJTHr4Hq+cUcJE4tXEvWFwIqGbWrGeMEPWCEidnPoGaLyFx8MULZoheJYmLX++wQthAe6cf
  YoKw1SSuntvEPIFRcBaS9llI2hcwMq1iNC1OLSpLLdI10UsqykzPKMlNzMzRS6zSTdRLLdUtT
  y0u0TXUSywv1kstLtYrrsxNzknRy0st2cQIjKaUYta3Oxj/9/7VO8QoycGkJMpbNMs0RYgvKT
  +lMiOxOCO+qDQntfgQowwHh5IEryowPoUEi1LTUyvSMnOAkQ2TluDgURLhndcBlOYtLkjMLc5
  Mh0idYtTlWNtwYC+zEEtefl6qlDjvzh6gIgGQoozSPLgRsCRziVFWSpiXkYGBQYinILUoN7ME
  Vf4VozgHo5Iwr3Q30BSezLwSuE2vgI5gAjripIUJyBEliQgpqQamKSoKNekfeiWClnKX+PF1G
  X79kL7twGpry3Tj+fV7w9hzC6cf/l/w3iFH5vIPlv92z8yr78uEmHlafKxI1z720nXqBceHF1
  n5K36yX1H/cH1DV/2vZusHxScdVjR4eTSs2NLwn9d7S1v30odv/C9FeFrKsKk/3pJbLjtPaVZ
  J6aPcggBhjrAij7vnvLP4Qo7wZvktKXN++pfvttShupR/EX3Z4qZsSgVnEzkKrc0luc58id22
  8yQPQ/lM9gf/Gbz2rdE3DDFfab13q8E2/rzzqzmkI5lkxW5Zry+Q6DshEn+PdW+N4mLvpsLKl
  X+nz9Ve+1jjDW/0hDnhZyW/TFDfo/LxfGmez7qXW8N0JJRYijMSDbWYi4oTAaen3AitAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-14.tower-585.messagelabs.com!1681296787!379847!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12752 invoked from network); 12 Apr 2023 10:53:10 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-14.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 12 Apr 2023 10:53:10 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 3C8461001B8;
        Wed, 12 Apr 2023 11:53:06 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 2F82C1001B5;
        Wed, 12 Apr 2023 11:53:06 +0100 (BST)
Received: from 6051890f8c81.g08.fujitsu.local (10.167.234.230) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Wed, 12 Apr 2023 11:53:02 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-xfs@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <dan.j.williams@intel.com>, <willy@infradead.org>, <jack@suse.cz>,
        <akpm@linux-foundation.org>, <djwong@kernel.org>
Subject: [RFC PATCH v11.1 2/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Wed, 12 Apr 2023 10:52:15 +0000
Message-ID: <1681296735-2-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
References: <1679996506-2-3-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
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

This is a RFC HOTFIX.

This hotfix adds a exclusive forzen state to make sure any others won't
thaw the fs during xfs_dax_notify_failure():

  #define SB_FREEZE_EXCLUSIVE	(SB_FREEZE_COMPLETE + 2)
Using +2 here is because Darrick's patch[0] is using +1.  So, should we
make these definitions global?

Another thing I can't make up my mind is: when another freezer has freeze
the fs, should we wait unitl it finish, or print a warning in dmesg and
return -EBUSY?

Since there are at least 2 places needs exclusive forzen state, I think
we can refactor helper functions of freeze/thaw for them.  e.g.
  int freeze_super_exclusive(struct super_block *sb, int frozen);
  int thaw_super_exclusive(struct super_block *sb, int frozen);

[0] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?h=repair-fscounters&id=c3a0d1de4d54ffb565dbc7092dfe1fb851940669


--- Original commit message ---
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
event.  Also introduce a exclusive freeze/thaw to lock the filesystem to
prevent new dax mapping from being created.  And do not shutdown
filesystem directly if something not supported, or if failure range
includes metadata area.  Make sure all files and processes are handled
correctly.  Also drop the cache of associated files before pmem is
removed.

[1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c         |   3 +-
 fs/xfs/xfs_notify_failure.c | 151 ++++++++++++++++++++++++++++++++++--
 include/linux/mm.h          |   1 +
 mm/memory-failure.c         |  17 +++-
 4 files changed, 162 insertions(+), 10 deletions(-)

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
index 1e2eddb8f90f..796dd954d33a 100644
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
@@ -92,14 +99,120 @@ xfs_dax_failure_fn(
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
 
+#define SB_FREEZE_EXCLUSIVE	(SB_FREEZE_COMPLETE + 2)
+
+static int
+xfs_dax_notify_failure_freeze(
+	struct xfs_mount	*mp)
+{
+	struct super_block	*sb = mp->m_super;
+	int			error = 0;
+	int			level;
+
+	/* Wait until we're ready to freeze. */
+	down_write(&sb->s_umount);
+	while (sb->s_writers.frozen != SB_UNFROZEN) {
+		up_write(&sb->s_umount);
+
+		// just wait, or print warning in dmesg then return -EBUSY?
+
+		delay(HZ / 10);
+		down_write(&sb->s_umount);
+	}
+
+	if (sb_rdonly(sb)) {
+		sb->s_writers.frozen = SB_FREEZE_EXCLUSIVE;
+		goto out;
+	}
+
+	sb->s_writers.frozen = SB_FREEZE_WRITE;
+	/* Release s_umount to preserve sb_start_write -> s_umount ordering */
+	up_write(&sb->s_umount);
+	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_WRITE - 1);
+	down_write(&sb->s_umount);
+
+	/* Now we go and block page faults... */
+	sb->s_writers.frozen = SB_FREEZE_PAGEFAULT;
+	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_PAGEFAULT - 1);
+
+	/* All writers are done so after syncing there won't be dirty data */
+	error = sync_filesystem(sb);
+	if (error) {
+		sb->s_writers.frozen = SB_UNFROZEN;
+		for (level = SB_FREEZE_PAGEFAULT - 1; level >= 0; level--)
+			percpu_up_write(sb->s_writers.rw_sem + level);
+		wake_up(&sb->s_writers.wait_unfrozen);
+		goto out;
+	}
+
+	/* Now wait for internal filesystem counter */
+	sb->s_writers.frozen = SB_FREEZE_FS;
+	percpu_down_write(sb->s_writers.rw_sem + SB_FREEZE_FS - 1);
+
+	/*
+	 * To prevent anyone else from unfreezing us, set the VFS freeze level
+	 * to one higher than SB_FREEZE_COMPLETE.
+	 */
+	sb->s_writers.frozen = SB_FREEZE_EXCLUSIVE;
+	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
+		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0,
+				_THIS_IP_);
+
+out:
+	up_write(&sb->s_umount);
+	return error;
+}
+
+static void
+xfs_dax_notify_failure_thaw(
+	struct xfs_mount	*mp)
+{
+	struct super_block	*sb = mp->m_super;
+	int			level;
+
+	down_write(&sb->s_umount);
+	if (sb->s_writers.frozen != SB_FREEZE_EXCLUSIVE) {
+		/* somebody snuck in and unfroze us? */
+		ASSERT(0);
+		up_write(&sb->s_umount);
+		return;
+	}
+
+	if (sb_rdonly(sb)) {
+		sb->s_writers.frozen = SB_UNFROZEN;
+		goto out;
+	}
+
+	for (level = 0; level < SB_FREEZE_LEVELS; ++level)
+		percpu_rwsem_acquire(sb->s_writers.rw_sem + level, 0,
+				_THIS_IP_);
+
+	sb->s_writers.frozen = SB_UNFROZEN;
+	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
+		percpu_up_write(sb->s_writers.rw_sem + level);
+
+out:
+	wake_up(&sb->s_writers.wait_unfrozen);
+	up_write(&sb->s_umount);
+}
+
 static int
 xfs_dax_notify_ddev_failure(
 	struct xfs_mount	*mp,
@@ -164,11 +277,22 @@ xfs_dax_notify_ddev_failure(
 	}
 
 	xfs_trans_cancel(tp);
+
+	/* Thaw the fs if it is freezed before. */
+	if (mf_flags & MF_MEM_PRE_REMOVE)
+		xfs_dax_notify_failure_thaw(mp);
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
 
@@ -182,6 +306,7 @@ xfs_dax_notify_failure(
 	struct xfs_mount	*mp = dax_holder(dax_dev);
 	u64			ddev_start;
 	u64			ddev_end;
+	int			error;
 
 	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
@@ -196,6 +321,8 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
@@ -209,6 +336,12 @@ xfs_dax_notify_failure(
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
@@ -225,6 +358,14 @@ xfs_dax_notify_failure(
 	if (offset + len - 1 > ddev_end)
 		len = ddev_end - offset + 1;
 
+	if (mf_flags & MF_MEM_PRE_REMOVE) {
+		xfs_info(mp, "device is about to be removed!");
+		/* Freeze fs to prevent new mappings from being created. */
+		error = xfs_dax_notify_failure_freeze(mp);
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
2.40.0

