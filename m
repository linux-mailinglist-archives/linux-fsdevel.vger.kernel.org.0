Return-Path: <linux-fsdevel+bounces-29788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD2697DE86
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 21:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138391F21A7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Sep 2024 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082C6762C1;
	Sat, 21 Sep 2024 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NabXvlP+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF843BBC1
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Sep 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726946891; cv=none; b=q4oG/59obeC8uwqHR2xKJPGxYL6e9ZV7+nF2UwrEPM+D29I3MYI4/RPfko6izQalR3iMj/9o6EDEXeeiTlh7KeZK8yPmvg78BmJC8FOGxuHshDO0sp1xxhenP8quWcdIpRu0U10bcqOQnZsfN9BtP8jgidIS8z+e71rVWzuL42M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726946891; c=relaxed/simple;
	bh=yJRE5a9yv1MoadkgcUX1MA9cZ1ciGYxfDxwQ5Sz7YbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UdvJz4j9mRiyyJzdgBBwZGVsg6+EBULtzkJEEvaw/aoOHlZMwj+cwVIkO2ZRCCxqWUH9vPbm8Fr5q7EKPfhRKA03BeH6JpK9mevmOW6Uk1jqfE0u0Cl5syjeDsv7HkzjOMjTH48qbZ/2zU8qnsHxlo6wJyZn5V1J1UtPWMaklRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NabXvlP+; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 21 Sep 2024 15:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726946883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QvN+A4k/j4uBbpGNGBjBwlpS9XEVr9N8qPafYhHwVvc=;
	b=NabXvlP+sCmXCLQ+f+jRvwXjtEijuHIA/2OQouI6avWjSvSiIvUKwbYkARp50r0tmb4dId
	OwZhw7Sw+o+ki/nG/B5I1SU7iS6VfvxSF+jbsQCJmqyzMPTgaBLZLoN9I4TRnQ7BrnQtsD
	hlWe2GRkjWXCIHYp7kq/ngeBD1u73vg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Relatively quiet cycle here - which is good, because 6.11 was huge.

I think we'll be able to take off EXPERIMENTAL in inside of a year, see
below for more.

Cheers,
Kent

The following changes since commit 16005147cca41a0f67b5def2a4656286f8c0db4a:

  bcachefs: Don't delete open files in online fsck (2024-09-09 09:41:47 -0400)

are available in the Git repository at:

  git://evilpiepirate.org/bcachefs.git tags/bcachefs-2024-09-21

for you to fetch changes up to 025c55a4c7f11ea38521c6e797f3192ad8768c93:

  bcachefs: return err ptr instead of null in read sb clean (2024-09-21 11:39:49 -0400)

----------------------------------------------------------------
bcachefs changes for 6.12-rc1

rcu_pending, btree key cache rework: this solves lock contenting in the
key cache, eliminating the biggest source of the srcu lock hold time
warnings, and drastically improving performance on some metadata heavy
workloads - on multithreaded creates we're now 3-4x faster than xfs.

We're now using an rhashtable instead of the system inode hash table;
this is another significant performance improvement on multithreaded
metadata workloads, eliminating more lock contention.

for_each_btree_key_in_subvolume_upto(): new helper for iterating over
keys within a specific subvolume, eliminating a lot of open coded
"subvolume_get_snapshot()" and also fixing another source of srcu lock
time warnings, by running each loop iteration in its own transaction (as
the existing for_each_btree_key() does).

More work on btree_trans locking asserts; we now assert that we don't
hold btree node locks when trans->locked is false, which is important
because we don't use lockdep for tracking individual btree node locks.

Some cleanups and improvements in the bset.c btree node lookup code,
from Alan.

Rework of btree node pinning, which we use in backpointers fsck. The old
hacky implementation, where the shrinker just skipped over nodes in the
pinned range, was causing OOMs; instead we now use another shrinker with
a much higher seeks number for pinned nodes.

Rebalance now uses BCH_WRITE_ONLY_SPECIFIED_DEVS; this fixes an issue
where rebalance would sometimes fall back to allocating from the full
filesystem, which is not what we want when it's trying to move data to a
specific target.

Use __GFP_ACCOUNT, GFP_RECLAIMABLE for btree node, key cache
allocations.

Idmap mounts are now supported - Hongbo.

Rename whiteouts are now supported - Hongbo.

Erasure coding can now handle devices being marked as failed, or
forcibly removed. We still need the evacuate path for erasure coding,
but it's getting very close to ready for people to start using.

Status, and when will we be taking off experimental:
----------------------------------------------------

Going by critical, user facing bugs getting found and fixed, we're
nearly there. There are a couple key items that need to be finished
before we can take off the experimental label:

- The end-user experience is still pretty painful when the root
  filesystem needs a fsck; we need some form of limited self healing so
  that necessary repair gets run automatically. Errors (by type) are
  recorded in the superblock, so what we need to do next is convert
  remaining inconsistent() errors to fsck() errors (so that all runtime
  inconsistencies are logged in the superblock), and we need to go
  through the list of fsck errors and classify them by which fsck passes
  are needed to repair them.

- We need comprehensive torture testing for all our repair paths, to
  shake out remaining bugs there. Thomas has been working on the tooling
  for this, so this is coming soonish.

Slightly less critical items:

- We need to improve the end-user experience for degraded mounts: right
  now, a degraded root filesystem means dropping to an initramfs shell
  or somehow inputting mount options manually (we don't want to allow
  degraded mounts without some form of user input, except on unattended
  servers) - we need the mount helper to prompt the user to allow
  mounting degraded, and make sure this works with systemd.

- Scalabiity: we have users running 100TB+ filesystems, and that's
  effectively the limit right now due to fsck times. We have some
  reworks in the pipeline to address this, we're aiming to make petabyte
  sized filesystems practical.

----------------------------------------------------------------
Alan Huang (8):
      bcachefs: Remove unused parameter of bkey_mantissa
      bcachefs: Remove unused parameter of bkey_mantissa_bits_dropped
      bcachefs: Remove dead code in __build_ro_aux_tree
      bcachefs: Convert open-coded extra computation to helper
      bcachefs: Minimize the search range used to calculate the mantissa
      bcachefs: Remove the prev array stuff
      bcachefs: Remove unused parameter
      bcachefs: Refactor bch2_bset_fix_lookup_table

Alyssa Ross (1):
      bcachefs: Fix negative timespecs

Chen Yufan (1):
      bcachefs: Convert to use jiffies macros

Diogo Jahchan Koike (1):
      bcachefs: return err ptr instead of null in read sb clean

Feiko Nanninga (1):
      bcachefs: Fix sysfs rebalance duration waited formatting

Hongbo Li (2):
      bcachefs: support idmap mounts
      bcachefs: Fix compilation error for bch2_sb_member_alloc

Julian Sun (4):
      bcachefs: remove the unused macro definition
      bcachefs: fix macro definition allocate_dropping_locks_errcode
      bcachefs: fix macro definition allocate_dropping_locks
      bcachefs: remove the unused parameter in macro bkey_crc_next

Kent Overstreet (68):
      inode: make __iget() a static inline
      bcachefs: switch to rhashtable for vfs inodes hash
      bcachefs: Fix deadlock in __wait_on_freeing_inode()
      lib/generic-radix-tree.c: genradix_ptr_inlined()
      lib/generic-radix-tree.c: add preallocation
      bcachefs: rcu_pending
      bcachefs: rcu_pending now works in userspace
      bcachefs: Rip out freelists from btree key cache
      bcachefs: key cache can now allocate from pending
      bcachefs: data_allowed is now an opts.h option
      bcachefs: bch2_opt_set_sb() can now set (some) device options
      bcachefs: Opt_durability can now be set via bch2_opt_set_sb()
      bcachefs: Add check for btree_path ref overflow
      bcachefs: Btree path tracepoints
      bcachefs: kill bch2_btree_iter_peek_and_restart()
      bcachefs: bchfs_read(): call trans_begin() on every loop iter
      bcachefs: bch2_fiemap(): call trans_begin() on every loop iter
      bcachefs: for_each_btree_key_in_subvolume_upto()
      bcachefs: bch2_readdir() -> for_each_btree_key_in_subvolume_upto
      bcachefs: bch2_xattr_list() -> for_each_btree_key_in_subvolume_upto
      bcachefs: bch2_seek_data() -> for_each_btree_key_in_subvolume_upto
      bcachefs: bch2_seek_hole() -> for_each_btree_key_in_subvolume_upto
      bcachefs: range_has_data() -> for_each_btree_key_in_subvolume_upto
      bcachefs: bch2_folio_set() -> for_each_btree_key_in_subvolume_upto
      bcachefs: quota_reserve_range() -> for_each_btree_key_in_subvolume_upto
      bcachefs: Move rebalance_status out of sysfs/internal
      bcachefs: promote_whole_extents is now a normal option
      bcachefs: trivial open_bucket_add_buckets() cleanup
      bcachefs: bch2_sb_nr_devices()
      bcachefs: Drop memalloc_nofs_save() in bch2_btree_node_mem_alloc()
      bcachefs: bch2_time_stats_reset()
      bcachefs: Assert that we don't lock nodes when !trans->locked
      bcachefs: darray: convert to alloc_hooks()
      bcachefs: Switch gc bucket array to a genradix
      bcachefs: Add pinned to btree cache not freed counters
      bcachefs: do_encrypt() now handles allocation failures
      bcachefs: convert __bch2_encrypt_bio() to darray
      bcachefs: kill redundant is_vmalloc_addr()
      bcachefs: fix prototype to bch2_alloc_sectors_start_trans()
      bcachefs: BCH_WRITE_ALLOC_NOWAIT no longer applies to open bucket allocation
      bcachefs: rebalance writes use BCH_WRITE_ONLY_SPECIFIED_DEVS
      bcachefs: Use __GFP_ACCOUNT for reclaimable memory
      bcachefs: Use mm_account_reclaimed_pages() when freeing btree nodes
      bcachefs: Options for recovery_passes, recovery_passes_exclude
      bcachefs: Move tabstop setup to bch2_dev_usage_to_text()
      bcachefs: bch2_dev_remove_alloc() -> alloc_background.c
      bcachefs: bch2_sb_member_alloc()
      bcachefs: improve "no device to read from" message
      bcachefs: bch2_opts_to_text()
      bcachefs: Progress indicator for extents_to_backpointers
      bcachefs: bch2_dev_rcu_noerror()
      bcachefs: Failed devices no longer require mounting in degraded mode
      bcachefs: Don't count "skipped access bit" as touched in btree cache scan
      bcachefs: btree cache counters should be size_t
      bcachefs: split up btree cache counters for live, freeable
      bcachefs: Rework btree node pinning
      bcachefs: EIO errcode cleanup
      bcachefs: stripe_to_mem()
      bcachefs: bch_stripe.disk_label
      bcachefs: ec_stripe_head.nr_created
      bcachefs: improve bch2_new_stripe_to_text()
      bcachefs: improve error message on too few devices for ec
      bcachefs: improve error messages in bch2_ec_read_extent()
      bcachefs: bch2_trigger_ptr() calculates sectors even when no device
      bcachefs: bch2_dev_remove_stripes()
      bcachefs: bch_fs.rw_devs_change_count
      bcachefs: bch2_ec_stripe_head_get() now checks for change in rw devices
      bcachefs: Don't drop devices with stripe pointers

Matthew Wilcox (Oracle) (1):
      bcachefs: Do not check folio_has_private()

Nathan Chancellor (1):
      bcachefs: Fix format specifier in bch2_btree_key_cache_to_text()

Reed Riley (1):
      bcachefs: Replace div_u64 with div64_u64 where second param is u64

Sasha Finkelstein (1):
      bcachefs: Hook up RENAME_WHITEOUT in rename.

Thorsten Blum (3):
      bcachefs: Annotate struct bucket_array with __counted_by()
      bcachefs: Annotate struct bch_xattr with __counted_by()
      bcachefs: Annotate bch_replicas_entry_{v0,v1} with __counted_by()

Xiaxi Shen (1):
      bcachefs: Fix a spelling error in docs

Yang Li (1):
      bcachefs: Remove duplicated include in backpointers.c

Youling Tang (4):
      bcachefs: allocate inode by using alloc_inode_sb()
      bcachefs: Mark bch_inode_info as SLAB_ACCOUNT
      bcachefs: drop unused posix acl handlers
      bcachefs: Simplify bch2_xattr_emit() implementation

 Documentation/filesystems/bcachefs/CodingStyle.rst |   2 +-
 fs/bcachefs/Kconfig                                |   7 +
 fs/bcachefs/Makefile                               |   1 +
 fs/bcachefs/acl.c                                  |   2 +-
 fs/bcachefs/alloc_background.c                     |  45 +-
 fs/bcachefs/alloc_background.h                     |   3 +-
 fs/bcachefs/alloc_foreground.c                     |  59 +-
 fs/bcachefs/alloc_foreground.h                     |   5 +-
 fs/bcachefs/backpointers.c                         | 106 +++-
 fs/bcachefs/backpointers.h                         |  23 +-
 fs/bcachefs/bcachefs.h                             |  14 +-
 fs/bcachefs/bcachefs_format.h                      |   2 +
 fs/bcachefs/bset.c                                 | 182 +++---
 fs/bcachefs/bset.h                                 |   4 +-
 fs/bcachefs/btree_cache.c                          | 273 ++++++---
 fs/bcachefs/btree_cache.h                          |   3 +
 fs/bcachefs/btree_gc.c                             |  21 +-
 fs/bcachefs/btree_io.c                             |   8 +-
 fs/bcachefs/btree_io.h                             |   4 +-
 fs/bcachefs/btree_iter.c                           |  63 +-
 fs/bcachefs/btree_iter.h                           |  52 +-
 fs/bcachefs/btree_key_cache.c                      | 405 +++----------
 fs/bcachefs/btree_key_cache_types.h                |  18 +-
 fs/bcachefs/btree_locking.h                        |  13 +-
 fs/bcachefs/btree_trans_commit.c                   |   2 +-
 fs/bcachefs/btree_types.h                          |  60 +-
 fs/bcachefs/btree_update.c                         |  12 +-
 fs/bcachefs/btree_update_interior.c                |  37 +-
 fs/bcachefs/btree_update_interior.h                |   2 +
 fs/bcachefs/buckets.c                              |  35 +-
 fs/bcachefs/buckets.h                              |  15 +-
 fs/bcachefs/buckets_types.h                        |   8 -
 fs/bcachefs/checksum.c                             | 101 ++--
 fs/bcachefs/clock.h                                |   9 -
 fs/bcachefs/darray.c                               |   4 +-
 fs/bcachefs/darray.h                               |  26 +-
 fs/bcachefs/data_update.c                          |   2 +-
 fs/bcachefs/dirent.c                               |  66 +--
 fs/bcachefs/ec.c                                   | 303 +++++++---
 fs/bcachefs/ec.h                                   |  11 +-
 fs/bcachefs/ec_format.h                            |   9 +-
 fs/bcachefs/ec_types.h                             |   1 +
 fs/bcachefs/errcode.h                              |  14 +-
 fs/bcachefs/extents.c                              |  33 +-
 fs/bcachefs/extents.h                              |  24 +-
 fs/bcachefs/fs-common.c                            |   5 +-
 fs/bcachefs/fs-io-buffered.c                       |  41 +-
 fs/bcachefs/fs-io-direct.c                         |   2 +-
 fs/bcachefs/fs-io-pagecache.c                      |  90 ++-
 fs/bcachefs/fs-io-pagecache.h                      |   4 +-
 fs/bcachefs/fs-io.c                                | 178 ++----
 fs/bcachefs/fs-ioctl.c                             |   4 +-
 fs/bcachefs/fs.c                                   | 427 +++++++++-----
 fs/bcachefs/fs.h                                   |  18 +-
 fs/bcachefs/inode.c                                |   2 +-
 fs/bcachefs/io_read.c                              |  18 +-
 fs/bcachefs/io_write.c                             |   7 +-
 fs/bcachefs/journal_io.c                           |   6 +-
 fs/bcachefs/journal_reclaim.c                      |   7 +-
 fs/bcachefs/opts.c                                 |  85 ++-
 fs/bcachefs/opts.h                                 |  61 +-
 fs/bcachefs/rcu_pending.c                          | 650 +++++++++++++++++++++
 fs/bcachefs/rcu_pending.h                          |  27 +
 fs/bcachefs/rebalance.c                            |   3 +
 fs/bcachefs/recovery.c                             |  22 +-
 fs/bcachefs/recovery_passes.c                      |  10 +-
 fs/bcachefs/replicas.c                             |  10 +-
 fs/bcachefs/replicas_format.h                      |   9 +-
 fs/bcachefs/sb-clean.c                             |   2 +-
 fs/bcachefs/sb-members.c                           |  57 ++
 fs/bcachefs/sb-members.h                           |  22 +-
 fs/bcachefs/str_hash.h                             |   2 +-
 fs/bcachefs/subvolume.h                            |  45 ++
 fs/bcachefs/subvolume_types.h                      |   3 +-
 fs/bcachefs/super-io.c                             |  12 +-
 fs/bcachefs/super.c                                |  85 +--
 fs/bcachefs/sysfs.c                                |  55 +-
 fs/bcachefs/thread_with_file.c                     |   2 +-
 fs/bcachefs/time_stats.c                           |  14 +
 fs/bcachefs/time_stats.h                           |   3 +-
 fs/bcachefs/trace.h                                | 465 ++++++++++++++-
 fs/bcachefs/util.c                                 |  16 +-
 fs/bcachefs/util.h                                 |   2 +-
 fs/bcachefs/xattr.c                                |  81 +--
 fs/bcachefs/xattr_format.h                         |   2 +-
 fs/inode.c                                         |   8 -
 include/linux/fs.h                                 |   9 +-
 include/linux/generic-radix-tree.h                 | 105 +++-
 lib/generic-radix-tree.c                           |  80 +--
 89 files changed, 3155 insertions(+), 1690 deletions(-)
 create mode 100644 fs/bcachefs/rcu_pending.c
 create mode 100644 fs/bcachefs/rcu_pending.h

