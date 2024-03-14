Return-Path: <linux-fsdevel+bounces-14380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C368C87B6E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 04:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7460F282792
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 03:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B605C83;
	Thu, 14 Mar 2024 03:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O2Eh3lLF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98AE4C9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Mar 2024 03:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387444; cv=none; b=vE/ksJb5NZ7WCjj3/XTHtLZM13ZzAPH0Gb5t1jC2LuHmkTsA9H87v+3s2e7KIRyruA+BksGQrV2ETqYVB0d2dX9a37O6WYuHNN4IcXk+eTD9oHs68tuXSRYECQrzzMJ8GBfGZetORRXc8X0dQSo69vrNvzJfMNdbj/nPJorKb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387444; c=relaxed/simple;
	bh=qdmWg6+2YmWXjID9NQZ9lAUJBUu8LsMBaV+5s/Fw9lA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L410JqojbacpuxakbzECIaxLOaBRCsjMPA3r/w6sb4FOCa0iqm+vqQFY9zydpXniHFCV3pTUS9rlqtAnCdfz0Y6YYUyp2kZjQVHGgkbMsV4CEpg0eGJyTCoNn0sGrr/AjH1i24QnkdaNRijFE3rg/Op6qSd77pQfA/VB2VhkvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O2Eh3lLF; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Mar 2024 23:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710387439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bEZ4V9sjvqMxqEoF4U6YuT83Yq3pCV1X6XT5lYc8MKI=;
	b=O2Eh3lLFzNarFtKYygeLyEQn8AbFzutLv6IXRuw3GSMmeVMnpeHig9Uk/FeodZ2g9kYqq4
	Jxgyjb8ZJVGsmV7hi5nEScKEzJbFxDUtiRM+xUbaQp6iOB01eS7+Wh3vREKRuljOhtiyBw
	S6JpCcTOImRvDN41kYZjb++/Xxxy1Cw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs 6.9 updates v2
Message-ID: <b2cm5vuqgiel2gwdzaxvs7hfjnvio3lu6zcu24wwmzt3xsofow@6zdd466oh7jj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-03-13

for you to fetch changes up to be28368b2ccb328b207c9f66c35bb088d91e6a03:

  bcachefs: time_stats: shrink time_stat_buffer for better alignment (2024-03-13 21:38:03 -0400)

----------------------------------------------------------------
bcachefs updates for 6.9

 - Subvolume children btree; this is needed for providing a userspace
   interface for walking subvolumes, which will come later
 - Lots of improvements to directory structure checking
 - Improved journal pipelining, significantly improving performance on
   high iodepth write workloads
 - Discard path improvements: the discard path is more efficient, and no
   longer flushes the journal unnecessarily
 - Buffered write path can now avoid taking the inode lock
 - new mm helper: memalloc_flags_{save|restore}
 - mempool now does kvmalloc mempools

----------------------------------------------------------------
Brian Foster (1):
      bcachefs: fix lost journal buf wakeup due to improved pipelining

Calvin Owens (1):
      bcachefs: Silence gcc warnings about arm arch ABI drift

Colin Ian King (1):
      bcachefs: remove redundant assignment to variable ret

Daniel Hill (1):
      bcachefs: rebalance_status now shows correct units

Darrick J. Wong (8):
      bcachefs: thread_with_file: allow creation of readonly files
      bcachefs: thread_with_file: fix various printf problems
      bcachefs: thread_with_file: create ops structure for thread_with_stdio
      bcachefs: thread_with_file: allow ioctls against these files
      bcachefs: time_stats: add larger units
      bcachefs: mean_and_variance: put struct mean_and_variance_weighted on a diet
      bcachefs: time_stats: split stats-with-quantiles into a separate structure
      bcachefs: time_stats: shrink time_stat_buffer for better alignment

Erick Archer (1):
      bcachefs: Prefer struct_size over open coded arithmetic

Guoyu Ou (1):
      bcachefs: skip invisible entries in empty subvolume checking

Hongbo Li (3):
      bcachefs: fix the error code when mounting with incorrect options.
      bcachefs: avoid returning private error code in bch2_xattr_bcachefs_set
      bcachefs: intercept mountoption value for bool type

Kent Overstreet (109):
      bcachefs: journal_seq_blacklist_add() now handles entries being added out of order
      bcachefs: extent_entry_next_safe()
      bcachefs: no_splitbrain_check option
      bcachefs: fix check_inode_deleted_list()
      bcachefs: Fix journal replay with unreadable btree roots
      bcachefs: Fix degraded mode fsck
      bcachefs: Correctly validate k->u64s in btree node read path
      bcachefs: Set path->uptodate when no node at level
      bcachefs: fix split brain message
      bcachefs: Kill unnecessary wakeups in journal reclaim
      bcachefs: Split out journal workqueue
      bcachefs: Avoid setting j->write_work unnecessarily
      bcachefs: Journal writes should be REQ_SYNC|REQ_META
      bcachefs: Avoid taking journal lock unnecessarily
      bcachefs: fixup for building in userspace
      bcachefs: Improve bch2_dirent_to_text()
      bcachefs: Workqueues should be WQ_HIGHPRI
      bcachefs: bch2_hash_set_snapshot() -> bch2_hash_set_in_snapshot()
      bcachefs: Cleanup bch2_dirent_lookup_trans()
      bcachefs: convert journal replay ptrs to darray
      bcachefs: improve journal entry read fsck error messages
      bcachefs: jset_entry_datetime
      bcachefs: bio per journal buf
      bcachefs: closure per journal buf
      bcachefs: better journal pipelining
      bcachefs: btree_and_journal_iter.trans
      bcachefs: btree node prefetching in check_topology
      bcachefs: Subvolumes may now be renamed
      bcachefs: Switch to uuid_to_fsid()
      bcachefs: Initialize super_block->s_uuid
      bcachefs: move fsck_write_inode() to inode.c
      bcachefs: bump max_active on btree_interior_update_worker
      bcachefs: Kill some -EINVALs
      bcachefs: Factor out check_subvol_dirent()
      bcachefs: factor out check_inode_backpointer()
      mm: introduce memalloc_flags_{save,restore}
      mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN
      bcachefs: bch2_inode_insert()
      bcachefs: bch2_lookup() gives better error message on inode not found
      mempool: kvmalloc pool
      bcachefs: kill kvpmalloc()
      bcachefs: thread_with_stdio: eliminate double buffering
      bcachefs: thread_with_stdio: convert to darray
      bcachefs: thread_with_stdio: kill thread_with_stdio_done()
      bcachefs: thread_with_stdio: fix bch2_stdio_redirect_readline()
      bcachefs: Thread with file documentation
      bcachefs: thread_with_stdio: Mark completed in ->release()
      kernel/hung_task.c: export sysctl_hung_task_timeout_secs
      bcachefs: thread_with_stdio: suppress hung task warning
      bcachefs: thread_with_file: Fix missing va_end()
      bcachefs: thread_with_file: add f_ops.flush
      bcachefs: Kill more -EIO error codes
      bcachefs: Check subvol <-> inode pointers in check_subvol()
      bcachefs: Check subvol <-> inode pointers in check_inode()
      bcachefs: check_inode_dirent_inode()
      bcachefs: better log message in lookup_inode_for_snapshot()
      bcachefs: check bi_parent_subvol in check_inode()
      bcachefs: simplify check_dirent_inode_dirent()
      bcachefs: delete duplicated checks in check_dirent_to_subvol()
      bcachefs: check inode->bi_parent_subvol against dirent
      bcachefs: check dirent->d_parent_subvol
      bcachefs: Repair subvol dirents that point to non subvols
      bcachefs: bch_subvolume::parent -> creation_parent
      bcachefs: Fix path where dirent -> subvol missing and we don't fix
      bcachefs: Pass inode bkey to check_path()
      bcachefs: check_path() now prints full inode when reattaching
      bcachefs: Correctly reattach subvolumes
      bcachefs: bch2_btree_bit_mod -> bch2_btree_bit_mod_buffered
      bcachefs: bch2_btree_bit_mod()
      bcachefs: bch_subvolume::fs_path_parent
      bcachefs: BTREE_ID_subvolume_children
      bcachefs: Check for subvolume children when deleting subvolumes
      bcachefs: Pin btree cache in ram for random access in fsck
      bcachefs: Save key_cache_path in peek_slot()
      bcachefs: Track iter->ip_allocated at bch2_trans_copy_iter()
      bcachefs: Use kvzalloc() when dynamically allocating btree paths
      bcachefs: Improve error messages in device remove path
      bcachefs: bch2_print_opts()
      bcachefs: bch2_trigger_alloc() handles state changes better
      bcachefs: bch2_check_subvolume_structure()
      bcachefs: check_path() now only needs to walk up to subvolume root
      bcachefs: more informative write path error message
      bcachefs: Drop redundant btree_path_downgrade()s
      bcachefs: improve bch2_journal_buf_to_text()
      bcachefs: Split out discard fastpath
      bcachefs: Fix journal_buf bitfield accesses
      bcachefs: Add journal.blocked to journal_debug_to_text()
      bcachefs: Errcode tracepoint, documentation
      bcachefs: jset_entry for loops declare loop iter
      bcachefs: Rename journal_keys.d -> journal_keys.data
      bcachefs: journal_keys now uses darray helpers
      bcachefs: improve move_gap()
      bcachefs: split out ignore_blacklisted, ignore_not_dirty
      bcachefs: Fix bch2_journal_noflush_seq()
      fs: file_remove_privs_flags()
      bcachefs: Buffered write path now can avoid the inode lock
      bcachefs: Split out bkey_types.h
      bcachefs: copy_(to|from)_user_errcode()
      lib/generic-radix-tree.c: Make nodes more reasonably sized
      bcachefs: fix bch2_journal_buf_to_text()
      bcachefs: Check for writing superblocks with nonsense member seq fields
      bcachefs: Kill unused flags argument to btree_split()
      bcachefs: fix deletion of indirect extents in btree_gc
      bcachefs: Fix order of gc_done passes
      bcachefs: Always flush write buffer in delete_dead_inodes()
      bcachefs: Fix btree key cache coherency during replay
      bcachefs: fix bch_folio_sector padding
      bcachefs: reconstruct_alloc cleanup
      bcachefs: pull out time_stats.[ch]

Li Zetao (1):
      bcachefs: Fix null-ptr-deref in bch2_fs_alloc()

Thomas Bertschinger (1):
      bcachefs: omit alignment attribute on big endian struct bkey

 Documentation/filesystems/bcachefs/errorcodes.rst |  30 +
 MAINTAINERS                                       |   1 +
 fs/bcachefs/Makefile                              |   4 +
 fs/bcachefs/alloc_background.c                    | 219 ++++--
 fs/bcachefs/alloc_background.h                    |   1 +
 fs/bcachefs/alloc_foreground.c                    |  13 +-
 fs/bcachefs/backpointers.c                        | 143 ++--
 fs/bcachefs/bbpos_types.h                         |   2 +-
 fs/bcachefs/bcachefs.h                            |  21 +-
 fs/bcachefs/bcachefs_format.h                     |  53 +-
 fs/bcachefs/bkey.h                                | 207 +-----
 fs/bcachefs/bkey_types.h                          | 213 ++++++
 fs/bcachefs/btree_cache.c                         |  37 +-
 fs/bcachefs/btree_gc.c                            | 151 ++--
 fs/bcachefs/btree_io.c                            |  22 +-
 fs/bcachefs/btree_iter.c                          |  20 +-
 fs/bcachefs/btree_journal_iter.c                  | 180 +++--
 fs/bcachefs/btree_journal_iter.h                  |  14 +-
 fs/bcachefs/btree_key_cache.c                     |   8 +-
 fs/bcachefs/btree_locking.c                       |   3 +-
 fs/bcachefs/btree_types.h                         |   9 +-
 fs/bcachefs/btree_update.c                        |  23 +-
 fs/bcachefs/btree_update.h                        |   3 +-
 fs/bcachefs/btree_update_interior.c               |  83 ++-
 fs/bcachefs/btree_update_interior.h               |   2 +
 fs/bcachefs/btree_write_buffer.c                  |   4 +-
 fs/bcachefs/buckets.c                             |  32 +-
 fs/bcachefs/chardev.c                             |  57 +-
 fs/bcachefs/checksum.c                            |   2 +-
 fs/bcachefs/compress.c                            |  14 +-
 fs/bcachefs/debug.c                               |   6 +-
 fs/bcachefs/dirent.c                              | 143 ++--
 fs/bcachefs/dirent.h                              |   6 +-
 fs/bcachefs/ec.c                                  |   4 +-
 fs/bcachefs/errcode.c                             |  15 +-
 fs/bcachefs/errcode.h                             |  18 +-
 fs/bcachefs/error.c                               |  10 +-
 fs/bcachefs/error.h                               |   2 +-
 fs/bcachefs/extents.h                             |  11 +-
 fs/bcachefs/fifo.h                                |   4 +-
 fs/bcachefs/fs-common.c                           |  74 +-
 fs/bcachefs/fs-io-buffered.c                      | 149 +++-
 fs/bcachefs/fs-io-pagecache.h                     |   9 +-
 fs/bcachefs/fs.c                                  | 222 ++++--
 fs/bcachefs/fsck.c                                | 847 ++++++++++++++--------
 fs/bcachefs/fsck.h                                |   1 +
 fs/bcachefs/inode.c                               |  55 +-
 fs/bcachefs/inode.h                               |  19 +
 fs/bcachefs/io_read.c                             |   2 +-
 fs/bcachefs/io_write.c                            |  18 +-
 fs/bcachefs/journal.c                             | 280 ++++---
 fs/bcachefs/journal.h                             |   7 +-
 fs/bcachefs/journal_io.c                          | 403 +++++-----
 fs/bcachefs/journal_io.h                          |  47 +-
 fs/bcachefs/journal_reclaim.c                     |  29 +-
 fs/bcachefs/journal_seq_blacklist.c               |  69 +-
 fs/bcachefs/journal_types.h                       |  30 +-
 fs/bcachefs/lru.c                                 |   7 +-
 fs/bcachefs/mean_and_variance.c                   |  28 +-
 fs/bcachefs/mean_and_variance.h                   |  14 +-
 fs/bcachefs/mean_and_variance_test.c              |  80 +-
 fs/bcachefs/migrate.c                             |   8 +-
 fs/bcachefs/opts.c                                |   8 +-
 fs/bcachefs/opts.h                                |  10 +
 fs/bcachefs/rebalance.c                           |   4 +-
 fs/bcachefs/recovery.c                            |  88 ++-
 fs/bcachefs/recovery_types.h                      |   2 +
 fs/bcachefs/sb-clean.c                            |  16 -
 fs/bcachefs/sb-downgrade.c                        |  10 +-
 fs/bcachefs/sb-errors_types.h                     |  19 +-
 fs/bcachefs/str_hash.h                            |  15 +-
 fs/bcachefs/subvolume.c                           | 187 ++++-
 fs/bcachefs/subvolume.h                           |   8 +-
 fs/bcachefs/subvolume_format.h                    |   4 +-
 fs/bcachefs/super-io.c                            |  22 +-
 fs/bcachefs/super.c                               |  93 ++-
 fs/bcachefs/sysfs.c                               |   4 +-
 fs/bcachefs/thread_with_file.c                    | 391 +++++++---
 fs/bcachefs/thread_with_file.h                    |  59 +-
 fs/bcachefs/thread_with_file_types.h              |  15 +-
 fs/bcachefs/time_stats.c                          | 165 +++++
 fs/bcachefs/time_stats.h                          | 159 ++++
 fs/bcachefs/trace.h                               |  19 +
 fs/bcachefs/util.c                                | 227 +-----
 fs/bcachefs/util.h                                | 142 +---
 fs/bcachefs/xattr.c                               |   5 +-
 fs/inode.c                                        |   7 +-
 include/linux/fs.h                                |   1 +
 include/linux/generic-radix-tree.h                |  29 +-
 include/linux/mempool.h                           |  13 +
 include/linux/sched.h                             |   4 +-
 include/linux/sched/mm.h                          |  60 +-
 kernel/hung_task.c                                |   1 +
 lib/generic-radix-tree.c                          |  35 +-
 mm/mempool.c                                      |  13 +
 95 files changed, 3770 insertions(+), 2253 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/errorcodes.rst
 create mode 100644 fs/bcachefs/bkey_types.h
 create mode 100644 fs/bcachefs/time_stats.c
 create mode 100644 fs/bcachefs/time_stats.h

