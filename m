Return-Path: <linux-fsdevel+bounces-23649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A85930C5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 03:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E50281455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31164C7C;
	Mon, 15 Jul 2024 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eRVdD4Qh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FFC4C6D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721006800; cv=none; b=LanGHVn3Q4q3j8B3SQp/cVyKHcLoqaX2p/MYvV8nyQZdk70xh+Y6TlpkhJ/rTHdsO9mq4KLib3kiMgMaHFVOt10x7ST/bXY9co+D98accnnNQ2qKgu3wQO3yp3ecFNsq1V47oub5wKuvqBETHLK7EdgoHjjcYN2I76TqTZICywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721006800; c=relaxed/simple;
	bh=4ZfbjHQdsE214vgA415ikZm22hhOXF9SDSujhbpCHyI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M9GSXfTS0a/j6iNyBzWJDkpVrJ+v3bpErF5Dkb8k8EfHXsJRg4bEAESCmnWOgJ8ZVRSXWYm+wPNjnubmKSEgyT5cucBWqig8MqoaTZn4V8wemTbdBf9FohkwQdoGss0M5LaySNqvOU6cX5LydXfmmeYzgGCn9kb7/sASCgjbJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eRVdD4Qh; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721006794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=jF1jBEQDJF+VD0zIizAcmSBdRN7DZJsvrAxxTfY6jfc=;
	b=eRVdD4QhZit3epChwSvxvtGOlbztFUGUpOoSD9bmRWr7RpxuyZcpO2WGsqwxJ9WtKuhVBV
	Qf3+pQiR7uxwkpgvSxtKpC04fMWB1p6DGsH4lW5pWoGl0BKbKGPA0i6qe5b3RzI10SUM8i
	QyZDkM63ai00UR01GpUesN0nRUvdxjQ=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sun, 14 Jul 2024 21:26:30 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs changes for 6.11
Message-ID: <r75jqqdjp24gikil2l26wwtxdxvqxpgfaixb2rqmuyzxnbhseq@6k34emck64hv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus - another opossum for the posse:

The following changes since commit 0c3836482481200ead7b416ca80c68a29cfdaabd:

  Linux 6.10 (2024-07-14 15:43:32 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-14

for you to fetch changes up to efb2018e4d238cc205690ac62c0917d60d291e66:

  bcachefs: Kill bch2_assert_btree_nodes_not_locked() (2024-07-14 19:59:12 -0400)

----------------------------------------------------------------
bcachefs changes for 6.11-rc1

- Metadata version 1.8: Stripe sectors accounting, BCH_DATA_unstriped

This splits out the accounting of dirty sectors and stripe sectors in
alloc keys; this lets us see stripe buckets that still have unstriped
data in them.

This is needed for ensuring that erasure coding is working correctly, as
well as completing stripe creation after a crash.

- Metadata version 1.9: Disk accounting rewrite

The previous disk accounting scheme relied heavily on percpu counters
that were also sharded by outstanding journal buffer; it was fast but
not extensible or scalable, and meant that all accounting counters were
recorded in every journal entry.

The new disk accounting scheme stores accounting as normal btree keys;
updates are deltas until they are flushed by the btree write buffer.

This means we have no practical limit on the number of counters, and a
new tagged union format that's easy to extend.

We now have counters for compression type/ratio, per-snapshot-id usage,
per-btree-id usage, and pending rebalance work.

- Self healing on read IO/checksum error

data is now automatically rewritten if we get a read error and then a
successful retry

- Mount API conversion (thanks to Thomas Bertschinger)

- Better lockdep coverage

Previously, btree node locks were tracked individually by lockdep, like
any other lock. But we may take _many_ btree node locks simultaneously,
we easily blow through the limit of 48 locks that lockdep can track,
leading to lockdep turning itself off.

Tracking each btree node lock individually isn't really necessary since
we have our own cycle detector for deadlock avoidance and centralized
tracking of btree node locks, so we now have a single lockdep_map in
btree_trans for "any btree nodes are locked".

- some more small incremental work towards online check_allocations

- lots more debugging improvements, fixes

----------------------------------------------------------------
Ariel Miculas (2):
      bcachefs: bch2_dir_emit() - fix directory reads in the fuse driver
      bcachefs: bch2_btree_insert() - add btree iter flags

Brian Foster (2):
      bcachefs: fix smatch data leak warning in fs usage ioctl
      MAINTAINERS: remove Brian Foster as a reviewer for bcachefs

Hongbo Li (5):
      bcachefs: implement FS_IOC_GETVERSION to support lsattr
      bcachefs: support get fs label
      bcachefs: support FS_IOC_SETFSLABEL
      bcachefs: support STATX_DIOALIGN for statx file
      bcachefs: show none if label is not set

Kent Overstreet (89):
      bcachefs: Print allocator stuck on timeout in fallocate path
      bcachefs: btree ids are 64 bit bitmasks
      bcachefs: uninline fallocate functions
      bcachefs: add capacity, reserved to fs_alloc_debug_to_text()
      bcachefs: sysfs internal/trigger_journal_writes
      bcachefs: sysfs trigger_freelist_wakeup
      bcachefs: bch2_btree_reserve_cache_to_text()
      bcachefs: fix ei_update_lock lock ordering
      bcachefs: fix missing include
      bcachefs: add might_sleep() annotations for fsck_err()
      bcachefs: Check for bsets past bch_btree_ptr_v2.sectors_written
      bcachefs: btree_ptr_sectors_written() now takes bkey_s_c
      bcachefs: bch2_printbuf_strip_trailing_newline()
      bcachefs: check_key_has_inode()
      bcachefs: bch_alloc->stripe_sectors
      bcachefs: BCH_DATA_unstriped
      bcachefs: metadata version bucket_stripe_sectors
      bcachefs: KEY_TYPE_accounting
      bcachefs: Accumulate accounting keys in journal replay
      bcachefs: btree write buffer knows how to accumulate bch_accounting keys
      bcachefs: Disk space accounting rewrite
      bcachefs: Coalesce accounting keys before journal replay
      bcachefs: dev_usage updated by new accounting
      bcachefs: Kill bch2_fs_usage_initialize()
      bcachefs: Convert bch2_ioctl_fs_usage() to new accounting
      bcachefs: kill bch2_fs_usage_read()
      bcachefs: Kill writing old accounting to journal
      bcachefs: Delete journal-buf-sharded old style accounting
      bcachefs: Kill bch2_fs_usage_to_text()
      bcachefs: Kill fs_usage_online
      bcachefs: Kill replicas_journal_res
      bcachefs: Convert gc to new accounting
      bcachefs: Convert bch2_replicas_gc2() to new accounting
      bcachefs: bch2_verify_accounting_clean()
      bcachefs: bch_acct_compression
      bcachefs: Convert bch2_compression_stats_to_text() to new accounting
      bcachefs: bch2_fs_accounting_to_text()
      bcachefs: bch2_fs_usage_base_to_text()
      bcachefs: bch_acct_snapshot
      bcachefs: bch_acct_btree
      bcachefs: bch_acct_rebalance_work
      bcachefs: Eytzinger accumulation for accounting keys
      bcachefs: Kill bch2_mount()
      bcachefs: bch2_fs_get_tree() cleanup
      bcachefs: Don't block journal when finishing check_allocations()
      bcachefs: Walk leaf to root in btree_gc
      bcachefs: Initialize gc buckets in alloc trigger
      bcachefs: Delete old assertion for online fsck
      bcachefs: btree_types bitmask cleanups
      bcachefs: fsck_err() may now take a btree_trans
      bcachefs: Plumb more logging through stdio redirect
      bcachefs: twf: convert bch2_stdio_redirect_readline() to darray
      bcachefs: bch2_stdio_redirect_readline_timeout()
      bcachefs: twf: delete dead struct fields
      bcachefs: Unlock trans when waiting for user input in fsck
      bcachefs: BCH_IOCTL_QUERY_ACCOUNTING
      bcachefs: Fix race in bch2_accounting_mem_insert()
      bcachefs: Refactor disk accounting data structures
      bcachefs: bch2_accounting_mem_gc()
      bcachefs: Fix bch2_gc_accounting_done() locking
      bcachefs: Kill gc_pos_btree_node()
      bcachefs: bch2_btree_id_to_text()
      bcachefs: bch2_gc_pos_to_text()
      bcachefs: btree_node_unlock() assert
      bcachefs: btree_path_cached_set()
      bcachefs: kill key cache arg to bch2_assert_pos_locked()
      bcachefs: per_cpu_sum()
      bcachefs: Reduce the scope of gc_lock
      bcachefs: bch2_btree_key_cache_drop() now evicts
      bcachefs: split out lru_format.h
      bcachefs: Ensure buffered writes write as much as they can
      bcachefs: Fix missing BTREE_TRIGGER_bucket_invalidate flag
      bcachefs: Improve "unable to allocate journal write" message
      bcachefs: Simplify btree key cache fill path
      bcachefs: spelling fix
      bcachefs: Ratelimit checksum error messages
      bcachefs: bch2_extent_crc_unpacked_to_text()
      bcachefs: Make read_only a mount option again, but hidden
      bcachefs: Self healing on read IO error
      bcachefs: Improve startup message
      bcachefs: Convert clock code to u64s
      bcachefs: Improve copygc_wait_to_text()
      lockdep: lockdep_set_notrack_class()
      bcachefs: Add lockdep support for btree node locks
      bcachefs: btree node scan: fall back to comparing by journal seq
      bcachefs: drop packed, aligned from bkey_inode_buf
      bcachefs: __bch2_read(): call trans_begin() on every loop iter
      bcachefs: Rename BCH_WRITE_DONE -> BCH_WRITE_SUBMITTED
      bcachefs: Kill bch2_assert_btree_nodes_not_locked()

Pankaj Raghav (2):
      bcachefs: use FGP_WRITEBEGIN instead of combining individual flags
      bcachefs: set fgf order hint before starting a buffered write

Reed Riley (1):
      bcachefs: support REMAP_FILE_DEDUP in bch2_remap_file_range

Thomas Bertschinger (6):
      bcachefs: make offline fsck set read_only fs flag
      bcachefs: don't expose "read_only" as a mount option
      bcachefs: allow passing full device path for target options
      bcachefs: add printbuf arg to bch2_parse_mount_opts()
      bcachefs: Add error code to defer option parsing
      bcachefs: use new mount API

Uros Bizjak (1):
      bcachefs: Use try_cmpxchg() family of functions instead of cmpxchg()

Youling Tang (5):
      bcachefs: Fix missing spaces in journal_entry_dev_usage_to_text
      bcachefs: Align the display format of `btrees/inodes/keys`
      bcachefs: Use filemap_read() to simplify the execution flow
      bcachefs: track writeback errors using the generic tracking infrastructure
      bcachefs: Add tracepoints for bch2_sync_fs() and bch2_fsync()

 MAINTAINERS                            |   1 -
 fs/bcachefs/Makefile                   |   3 +-
 fs/bcachefs/acl.c                      |   4 +-
 fs/bcachefs/alloc_background.c         | 189 +++++---
 fs/bcachefs/alloc_background.h         |  41 +-
 fs/bcachefs/alloc_background_format.h  |   2 +
 fs/bcachefs/alloc_foreground.c         |  20 +-
 fs/bcachefs/alloc_foreground.h         |   1 +
 fs/bcachefs/backpointers.c             |  22 +-
 fs/bcachefs/bcachefs.h                 |  29 +-
 fs/bcachefs/bcachefs_format.h          |  70 +--
 fs/bcachefs/bcachefs_ioctl.h           |  36 +-
 fs/bcachefs/bkey_methods.c             |   1 +
 fs/bcachefs/btree_cache.c              |  16 +-
 fs/bcachefs/btree_cache.h              |   2 +
 fs/bcachefs/btree_gc.c                 | 287 ++++--------
 fs/bcachefs/btree_gc.h                 |  23 +-
 fs/bcachefs/btree_gc_types.h           |  13 +-
 fs/bcachefs/btree_io.c                 |  45 +-
 fs/bcachefs/btree_io.h                 |   6 +-
 fs/bcachefs/btree_iter.c               |  87 ++--
 fs/bcachefs/btree_iter.h               |  15 +-
 fs/bcachefs/btree_journal_iter.c       |  23 +-
 fs/bcachefs/btree_journal_iter.h       |  17 +
 fs/bcachefs/btree_key_cache.c          | 344 ++++++--------
 fs/bcachefs/btree_locking.c            |  12 +-
 fs/bcachefs/btree_locking.h            |   9 +-
 fs/bcachefs/btree_node_scan.c          |  51 ++-
 fs/bcachefs/btree_node_scan_types.h    |   1 +
 fs/bcachefs/btree_trans_commit.c       | 171 ++++---
 fs/bcachefs/btree_types.h              |  19 +-
 fs/bcachefs/btree_update.c             |   6 +-
 fs/bcachefs/btree_update.h             |  36 +-
 fs/bcachefs/btree_update_interior.c    |  42 +-
 fs/bcachefs/btree_update_interior.h    |   2 +
 fs/bcachefs/btree_write_buffer.c       | 138 +++++-
 fs/bcachefs/btree_write_buffer.h       |  49 +-
 fs/bcachefs/btree_write_buffer_types.h |   2 +
 fs/bcachefs/buckets.c                  | 764 +++++++------------------------
 fs/bcachefs/buckets.h                  |  71 +--
 fs/bcachefs/buckets_types.h            |  17 +-
 fs/bcachefs/chardev.c                  | 103 +++--
 fs/bcachefs/checksum.c                 |   5 +-
 fs/bcachefs/clock.c                    |  65 ++-
 fs/bcachefs/clock.h                    |   9 +-
 fs/bcachefs/clock_types.h              |   3 +-
 fs/bcachefs/dirent.c                   |   8 +
 fs/bcachefs/disk_accounting.c          | 790 +++++++++++++++++++++++++++++++++
 fs/bcachefs/disk_accounting.h          | 219 +++++++++
 fs/bcachefs/disk_accounting_format.h   | 162 +++++++
 fs/bcachefs/disk_accounting_types.h    |  19 +
 fs/bcachefs/disk_groups.c              |   2 +-
 fs/bcachefs/ec.c                       | 117 +++--
 fs/bcachefs/errcode.h                  |   3 +-
 fs/bcachefs/error.c                    |  56 ++-
 fs/bcachefs/error.h                    |  22 +-
 fs/bcachefs/extents.c                  |  29 +-
 fs/bcachefs/extents.h                  |   4 +
 fs/bcachefs/eytzinger.h                |  11 +
 fs/bcachefs/fs-common.h                |   2 +
 fs/bcachefs/fs-io-buffered.c           |  41 +-
 fs/bcachefs/fs-io-direct.c             |   4 +-
 fs/bcachefs/fs-io-pagecache.c          |  37 +-
 fs/bcachefs/fs-io-pagecache.h          |   7 +-
 fs/bcachefs/fs-io.c                    |  23 +-
 fs/bcachefs/fs-ioctl.c                 |  80 +++-
 fs/bcachefs/fs.c                       | 209 ++++++---
 fs/bcachefs/fsck.c                     | 280 ++++++------
 fs/bcachefs/inode.c                    |  60 ++-
 fs/bcachefs/inode.h                    |   2 +-
 fs/bcachefs/io_misc.c                  |   6 +-
 fs/bcachefs/io_read.c                  | 114 +++--
 fs/bcachefs/io_write.c                 |  36 +-
 fs/bcachefs/io_write.h                 |   2 +-
 fs/bcachefs/journal.c                  |  17 +-
 fs/bcachefs/journal.h                  |   8 +-
 fs/bcachefs/journal_io.c               |  27 +-
 fs/bcachefs/lru.c                      |   8 +-
 fs/bcachefs/lru.h                      |  12 -
 fs/bcachefs/lru_format.h               |  25 ++
 fs/bcachefs/move.c                     |   2 +-
 fs/bcachefs/movinggc.c                 |  11 +-
 fs/bcachefs/opts.c                     | 120 +++--
 fs/bcachefs/opts.h                     |  15 +-
 fs/bcachefs/printbuf.c                 |  14 +
 fs/bcachefs/printbuf.h                 |   1 +
 fs/bcachefs/recovery.c                 | 134 ++++--
 fs/bcachefs/recovery_passes.c          |   5 +
 fs/bcachefs/recovery_passes_types.h    |   1 +
 fs/bcachefs/reflink.c                  |   2 +-
 fs/bcachefs/replicas.c                 | 251 ++---------
 fs/bcachefs/replicas.h                 |  16 +-
 fs/bcachefs/replicas_types.h           |  16 -
 fs/bcachefs/sb-clean.c                 |  62 ---
 fs/bcachefs/sb-downgrade.c             | 113 ++++-
 fs/bcachefs/sb-downgrade.h             |   1 +
 fs/bcachefs/sb-errors_format.h         |   4 +-
 fs/bcachefs/snapshot.c                 |  24 +-
 fs/bcachefs/subvolume.c                |  20 +-
 fs/bcachefs/super-io.c                 |   5 +-
 fs/bcachefs/super.c                    |  92 ++--
 fs/bcachefs/sysfs.c                    | 126 +++---
 fs/bcachefs/tests.c                    |  14 +-
 fs/bcachefs/thread_with_file.c         |  87 ++--
 fs/bcachefs/thread_with_file.h         |   4 +-
 fs/bcachefs/thread_with_file_types.h   |   5 +-
 fs/bcachefs/trace.h                    |  50 +++
 fs/bcachefs/two_state_shared_lock.h    |  11 +-
 fs/bcachefs/util.h                     |  21 +-
 include/linux/lockdep.h                |   4 +
 include/linux/lockdep_types.h          |   1 +
 kernel/locking/lockdep.c               |   9 +-
 112 files changed, 3876 insertions(+), 2679 deletions(-)
 create mode 100644 fs/bcachefs/disk_accounting.c
 create mode 100644 fs/bcachefs/disk_accounting.h
 create mode 100644 fs/bcachefs/disk_accounting_format.h
 create mode 100644 fs/bcachefs/disk_accounting_types.h
 create mode 100644 fs/bcachefs/lru_format.h

