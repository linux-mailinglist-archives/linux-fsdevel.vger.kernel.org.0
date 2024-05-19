Return-Path: <linux-fsdevel+bounces-19724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8238C953E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E771C21236
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 May 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D534D584;
	Sun, 19 May 2024 16:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J3pmek+u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461323FB87
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716135285; cv=none; b=h8fq8pLcKxwj+gaprT2CmrFLGEhZ6Dy2vndIogej9GGpll2s2djThHYPvtl1XaVD1BXKMLWbP6AIAYK66vkNNY6rNtf4gx5Vw5VOCfGz6ttWFvlnBG/84sGGymhkxbkcUOmLwCFDaS6hpEHIKcwYYi+mLGVHbFDhpf/GwJ116d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716135285; c=relaxed/simple;
	bh=qZoQ6UyjODTd1TmCcMMSUfCORrz/Mx5vHmcsbyNJSF4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AFdV17ZvCV2LVRIvVTQl8l1/uF4a8we/5RbLpvWuqhhIlZgfXs6lgS6Mf3TD/gUx40dQ/9YjInR7scQ3/Up7k7IXRqxX3u6b/SzXrVES5yUfuSsX/CSXU62H4RxsuvVO8eHFD3XWJ9+eeEETst0XC7QfkmTSjmKIahgKfHX8w5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J3pmek+u; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716135279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=u8813BbjKlDpJU/WAcwRmww702c8DRufK65oabK/ChY=;
	b=J3pmek+uAbWmpCoBVdBrXg0zcMZ0FhFAwi7wwA7jCHZaTs8gy27z7uL07XcBqakTw1zA2I
	M9fVDHp6e43MJIYFlfuD2q2J0OE2BB1rhaKX6G5lJdnFWqAzTG2Z3q08sChvKW7XbtPC2+
	7L4BGq5+dWNSZuBL5LIN0m31hg41Sq0=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 19 May 2024 12:14:34 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs updates fro 6.10-rc1
Message-ID: <zhtllemg2gcex7hwybjzoavzrsnrwheuxtswqyo3mn2dlhsxbx@dkfnr5zx3r2x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT



The following changes since commit 6e297a73bccf852e7716207caa8eb868737c7155:

  bcachefs: Add missing sched_annotate_sleep() in bch2_journal_flush_seq_async() (2024-05-07 11:02:37 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-19

for you to fetch changes up to 07f9a27f1969764d11374942961d51fee0ab628f:

  bcachefs: add no_invalid_checks flag (2024-05-09 16:24:30 -0400)

----------------------------------------------------------------
bcachefs changes for 6.10-rc1

- More safety fixes, primarily found by syzbot

- Run the upgrade/downgrade paths in nochnages mode. Nochanges mode is
  primarily for testing fsck/recovery in dry run mode, so it shouldn't
  change anything besides disabling writes and holding dirty metadata in
  memory.

  The idea here was to reduce the amount of activity if we can't write
  anything out, so that bringing up a filesystem in "super ro" mode
  would be more lilkely to work for data recovery - but norecovery is
  the correct option for this.

- btree_trans->locked; we now track whether a btree_trans has any btree
  nodes locked, and this is used for improved assertions related to
  trans_unlock() and trans_relock(). We'll also be using it for
  improving how we work with lockdep in the future: we don't want
  lockdep to be tracking individual btree node locks because we take too
  many for lockdep to track, and it's not necessary since we have a
  cycle detector.

- Trigger improvements that are prep work for online fsck

- BTREE_TRIGGER_check_repair; this regularizes how we do some repair
  work for extents that goes with running triggers in fsck, and fixes
  some subtle issues with transaction restarts there.

- bch2_snapshot_equiv() has now been ripped out of fsck.c; snapshot
  equivalence classes are for when snapshot deletion leaves behind
  redundant snapshot nodes, but snapshot deletion now cleans this up
  right away, so the abstraction doesn't need to leak.

- Improvements to how we resume writing to the journal in recovery. The
  code for picking the new place to write when reading the journal is
  greatly simplified and we also store the position in the superblock
  for when we don't read the journal; this means that we preserve more
  of the journal for list_journal debugging.

- Improvements to sysfs btree_cache and btree_node_cache, for debugging
  memory reclaim.

- We now detect when we've blocked for 10 seconds on the allocator in
  the write path and dump some useful info.

- Safety fixes for devices references: this is a big series that changes
  almost all device lookups to properly check if the device exists and
  take a reference to it.

  Previously we assumed that if a bkey exists that references a device
  then the device must exist, and this was enforced in .invalid methods,
  but this was incorrect because it meant device removal relied on
  accounting being correct to not leave keys pointing to invalid
  devices, and that's not something we can assume.

  Getting the "pointer to invalid device" checks out of our .invalid()
  methods fixes some long standing device removal bugs; the only
  outstanding bug with device removal now is a race between the discard
  path and deleting alloc info, which should be easily fixed.

- The allocator now prefers not to expand the new
  member_info.btree_allocated bitmap, meaning if repair ever requires
  scanning for btree nodes (because of a corrupt interior nodes) we
  won't have to scan the whole device(s).

- New coding style document, which among other things talks about the
  correct usage of assertions

----------------------------------------------------------------
Daniel Hill (1):
      bcachefs: add counters for failed shrinker reclaim

Hongbo Li (1):
      bcachefs: eliminate the uninitialized compilation warning in bch2_reconstruct_snapshots

Kent Overstreet (142):
      bcachefs: Fix sb_clean_validate endianness conversion
      bcachefs: Fix needs_whiteout BUG_ON() in bkey_sort()
      bcachefs: bch2_bkey_format_field_overflows()
      bcachefs: Fix xattr_to_text() unsafety
      bcachefs: Better write_super() error messages
      bcachefs: Run upgrade/downgrade even in -o nochanges mode
      bcachefs: printbuf improvements
      bcachefs: printbufs: prt_printf() now handles \t\r\n
      bcachefs: prt_printf() now respects \r\n\t
      bcachefs: bch2_btree_node_header_to_text()
      bcachefs: bch2_journal_keys_dump()
      bcachefs: bch2_hash_lookup() now returns bkey_s_c
      bcachefs: add btree_node_merging_disabled debug param
      bcachefs: bch2_btree_path_to_text()
      bcachefs: New assertion for writing to the journal after shutdown
      bcachefs: allow for custom action in fsck error messages
      bcachefs: Don't read journal just for fsck
      bcachefs: When traversing to interior nodes, propagate result to paths to same leaf node
      bcachefs: kill for_each_btree_key_old()
      bcachefs: for_each_btree_key_continue()
      bcachefs: bch2_gc() is now private to btree_gc.c
      bcachefs: Finish converting reconstruct_alloc to errors_silent
      bcachefs: kill metadata only gc
      bcachefs: move topology repair kick to gc_btrees()
      bcachefs: move root node topo checks to node_check_topology()
      bcachefs: gc_btree_init_recurse() uses gc_mark_node()
      bcachefs: mark_superblock cleanup
      bcachefs: __BTREE_ITER_ALL_SNAPSHOTS -> BTREE_ITER_SNAPSHOT_FIELD
      bcachefs: iter/update/trigger/str_hash flag cleanup
      bcachefs: bch2_btree_insert_trans() no longer specifies BTREE_ITER_cached
      bcachefs: bch2_dir_emit() - drop_locks_do() conversion
      bcachefs: bch2_trans_relock_fail() - factor out slowpath
      bcachefs: bucket_valid()
      bcachefs: member helper cleanups
      bcachefs: get_unlocked_mut_path -> bch2_path_get_unlocked_mut
      bcachefs: prefer drop_locks_do()
      bcachefs: bch2_trans_commit_flags_to_text()
      bcachefs: maintain lock invariants in btree_iter_next_node()
      bcachefs: bch2_btree_path_upgrade() checks nodes_locked, not uptodate
      bcachefs: Use bch2_btree_path_upgrade() in key cache traverse
      bcachefs: bch2_trans_unlock() must always be followed by relock() or begin()
      bcachefs: bch2_btree_root_alloc_fake_trans()
      bcachefs: trans->locked
      bcachefs: bch2_btree_path_can_relock()
      bcachefs: bch2_trans_verify_not_unlocked()
      bcachefs: assert that online_reserved == 0 on shutdown
      bcachefs: fs_alloc_debug_to_text()
      bcachefs: Add asserts to bch2_dev_btree_bitmap_marked_sectors()
      bcachefs: Check for writing btree_ptr_v2.sectors_written == 0
      bcachefs: Rip bch2_snapshot_equiv() out of fsck
      bcachefs: make btree read errors silent during scan
      bcachefs: Sync journal when we complete a recovery pass
      bcachefs: fix flag printing in journal_buf_to_text()
      bcachefs: Move gc of bucket.oldest_gen to workqueue
      bcachefs: Btree key cache instrumentation
      bcachefs: Add btree_allocated_bitmap to member_to_text()
      bcachefs: plumb data_type into bch2_bucket_alloc_trans()
      bcachefs: journal seq blacklist gc no longer has to walk btree
      bcachefs: Clean up inode alloc
      bcachefs: bucket_data_type_mismatch()
      bcachefs: mark_stripe_bucket cleanup
      bcachefs: Consolidate mark_stripe_bucket() and trans_mark_stripe_bucket()
      bcachefs: bch2_bucket_ref_update()
      bcachefs: kill gc looping for bucket gens
      bcachefs: Run bch2_check_fix_ptrs() via triggers
      bcachefs: do reflink_p repair from BTREE_TRIGGER_check_repair
      bcachefs: Kill gc_init_recurse()
      bcachefs: fix btree_path_clone() ip_allocated
      bcachefs: uninline set_btree_iter_dontneed()
      bcachefs: bch_member.last_journal_bucket
      bcachefs: check for inodes that should have backpointers in fsck
      bcachefs: check inode backpointer in bch2_lookup()
      bcachefs: Simplify resuming of journal position
      bcachefs: delete old gen check bch2_alloc_write_key()
      bcachefs: dirty_sectors -> replicas_sectors
      bcachefs: alloc_data_type_set()
      bcachefs: kill bch2_dev_usage_update_m()
      bcachefs: __mark_pointer now takes bch_alloc_v4
      bcachefs: __mark_stripe_bucket() now takes bch_alloc_v4
      bcachefs: simplify bch2_trans_start_alloc_update()
      bcachefs: CodingStyle
      bcachefs: Kill opts.buckets_nouse
      bcachefs: On device add, prefer unused slots
      bcachefs: x-macroize journal flags enums
      bcachefs: bch2_bkey_drop_ptrs() declares loop iter
      closures: closure_sync_timeout()
      bcachefs: bch2_print_allocator_stuck()
      bcachefs: New helpers for device refcounts
      bcachefs: Debug asserts for ca->ref
      bcachefs: bch2_dev_safe() -> bch2_dev_rcu()
      bcachefs: Pass device to bch2_alloc_write_key()
      bcachefs: Pass device to bch2_bucket_do_index()
      bcachefs: bch2_dev_btree_bitmap_marked() -> bch2_dev_rcu()
      bcachefs: journal_replay_entry_early() checks for nonexistent device
      bcachefs: bch2_have_enough_devs() checks for nonexistent device
      bcachefs: bch2_dev_tryget()
      bcachefs: Convert to bch2_dev_tryget_noerror()
      bcachefs: bch2_check_alloc_key() -> bch2_dev_tryget_noerror()
      bcachefs: bch2_trigger_alloc() -> bch2_dev_tryget()
      bcachefs: bch2_bucket_ref_update() now takes bch_dev
      bcachefs: bch2_evacuate_bucket() -> bch2_dev_tryget()
      bcachefs: bch2_dev_iterate()
      bcachefs: PTR_BUCKET_POS() now takes bch_dev
      bcachefs: Kill bch2_dev_bkey_exists() in backpointer code
      bcachefs: move replica_set from bch_dev to bch_fs
      bcachefs: ob_dev()
      bcachefs: ec_validate_checksums() -> bch2_dev_tryget()
      bcachefs: bch2_extent_merge() -> bch2_dev_rcu()
      bcachefs: extent_ptr_durability() -> bch2_dev_rcu()
      bcachefs: ptr_stale() -> dev_ptr_stale()
      bcachefs: extent_ptr_invalid() -> bch2_dev_rcu()
      bcachefs: bch2_bkey_has_target() -> bch2_dev_rcu()
      bcachefs: bch2_extent_normalize() -> bch2_dev_rcu()
      bcachefs: kill bch2_dev_bkey_exists() in btree_gc.c
      bcachefs: bch2_dev_bucket_exists() uses bch2_dev_rcu()
      bcachefs: pass bch_dev to read_from_stale_dirty_pointer()
      bcachefs: kill bch2_dev_bkey_exists() in bkey_pick_read_device()
      bcachefs: kill bch2_dev_bkey_exists() in data_update_init()
      bcachefs: bch2_dev_have_ref()
      bcachefs: kill bch2_dev_bkey_exists() in check_alloc_info()
      bcachefs: kill bch2_dev_bkey_exists() in discard_one_bucket_fast()
      bcachefs: kill bch2_dev_bkey_exists() in journal_ptrs_to_text()
      bcachefs: Move nocow unlock to bch2_write_endio()
      bcachefs: Better bucket alloc tracepoints
      bcachefs: Allocator prefers not to expand mi.btree_allocated bitmap
      bcachefs: Improve sysfs internal/btree_cache
      bcachefs: for_each_bset() declares loop iter
      bcachefs: bch2_dev_get_ioref2(); alloc_background.c
      bcachefs: bch2_dev_get_ioref2(); backpointers.c
      bcachefs: bch2_dev_get_ioref2(); btree_io.c
      bcachefs: bch2_dev_get_ioref2(); io_write.c
      bcachefs: bch2_dev_get_ioref2(); journal_io.c
      bcachefs: bch2_dev_get_ioref2(); debug.c
      bcachefs: bch2_dev_get_ioref2(); io_read.c
      bcachefs: bch2_dev_get_ioref() checks for device not present
      bcachefs: kill bch2_dev_bkey_exists() in bch2_read_endio()
      bcachefs: kill bch2_dev_bkey_exists() in bch2_check_fix_ptrs()
      bcachefs: Invalid devices are now checked for by fsck, not .invalid methods
      bcachefs: fsync() should not return -EROFS
      bcachefs: s/bkey_invalid_flags/bch_validate_flags
      bcachefs: Plumb bch_validate_flags to sb_field_ops.validate()
      bcachefs: Fix sb_field_downgrade validation

Kuan-Wei Chiu (1):
      bcachefs: Optimize eytzinger0_sort() with bottom-up heapsort

Lukas Bulwahn (1):
      bcachefs: fix typo in reference to BCACHEFS_DEBUG

Matthew Wilcox (Oracle) (1):
      bcachefs: Remove calls to folio_set_error

Nathan Chancellor (2):
      bcachefs: Fix type of flags parameter for some ->trigger() implementations
      bcachefs: Fix format specifiers in bch2_btree_key_cache_to_text()

Petr Vorel (1):
      bcachefs: Move BCACHEFS_STATFS_MAGIC value to UAPI magic.h

Ricardo B. Marliere (1):
      bcachefs: chardev: make bch_chardev_class constant

Thomas Bertschinger (1):
      bcachefs: add no_invalid_checks flag

Youling Tang (3):
      bcachefs: Change destroy_inode to free_inode
      bcachefs: Fix error path of bch2_link_trans()
      bcachefs: Correct the FS_IOC_GETFLAGS to FS_IOC32_GETFLAGS in bch2_compat_fs_ioctl()

 Documentation/filesystems/bcachefs/CodingStyle.rst |  186 ++++
 Documentation/filesystems/bcachefs/index.rst       |    1 +
 fs/bcachefs/acl.c                                  |   41 +-
 fs/bcachefs/alloc_background.c                     |  337 ++++---
 fs/bcachefs/alloc_background.h                     |  109 ++-
 fs/bcachefs/alloc_foreground.c                     |  304 ++++--
 fs/bcachefs/alloc_foreground.h                     |   15 +-
 fs/bcachefs/alloc_types.h                          |    7 +
 fs/bcachefs/backpointers.c                         |  158 +--
 fs/bcachefs/backpointers.h                         |   43 +-
 fs/bcachefs/bcachefs.h                             |   34 +-
 fs/bcachefs/bcachefs_format.h                      |   10 +-
 fs/bcachefs/bkey.c                                 |   15 +-
 fs/bcachefs/bkey.h                                 |   33 +-
 fs/bcachefs/bkey_methods.c                         |   22 +-
 fs/bcachefs/bkey_methods.h                         |   73 +-
 fs/bcachefs/bkey_sort.c                            |   79 +-
 fs/bcachefs/bkey_sort.h                            |    4 +-
 fs/bcachefs/bset.c                                 |   29 +-
 fs/bcachefs/bset.h                                 |    6 +-
 fs/bcachefs/btree_cache.c                          |  149 ++-
 fs/bcachefs/btree_cache.h                          |    5 +-
 fs/bcachefs/btree_gc.c                             | 1032 ++++----------------
 fs/bcachefs/btree_gc.h                             |   44 +-
 fs/bcachefs/btree_io.c                             |  117 +--
 fs/bcachefs/btree_io.h                             |    2 -
 fs/bcachefs/btree_iter.c                           |  347 ++++---
 fs/bcachefs/btree_iter.h                           |   95 +-
 fs/bcachefs/btree_journal_iter.c                   |   17 +
 fs/bcachefs/btree_journal_iter.h                   |    2 +
 fs/bcachefs/btree_key_cache.c                      |  107 +-
 fs/bcachefs/btree_key_cache_types.h                |    8 +
 fs/bcachefs/btree_locking.c                        |  179 ++--
 fs/bcachefs/btree_locking.h                        |    4 +-
 fs/bcachefs/btree_trans_commit.c                   |   70 +-
 fs/bcachefs/btree_types.h                          |  127 ++-
 fs/bcachefs/btree_update.c                         |   95 +-
 fs/bcachefs/btree_update.h                         |   14 +-
 fs/bcachefs/btree_update_interior.c                |   95 +-
 fs/bcachefs/btree_update_interior.h                |    7 +-
 fs/bcachefs/btree_write_buffer.c                   |    8 +-
 fs/bcachefs/buckets.c                              |  693 ++++++++-----
 fs/bcachefs/buckets.h                              |   70 +-
 fs/bcachefs/chardev.c                              |   66 +-
 fs/bcachefs/checksum.c                             |   17 +-
 fs/bcachefs/data_update.c                          |   54 +-
 fs/bcachefs/debug.c                                |   80 +-
 fs/bcachefs/dirent.c                               |   97 +-
 fs/bcachefs/dirent.h                               |    8 +-
 fs/bcachefs/disk_groups.c                          |   11 +-
 fs/bcachefs/ec.c                                   |  369 +++----
 fs/bcachefs/ec.h                                   |    7 +-
 fs/bcachefs/error.c                                |   59 +-
 fs/bcachefs/extent_update.c                        |    2 +-
 fs/bcachefs/extents.c                              |  151 +--
 fs/bcachefs/extents.h                              |   12 +-
 fs/bcachefs/eytzinger.c                            |  105 +-
 fs/bcachefs/fs-common.c                            |   38 +-
 fs/bcachefs/fs-io-buffered.c                       |   14 +-
 fs/bcachefs/fs-io-direct.c                         |    2 +-
 fs/bcachefs/fs-io-pagecache.c                      |    2 +-
 fs/bcachefs/fs-io.c                                |    9 +-
 fs/bcachefs/fs-ioctl.c                             |    2 +-
 fs/bcachefs/fs.c                                   |  109 ++-
 fs/bcachefs/fsck.c                                 |  212 ++--
 fs/bcachefs/inode.c                                |   64 +-
 fs/bcachefs/inode.h                                |   23 +-
 fs/bcachefs/io_misc.c                              |   10 +-
 fs/bcachefs/io_read.c                              |   68 +-
 fs/bcachefs/io_write.c                             |   95 +-
 fs/bcachefs/io_write_types.h                       |    1 +
 fs/bcachefs/journal.c                              |  131 ++-
 fs/bcachefs/journal.h                              |    6 +-
 fs/bcachefs/journal_io.c                           |  163 ++--
 fs/bcachefs/journal_io.h                           |    5 +-
 fs/bcachefs/journal_reclaim.c                      |   10 +-
 fs/bcachefs/journal_sb.c                           |   10 +-
 fs/bcachefs/journal_seq_blacklist.c                |   77 +-
 fs/bcachefs/journal_seq_blacklist.h                |    2 +-
 fs/bcachefs/journal_types.h                        |   17 +-
 fs/bcachefs/logged_ops.c                           |    2 +-
 fs/bcachefs/lru.c                                  |    4 +-
 fs/bcachefs/lru.h                                  |    2 +-
 fs/bcachefs/migrate.c                              |    8 +-
 fs/bcachefs/move.c                                 |   82 +-
 fs/bcachefs/movinggc.c                             |    4 +-
 fs/bcachefs/opts.h                                 |    7 +-
 fs/bcachefs/printbuf.c                             |  232 +++--
 fs/bcachefs/printbuf.h                             |   53 +-
 fs/bcachefs/quota.c                                |  123 +--
 fs/bcachefs/quota.h                                |    4 +-
 fs/bcachefs/rebalance.c                            |   10 +-
 fs/bcachefs/recovery.c                             |  142 +--
 fs/bcachefs/recovery_passes.c                      |    8 +-
 fs/bcachefs/reflink.c                              |   72 +-
 fs/bcachefs/reflink.h                              |   16 +-
 fs/bcachefs/replicas.c                             |   20 +-
 fs/bcachefs/sb-clean.c                             |   15 +-
 fs/bcachefs/sb-counters.c                          |   20 +-
 fs/bcachefs/sb-downgrade.c                         |   25 +-
 fs/bcachefs/sb-errors.c                            |    2 +-
 fs/bcachefs/sb-errors_types.h                      |    3 +-
 fs/bcachefs/sb-members.c                           |  149 ++-
 fs/bcachefs/sb-members.h                           |  165 +++-
 fs/bcachefs/sb-members_types.h                     |   21 +
 fs/bcachefs/snapshot.c                             |   53 +-
 fs/bcachefs/snapshot.h                             |   16 +-
 fs/bcachefs/str_hash.h                             |   70 +-
 fs/bcachefs/subvolume.c                            |   22 +-
 fs/bcachefs/subvolume.h                            |    7 +-
 fs/bcachefs/super-io.c                             |  117 +--
 fs/bcachefs/super-io.h                             |    3 +-
 fs/bcachefs/super.c                                |  112 ++-
 fs/bcachefs/super_types.h                          |   15 -
 fs/bcachefs/sysfs.c                                |  178 +---
 fs/bcachefs/tests.c                                |   16 +-
 fs/bcachefs/trace.h                                |   97 +-
 fs/bcachefs/util.c                                 |   61 +-
 fs/bcachefs/xattr.c                                |   47 +-
 fs/bcachefs/xattr.h                                |    2 +-
 include/linux/closure.h                            |   12 +
 include/uapi/linux/magic.h                         |    1 +
 lib/closure.c                                      |   37 +
 123 files changed, 4632 insertions(+), 4324 deletions(-)
 create mode 100644 Documentation/filesystems/bcachefs/CodingStyle.rst
 create mode 100644 fs/bcachefs/sb-members_types.h

