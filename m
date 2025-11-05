Return-Path: <linux-fsdevel+bounces-67024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC38C33845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 01:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B93D465310
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 00:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBFB23B63E;
	Wed,  5 Nov 2025 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkcylQCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D416E2367B3;
	Wed,  5 Nov 2025 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762303721; cv=none; b=FRWCoEnY3WL651MkYIC48w86s5qItsrS59LpvPJ9ZoMOJEs0tIwQi4aOLcZcXplMTFyVr7595tpKr6dvkGUiKu3fPbcnhuUKX2JtHSzdfcTMAkcb5LMpKhMc0a/nTkK8MycRciRFZr991NlSZsfXU7E8NSiZNwK2AA5TP+2H5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762303721; c=relaxed/simple;
	bh=12h+1UAH0Uxpz5MQuH4PpjOXDz6+8yjersdXazWhlqA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H57IO3i64blVMvQHcMTbDcQP+OYcp/NMw+fjDrRKvhEGW1mIHC9/3lONKxeYurKKvFK9dVjj/4nBRCI+RsrS9IGYVlh5xESBrdiJlr4jYyzogzVAd0hsfhZN49zknGfgjk5lg2SYNcMBE9oMlt2K+vRIm3NpP828AvbPZOE4igQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkcylQCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55820C4CEF7;
	Wed,  5 Nov 2025 00:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762303721;
	bh=12h+1UAH0Uxpz5MQuH4PpjOXDz6+8yjersdXazWhlqA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UkcylQCZU3tVsivnlW7Sdun1/GWiRt9T458UFdAeYHDh97PLvxjgFVgHnFcc/yRR8
	 A+Esq4y5rwBz0FoxAE99Dab4Yyt0DOTl7e38XK+5rU+n2G3AoUYMURrkkEbsjBLzZr
	 lwsNfuLs7ZM6lG5YFysDAlpIYXodewCaFd90KufYBLXP9tS5J0K/fvLd+B+bLfgZfV
	 /wxOBmBwhdwD7JQT459k0ESHA+jUtdk5XsnnxlxqRhhN8Ji1PNwYdB85IUeGi8ADtD
	 kIOI8lJTXy5/S8HYll+s0TQI+RPSoqSDExW7+RCIbdJPDDUwHgowf7ksGH4sPVwrVM
	 pM5x0B7k1cjyA==
Date: Tue, 04 Nov 2025 16:48:40 -0800
Subject: [PATCH 01/22] docs: remove obsolete links in the xfs online repair
 documentation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, cem@kernel.org
Cc: hch@lst.de, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <176230365709.1647136.9384258714241175193.stgit@frogsfrogsfrogs>
In-Reply-To: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
References: <176230365543.1647136.3601811429298452884.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Online repair is now merged in upstream, no need to point to patchset
links anymore.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  236 +-------------------
 1 file changed, 6 insertions(+), 230 deletions(-)


diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index 8cbcd3c2643430..189d1f5f40788d 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -105,10 +105,8 @@ occur; this capability aids both strategies.
 TLDR; Show Me the Code!
 -----------------------
 
-Code is posted to the kernel.org git trees as follows:
-`kernel changes <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-symlink>`_,
-`userspace changes <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-media-scan-service>`_, and
-`QA test changes <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=repair-dirs>`_.
+Kernel and userspace code has been fully merged as of October 2025.
+
 Each kernel patchset adding an online repair function will use the same branch
 name across the kernel, xfsprogs, and fstests git repos.
 
@@ -764,12 +762,8 @@ allow the online fsck developers to compare online fsck against offline fsck,
 and they enable XFS developers to find deficiencies in the code base.
 
 Proposed patchsets include
-`general fuzzer improvements
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuzzer-improvements>`_,
 `fuzzing baselines
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuzz-baseline>`_,
-and `improvements in fuzz testing comprehensiveness
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=more-fuzz-testing>`_.
+<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fuzz-baseline>`_.
 
 Stress Testing
 --------------
@@ -801,11 +795,6 @@ Success is defined by the ability to run all of these tests without observing
 any unexpected filesystem shutdowns due to corrupted metadata, kernel hang
 check warnings, or any other sort of mischief.
 
-Proposed patchsets include `general stress testing
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes>`_
-and the `evolution of existing per-function stress testing
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-scrub-stress>`_.
-
 4. User Interface
 =================
 
@@ -886,10 +875,6 @@ apply as nice of a priority to IO and CPU scheduling as possible.
 This measure was taken to minimize delays in the rest of the filesystem.
 No such hardening has been performed for the cron job.
 
-Proposed patchset:
-`Enabling the xfs_scrub background service
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-media-scan-service>`_.
-
 Health Reporting
 ----------------
 
@@ -912,13 +897,6 @@ notifications and initiate a repair?
 *Answer*: These questions remain unanswered, but should be a part of the
 conversation with early adopters and potential downstream users of XFS.
 
-Proposed patchsets include
-`wiring up health reports to correction returns
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=corruption-health-reports>`_
-and
-`preservation of sickness info during memory reclaim
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=indirect-health-reporting>`_.
-
 5. Kernel Algorithms and Data Structures
 ========================================
 
@@ -1310,21 +1288,6 @@ Space allocation records are cross-referenced as follows:
      are there the same number of reverse mapping records for each block as the
      reference count record claims?
 
-Proposed patchsets are the series to find gaps in
-`refcount btree
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-refcount-gaps>`_,
-`inode btree
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-inobt-gaps>`_, and
-`rmap btree
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-rmapbt-gaps>`_ records;
-to find
-`mergeable records
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-detect-mergeable-records>`_;
-and to
-`improve cross referencing with rmap
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-strengthen-rmap-checking>`_
-before starting a repair.
-
 Checking Extended Attributes
 ````````````````````````````
 
@@ -1756,10 +1719,6 @@ For scrub, the drain works as follows:
 To avoid polling in step 4, the drain provides a waitqueue for scrub threads to
 be woken up whenever the intent count drops to zero.
 
-The proposed patchset is the
-`scrub intent drain series
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-drain-intents>`_.
-
 .. _jump_labels:
 
 Static Keys (aka Jump Label Patching)
@@ -2036,10 +1995,6 @@ The ``xfarray_store_anywhere`` function is used to insert a record in any
 null record slot in the bag; and the ``xfarray_unset`` function removes a
 record from the bag.
 
-The proposed patchset is the
-`big in-memory array
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=big-array>`_.
-
 Iterating Array Elements
 ^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -2172,10 +2127,6 @@ However, it should be noted that these repair functions only use blob storage
 to cache a small number of entries before adding them to a temporary ondisk
 file, which is why compaction is not required.
 
-The proposed patchset is at the start of the
-`extended attribute repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_ series.
-
 .. _xfbtree:
 
 In-Memory B+Trees
@@ -2214,11 +2165,6 @@ xfiles enables reuse of the entire btree library.
 Btrees built atop an xfile are collectively known as ``xfbtrees``.
 The next few sections describe how they actually work.
 
-The proposed patchset is the
-`in-memory btree
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=in-memory-btrees>`_
-series.
-
 Using xfiles as a Buffer Cache Target
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -2459,14 +2405,6 @@ This enables the log to release the old EFI to keep the log moving forwards.
 EFIs have a role to play during the commit and reaping phases; please see the
 next section and the section about :ref:`reaping<reaping>` for more details.
 
-Proposed patchsets are the
-`bitmap rework
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-bitmap-rework>`_
-and the
-`preparation for bulk loading btrees
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-prep-for-bulk-loading>`_.
-
-
 Writing the New Tree
 ````````````````````
 
@@ -2623,11 +2561,6 @@ The number of records for the inode btree is the number of xfarray records,
 but the record count for the free inode btree has to be computed as inode chunk
 records are stored in the xfarray.
 
-The proposed patchset is the
-`AG btree repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
-series.
-
 Case Study: Rebuilding the Space Reference Counts
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -2716,11 +2649,6 @@ Reverse mappings are added to the bag using ``xfarray_store_anywhere`` and
 removed via ``xfarray_unset``.
 Bag members are examined through ``xfarray_iter`` loops.
 
-The proposed patchset is the
-`AG btree repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
-series.
-
 Case Study: Rebuilding File Fork Mapping Indices
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -2757,11 +2685,6 @@ EXTENTS format instead of BMBT, which may require a conversion.
 Third, the incore extent map must be reloaded carefully to avoid disturbing
 any delayed allocation extents.
 
-The proposed patchset is the
-`file mapping repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-file-mappings>`_
-series.
-
 .. _reaping:
 
 Reaping Old Metadata Blocks
@@ -2843,11 +2766,6 @@ blocks.
 As stated earlier, online repair functions use very large transactions to
 minimize the chances of this occurring.
 
-The proposed patchset is the
-`preparation for bulk loading btrees
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-prep-for-bulk-loading>`_
-series.
-
 Case Study: Reaping After a Regular Btree Repair
 ````````````````````````````````````````````````
 
@@ -2943,11 +2861,6 @@ When the walk is complete, the bitmap disunion operation ``(ag_owner_bitmap &
 btrees.
 These blocks can then be reaped using the methods outlined above.
 
-The proposed patchset is the
-`AG btree repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
-series.
-
 .. _rmap_reap:
 
 Case Study: Reaping After Repairing Reverse Mapping Btrees
@@ -2972,11 +2885,6 @@ methods outlined above.
 The rest of the process of rebuildng the reverse mapping btree is discussed
 in a separate :ref:`case study<rmap_repair>`.
 
-The proposed patchset is the
-`AG btree repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-ag-btrees>`_
-series.
-
 Case Study: Rebuilding the AGFL
 ```````````````````````````````
 
@@ -3024,11 +2932,6 @@ more complicated, because computing the correct value requires traversing the
 forks, or if that fails, leaving the fields invalid and waiting for the fork
 fsck functions to run.
 
-The proposed patchset is the
-`inode
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-inodes>`_
-repair series.
-
 Quota Record Repairs
 --------------------
 
@@ -3045,11 +2948,6 @@ checking are obviously bad limits and timer values.
 Quota usage counters are checked, repaired, and discussed separately in the
 section about :ref:`live quotacheck <quotacheck>`.
 
-The proposed patchset is the
-`quota
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quota>`_
-repair series.
-
 .. _fscounters:
 
 Freezing to Fix Summary Counters
@@ -3145,11 +3043,6 @@ long enough to check and correct the summary counters.
 |   This bug was fixed in Linux 5.17.                                      |
 +--------------------------------------------------------------------------+
 
-The proposed patchset is the
-`summary counter cleanup
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-fscounters>`_
-series.
-
 Full Filesystem Scans
 ---------------------
 
@@ -3277,15 +3170,6 @@ Second, if the incore inode is stuck in some intermediate state, the scan
 coordinator must release the AGI and push the main filesystem to get the inode
 back into a loadable state.
 
-The proposed patches are the
-`inode scanner
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-iscan>`_
-series.
-The first user of the new functionality is the
-`online quotacheck
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quotacheck>`_
-series.
-
 Inode Management
 ````````````````
 
@@ -3381,12 +3265,6 @@ To capture these nuances, the online fsck code has a separate ``xchk_irele``
 function to set or clear the ``DONTCACHE`` flag to get the required release
 behavior.
 
-Proposed patchsets include fixing
-`scrub iget usage
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-iget-fixes>`_ and
-`dir iget usage
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-dir-iget-fixes>`_.
-
 .. _ilocking:
 
 Locking Inodes
@@ -3443,11 +3321,6 @@ If the dotdot entry changes while the directory is unlocked, then a move or
 rename operation must have changed the child's parentage, and the scan can
 exit early.
 
-The proposed patchset is the
-`directory repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
-series.
-
 .. _fshooks:
 
 Filesystem Hooks
@@ -3594,11 +3467,6 @@ The inode scan APIs are pretty simple:
 
 - ``xchk_iscan_teardown`` to finish the scan
 
-This functionality is also a part of the
-`inode scanner
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-iscan>`_
-series.
-
 .. _quotacheck:
 
 Case Study: Quota Counter Checking
@@ -3686,11 +3554,6 @@ needing to hold any locks for a long duration.
 If repairs are desired, the real and shadow dquots are locked and their
 resource counts are set to the values in the shadow dquot.
 
-The proposed patchset is the
-`online quotacheck
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-quotacheck>`_
-series.
-
 .. _nlinks:
 
 Case Study: File Link Count Checking
@@ -3744,11 +3607,6 @@ shadow information.
 If no parents are found, the file must be :ref:`reparented <orphanage>` to the
 orphanage to prevent the file from being lost forever.
 
-The proposed patchset is the
-`file link count repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-nlinks>`_
-series.
-
 .. _rmap_repair:
 
 Case Study: Rebuilding Reverse Mapping Records
@@ -3828,11 +3686,6 @@ scan for reverse mapping records.
 
 12. Free the xfbtree now that it not needed.
 
-The proposed patchset is the
-`rmap repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rmap-btree>`_
-series.
-
 Staging Repairs with Temporary Files on Disk
 --------------------------------------------
 
@@ -3971,11 +3824,6 @@ Once a good copy of a data file has been constructed in a temporary file, it
 must be conveyed to the file being repaired, which is the topic of the next
 section.
 
-The proposed patches are in the
-`repair temporary files
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-tempfiles>`_
-series.
-
 Logged File Content Exchanges
 -----------------------------
 
@@ -4025,11 +3873,6 @@ The new ``XFS_SB_FEAT_INCOMPAT_EXCHRANGE`` incompatible feature flag
 in the superblock protects these new log item records from being replayed on
 old kernels.
 
-The proposed patchset is the
-`file contents exchange
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates>`_
-series.
-
 +--------------------------------------------------------------------------+
 | **Sidebar: Using Log-Incompatible Feature Flags**                        |
 +--------------------------------------------------------------------------+
@@ -4323,11 +4166,6 @@ To repair the summary file, write the xfile contents into the temporary file
 and use atomic mapping exchange to commit the new contents.
 The temporary file is then reaped.
 
-The proposed patchset is the
-`realtime summary repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-rtsummary>`_
-series.
-
 Case Study: Salvaging Extended Attributes
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -4369,11 +4207,6 @@ Salvaging extended attributes is done as follows:
 
 4. Reap the temporary file.
 
-The proposed patchset is the
-`extended attribute repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-xattrs>`_
-series.
-
 Fixing Directories
 ------------------
 
@@ -4448,11 +4281,6 @@ Unfortunately, the current dentry cache design doesn't provide a means to walk
 every child dentry of a specific directory, which makes this a hard problem.
 There is no known solution.
 
-The proposed patchset is the
-`directory repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-dirs>`_
-series.
-
 Parent Pointers
 ```````````````
 
@@ -4612,11 +4440,6 @@ a :ref:`directory entry live update hook <liveupdate>` as follows:
 
 7. Reap the temporary directory.
 
-The proposed patchset is the
-`parent pointers directory repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=pptrs-fsck>`_
-series.
-
 Case Study: Repairing Parent Pointers
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -4662,11 +4485,6 @@ directory reconstruction:
 
 8. Reap the temporary file.
 
-The proposed patchset is the
-`parent pointers repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=pptrs-fsck>`_
-series.
-
 Digression: Offline Checking of Parent Pointers
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -4755,11 +4573,6 @@ connectivity checks:
 
 4. Move on to examining link counts, as we do today.
 
-The proposed patchset is the
-`offline parent pointers repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=pptrs-fsck>`_
-series.
-
 Rebuilding directories from parent pointers in offline repair would be very
 challenging because xfs_repair currently uses two single-pass scans of the
 filesystem during phases 3 and 4 to decide which files are corrupt enough to be
@@ -4903,12 +4716,6 @@ Repairing the directory tree works as follows:
 
 6. If the subdirectory has zero paths, attach it to the lost and found.
 
-The proposed patches are in the
-`directory tree repair
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=scrub-directory-tree>`_
-series.
-
-
 .. _orphanage:
 
 The Orphanage
@@ -4973,11 +4780,6 @@ Orphaned files are adopted by the orphanage as follows:
 7. If a runtime error happens, call ``xrep_adoption_cancel`` to release all
    resources.
 
-The proposed patches are in the
-`orphanage adoption
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-orphanage>`_
-series.
-
 6. Userspace Algorithms and Data Structures
 ===========================================
 
@@ -5091,14 +4893,6 @@ first workqueue's workers until the backlog eases.
 This doesn't completely solve the balancing problem, but reduces it enough to
 move on to more pressing issues.
 
-The proposed patchsets are the scrub
-`performance tweaks
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-performance-tweaks>`_
-and the
-`inode scan rebalance
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-iscan-rebalance>`_
-series.
-
 .. _scrubrepair:
 
 Scheduling Repairs
@@ -5179,20 +4973,6 @@ immediately.
 Corrupt file data blocks reported by phase 6 cannot be recovered by the
 filesystem.
 
-The proposed patchsets are the
-`repair warning improvements
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-better-repair-warnings>`_,
-refactoring of the
-`repair data dependency
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-repair-data-deps>`_
-and
-`object tracking
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-object-tracking>`_,
-and the
-`repair scheduling
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-repair-scheduling>`_
-improvement series.
-
 Checking Names for Confusable Unicode Sequences
 -----------------------------------------------
 
@@ -5372,6 +5152,8 @@ The extra flexibility enables several new use cases:
   This emulates an atomic device write in software, and can support arbitrary
   scattered writes.
 
+(This functionality was merged into mainline as of 2025)
+
 Vectorized Scrub
 ----------------
 
@@ -5393,13 +5175,7 @@ It is hoped that ``io_uring`` will pick up enough of this functionality that
 online fsck can use that instead of adding a separate vectored scrub system
 call to XFS.
 
-The relevant patchsets are the
-`kernel vectorized scrub
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=vectorized-scrub>`_
-and
-`userspace vectorized scrub
-<https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=vectorized-scrub>`_
-series.
+(This functionality was merged into mainline as of 2025)
 
 Quality of Service Targets for Scrub
 ------------------------------------


