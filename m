Return-Path: <linux-fsdevel+bounces-16404-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFA89D134
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CF21F256D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61155E45;
	Tue,  9 Apr 2024 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWoVb8Cd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9770954743;
	Tue,  9 Apr 2024 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633874; cv=none; b=NzibPdJEvaLLx8Va4cp6M0j1d20ScLgqGuj43OUu+Ln4Tz/RxW7gTY6597XFs61RReQalaYco3ZoEuSB3xMJ1OFNjJH96y6vebl350Cf7jo1Cyza/kLFFcvq6I2SxdOr68aDPH2XIRQa/PgHC65M+5sNoe/JSdebP4EdpAY1cXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633874; c=relaxed/simple;
	bh=pSsWFjlk16o8y34SVfySDFfb22LPcXTuC6ggGMv94PU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i6gbjZKgIgLxeGnOrroZj1mCvI8Z3Ipjy0SGcswraWLBNW2xXBiMNwKdblFLOHM/54fxKKUjFmW+HkzVveLYhftyEDTmH/M97VZINgCbPqhngYkBD7vTZf+Q/6LnJvcNaXZr+W5G6Jgb0lNlZ+2LyXdJBVU2ZuJ4ko9UF04sPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWoVb8Cd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1F5C433F1;
	Tue,  9 Apr 2024 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633874;
	bh=pSsWFjlk16o8y34SVfySDFfb22LPcXTuC6ggGMv94PU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rWoVb8Cd7kY84kuiewdj2NuGQ6SG78WYhDEXkbGHdxLlgdzCTv0XsM4w2yv9qN5cv
	 Sb4HN0R1mduz+lIy+1bkQ0STEBHC8uDFCe9JTGBxuAR5qpPjAe1/Pru9NBoAS6o3Po
	 Yq9FIDhD5i34N7Wr/zmmPTqQfI2zjt4qCtyR+ZWxT/ZlfIxiczn5ZE5ZvyRYhz8Smo
	 e+T49kz+W0rPX6U5LlyaY8MT9Q16G+D/wqpaO2Sp71cjmj21JG6opuJtDr04G5pmec
	 HN0fwKmkmPA9WCfsiz5dDo0rjfi/DQhMZV3dMAKsNqXffL2BozytZcODaNAbdDi6Xe
	 Ija1078h7egMg==
Date: Mon, 08 Apr 2024 20:37:53 -0700
Subject: [PATCH 13/14] docs: update swapext -> exchmaps language
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348677.2978056.953162618237376858.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Start reworking the atomic swapext design documentation to refer to its
new file contents/mapping exchange name.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 .../filesystems/xfs/xfs-online-fsck-design.rst     |  259 +++++++++++---------
 1 file changed, 136 insertions(+), 123 deletions(-)


diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
index 1d161752f09ed..3afa1bc5f47ce 100644
--- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
+++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
@@ -2167,7 +2167,7 @@ The ``xfblob_free`` function frees a specific blob, and the ``xfblob_truncate``
 function frees them all because compaction is not needed.
 
 The details of repairing directories and extended attributes will be discussed
-in a subsequent section about atomic extent swapping.
+in a subsequent section about atomic file content exchanges.
 However, it should be noted that these repair functions only use blob storage
 to cache a small number of entries before adding them to a temporary ondisk
 file, which is why compaction is not required.
@@ -2802,7 +2802,8 @@ follows this format:
 
 Repairs for file-based metadata such as extended attributes, directories,
 symbolic links, quota files and realtime bitmaps are performed by building a
-new structure attached to a temporary file and swapping the forks.
+new structure attached to a temporary file and exchanging all mappings in the
+file forks.
 Afterward, the mappings in the old file fork are the candidate blocks for
 disposal.
 
@@ -3851,8 +3852,8 @@ Because file forks can consume as much space as the entire filesystem, repairs
 cannot be staged in memory, even when a paging scheme is available.
 Therefore, online repair of file-based metadata createas a temporary file in
 the XFS filesystem, writes a new structure at the correct offsets into the
-temporary file, and atomically swaps the fork mappings (and hence the fork
-contents) to commit the repair.
+temporary file, and atomically exchanges all file fork mappings (and hence the
+fork contents) to commit the repair.
 Once the repair is complete, the old fork can be reaped as necessary; if the
 system goes down during the reap, the iunlink code will delete the blocks
 during log recovery.
@@ -3862,10 +3863,11 @@ consistent to use a temporary file safely!
 This dependency is the reason why online repair can only use pageable kernel
 memory to stage ondisk space usage information.
 
-Swapping metadata extents with a temporary file requires the owner field of the
-block headers to match the file being repaired and not the temporary file.  The
-directory, extended attribute, and symbolic link functions were all modified to
-allow callers to specify owner numbers explicitly.
+Exchanging metadata file mappings with a temporary file requires the owner
+field of the block headers to match the file being repaired and not the
+temporary file.
+The directory, extended attribute, and symbolic link functions were all
+modified to allow callers to specify owner numbers explicitly.
 
 There is a downside to the reaping process -- if the system crashes during the
 reap phase and the fork extents are crosslinked, the iunlink processing will
@@ -3974,8 +3976,8 @@ The proposed patches are in the
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=repair-tempfiles>`_
 series.
 
-Atomic Extent Swapping
-----------------------
+Logged File Content Exchanges
+-----------------------------
 
 Once repair builds a temporary file with a new data structure written into
 it, it must commit the new changes into the existing file.
@@ -4010,17 +4012,21 @@ e. Old blocks in the file may be cross-linked with another structure and must
 These problems are overcome by creating a new deferred operation and a new type
 of log intent item to track the progress of an operation to exchange two file
 ranges.
-The new deferred operation type chains together the same transactions used by
-the reverse-mapping extent swap code.
+The new exchange operation type chains together the same transactions used by
+the reverse-mapping extent swap code, but records intermedia progress in the
+log so that operations can be restarted after a crash.
+This new functionality is called the file contents exchange (xfs_exchrange)
+code.
+The underlying implementation exchanges file fork mappings (xfs_exchmaps).
 The new log item records the progress of the exchange to ensure that once an
 exchange begins, it will always run to completion, even there are
 interruptions.
-The new ``XFS_SB_FEAT_INCOMPAT_LOG_ATOMIC_SWAP`` log-incompatible feature flag
+The new ``XFS_SB_FEAT_INCOMPAT_EXCHRANGE`` incompatible feature flag
 in the superblock protects these new log item records from being replayed on
 old kernels.
 
 The proposed patchset is the
-`atomic extent swap
+`file contents exchange
 <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=atomic-file-updates>`_
 series.
 
@@ -4061,72 +4067,73 @@ series.
 | The feature bit will not be cleared from the superblock until the log    |
 | becomes clean.                                                           |
 |                                                                          |
-| Log-assisted extended attribute updates and atomic extent swaps both use |
-| log incompat features and provide convenience wrappers around the        |
+| Log-assisted extended attribute updates and file content exchanges bothe |
+| use log incompat features and provide convenience wrappers around the    |
 | functionality.                                                           |
 +--------------------------------------------------------------------------+
 
-Mechanics of an Atomic Extent Swap
-``````````````````````````````````
+Mechanics of a Logged File Content Exchange
+```````````````````````````````````````````
 
-Swapping entire file forks is a complex task.
+Exchanging contents between file forks is a complex task.
 The goal is to exchange all file fork mappings between two file fork offset
 ranges.
 There are likely to be many extent mappings in each fork, and the edges of
 the mappings aren't necessarily aligned.
-Furthermore, there may be other updates that need to happen after the swap,
+Furthermore, there may be other updates that need to happen after the exchange,
 such as exchanging file sizes, inode flags, or conversion of fork data to local
 format.
-This is roughly the format of the new deferred extent swap work item:
+This is roughly the format of the new deferred exchange-mapping work item:
 
 .. code-block:: c
 
-	struct xfs_swapext_intent {
+	struct xfs_exchmaps_intent {
 	    /* Inodes participating in the operation. */
-	    struct xfs_inode    *sxi_ip1;
-	    struct xfs_inode    *sxi_ip2;
+	    struct xfs_inode    *xmi_ip1;
+	    struct xfs_inode    *xmi_ip2;
 
 	    /* File offset range information. */
-	    xfs_fileoff_t       sxi_startoff1;
-	    xfs_fileoff_t       sxi_startoff2;
-	    xfs_filblks_t       sxi_blockcount;
+	    xfs_fileoff_t       xmi_startoff1;
+	    xfs_fileoff_t       xmi_startoff2;
+	    xfs_filblks_t       xmi_blockcount;
 
 	    /* Set these file sizes after the operation, unless negative. */
-	    xfs_fsize_t         sxi_isize1;
-	    xfs_fsize_t         sxi_isize2;
+	    xfs_fsize_t         xmi_isize1;
+	    xfs_fsize_t         xmi_isize2;
 
-	    /* XFS_SWAP_EXT_* log operation flags */
-	    uint64_t            sxi_flags;
+	    /* XFS_EXCHMAPS_* log operation flags */
+	    uint64_t            xmi_flags;
 	};
 
 The new log intent item contains enough information to track two logical fork
 offset ranges: ``(inode1, startoff1, blockcount)`` and ``(inode2, startoff2,
 blockcount)``.
-Each step of a swap operation exchanges the largest file range mapping possible
-from one file to the other.
-After each step in the swap operation, the two startoff fields are incremented
-and the blockcount field is decremented to reflect the progress made.
-The flags field captures behavioral parameters such as swapping the attr fork
-instead of the data fork and other work to be done after the extent swap.
-The two isize fields are used to swap the file size at the end of the operation
-if the file data fork is the target of the swap operation.
+Each step of an exchange operation exchanges the largest file range mapping
+possible from one file to the other.
+After each step in the exchange operation, the two startoff fields are
+incremented and the blockcount field is decremented to reflect the progress
+made.
+The flags field captures behavioral parameters such as exchanging attr fork
+mappings instead of the data fork and other work to be done after the exchange.
+The two isize fields are used to exchange the file sizes at the end of the
+operation if the file data fork is the target of the operation.
 
-When the extent swap is initiated, the sequence of operations is as follows:
+When the exchange is initiated, the sequence of operations is as follows:
 
-1. Create a deferred work item for the extent swap.
-   At the start, it should contain the entirety of the file ranges to be
-   swapped.
+1. Create a deferred work item for the file mapping exchange.
+   At the start, it should contain the entirety of the file block ranges to be
+   exchanged.
 
 2. Call ``xfs_defer_finish`` to process the exchange.
-   This is encapsulated in ``xrep_tempswap_contents`` for scrub operations.
+   This is encapsulated in ``xrep_tempexch_contents`` for scrub operations.
    This will log an extent swap intent item to the transaction for the deferred
-   extent swap work item.
+   mapping exchange work item.
 
-3. Until ``sxi_blockcount`` of the deferred extent swap work item is zero,
+3. Until ``xmi_blockcount`` of the deferred mapping exchange work item is zero,
 
-   a. Read the block maps of both file ranges starting at ``sxi_startoff1`` and
-      ``sxi_startoff2``, respectively, and compute the longest extent that can
-      be swapped in a single step.
+   a. Read the block maps of both file ranges starting at ``xmi_startoff1`` and
+      ``xmi_startoff2``, respectively, and compute the longest extent that can
+      be exchanged in a single step.
       This is the minimum of the two ``br_blockcount`` s in the mappings.
       Keep advancing through the file forks until at least one of the mappings
       contains written blocks.
@@ -4148,20 +4155,20 @@ When the extent swap is initiated, the sequence of operations is as follows:
 
    g. Extend the ondisk size of either file if necessary.
 
-   h. Log an extent swap done log item for the extent swap intent log item
-      that was read at the start of step 3.
+   h. Log a mapping exchange done log item for th mapping exchange intent log
+      item that was read at the start of step 3.
 
    i. Compute the amount of file range that has just been covered.
       This quantity is ``(map1.br_startoff + map1.br_blockcount -
-      sxi_startoff1)``, because step 3a could have skipped holes.
+      xmi_startoff1)``, because step 3a could have skipped holes.
 
-   j. Increase the starting offsets of ``sxi_startoff1`` and ``sxi_startoff2``
+   j. Increase the starting offsets of ``xmi_startoff1`` and ``xmi_startoff2``
       by the number of blocks computed in the previous step, and decrease
-      ``sxi_blockcount`` by the same quantity.
+      ``xmi_blockcount`` by the same quantity.
       This advances the cursor.
 
-   k. Log a new extent swap intent log item reflecting the advanced state of
-      the work item.
+   k. Log a new mapping exchange intent log item reflecting the advanced state
+      of the work item.
 
    l. Return the proper error code (EAGAIN) to the deferred operation manager
       to inform it that there is more work to be done.
@@ -4172,22 +4179,23 @@ When the extent swap is initiated, the sequence of operations is as follows:
    This will be discussed in more detail in subsequent sections.
 
 If the filesystem goes down in the middle of an operation, log recovery will
-find the most recent unfinished extent swap log intent item and restart from
-there.
-This is how extent swapping guarantees that an outside observer will either see
-the old broken structure or the new one, and never a mismash of both.
+find the most recent unfinished maping exchange log intent item and restart
+from there.
+This is how atomic file mapping exchanges guarantees that an outside observer
+will either see the old broken structure or the new one, and never a mismash of
+both.
 
-Preparation for Extent Swapping
-```````````````````````````````
+Preparation for File Content Exchanges
+``````````````````````````````````````
 
 There are a few things that need to be taken care of before initiating an
-atomic extent swap operation.
+atomic file mapping exchange operation.
 First, regular files require the page cache to be flushed to disk before the
 operation begins, and directio writes to be quiesced.
-Like any filesystem operation, extent swapping must determine the maximum
-amount of disk space and quota that can be consumed on behalf of both files in
-the operation, and reserve that quantity of resources to avoid an unrecoverable
-out of space failure once it starts dirtying metadata.
+Like any filesystem operation, file mapping exchanges must determine the
+maximum amount of disk space and quota that can be consumed on behalf of both
+files in the operation, and reserve that quantity of resources to avoid an
+unrecoverable out of space failure once it starts dirtying metadata.
 The preparation step scans the ranges of both files to estimate:
 
 - Data device blocks needed to handle the repeated updates to the fork
@@ -4201,56 +4209,59 @@ The preparation step scans the ranges of both files to estimate:
   to different extents on the realtime volume, which could happen if the
   operation fails to run to completion.
 
-The need for precise estimation increases the run time of the swap operation,
-but it is very important to maintain correct accounting.
-The filesystem must not run completely out of free space, nor can the extent
-swap ever add more extent mappings to a fork than it can support.
+The need for precise estimation increases the run time of the exchange
+operation, but it is very important to maintain correct accounting.
+The filesystem must not run completely out of free space, nor can the mapping
+exchange ever add more extent mappings to a fork than it can support.
 Regular users are required to abide the quota limits, though metadata repairs
 may exceed quota to resolve inconsistent metadata elsewhere.
 
-Special Features for Swapping Metadata File Extents
-```````````````````````````````````````````````````
+Special Features for Exchanging Metadata File Contents
+``````````````````````````````````````````````````````
 
 Extended attributes, symbolic links, and directories can set the fork format to
 "local" and treat the fork as a literal area for data storage.
 Metadata repairs must take extra steps to support these cases:
 
 - If both forks are in local format and the fork areas are large enough, the
-  swap is performed by copying the incore fork contents, logging both forks,
-  and committing.
-  The atomic extent swap mechanism is not necessary, since this can be done
-  with a single transaction.
+  exchange is performed by copying the incore fork contents, logging both
+  forks, and committing.
+  The atomic file mapping exchange mechanism is not necessary, since this can
+  be done with a single transaction.
 
-- If both forks map blocks, then the regular atomic extent swap is used.
+- If both forks map blocks, then the regular atomic file mapping exchange is
+  used.
 
 - Otherwise, only one fork is in local format.
   The contents of the local format fork are converted to a block to perform the
-  swap.
+  exchange.
   The conversion to block format must be done in the same transaction that
-  logs the initial extent swap intent log item.
-  The regular atomic extent swap is used to exchange the mappings.
-  Special flags are set on the swap operation so that the transaction can be
-  rolled one more time to convert the second file's fork back to local format
-  so that the second file will be ready to go as soon as the ILOCK is dropped.
+  logs the initial mapping exchange intent log item.
+  The regular atomic mapping exchange is used to exchange the metadata file
+  mappings.
+  Special flags are set on the exchange operation so that the transaction can
+  be rolled one more time to convert the second file's fork back to local
+  format so that the second file will be ready to go as soon as the ILOCK is
+  dropped.
 
 Extended attributes and directories stamp the owning inode into every block,
 but the buffer verifiers do not actually check the inode number!
 Although there is no verification, it is still important to maintain
-referential integrity, so prior to performing the extent swap, online repair
-builds every block in the new data structure with the owner field of the file
-being repaired.
+referential integrity, so prior to performing the mapping exchange, online
+repair builds every block in the new data structure with the owner field of the
+file being repaired.
 
-After a successful swap operation, the repair operation must reap the old fork
-blocks by processing each fork mapping through the standard :ref:`file extent
-reaping <reaping>` mechanism that is done post-repair.
+After a successful exchange operation, the repair operation must reap the old
+fork blocks by processing each fork mapping through the standard :ref:`file
+extent reaping <reaping>` mechanism that is done post-repair.
 If the filesystem should go down during the reap part of the repair, the
 iunlink processing at the end of recovery will free both the temporary file and
 whatever blocks were not reaped.
 However, this iunlink processing omits the cross-link detection of online
 repair, and is not completely foolproof.
 
-Swapping Temporary File Extents
-```````````````````````````````
+Exchanging Temporary File Contents
+``````````````````````````````````
 
 To repair a metadata file, online repair proceeds as follows:
 
@@ -4260,14 +4271,14 @@ To repair a metadata file, online repair proceeds as follows:
    file.
    The same fork must be written to as is being repaired.
 
-3. Commit the scrub transaction, since the swap estimation step must be
-   completed before transaction reservations are made.
+3. Commit the scrub transaction, since the exchange resource estimation step
+   must be completed before transaction reservations are made.
 
-4. Call ``xrep_tempswap_trans_alloc`` to allocate a new scrub transaction with
+4. Call ``xrep_tempexch_trans_alloc`` to allocate a new scrub transaction with
    the appropriate resource reservations, locks, and fill out a ``struct
-   xfs_swapext_req`` with the details of the swap operation.
+   xfs_exchmaps_req`` with the details of the exchange operation.
 
-5. Call ``xrep_tempswap_contents`` to swap the contents.
+5. Call ``xrep_tempexch_contents`` to exchange the contents.
 
 6. Commit the transaction to complete the repair.
 
@@ -4309,7 +4320,7 @@ To check the summary file against the bitmap:
 3. Compare the contents of the xfile against the ondisk file.
 
 To repair the summary file, write the xfile contents into the temporary file
-and use atomic extent swap to commit the new contents.
+and use atomic mapping exchange to commit the new contents.
 The temporary file is then reaped.
 
 The proposed patchset is the
@@ -4352,8 +4363,8 @@ Salvaging extended attributes is done as follows:
    memory or there are no more attr fork blocks to examine, unlock the file and
    add the staged extended attributes to the temporary file.
 
-3. Use atomic extent swapping to exchange the new and old extended attribute
-   structures.
+3. Use atomic file mapping exchange to exchange the new and old extended
+   attribute structures.
    The old attribute blocks are now attached to the temporary file.
 
 4. Reap the temporary file.
@@ -4410,7 +4421,8 @@ salvaging directories is straightforward:
    directory and add the staged dirents into the temporary directory.
    Truncate the staging files.
 
-4. Use atomic extent swapping to exchange the new and old directory structures.
+4. Use atomic file mapping exchange to exchange the new and old directory
+   structures.
    The old directory blocks are now attached to the temporary file.
 
 5. Reap the temporary file.
@@ -4542,7 +4554,7 @@ a :ref:`directory entry live update hook <liveupdate>` as follows:
       Instead, we stash updates in the xfarray and rely on the scanner thread
       to apply the stashed updates to the temporary directory.
 
-5. When the scan is complete, atomically swap the contents of the temporary
+5. When the scan is complete, atomically exchange the contents of the temporary
    directory and the directory being repaired.
    The temporary directory now contains the damaged directory structure.
 
@@ -4629,8 +4641,8 @@ directory reconstruction:
 
 5. Copy all non-parent pointer extended attributes to the temporary file.
 
-6. When the scan is complete, atomically swap the attribute fork of the
-   temporary file and the file being repaired.
+6. When the scan is complete, atomically exchange the mappings of the attribute
+   forks of the temporary file and the file being repaired.
    The temporary file now contains the damaged extended attribute structure.
 
 7. Reap the temporary file.
@@ -5105,18 +5117,18 @@ make it easier for code readers to understand what has been built, for whom it
 has been built, and why.
 Please feel free to contact the XFS mailing list with questions.
 
-FIEXCHANGE_RANGE
-----------------
+XFS_IOC_EXCHANGE_RANGE
+----------------------
 
-As discussed earlier, a second frontend to the atomic extent swap mechanism is
-a new ioctl call that userspace programs can use to commit updates to files
-atomically.
+As discussed earlier, a second frontend to the atomic file mapping exchange
+mechanism is a new ioctl call that userspace programs can use to commit updates
+to files atomically.
 This frontend has been out for review for several years now, though the
 necessary refinements to online repair and lack of customer demand mean that
 the proposal has not been pushed very hard.
 
-Extent Swapping with Regular User Files
-```````````````````````````````````````
+File Content Exchanges with Regular User Files
+``````````````````````````````````````````````
 
 As mentioned earlier, XFS has long had the ability to swap extents between
 files, which is used almost exclusively by ``xfs_fsr`` to defragment files.
@@ -5131,12 +5143,12 @@ the consistency of the fork mappings with the reverse mapping index was to
 develop an iterative mechanism that used deferred bmap and rmap operations to
 swap mappings one at a time.
 This mechanism is identical to steps 2-3 from the procedure above except for
-the new tracking items, because the atomic extent swap mechanism is an
-iteration of an existing mechanism and not something totally novel.
+the new tracking items, because the atomic file mapping exchange mechanism is
+an iteration of an existing mechanism and not something totally novel.
 For the narrow case of file defragmentation, the file contents must be
 identical, so the recovery guarantees are not much of a gain.
 
-Atomic extent swapping is much more flexible than the existing swapext
+Atomic file content exchanges are much more flexible than the existing swapext
 implementations because it can guarantee that the caller never sees a mix of
 old and new contents even after a crash, and it can operate on two arbitrary
 file fork ranges.
@@ -5147,11 +5159,11 @@ The extra flexibility enables several new use cases:
   Next, it opens a temporary file and calls the file clone operation to reflink
   the first file's contents into the temporary file.
   Writes to the original file should instead be written to the temporary file.
-  Finally, the process calls the atomic extent swap system call
-  (``FIEXCHANGE_RANGE``) to exchange the file contents, thereby committing all
-  of the updates to the original file, or none of them.
+  Finally, the process calls the atomic file mapping exchange system call
+  (``XFS_IOC_EXCHANGE_RANGE``) to exchange the file contents, thereby
+  committing all of the updates to the original file, or none of them.
 
-.. _swapext_if_unchanged:
+.. _exchrange_if_unchanged:
 
 - **Transactional file updates**: The same mechanism as above, but the caller
   only wants the commit to occur if the original file's contents have not
@@ -5160,16 +5172,17 @@ The extra flexibility enables several new use cases:
   change timestamps of the original file before reflinking its data to the
   temporary file.
   When the program is ready to commit the changes, it passes the timestamps
-  into the kernel as arguments to the atomic extent swap system call.
+  into the kernel as arguments to the atomic file mapping exchange system call.
   The kernel only commits the changes if the provided timestamps match the
   original file.
+  A new ioctl (``XFS_IOC_COMMIT_RANGE``) is provided to perform this.
 
 - **Emulation of atomic block device writes**: Export a block device with a
   logical sector size matching the filesystem block size to force all writes
   to be aligned to the filesystem block size.
   Stage all writes to a temporary file, and when that is complete, call the
-  atomic extent swap system call with a flag to indicate that holes in the
-  temporary file should be ignored.
+  atomic file mapping exchange system call with a flag to indicate that holes
+  in the temporary file should be ignored.
   This emulates an atomic device write in software, and can support arbitrary
   scattered writes.
 
@@ -5251,8 +5264,8 @@ of the file to try to share the physical space with a dummy file.
 Cloning the extent means that the original owners cannot overwrite the
 contents; any changes will be written somewhere else via copy-on-write.
 Clearspace makes its own copy of the frozen extent in an area that is not being
-cleared, and uses ``FIEDEUPRANGE`` (or the :ref:`atomic extent swap
-<swapext_if_unchanged>` feature) to change the target file's data extent
+cleared, and uses ``FIEDEUPRANGE`` (or the :ref:`atomic file content exchanges
+<exchrange_if_unchanged>` feature) to change the target file's data extent
 mapping away from the area being cleared.
 When all other mappings have been moved, clearspace reflinks the space into the
 space collector file so that it becomes unavailable.


