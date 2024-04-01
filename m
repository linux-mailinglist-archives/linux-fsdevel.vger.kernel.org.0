Return-Path: <linux-fsdevel+bounces-15844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD789472D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 00:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFE3F1F21CD5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52656457;
	Mon,  1 Apr 2024 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OZi7IvUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE69255C3C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009682; cv=none; b=Vopg6IyvvSuIGQoMK0kkVF0maUzfpViH8U/GelU94eLH9AckvDDzdKzd/sdKN31yrsjIl2yzXSVZIgxrKYahIUPJ5m45j4+0nN9pfkPPh0e3wx9QASc0KL3/aDhk0BFDNHcdDqsqtqQ7bbx+g5yi6Bbk+JhOU2V41spAZk4TVaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009682; c=relaxed/simple;
	bh=MjGqFgbLiJngHsC+x8lJzfQ8/qv8sVvv3614U6dNFA0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f1D7m3wOs4Wgw/zFzee00GN4VOZVAiQZaqbT/Bo6mv3LVmp3FFbfk6vZDO8t25MaltQNTYb9jYhd2u7e2h+aj3gig+8qTQp5l4v+dBz7iXF0cQvcweBwpu16YAEiu44Ct5g+n968AduG4grMTz7cLwmbU63py7b8BaL5LI6OLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OZi7IvUJ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 1 Apr 2024 18:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712009677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=BfmOeck52USxlYrFywRN2KplNKbKixLNHS46Bpx9pJw=;
	b=OZi7IvUJuvh3R2bbRtwhZMXIjLXRaICjv8lecKm/T4fEaySegES7+KVTVe3euKjvzaT/XI
	WfFgHtQ1ATGr3lgq0OnuLJ5xDwU0LNurawnZfOntvpImPvGoHMHF/lhJL5jc2RwWV07xKm
	6KUyfYCFuGVa8n1jM7gP8n1o1khD1/k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.9-rc3
Message-ID: <wwkqc7ugdewzde6gdej5bi6kb3bsvoqzqkexxejcl64d5r3pow@46qmmqq5wx4y>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, some bcachefs fixes for you.

Cheers,
Kent

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-01

for you to fetch changes up to b3c7fd35c03c17a950737fb56a06b730a7962d28:

  bcachefs: On emergency shutdown, print out current journal sequence number (2024-04-01 01:07:24 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.9-rc3

Lots of fixes for situations with extreme filesystem damage. One fix
("Fix journal pins in btree write buffer") applicable to normal usage;
also a dio performance fix.

New repair/construction code is in the final stages, should be ready in
about a week. Anyone that lost btree interior nodes (or a variety of
other damage) as a result of the splitbrain bug will be able to repair
then.

----------------------------------------------------------------
Hongbo Li (1):
      bcachefs: fix trans->mem realloc in __bch2_trans_kmalloc

Kent Overstreet (29):
      bcachefs: Fix assert in bch2_backpointer_invalid()
      bcachefs: Fix journal pins in btree write buffer
      bcachefs: fix mount error path
      bcachefs: Add an assertion for trying to evict btree root
      bcachefs: Move snapshot table size to struct snapshot_table
      bcachefs: Add checks for invalid snapshot IDs
      bcachefs: Don't do extent merging before journal replay is finished
      bcachefs: btree_and_journal_iter now respects trans->journal_replay_not_finished
      bcachefs: Be careful about btree node splits during journal replay
      bcachefs: Improved topology repair checks
      bcachefs: Check btree ptr min_key in .invalid
      bcachefs: Fix btree node keys accounting in topology repair path
      bcachefs: Fix use after free in bch2_check_fix_ptrs()
      bcachefs: Fix repair path for missing indirect extents
      bcachefs: Fix use after free in check_root_trans()
      bcachefs: Kill bch2_bkey_ptr_data_type()
      bcachefs: Fix bch2_btree_increase_depth()
      bcachefs: fix backpointer for missing alloc key msg
      bcachefs: Split out recovery_passes.c
      bcachefs: Add error messages to logged ops fns
      bcachefs: Resume logged ops after fsck
      bcachefs: Flush journal immediately after replay if we did early repair
      bcachefs: Ensure bch_sb_field_ext always exists
      bcachefs: bch2_run_explicit_recovery_pass_persistent()
      bcachefs: Improve -o norecovery; opts.recovery_pass_limit
      bcachefs: Logged op errors should be ignored
      bcachefs: Fix remove_dirent()
      bcachefs: Fix overlapping extent repair
      bcachefs: On emergency shutdown, print out current journal sequence number

Thomas Bertschinger (1):
      bcachefs: fix misplaced newline in __bch2_inode_unpacked_to_text()

zhuxiaohui (1):
      bcachefs: add REQ_SYNC and REQ_IDLE in write dio

 fs/bcachefs/Makefile                               |   1 +
 fs/bcachefs/backpointers.c                         |  13 +-
 fs/bcachefs/backpointers.h                         |  32 ++-
 fs/bcachefs/bcachefs.h                             |   3 +-
 fs/bcachefs/bset.c                                 |  14 +-
 fs/bcachefs/bset.h                                 |   2 +
 fs/bcachefs/btree_cache.c                          |   5 +-
 fs/bcachefs/btree_gc.c                             | 206 ++++----------
 fs/bcachefs/btree_io.c                             |   3 +-
 fs/bcachefs/btree_iter.c                           |  52 +++-
 fs/bcachefs/btree_journal_iter.c                   |  29 +-
 fs/bcachefs/btree_journal_iter.h                   |   4 +-
 fs/bcachefs/btree_trans_commit.c                   |   2 +-
 fs/bcachefs/btree_update.c                         |   6 +
 fs/bcachefs/btree_update_interior.c                | 151 +++++++---
 fs/bcachefs/btree_update_interior.h                |   2 +
 fs/bcachefs/btree_write_buffer.c                   |  14 +
 fs/bcachefs/buckets.c                              |  12 +-
 fs/bcachefs/chardev.c                              |   2 +-
 fs/bcachefs/data_update.c                          |   9 +
 fs/bcachefs/errcode.h                              |   3 +-
 fs/bcachefs/error.c                                |   6 +-
 fs/bcachefs/error.h                                |   6 +
 fs/bcachefs/extents.c                              |   9 +-
 fs/bcachefs/extents.h                              |  24 --
 fs/bcachefs/fs-io-direct.c                         |   4 +-
 fs/bcachefs/fs.c                                   |   1 +
 fs/bcachefs/fsck.c                                 |  37 ++-
 fs/bcachefs/inode.c                                |   2 +-
 fs/bcachefs/io_misc.c                              |   2 +
 fs/bcachefs/logged_ops.c                           |   7 +-
 fs/bcachefs/opts.c                                 |   4 +
 fs/bcachefs/opts.h                                 |   7 +-
 fs/bcachefs/recovery.c                             | 304 +++------------------
 fs/bcachefs/recovery.h                             |  32 +--
 fs/bcachefs/recovery_passes.c                      | 225 +++++++++++++++
 fs/bcachefs/recovery_passes.h                      |  17 ++
 .../{recovery_types.h => recovery_passes_types.h}  |   9 +-
 fs/bcachefs/reflink.c                              |   3 +-
 fs/bcachefs/sb-downgrade.c                         |   2 +-
 fs/bcachefs/sb-errors_types.h                      |   4 +-
 fs/bcachefs/snapshot.c                             |  35 ++-
 fs/bcachefs/snapshot.h                             |  63 ++---
 fs/bcachefs/subvolume.c                            |  72 +++++
 fs/bcachefs/subvolume.h                            |   3 +
 fs/bcachefs/subvolume_types.h                      |   2 +
 fs/bcachefs/super-io.c                             |   2 +-
 fs/bcachefs/super.c                                |  13 +-
 48 files changed, 814 insertions(+), 646 deletions(-)
 create mode 100644 fs/bcachefs/recovery_passes.c
 create mode 100644 fs/bcachefs/recovery_passes.h
 rename fs/bcachefs/{recovery_types.h => recovery_passes_types.h} (94%)

