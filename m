Return-Path: <linux-fsdevel+bounces-50682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B9EACE623
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 23:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A6A3A39CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C9C211479;
	Wed,  4 Jun 2025 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="R0WX9NI+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91147F4A
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749072218; cv=none; b=mWerAncnn1DTGL2jGADRuWtiwY7049XtZYVbuBiln5SI+rWRAX5H49ZcqBdh9QdHikQ0KY1itxBirSf5yfK0dVoLAz6/I7qDXqKq0XUiM8ayLy/y0MPGkFDYUlrr1esr6mAirzQV0h3qDQlyjB9tJIiRvLrp9m1vp/xtkbIrxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749072218; c=relaxed/simple;
	bh=4S10gW2wt3Usw1eY6iH4D3RuLj5PdEfnJJKHo9LJi6s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JSgFvDk1kxRRqQb+hdQc5o9D0EMSQ/H43nkSo1cqZjAl05Vp8NfMICy8w4PiSZLi8eDkZqqSH0PO1Sdr+Db5eR/i5pTdTA+2AArH9XRhubUbBkDd8VkOd6a3qCFMi30Sm0i///oLs9IYpCqrzXgGo+XWNpN5hZeHSOxQLiSLPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=R0WX9NI+; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Jun 2025 17:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749072203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mkV9b8O+6559TIf0+Ma+w1OI88MqcmuriotQpPbTw/Q=;
	b=R0WX9NI+oV+nyQiYmfggYH9bcblA/PDrxpwY1yX1hAPZw8OyMoJTN9jlMhhFdUEx8sNOe0
	bcNt0hrsKQRfW84LrE2vNFjUdNPRhyZ5jRGNxS07uNBz33Qk16o0oO88JSon1cqRnGTeMo
	Vq+5Le4Tl8FOuVyj3HIU9f6i5BhcgQg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs changes for 6.16, part 2
Message-ID: <xtigikvqorbxtpy2rh52fobvunp7yrwkfpj4muwaogr4ijxl4j@s327kfvhpi3v>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Linus - there's also a small merge conflict, due to the timer renaming;
the relevant code has been deleted here.

The following changes since commit 9caea9208fc3fbdbd4a41a2de8c6a0c969b030f9:

  bcachefs: Don't mount bs > ps without TRANSPARENT_HUGEPAGE (2025-05-23 22:00:07 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-06-04

for you to fetch changes up to 3d11125ff624b540334f7134d98b94f3b980e85d:

  bcachefs: add cond_resched() to handle_overwrites() (2025-06-04 16:45:41 -0400)

----------------------------------------------------------------
bcachefs updates for 6.16, part 2

- More stack usage improvements (~600 bytes).

- Define CLASS()es for some commonly used types, and convert most
  rcu_read_lock() uses to the new lock guards

- New introspection:
  - Superblock error counters are now available in sysfs: previously,
    they were only visible with 'show-super', which doesn't provide a
    live view
  - New tracepoint, error_throw(), which is called any time we return an
    error and start to unwind

- Repair
  - check_fix_ptrs() can now repair btree node roots
  - We can now repair when we've somehow ended up with the journal using
    a superblock bucket

- Revert some leftovers from the aborted directory i_size feature, and
  add repair code: some userspace programs (e.g. sshfs) were getting
  confused.

It seems in 6.15 there's a bug where i_nlink on the vfs inode has been
getting incorrectly set to 0, with some unfortunate results;
list_journal analysis showed bch2_inode_rm() being called (by
bch2_evict_inode()) when it clearly should not have been.

- bch2_inode_rm() now runs "should we be deleting this inode?" checks
  that were previously only run when deleting unlinked inodes in
  recovery.

- check_subvol() was treating a dangling subvol (pointing to a missing
  root inode) like a dangling dirent, and deleting it. This was the
  really unfortunate one: check_subvol() will now recreate the root
  inode if necessary.

This took longer to debug than it should have, and we lost several
filesystems unnecessarily, becuase users have been ignoring the release
notes and blindly running 'fsck -y'. Debugging required reconstructing
what happened through analyzing the journal, when ideally someone would
have noticed 'hey, fsck is asking me if I want to repair this: it
usually doesn't, maybe I should run this in dry run mode and check
what's going on?'.

As a reminder, fsck errors are being marked as autofix once we've
verified, in real world usage, that they're working correctly; blindly
running 'fsck -y' on an experimental filesystem is playing with fire.

Up to this incident we've had an excellent track record of not losing
data, so let's try to learn from this one.

This is a community effort, I wouldn't be able to get this done without
the help of all the people QAing and providing excellent bug reports and
feedback based on real world usage. But please don't ignore advice and
expect me to pick up the pieces.

If an error isn't marked as autofix, and it /is/ happening in the wild,
that's also something I need to know about so we can check it out and
add it to the autofix list if repair looks good. I haven't been getting
those reports, and I should be; since we don't have any sort of
telemetry yet I am absolutely dependent on user reports.

Now I'll be spending the weekend working on new repair code to see if I
can get a filesystem back for a user who didn't have backups.

----------------------------------------------------------------
Kent Overstreet (68):
      bcachefs: fix REFLINK_P_MAY_UPDATE_OPTIONS
      bcachefs: Fix missing BTREE_UPDATE_internal_snapshot_node
      bcachefs: Ensure we print output of run_recovery_pass if it errors
      bcachefs: bch2_kthread_io_clock_wait_once()
      bcachefs: Fix lost rebalance wakeups
      bcachefs: Fix missing commit in check_dirents
      bcachefs: Move unicode message to after the startup message
      bcachefs: Don't rewind to run a recovery pass we already ran
      bcachefs: Journal read error message improvements
      bcachefs: Fix infinite loop in journal_entry_btree_keys_to_text()
      bcachefs: trace_io_move_pred
      bcachefs: io_move_evacuate_bucket tracepoint, counter
      bcachefs: Catch data_update_done events in trace_io_move_start_fail
      bcachefs: Fix incorrect multiple dev check in journal write path
      bcachefs: Fix misaligned bucket check in journal space calculations
      bcachefs: Add missing error logging in delete_dead_inodes()
      bcachefs: Kill bkey_buf in btree_path_down()
      bcachefs: btree_node_missing_err()
      bcachefs: factor out break_cycle_fail()
      bcachefs: Don't stack allocate bch_writepage_state
      bcachefs: kill replicas_sectors arg to __trigger_extent()
      bcachefs: Tweak bch2_data_update_init() for stack usage
      bcachefs: bch2_alloc_v4_to_text()
      bcachefs: reduce stack usage in alloc_sectors_start()
      bcachefs: Move devs_sorted to alloc_request
      bcachefs: Include b->ob.nr in cached_btree_node_to_text()
      bcachefs: bch2_check_fix_ptrs() can now repair btree roots
      bcachefs: sysfs/errors
      bcachefs: Add missing printbuf_reset() in bch2_check_dirent_inode_dirent()
      bcachefs: Mark bch_errcode helpers __attribute__((const))
      bcachefs: Use bch2_err_matches() for BCH_ERR_fsck_(fix|ignore)
      bcachefs: Don't unlock trans before data_update_init()
      bcachefs: Runtime self healing for keys for deleted snapshots
      bcachefs: bch2_dev_journal_bucket_delete()
      bcachefs: bch2_get_snapshot_overwrites()
      bcachefs: __bch2_insert_snapshot_whiteouts() refactoring
      bcachefs: bch2_str_hash_check_key() may now be called without snapshots_seen
      bcachefs: bch2_readdir() now calls str_hash_check_key()
      bcachefs: Improve error printing in btree_node_check_topology()
      bcachefs: Journal keys are retained until shutdown, or journal replay finishes
      bcachefs: darray_find(), darray_find_p()
      bcachefs: sysfs trigger_emergency_read_only
      bcachefs: sysfs trigger_journal_commit
      bcachefs: CLASS(printbuf)
      bcachefs: CLASS(darray)
      bcachefs: CLASS(btree_trans)
      bcachefs: Replace rcu_read_lock() with guards
      bcachefs: Add better logging to fsck_rename_dirent()
      bcachefs: Convert BUG() to error
      bcachefs: Delete redundant fsck_err()
      bcachefs: Kill un-reverted directory i_size code
      bcachefs: Repair code for directory i_size
      bcachefs: bch_err_throw()
      bcachefs: bch2_require_recovery_pass()
      bcachefs: BCH_RECOVERY_PASS_NO_RATELIMIT
      bcachefs: Make check_key_has_snapshot safer
      bcachefs: Run snapshot deletion out of system_long_wq
      bcachefs: Run check_dirents second time if required
      bcachefs: Redo bch2_dirent_init_name()
      bcachefs: Fix bch2_fsck_rename_dirent() for casefold
      bcachefs: Fix dirent_casefold_mismatch repair
      bcachefs: Fix oops in btree_node_seq_matches()
      bcachefs: Add flags to subvolume_to_text()
      bcachefs: delete dead code from may_delete_deleted_inode()
      bcachefs: Run may_delete_deleted_inode() checks in bch2_inode_rm()
      bcachefs: Fix subvol to missing root repair
      bcachefs: Make journal read log message a bit quieter
      bcachefs: add cond_resched() to handle_overwrites()

Nathan Chancellor (1):
      bcachefs: Fix -Wc23-extensions in bch2_check_dirents()

 fs/bcachefs/alloc_background.c            |  79 ++++-----
 fs/bcachefs/alloc_background.h            |   9 +-
 fs/bcachefs/alloc_foreground.c            | 108 ++++++------
 fs/bcachefs/alloc_foreground.h            |   8 +-
 fs/bcachefs/backpointers.c                |  72 ++++----
 fs/bcachefs/backpointers.h                |   5 +-
 fs/bcachefs/bcachefs.h                    |  72 ++++----
 fs/bcachefs/btree_cache.c                 |  24 +--
 fs/bcachefs/btree_gc.c                    |  57 +++---
 fs/bcachefs/btree_io.c                    |  43 +++--
 fs/bcachefs/btree_iter.c                  |  78 ++++-----
 fs/bcachefs/btree_iter.h                  |  31 ++--
 fs/bcachefs/btree_journal_iter.c          |  19 +-
 fs/bcachefs/btree_key_cache.c             |  28 ++-
 fs/bcachefs/btree_locking.c               |  56 +++---
 fs/bcachefs/btree_node_scan.c             |   2 +
 fs/bcachefs/btree_trans_commit.c          |  36 ++--
 fs/bcachefs/btree_types.h                 |   2 +
 fs/bcachefs/btree_update.c                |  59 ++-----
 fs/bcachefs/btree_update.h                |  14 +-
 fs/bcachefs/btree_update_interior.c       | 104 ++++++-----
 fs/bcachefs/btree_write_buffer.c          |   6 +-
 fs/bcachefs/buckets.c                     | 163 ++++++++++-------
 fs/bcachefs/buckets.h                     |  12 +-
 fs/bcachefs/buckets_waiting_for_journal.c |   3 +-
 fs/bcachefs/chardev.c                     |   9 +-
 fs/bcachefs/checksum.c                    |   8 +-
 fs/bcachefs/clock.c                       |  47 ++---
 fs/bcachefs/clock.h                       |   1 +
 fs/bcachefs/compress.c                    |  20 +--
 fs/bcachefs/darray.h                      |  46 ++++-
 fs/bcachefs/data_update.c                 | 174 ++++++++++--------
 fs/bcachefs/debug.c                       |  30 ++--
 fs/bcachefs/dirent.c                      | 169 +++++++++---------
 fs/bcachefs/dirent.h                      |  16 +-
 fs/bcachefs/disk_accounting.c             |  38 ++--
 fs/bcachefs/disk_accounting.h             |   6 +-
 fs/bcachefs/disk_groups.c                 |  37 ++--
 fs/bcachefs/ec.c                          | 108 ++++++------
 fs/bcachefs/errcode.c                     |   4 +-
 fs/bcachefs/errcode.h                     |  15 +-
 fs/bcachefs/error.c                       |  93 +++++-----
 fs/bcachefs/error.h                       |  12 +-
 fs/bcachefs/extents.c                     |  63 +++----
 fs/bcachefs/fs-io-buffered.c              |  30 ++--
 fs/bcachefs/fs-io-pagecache.c             |   2 +-
 fs/bcachefs/fs-io.c                       |  12 +-
 fs/bcachefs/fs-ioctl.c                    |   4 +-
 fs/bcachefs/fs.c                          |  40 +++--
 fs/bcachefs/fsck.c                        | 149 +++++++++-------
 fs/bcachefs/fsck.h                        |   6 +
 fs/bcachefs/inode.c                       |  86 +++++----
 fs/bcachefs/inode.h                       |   9 -
 fs/bcachefs/io_misc.c                     |   2 +-
 fs/bcachefs/io_read.c                     |  35 ++--
 fs/bcachefs/io_read.h                     |   6 +-
 fs/bcachefs/io_write.c                    |  26 ++-
 fs/bcachefs/journal.c                     | 117 ++++++++++---
 fs/bcachefs/journal.h                     |   5 +-
 fs/bcachefs/journal_io.c                  | 281 ++++++++++++++++++------------
 fs/bcachefs/journal_io.h                  |   1 +
 fs/bcachefs/journal_reclaim.c             |  44 ++---
 fs/bcachefs/journal_sb.c                  |   2 +-
 fs/bcachefs/journal_seq_blacklist.c       |   4 +-
 fs/bcachefs/lru.c                         |   6 +-
 fs/bcachefs/migrate.c                     |   4 +-
 fs/bcachefs/move.c                        | 132 +++++++++-----
 fs/bcachefs/movinggc.c                    |  26 ++-
 fs/bcachefs/movinggc.h                    |   3 +-
 fs/bcachefs/namei.c                       |  21 +--
 fs/bcachefs/printbuf.h                    |   8 +
 fs/bcachefs/quota.c                       |   6 +-
 fs/bcachefs/rebalance.c                   |  27 +--
 fs/bcachefs/rebalance.h                   |   8 +-
 fs/bcachefs/rebalance_types.h             |   1 +
 fs/bcachefs/recovery.c                    |   6 +-
 fs/bcachefs/recovery_passes.c             |  92 ++++++++--
 fs/bcachefs/recovery_passes.h             |   5 +
 fs/bcachefs/recovery_passes_format.h      |   2 +
 fs/bcachefs/reflink.c                     |   9 +-
 fs/bcachefs/replicas.c                    |  35 ++--
 fs/bcachefs/sb-counters_format.h          |   1 +
 fs/bcachefs/sb-downgrade.c                |   2 +-
 fs/bcachefs/sb-errors.c                   |  22 +++
 fs/bcachefs/sb-errors.h                   |   1 +
 fs/bcachefs/sb-errors_format.h            |   4 +-
 fs/bcachefs/sb-members.c                  |  21 +--
 fs/bcachefs/sb-members.h                  |  32 ++--
 fs/bcachefs/six.c                         |   7 +-
 fs/bcachefs/snapshot.c                    | 148 +++++++++-------
 fs/bcachefs/snapshot.h                    |  85 ++++-----
 fs/bcachefs/str_hash.c                    | 243 +++++++++++++++++---------
 fs/bcachefs/str_hash.h                    |  24 ++-
 fs/bcachefs/subvolume.c                   |  45 +++--
 fs/bcachefs/super-io.c                    |   8 +-
 fs/bcachefs/super.c                       | 106 ++++++-----
 fs/bcachefs/sysfs.c                       |  24 +++
 fs/bcachefs/trace.h                       |  69 ++++++--
 98 files changed, 2323 insertions(+), 1757 deletions(-)

