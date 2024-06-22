Return-Path: <linux-fsdevel+bounces-22176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15497913450
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 16:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FA61C218EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 14:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D616F82E;
	Sat, 22 Jun 2024 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M0t2dPWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6131552E1
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Jun 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719064835; cv=none; b=k8pgKhnea1BPqm/GrxswHKNPcFPUjjU59xIbcsflk/UYuSELsvaTheAytHtw7r+cGOQn68rMzGm/Vee6tO8nPXyxJbjwkoAD5VrGI2w6Bl7Hx7k0B3ENxVXZIhlOJX0NYtXWhrGFVjb0GKhcxMvjbEChRn4sVnhetune+dyaY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719064835; c=relaxed/simple;
	bh=fs6lZuo2LUc1dax5XxIA4Tuxi1wzIBvcoBGSs24+ExE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ljdHc3QWqzG+lkFspYs8KwRab1ZHRI2ez6scGeVAnDZkPQJTb07SuJIRRVGMBpij0LKqug7FJiRrHlT1G3xURjf5yk5EYPT6uESDywl5PVLdJ/aoOX6hoRKMLjNmZkyAJAcqhKgqhritF6wKDz0GkK0FP6s/p7VjUpWWa0x89xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M0t2dPWY; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719064830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5u24kxgSySrZQXwxrbt603z/pcXZVEqocR9DEgAawuc=;
	b=M0t2dPWYtgK2mgJU7uhtotSGzpTYNTxfa4vJW428fdsIDouoNqhs98A33dgRyAwOOiDZ8G
	pqJuWXKRhSecMi57Fc0N7xnoG6VsfdS4yZ8jifN5chygrRVMCaQR+rD7ikK6qyWD1kkmHT
	vpwT5GcAasmG91mV8mW03xqTaL4jIdw=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Sat, 22 Jun 2024 10:00:27 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10-rc5
Message-ID: <nbed7rrwexwonrtxvv6zmlxrvheicxxx6vlzcq4hzcxhrtm7ps@s5nkcab6f3cp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, fresh batch of fixes for you,

Cheers,
Kent

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-22

for you to fetch changes up to bd4da0462ea7bf26b2a5df5528ec20c550f7ec41:

  bcachefs: Move the ei_flags setting to after initialization (2024-06-21 10:17:07 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10-rc5

Lots of (mostly boring) fixes for syzbot bugs and rare(r) CI bugs.

The LRU_TIME_BITS fix was slightly more involved; we only have 48 bits
for the LRU position (we would prefer 64), so wraparound is possible for
the cached data LRUs on a filesystem that has done sufficient
(petabytes) reads; this is now handled.

One notable user reported bugfix, where we were forgetting to correctly
set the bucket data type, which should have been BCH_DATA_need_gc_gens
instead of BCH_DATA_free; this was causing us to go emergency read-only
on a filesystem that had seen heavy enough use to see bucket gen
wraparoud.

We're now starting to fix simple (safe) errors without requiring user
intervention - i.e. a small incremental step towards full self healing.
This is currently limited to just certain allocation information
counters, and the error is still logged in the superblock; see that
patch for more information. ("bcachefs: Fix safe errors by default").

----------------------------------------------------------------
Kent Overstreet (20):
      bcachefs: Fix initialization order for srcu barrier
      bcachefs: Fix array-index-out-of-bounds
      bcachefs: Fix a locking bug in the do_discard_fast() path
      bcachefs: Fix shift overflow in read_one_super()
      bcachefs: Fix btree ID bitmasks
      bcachefs: Check for invalid btree IDs
      bcachefs: Fix early init error path in journal code
      bcachefs: delete_dead_snapshots() doesn't need to go RW
      bcachefs: Guard against overflowing LRU_TIME_BITS
      bcachefs: Handle cached data LRU wraparound
      bcachefs: Fix bch2_sb_downgrade_update()
      bcachefs: set_worker_desc() for delete_dead_snapshots
      bcachefs: Fix bch2_trans_put()
      bcachefs: Fix safe errors by default
      closures: Change BUG_ON() to WARN_ON()
      bcachefs: Fix missing alloc_data_type_set()
      bcachefs: Replace bare EEXIST with private error codes
      bcachefs: Fix I_NEW warning in race path in bch2_inode_insert()
      bcachefs: Use bch2_print_string_as_lines for long err
      bcachefs: Fix a UAF after write_super()

Youling Tang (2):
      bcachefs: fix alignment of VMA for memory mapped files on THP
      bcachefs: Move the ei_flags setting to after initialization

 fs/bcachefs/alloc_background.c |  76 ++++--
 fs/bcachefs/alloc_background.h |   8 +-
 fs/bcachefs/bcachefs.h         |   5 +
 fs/bcachefs/bcachefs_format.h  |  13 +-
 fs/bcachefs/bkey.c             |   2 +-
 fs/bcachefs/bkey_methods.c     |   6 +-
 fs/bcachefs/bkey_methods.h     |   3 +-
 fs/bcachefs/btree_iter.c       |  11 +-
 fs/bcachefs/btree_types.h      |  16 +-
 fs/bcachefs/errcode.h          |   3 +
 fs/bcachefs/error.c            |  19 +-
 fs/bcachefs/error.h            |   7 -
 fs/bcachefs/fs-ioctl.c         |   2 +-
 fs/bcachefs/fs.c               |  21 +-
 fs/bcachefs/journal.c          |   3 +
 fs/bcachefs/journal_io.c       |  13 +-
 fs/bcachefs/lru.h              |   3 -
 fs/bcachefs/opts.h             |   2 +-
 fs/bcachefs/recovery.c         |  12 +-
 fs/bcachefs/sb-downgrade.c     |   2 +-
 fs/bcachefs/sb-errors_format.h | 559 +++++++++++++++++++++--------------------
 fs/bcachefs/snapshot.c         |   9 +-
 fs/bcachefs/str_hash.h         |   2 +-
 fs/bcachefs/super-io.c         |   7 +-
 fs/bcachefs/super.c            |  13 +-
 lib/closure.c                  |  10 +-
 26 files changed, 472 insertions(+), 355 deletions(-)

