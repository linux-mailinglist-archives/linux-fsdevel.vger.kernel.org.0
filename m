Return-Path: <linux-fsdevel+bounces-39709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C51A17210
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEBE3A6948
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC31EE00F;
	Mon, 20 Jan 2025 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mlCdo/eH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566331EC017
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 17:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394730; cv=none; b=HEncM+5vMAie7lB+QMZToNje+YTGKBsqy6wXvtb9SCA3ZVvSNjMqOK+NEpeSD44LrxFmm1GhHu+/Fh7fNBzCma2HCOUEttvWdqFC243ceb7+0nRzE2gO2AgONIUj83CTLEO8B1giBjypU1A1Q+ArdypH8s2oQEQH5rVWzmS1av4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394730; c=relaxed/simple;
	bh=KJ67dXXE7HyoJ4oX1teLkVEw2VpTFZWc42FJLeQLaL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6bSnwx1lT3Z39+EFMOuRLChweP+xwM7s2eIRRHGzpuP1F1zkfrt/7IATD1gGMTZtu6hLhvmqVQGpfrfpFDF/Fq6u3wM4pBrdeemqxHYFhCr89Yuwn+6wOM9LLDN6D0Qt9PJbu8Qn2hdFJ/ge4oRz7navF0pY/rkgwacM1Lh4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mlCdo/eH; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 20 Jan 2025 12:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737394709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPytVeaMra66tEQ/paj48Ep+Q0ePMCDVLvXrZXfVgug=;
	b=mlCdo/eHeZdne9xsyXU7SJODqp3wErfjsffgfwPuviIRyuTXVcDFinRN+ZY7UqFGsz1TMx
	6lq880gEbi3JEdszs7DwXRiE0HNtAYz1tnP4wEzgjOuB/gbiR69l/aW6neup0c76kNzEHC
	sMlktIaEqLIYm/H+1blROU5Xery0LpU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.14-rc1
Message-ID: <h6ibklgumu7ug77lhuruqnhtp7dftc36pgqryz5ha6igzgm5sq@bdxgtyrow2cv>
References: <mk2up66w3w4procezp2qeehkxq2ie5oyydvcowedd2fkltxbhh@yvuqt3jdjood>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mk2up66w3w4procezp2qeehkxq2ie5oyydvcowedd2fkltxbhh@yvuqt3jdjood>
X-Migadu-Flow: FLOW_OUT

Botched the first one...

The following changes since commit 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8:

  Linux 6.13-rc3 (2024-12-15 15:58:23 -0800)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-01-20.2

for you to fetch changes up to ff0b7ed607e779f0e109f7f24388e0ce07af2ebe:

  bcachefs: Fix check_inode_hash_info_matches_root() (2025-01-15 15:28:23 -0500)

----------------------------------------------------------------
bcachefs updates for 6.14-rc1

Lots of scalability work, another big on disk format change. On disk
format version goes from 1.13 to 1.20.

Like 6.11, this is another big and expensive automatic/required on disk
format upgrade. This is planned to be the last big on disk format
upgrade before the experimental label comes off. There will be one more
minor on disk format update for a few things that couldn't make this
release.

Headline improvements:
- Fix mount time regression that some users encountered post the 6.11
  disk accounting rewrite.

  Accounting keys were encoded little endian (typetag in the low bits) -
  which didn't anticipate adding accounting keys for every inode, which
  aren't stored in memory and we don't want to scan at mount time.

- fsck time on large filesystems is improved by multiple orders of
  magnitude. Previously, 100TB was about the practical max filesystem
  size, where users were reporting fsck times of a day+. With the new
  changes (which nearly eliminate backpointers fsck overhead), we fsck'd
  a filesystem with 10PB of data in 1.5 hours.

  The problematic fsck passes were walking every extent and checking for
  missing backpointers, and walking every backpointer to check for
  dangling backpointers. As we've been adding more and more runtime self
  healing there was no reason to keep around the backpointers -> extents
  pass; dangling backpointers are just deleted, and we can do that when
  using them - thus, backpointers -> extents is now only run in debug
  mode.

  extents -> backpointers does need to exist, since missing backpointers
  would mean we can't find data to move it (for e.g. copygc, device
  evacuate, scrub). But the new on disk format version makes possible a
  new strategy where we sum up backpointers within a bucket and check it
  against the bucket sector counts, and then only scan for missing
  backpointers if the counts are off (and then, only for specific
  buckets).

Full list of on disk format changes:
- 1.14: backpointer_bucket_gen
  Backpointers now have a field for the bucket generation number,
  replacing the obsolete bucket_offset field. This is needed for the
  new "sum up backpointers within a bucket" code, since backpointers use
  the btree write buffer - meaning we will see stale reads, and this
  runs online, with the filesystem in full rw mode.

- 1.15: disk_accounting_big_endian
  As previously described, fix the endianness of accounting keys so that
  accounting keys with the same typetag sort together, and accounting
  read can skip types it's not interested in.

- 1.16: reflink_p_may_update_opts:
  This version indicates that a new reflink pointer field is understood
  and may be used; the field indicates whether the reflink pointer has
  permissions to update IO path options (e.g. compression, replicas) may
  be updated on the indirect extent it points to.

  This completes the rebalance/reflink data path option handling from
  the 6.13 pull request.

- 1.17: inode_depth
  Add a new inode field, bi_depth, to accelerate the
  check_directory_structure fsck path, which checks for loops in the
  filesystem heirarchy.

  check_inodes and check_dirents check connectivity, so
  check_directory_structure only has to check for loops - by walking
  back up to the root from every directory.

  But a path can't be a loop if it has a counter that increases
  monotonically from root to leaf - adding a depth counter means that we
  can check for loops with only local (parent -> child) checks. We might
  need to occasionally renumber the depth field in fsck if directories
  have been moved around, but then future fsck runs will be much faster.

- 1.18: persistent_inode_cursors

  Previously, the cursor used for inode allocation was only kept in
  memory, which meant that users with large filesystems and lots of
  files were reporting that the first create after mounting would take
  awhile - since it had to scan from the start.

  Inode allocation cursors are now persistent, and also include a
  generation field (incremented on wraparound, which will only happen if
  inode allocation is restricted to 32 bit inodes), so that we don't
  have to leave inode_generation keys around after a delete.

  The option for 32 bit inode numbers may now also be set on individual
  directories, and non-32 bit inode allocations are disallowed from
  allocating from the 32 bit part of the inode number space.

- 1.19: autofix_errors

  Runtime self healing is now the default.o

- 1.20: directory size (from Hongbo)

  directory i_size is now meaningful, and not 0.

Release notes from the previous 6.13 pull request:

- Self healing work:
  Allocator and reflink now run the exact same check/repair code that
  fsck does at runtime, where applicable.

  The long term goal here is to remove inconsistent() errors (that cause
  us to go emergency read only) by lifting fsck code up to normal
  runtime paths; we should only go emergency read-only if we detect an
  inconsistency that was due to a runtime bug - or truly catastrophic
  damage (corrupted btree roots/interior nodes).

- Reflink repair no longer deletes reflink pointers: instead we flip an
  error bit and log the error, and they can still be deleted by file
  deletion. This means a temporary failure to find an indirect extent
  (perhaps repaired later by btree node scan) won't result in
  unnecessary data loss

- Improvements to rebalance data path option handling: we can now
  correctly apply changed filesystem-level io path options to pending
  rebalance work, and soon we'll be able to apply file-level io path
  option changes to indirect extents.

----------------------------------------------------------------
Alan Huang (8):
      bcachefs: Delete dead code
      Revert "bcachefs: Fix bch2_btree_node_upgrade()"
      bcachefs: Merge the condition to avoid additional invocation
      bcachefs: Do not allow no fail lock request to fail
      bcachefs: Convert open-coded lock_graph_pop_all to helper
      bcachefs: Introduce lock_graph_pop_from
      bcachefs: Only abort the transactions in the cycle
      bcachefs: Pop all the transactions from the abort one

Colin Ian King (1):
      bcachefs: remove superfluous ; after statements

Dennis Lam (1):
      docs: filesystems: bcachefs: fixed some spelling mistakes in the bcachefs coding style page

Geert Uytterhoeven (1):
      bcachefs: BCACHEFS_PATH_TRACEPOINTS should depend on TRACING

Hongbo Li (5):
      bcachefs: remove write permission for gc_gens_pos sysfs interface
      bcachefs: use attribute define helper for sysfs attribute
      bcachefs: add counter_flags for counters
      bcachefs: make directory i_size meaningful
      bcachefs: bcachefs_metadata_version_directory_size

Integral (1):
      bcachefs: add support for true/false & yes/no in bool-type options

Kent Overstreet (239):
      bcachefs: kill retry_estale() in bch2_ioctl_subvolume_create()
      Merge branch 'bcachefs-kill-retry-estale' into HEAD
      bcachefs: Fix racy use of jiffies
      bcachefs: bch2_inode_should_have_bp -> bch2_inode_should_have_single_bp
      bcachefs: remove_backpointer() now uses dirent_get_by_pos()
      bcachefs: __bch2_key_has_snapshot_overwrites uses for_each_btree_key_reverse_norestart()
      bcachefs: rcu_pending: don't invoke __call_rcu() under lock
      bcachefs: bch_verbose_ratelimited
      bcachefs: Pull disk accounting hooks out of trans_commit.c
      bcachefs: Remove unnecessary peek_slot()
      bcachefs: kill btree_trans_restart_nounlock()
      bcachefs: add more path idx debug asserts
      bcachefs: bch2_run_explicit_recovery_pass() returns different error when not in recovery
      bcachefs: lru, accounting are alloc btrees
      bcachefs: Add locking for bch_fs.curr_recovery_pass
      bcachefs: bch2_btree_lost_data() now uses run_explicit_rceovery_pass_persistent()
      bcachefs: improved bkey_val_copy()
      bcachefs: Factor out jset_entry_log_msg_bytes()
      bcachefs: better error message in check_snapshot_tree()
      bcachefs: Avoid bch2_btree_id_str()
      bcachefs: Refactor new stripe path to reduce dependencies on ec_stripe_head
      bcachefs: -o norecovery now bails out of recovery earlier
      bcachefs: bch2_journal_meta() takes ref on c->writes
      bcachefs: Fix warning about passing flex array member by value
      bcachefs: Add block plugging to read paths
      bcachefs: Add version check for bch_btree_ptr_v2.sectors_written validate
      bcachefs: avoid 'unsigned flags'
      bcachefs: use bch2_data_update_opts_to_text() in trace_move_extent_fail()
      bcachefs: bch2_io_opts_fixups()
      bcachefs: small cleanup for extent ptr bitmasks
      bcachefs: kill bch2_bkey_needs_rebalance()
      bcachefs: kill __bch2_bkey_sectors_need_rebalance()
      bcachefs: rename bch_extent_rebalance fields to match other opts structs
      bcachefs: io_opts_to_rebalance_opts()
      bcachefs: Add bch_io_opts fields for indicating whether the opts came from the inode
      bcachefs: copygc_enabled, rebalance_enabled now opts.h options
      bcachefs: bch2_prt_csum_opt()
      bcachefs: New bch_extent_rebalance fields
      bcachefs: bch2_write_inode() now checks for changing rebalance options
      bcachefs: get_update_rebalance_opts()
      bcachefs: Simplify option logic in rebalance
      bcachefs: Improve trace_rebalance_extent
      bcachefs: Move bch_extent_rebalance code to rebalance.c
      bcachefs: Add assert for use of journal replay keys for updates
      bcachefs: Kill BCH_TRANS_COMMIT_lazy_rw
      bcachefs: Improved check_topology() assert
      bcachefs: Fix unhandled transaction restart in evacuate_bucket()
      bcachefs: Assert we're not in a restart in bch2_trans_put()
      bcachefs: Better in_restart error
      bcachefs: bch2_trans_verify_not_unlocked_or_in_restart()
      bcachefs: Assert that we're not violating key cache coherency rules
      bcachefs: Rename btree_iter_peek_upto() -> btree_iter_peek_max()
      bcachefs: Simplify btree_iter_peek() filter_snapshots
      bcachefs: Kill unnecessary iter_rewind() in bkey_get_empty_slot()
      bcachefs: Move fsck ioctl code to fsck.c
      bcachefs: Add support for FS_IOC_GETFSUUID
      bcachefs: Add support for FS_IOC_GETFSSYSFSPATH
      bcachefs: Don't use page allocator for sb_read_scratch
      bcachefs: Fix shutdown message
      bcachefs: delete dead code
      bcachefs: bch2_btree_bit_mod_iter()
      bcachefs: Delete dead code from bch2_discard_one_bucket()
      bcachefs: lru errors are expected when reconstructing alloc
      bcachefs: Kill FSCK_NEED_FSCK
      bcachefs: Reserve 8 bits in bch_reflink_p
      bcachefs: Reorganize reflink.c a bit
      bcachefs: Don't delete reflink pointers to missing indirect extents
      bcachefs: kill inconsistent err in invalidate_one_bucket()
      bcachefs: rework bch2_bucket_alloc_freelist() freelist iteration
      bcachefs: try_alloc_bucket() now uses bch2_check_discard_freespace_key()
      bcachefs: bch2_bucket_do_index(): inconsistent_err -> fsck_err
      bcachefs: discard_one_bucket() now uses need_discard_or_freespace_err()
      bcachefs: Implement bch2_btree_iter_prev_min()
      bcachefs: peek_prev_min(): Search forwards for extents, snapshots
      bcachefs: Delete backpointers check in try_alloc_bucket()
      bcachefs: Kill bch2_get_next_backpointer()
      bcachefs: add missing BTREE_ITER_intent
      bcachefs: compression workspaces should be indexed by opt, not type
      bcachefs: Don't use a shared decompress workspace mempool
      bcachefs: Don't BUG_ON() when superblock feature wasn't set for compressed data
      bcachefs: kill bch2_journal_entries_free()
      bcachefs: journal keys: sort keys for interior nodes first
      bcachefs: btree_and_journal_iter: don't iterate over too many whiteouts when prefetching
      bcachefs: fix O(n^2) issue with whiteouts in journal keys
      bcachefs: Fix evacuate_bucket tracepoint
      bcachefs: fix bp_pos_to_bucket_nodev_noerror
      bcachefs: check for backpointers to invalid device
      bcachefs: bucket_pos_to_bp_end()
      bcachefs: Drop swab code for backpointers in alloc keys
      bcachefs: bch_backpointer -> bkey_i_backpointer
      bcachefs: Fix check_backpointers_to_extents range limiting
      bcachefs: kill bch_backpointer.bucket_offset usage
      bcachefs: New backpointers helpers
      bcachefs: Can now block journal activity without closing cur entry
      bcachefs: trivial btree write buffer refactoring
      bcachefs: Bias reads more in favor of faster device
      bcachefs: discard fastpath now uses bch2_discard_one_bucket()
      bcachefs: btree_write_buffer_flush_seq() no longer closes journal
      bcachefs: BCH_ERR_btree_node_read_error_cached
      bcachefs: Use separate rhltable for bch2_inode_or_descendents_is_open()
      bcachefs: errcode cleanup: journal errors
      bcachefs: disk_accounting: bch2_dev_rcu -> bch2_dev_rcu_noerror
      bcachefs: Fix accounting_read when we rewind
      bcachefs: backpointer_to_missing_ptr is now autofix
      bcachefs: Fix btree node scan when unknown btree IDs are present
      bcachefs: Kill bch2_bucket_alloc_new_fs()
      bcachefs: Bad btree roots are now autofix
      bcachefs: Fix dup/misordered check in btree node read
      bcachefs: Don't try to en/decrypt when encryption not available
      bcachefs: Change "disk accounting version 0" check to commit only
      bcachefs: Fix bch2_btree_node_update_key_early()
      bcachefs: Go RW earlier, for normal rw mount
      bcachefs: Fix null ptr deref in btree_path_lock_root()
      bcachefs: Ignore empty btree root journal entries
      bcachefs: struct bkey_validate_context
      bcachefs: Make topology errors autofix
      bcachefs: BCH_FS_recovery_running
      bcachefs: Guard against journal seq overflow
      bcachefs: Issue a transaction restart after commit in repair
      bcachefs: Guard against backpointers to unknown btrees
      bcachefs: Fix journal_iter list corruption
      bcachefs: add missing printbuf_reset()
      bcachefs: mark more errors AUTOFIX
      bcachefs: Don't error out when logging fsck error
      bcachefs: do_fsck_ask_yn()
      bcachefs: Check for bucket journal seq in the future
      bcachefs: Check for inode journal seq in the future
      bcachefs: cryptographic MACs on superblock are not (yet?) supported
      bcachefs: bch2_trans_relock() is trylock for lockdep
      bcachefs: Check for extent crc uncompressed/compressed size mismatch
      bcachefs: Don't recurse in check_discard_freespace_key
      bcachefs: Fix fsck.c build in userspace
      bcachefs: bch2_inum_to_path()
      bcachefs: Convert write path errors to inum_to_path()
      bcachefs: list_pop_entry()
      bcachefs: bkey_fsck_err now respects errors_silent
      bcachefs: If we did repair on a btree node, make sure we rewrite it
      bcachefs: bch2_async_btree_node_rewrites_flush()
      bcachefs: fix bch2_journal_key_insert_take() seq
      bcachefs: Improve "unable to allocate journal write" message
      bcachefs: Fix allocating too big journal entry
      bcachefs: rcu_pending now works in userspace
      bcachefs: logged ops only use inum 0 of logged ops btree
      bcachefs: Simplify disk accounting validate late
      bcachefs: Advance to next bp on BCH_ERR_backpointer_to_overwritten_btree_node
      bcachefs: trace_accounting_mem_insert
      bcachefs: Silence "unable to allocate journal write" if we're already RO
      bcachefs: BCH_ERR_insufficient_journal_devices
      bcachefs: Fix failure to allocate journal write on discard retry
      bcachefs: dev_alloc_list.devs -> dev_alloc_list.data
      bcachefs: Journal write path refactoring, debug improvements
      bcachefs: Call bch2_btree_lost_data() on btree read error
      bcachefs: Make sure __bch2_run_explicit_recovery_pass() signals to rewind
      bcachefs: Don't call bch2_btree_interior_update_will_free_node() until after update succeeds
      bcachefs: kill flags param to bch2_subvolume_get()
      bcachefs: factor out str_hash.c
      bcachefs: Journal space calculations should skip durability=0 devices
      bcachefs: fix bch2_btree_node_header_to_text() format string
      bcachefs: Mark more errors autofix
      bcachefs: Minor bucket alloc optimization
      lib min_heap: Switch to size_t
      bcachefs: Use a heap for handling overwrites in btree node scan
      bcachefs: Plumb bkey_validate_context to journal_entry_validate
      bcachefs: Don't add unknown accounting types to eytzinger tree
      bcachefs: Set bucket needs discard, inc gen on empty -> nonempty transition
      bcachefs: bch2_journal_noflush_seq() now takes [start, end)
      bcachefs: Fix reuse of bucket before journal flush on multiple empty -> nonempty transition
      bcachefs: Don't start rewriting btree nodes until after journal replay
      bcachefs: Kill unnecessary mark_lock usage
      bcachefs: kill sysfs internal/accounting
      bcachefs: Use proper errcodes for inode unpack errors
      bcachefs: Don't BUG_ON() inode unpack error
      bcachefs: bch2_str_hash_check_key() now checks inode hash info
      bcachefs: bch2_check_key_has_snapshot() prints btree id
      bcachefs: bch2_snapshot_exists()
      bcachefs: trace_write_buffer_maybe_flush
      bcachefs: Refactor c->opts.reconstruct_alloc
      bcachefs: check_indirect_extents can run online
      bcachefs: tidy up __bch2_btree_iter_peek()
      bcachefs: tidy btree_trans_peek_journal()
      bcachefs: Fix btree_trans_peek_key_cache() BTREE_ITER_all_snapshots
      bcachefs: Fix key cache + BTREE_ITER_all_snapshots
      bcachefs: alloc_data_type_set() happens in alloc trigger
      bcachefs: Don't run overwrite triggers before insert
      bcachefs: Kill equiv_seen arg to delete_dead_snapshots_process_key()
      bcachefs: Snapshot deletion no longer uses snapshot_t->equiv
      bcachefs: Kill snapshot_t->equiv
      bcachefs: bch2_trans_log_msg()
      bcachefs: Log message in journal for snapshot deletion
      bcachefs: trace_key_cache_fill
      bcachefs: bch2_btree_path_peek_slot() doesn't return errors
      bcachefs: bcachefs_metadata_version_backpointer_bucket_gen
      bcachefs: bcachefs_metadata_version_disk_accounting_big_endian
      bcachefs: bch2_extent_ptr_to_bp() no longer depends on device
      bcachefs: kill __bch2_extent_ptr_to_bp()
      bcachefs: Add write buffer flush param to backpointer_get_key()
      bcachefs: check_extents_to_backpointers() now only checks buckets with mismatches
      bcachefs: bch2_backpointer_get_key() now repairs dangling backpointers
      bcachefs: better backpointer_target_not_found() error message
      bcachefs: Only run check_backpointers_to_extents in debug mode
      bcachefs: BCH_SB_VERSION_INCOMPAT
      bcachefs: bcachefs_metadata_version_reflink_p_may_update_opts
      bcachefs: Option changes now get propagated to reflinked data
      bcachefs: bcachefs_metadata_version_inode_depth
      bcachefs: bcachefs_metadata_version_persistent_inode_cursors
      bcachefs: bcachefs_metadata_version_autofix_errors
      bcachefs: better check_bp_exists() error message
      bcachefs: Drop racy warning
      bcachefs: Drop redundant "read error" call from btree_gc
      bcachefs: kill __bch2_btree_iter_flags()
      bcachefs: Write lock btree node in key cache fills
      bcachefs: Handle -BCH_ERR_need_mark_replicas in gc
      bcachefs: Fix assert for online fsck
      bcachefs: bch2_kvmalloc()
      bcachefs: Don't rely on snapshot_tree.master_subvol for reattaching
      bcachefs: Fixes for snapshot_tree.master_subvol
      bcachefs: bch2_btree_node_write_trans()
      bcachefs: fix bch2_btree_key_cache_drop()
      bcachefs: btree_path_very_locks(): verify lock seq
      bcachefs: bch2_inum_path() no longer returns an error for disconnected inums
      bcachefs: bch2_inum_path() now crosses subvolumes correctly
      bcachefs: Assert that btree write buffer only touches the right btrees
      bcachefs: bch2_fs_btree_gc_init()
      bcachefs: six locks: write locks can now be held recursively
      bcachefs: btree_node_unlock() can now drop write locks
      bcachefs: bch2_trans_unlock_write()
      bcachefs: bch2_trans_node_drop()
      bcachefs: Dropped superblock write is no longer a fatal error
      bcachefs: Silence read-only errors when deleting snapshots
      bcachefs: printbuf_reset() handles tabstops
      bcachefs: __bch2_btree_pos_to_text()
      bcachefs: Don't set btree_path to updtodate if we don't fill
      bcachefs: bch2_btree_iter_peek_slot() handles navigating to nonexistent depth
      bcachefs: Check for dirents to overwritten inodes
      bcachefs: Don't use BTREE_ITER_cached when walking alloc btree during fsck
      bcachefs: check_unreachable_inodes is not actually PASS_ONLINE yet
      bcachefs: Fix self healing on read error
      bcachefs: Document issue with bch_stripe layout
      bcachefs: Fix check_inode_hash_info_matches_root()

Nathan Chancellor (1):
      bcachefs: Add empty statement between label and declaration in check_inode_hash_info_matches_root()

Thomas Bertschinger (1):
      bcachefs: move bch2_xattr_handlers to .rodata

Thorsten Blum (6):
      bcachefs: Remove duplicate included headers
      bcachefs: Use FOREACH_ACL_ENTRY() macro to iterate over acl entries
      bcachefs: Use str_write_read() helper function
      bcachefs: Use str_write_read() helper in ec_block_endio()
      bcachefs: Use str_write_read() helper in write_super_endio()
      bcachefs: Annotate struct bucket_gens with __counted_by()

Yang Li (1):
      bcachefs: Add missing parameter description to bch2_bucket_alloc_trans()

Youling Tang (4):
      bcachefs: Correct the description of the '--bucket=size' options
      bcachefs: Removes NULL pointer checks for __filemap_get_folio return values
      bcachefs: Remove redundant initialization in bch2_vfs_inode_init()
      bcachefs: Simplify code in bch2_dev_alloc()

 Documentation/filesystems/bcachefs/CodingStyle.rst |   2 +-
 fs/bcachefs/Kconfig                                |   2 +-
 fs/bcachefs/Makefile                               |   1 +
 fs/bcachefs/acl.c                                  |  11 +-
 fs/bcachefs/alloc_background.c                     | 558 +++++++-------
 fs/bcachefs/alloc_background.h                     |  18 +-
 fs/bcachefs/alloc_background_format.h              |   4 +-
 fs/bcachefs/alloc_foreground.c                     | 304 +++-----
 fs/bcachefs/alloc_foreground.h                     |   4 +-
 fs/bcachefs/backpointers.c                         | 838 +++++++++++++--------
 fs/bcachefs/backpointers.h                         |  97 ++-
 fs/bcachefs/bbpos.h                                |   2 +-
 fs/bcachefs/bcachefs.h                             |  70 +-
 fs/bcachefs/bcachefs_format.h                      | 106 ++-
 fs/bcachefs/bkey.h                                 |   7 -
 fs/bcachefs/bkey_methods.c                         |  29 +-
 fs/bcachefs/bkey_methods.h                         |  15 +-
 fs/bcachefs/bkey_types.h                           |  28 +
 fs/bcachefs/btree_cache.c                          |  59 +-
 fs/bcachefs/btree_cache.h                          |  14 +-
 fs/bcachefs/btree_gc.c                             | 178 ++---
 fs/bcachefs/btree_gc.h                             |   4 +-
 fs/bcachefs/btree_io.c                             | 225 ++++--
 fs/bcachefs/btree_io.h                             |   6 +-
 fs/bcachefs/btree_iter.c                           | 590 +++++++++------
 fs/bcachefs/btree_iter.h                           | 134 ++--
 fs/bcachefs/btree_journal_iter.c                   | 237 +++++-
 fs/bcachefs/btree_journal_iter.h                   |  22 +-
 fs/bcachefs/btree_journal_iter_types.h             |  36 +
 fs/bcachefs/btree_key_cache.c                      |  75 +-
 fs/bcachefs/btree_locking.c                        |  78 +-
 fs/bcachefs/btree_locking.h                        |  50 +-
 fs/bcachefs/btree_node_scan.c                      | 153 ++--
 fs/bcachefs/btree_node_scan_types.h                |   1 -
 fs/bcachefs/btree_trans_commit.c                   | 205 ++---
 fs/bcachefs/btree_types.h                          |  42 +-
 fs/bcachefs/btree_update.c                         |  70 +-
 fs/bcachefs/btree_update.h                         |  29 +-
 fs/bcachefs/btree_update_interior.c                | 293 +++----
 fs/bcachefs/btree_update_interior.h                |   3 +-
 fs/bcachefs/btree_write_buffer.c                   |  83 +-
 fs/bcachefs/buckets.c                              | 133 ++--
 fs/bcachefs/buckets.h                              |  30 +-
 fs/bcachefs/buckets_types.h                        |   2 +-
 fs/bcachefs/chardev.c                              | 219 +-----
 fs/bcachefs/checksum.c                             |  10 +-
 fs/bcachefs/checksum.h                             |   2 +-
 fs/bcachefs/compress.c                             |  96 ++-
 fs/bcachefs/darray.h                               |   2 +-
 fs/bcachefs/data_update.c                          |  76 +-
 fs/bcachefs/debug.c                                |   4 +-
 fs/bcachefs/dirent.c                               |  10 +-
 fs/bcachefs/dirent.h                               |   9 +-
 fs/bcachefs/disk_accounting.c                      | 150 ++--
 fs/bcachefs/disk_accounting.h                      |  73 +-
 fs/bcachefs/ec.c                                   | 267 +++----
 fs/bcachefs/ec.h                                   |   5 +-
 fs/bcachefs/ec_format.h                            |  17 +
 fs/bcachefs/errcode.h                              |  21 +-
 fs/bcachefs/error.c                                | 187 +++--
 fs/bcachefs/error.h                                |  58 +-
 fs/bcachefs/extent_update.c                        |   4 +-
 fs/bcachefs/extents.c                              | 290 +++----
 fs/bcachefs/extents.h                              |  18 +-
 fs/bcachefs/extents_format.h                       |  15 +-
 fs/bcachefs/fs-common.c                            | 119 ++-
 fs/bcachefs/fs-common.h                            |   2 +
 fs/bcachefs/fs-io-buffered.c                       |  45 +-
 fs/bcachefs/fs-io-direct.c                         |   5 +
 fs/bcachefs/fs-io-pagecache.c                      |   4 +-
 fs/bcachefs/fs-io.c                                |  54 +-
 fs/bcachefs/fs-ioctl.c                             |   7 +-
 fs/bcachefs/fs.c                                   | 101 ++-
 fs/bcachefs/fs.h                                   |   1 +
 fs/bcachefs/fsck.c                                 | 772 ++++++++++++-------
 fs/bcachefs/fsck.h                                 |  11 +
 fs/bcachefs/inode.c                                | 169 +++--
 fs/bcachefs/inode.h                                |  43 +-
 fs/bcachefs/inode_format.h                         |  15 +-
 fs/bcachefs/io_misc.c                              |  22 +-
 fs/bcachefs/io_read.c                              | 259 ++++---
 fs/bcachefs/io_read.h                              |  28 +-
 fs/bcachefs/io_write.c                             | 102 +--
 fs/bcachefs/journal.c                              | 162 ++--
 fs/bcachefs/journal.h                              |   9 +-
 fs/bcachefs/journal_io.c                           | 221 +++---
 fs/bcachefs/journal_io.h                           |   2 +-
 fs/bcachefs/journal_reclaim.c                      |  19 +-
 fs/bcachefs/journal_types.h                        |   5 +
 fs/bcachefs/logged_ops.c                           |  11 +-
 fs/bcachefs/logged_ops_format.h                    |   5 +
 fs/bcachefs/lru.c                                  |   4 +-
 fs/bcachefs/lru.h                                  |   2 +-
 fs/bcachefs/move.c                                 | 184 +++--
 fs/bcachefs/move.h                                 |   5 +-
 fs/bcachefs/movinggc.c                             |   6 +-
 fs/bcachefs/opts.c                                 |  26 +-
 fs/bcachefs/opts.h                                 |  61 +-
 fs/bcachefs/printbuf.h                             |  15 +-
 fs/bcachefs/quota.c                                |   2 +-
 fs/bcachefs/quota.h                                |   4 +-
 fs/bcachefs/rcu_pending.c                          |  38 +-
 fs/bcachefs/rebalance.c                            | 266 ++++++-
 fs/bcachefs/rebalance.h                            |  10 +
 fs/bcachefs/rebalance_format.h                     |  53 ++
 fs/bcachefs/rebalance_types.h                      |   2 -
 fs/bcachefs/recovery.c                             | 212 ++++--
 fs/bcachefs/recovery.h                             |   2 +-
 fs/bcachefs/recovery_passes.c                      | 112 ++-
 fs/bcachefs/recovery_passes.h                      |   1 +
 fs/bcachefs/recovery_passes_types.h                |  92 +--
 fs/bcachefs/reflink.c                              | 496 +++++++++---
 fs/bcachefs/reflink.h                              |  20 +-
 fs/bcachefs/reflink_format.h                       |   7 +-
 fs/bcachefs/sb-clean.c                             |   6 +-
 fs/bcachefs/sb-counters_format.h                   | 165 ++--
 fs/bcachefs/sb-downgrade.c                         |  28 +-
 fs/bcachefs/sb-errors_format.h                     |  54 +-
 fs/bcachefs/six.c                                  |  27 +-
 fs/bcachefs/six.h                                  |   1 +
 fs/bcachefs/snapshot.c                             | 515 ++++++-------
 fs/bcachefs/snapshot.h                             |  17 +-
 fs/bcachefs/str_hash.c                             | 295 ++++++++
 fs/bcachefs/str_hash.h                             |  28 +-
 fs/bcachefs/subvolume.c                            |  68 +-
 fs/bcachefs/subvolume.h                            |  19 +-
 fs/bcachefs/subvolume_types.h                      |   2 +-
 fs/bcachefs/super-io.c                             |  83 +-
 fs/bcachefs/super-io.h                             |  21 +-
 fs/bcachefs/super.c                                |  54 +-
 fs/bcachefs/super.h                                |  10 -
 fs/bcachefs/sysfs.c                                |  60 +-
 fs/bcachefs/tests.c                                |  26 +-
 fs/bcachefs/trace.h                                |  77 +-
 fs/bcachefs/util.h                                 |  32 +
 fs/bcachefs/varint.c                               |   5 +-
 fs/bcachefs/xattr.c                                |  13 +-
 fs/bcachefs/xattr.h                                |   5 +-
 fs/fs_parser.c                                     |   3 +-
 include/linux/fs_parser.h                          |   2 +
 include/linux/min_heap.h                           |   4 +-
 141 files changed, 7175 insertions(+), 4639 deletions(-)
 create mode 100644 fs/bcachefs/btree_journal_iter_types.h
 create mode 100644 fs/bcachefs/rebalance_format.h
 create mode 100644 fs/bcachefs/str_hash.c

