Return-Path: <linux-fsdevel+bounces-16073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB88978F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 21:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3801C25DDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58A155301;
	Wed,  3 Apr 2024 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a4vz7mcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B54B1552EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172182; cv=none; b=Nol7B5R98N0uy+DPWRbFP//wJMshzX+IMac2RYul0+qfYIveWfrRXmY6cr96AEOt1tc+taV8YTe5QFWCwQfPr3cbCXr7fhJF5KcFQoKb1IBEfROR1TmND1r2zhcQbSy6EPE4RmkqQaxPjQmV3u/kqG2XO5XSFTjM0L4GSifSaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172182; c=relaxed/simple;
	bh=GVnRWla4xNbGmuFq8dajbu07/OAKHmUyR3VegVUzplc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HA3b5qIn91ZBAn9AO1V2Zc6PCWEPzqT9KWOIGeGKM8dSpRNz3fCIgQS7p3iuLLRcnMzaqyOOgDSzBXZ511EYLpn/56O6PGDSpfmiGZWGW+mTUJDSQOnemEz06FAImhxJKQHw1dvGamYbXOeaXNFbFXXRwqvlofkN7qzI1Uzc9Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a4vz7mcC; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 3 Apr 2024 15:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712172177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=oJ71vK/IWYBLmY4Zs39AWEq/G+0AYqB3O096BbL43Mw=;
	b=a4vz7mcC3yuS8wd5N6caKekggrMEGVTrUK304YZGjokJ318RRh0JBjwqyABNf8y7XzaWzs
	PzMlLRf0AUJkmimLhqIU9GdXD6BBKTWREMEspzeM9/bqI/vwEt+RS3XwaCo3d2BPQ632Kq
	H3GkBr3cPReZXTQCBoLMcs4u7i5GOys=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs repair code for rc3
Message-ID: <nqkz5ed4k5vhhnmr5m32jydfgnon3hv7rj2vl6jywz6h44cjqp@olraxajp3avu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, another bcachefs pull for you - this one is the new repair
code.

Cheers,
Kent

The following changes since commit b3c7fd35c03c17a950737fb56a06b730a7962d28:

  bcachefs: On emergency shutdown, print out current journal sequence number (2024-04-01 01:07:24 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-04-03

for you to fetch changes up to 09d4c2acbf4c864fef0f520bbcba256c9a19102e:

  bcachefs: reconstruct_inode() (2024-04-03 14:46:51 -0400)

----------------------------------------------------------------
bcachefs repair code for 6.9-rc3

A couple more small fixes, and new repair code.

We can now automatically recover from arbitrary corrupted interior btree
nodes by scanning, and we can reconstruct metadata as needed to bring a
filesystem back into a working, consistent, read-write state and
preserve access to whatevver wasn't corrupted.

Meaning - you can blow away all metadata except for extents and dirents
leaf nodes, and repair will reconstruct everything else and give you
your data, and under the correct paths. If inodes are missing i_size
will be slightly off and permissions/ownership/timestamps will be gone,
and we do still need the snapshots btree if snapshots were in use - in
the future we'll be able to guess the snapshot tree structure in some
situations.

IOW - aside from shaking out remaining bugs (fuzz testing is still
coming), repair code should be complete and if repair ever doesn't work
that's the highest priority bug that I want to know about immediately.

This patchset was kindly tested by a user from India who accidentally
wiped one drive out of a three drive filesystem with no replication on
the family computer - it took a couple weeks but we got everything
important back.

----------------------------------------------------------------
Guenter Roeck (1):
      mean_and_variance: Drop always failing tests

Kent Overstreet (18):
      bcachefs: Fix btree node reserve
      bcachefs: BCH_WATERMARK_interior_updates
      bcachefs: fix nocow lock deadlock
      bcachefs: Improve bch2_btree_update_to_text()
      bcachefs: Check for bad needs_discard before doing discard
      bcachefs: ratelimit informational fsck errors
      bcachefs: Clear recovery_passes_required as they complete without errors
      bcachefs: bch2_shoot_down_journal_keys()
      bcachefs: Etyzinger cleanups
      bcachefs: bch2_btree_root_alloc() -> bch2_btree_root_alloc_fake()
      bcachefs: Don't skip fake btree roots in fsck
      bcachefs: Repair pass for scanning for btree nodes
      bcachefs: Topology repair now uses nodes found by scanning to fill holes
      bcachefs: Flag btrees with missing data
      bcachefs: Reconstruct missing snapshot nodes
      bcachefs: Check for extents that point to same space
      bcachefs: Subvolume reconstruction
      bcachefs: reconstruct_inode()

 fs/bcachefs/Makefile                 |   2 +
 fs/bcachefs/alloc_background.c       |  47 ++--
 fs/bcachefs/alloc_foreground.c       |   4 +-
 fs/bcachefs/alloc_types.h            |   3 +-
 fs/bcachefs/backpointers.c           | 173 +++++++++++-
 fs/bcachefs/bcachefs.h               |   5 +
 fs/bcachefs/bcachefs_format.h        |   1 +
 fs/bcachefs/btree_gc.c               | 306 ++++++++++++++--------
 fs/bcachefs/btree_io.c               |  15 +-
 fs/bcachefs/btree_journal_iter.c     |  19 ++
 fs/bcachefs/btree_journal_iter.h     |   4 +
 fs/bcachefs/btree_node_scan.c        | 495 +++++++++++++++++++++++++++++++++++
 fs/bcachefs/btree_node_scan.h        |  11 +
 fs/bcachefs/btree_node_scan_types.h  |  30 +++
 fs/bcachefs/btree_trans_commit.c     |   3 +-
 fs/bcachefs/btree_update_interior.c  |  57 ++--
 fs/bcachefs/btree_update_interior.h  |  26 +-
 fs/bcachefs/buckets.h                |   1 +
 fs/bcachefs/data_update.c            |   3 +-
 fs/bcachefs/extents.c                |  52 ++--
 fs/bcachefs/extents.h                |   1 +
 fs/bcachefs/eytzinger.c              | 234 +++++++++++++++++
 fs/bcachefs/eytzinger.h              |  63 +++--
 fs/bcachefs/fsck.c                   | 227 ++++++++++++++--
 fs/bcachefs/journal_seq_blacklist.c  |   3 +-
 fs/bcachefs/mean_and_variance_test.c |  28 +-
 fs/bcachefs/opts.h                   |   4 +-
 fs/bcachefs/recovery.c               | 108 +++++---
 fs/bcachefs/recovery.h               |   2 +
 fs/bcachefs/recovery_passes.c        |  42 ++-
 fs/bcachefs/recovery_passes_types.h  |   2 +
 fs/bcachefs/replicas.c               |  19 +-
 fs/bcachefs/sb-errors_types.h        |   5 +-
 fs/bcachefs/snapshot.c               | 173 +++++++++++-
 fs/bcachefs/snapshot.h               |  26 +-
 fs/bcachefs/super-io.c               |   9 +-
 fs/bcachefs/super.c                  |   3 +
 fs/bcachefs/util.c                   | 143 ----------
 fs/bcachefs/util.h                   |  14 +-
 39 files changed, 1869 insertions(+), 494 deletions(-)
 create mode 100644 fs/bcachefs/btree_node_scan.c
 create mode 100644 fs/bcachefs/btree_node_scan.h
 create mode 100644 fs/bcachefs/btree_node_scan_types.h
 create mode 100644 fs/bcachefs/eytzinger.c

