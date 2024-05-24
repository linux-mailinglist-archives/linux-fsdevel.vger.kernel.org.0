Return-Path: <linux-fsdevel+bounces-20113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA3E8CE61E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4D1C21B8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 13:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2812BEAE;
	Fri, 24 May 2024 13:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aL5TcvMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93231272DC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2024 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557029; cv=none; b=JpEZWl2eKhnqof5DJU8cgj+zBThSdpHsgZhCJBcuRL+SkV/ENeH97N9bshbiM+mN46UapIdgdLGt2gG6gjMlve0xP6lGE9uSlnXOWpDYpcmlX349mSolwWkyrXwaxGAWyZtzxO3lgaEGJLH/KSxYGzSPEd4/Rc1Vgd09GwAIXbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557029; c=relaxed/simple;
	bh=9M+Jfutkj+3xFQXRZrdiDpsrzCMNEVrBpKHHCVV94K0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qs0pinT4bAtgKgZSCDuyVYroQNeM2Rg7ji/I3Mx6UTC+Nn1dP+eODLTw36dlkBCjHNOxsHkDSCtvY9mzPKIKJ8IHu2k5MC/fHDq1qdExekjzyKMVuZ68B9zTxQf2d6mLkSLEvIpBiWCifzVyTd8ETSwAO1LDUuE6PWK53DWqFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aL5TcvMd; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716557024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=yawCa/zMhfVB+WtgnLQ25RsWeDGEuNkEkDSE1kcE66E=;
	b=aL5TcvMd3lk5CCclv+OGux6AYuDyhaKI02HIqsrrBlyd/bdEwwPLhrCAA4Aab0bq8KUcPD
	FZSjyQqBDEKX3WvJ2HDTOdEulj9D3eBd/IDUoaf6nfM6rOSeiLmNRVxPNUzwRsggVIwFV5
	MoWfoglS2UxtpTrEdfyjAgXzQvQhK5Q=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 24 May 2024 09:23:41 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10-rc1
Message-ID: <34o5tkmaecep7kccwzgwe4yzbkayhb5wkqukthj5may75yvqgn@43rljzrmlmmn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Nothing exciting, just syzbot fixes (except for the one
FMODE_CAN_ODIRECT patch).

Looks like syzbot reports have slowed down; this is all catch up from
two weeks of conferences.

Next hardening project is using Thomas's error injection tooling to
torture test repair.

The following changes since commit eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c:

  Merge tag 'mm-nonmm-stable-2024-05-19-11-56' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2024-05-19 14:02:03 -0700)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-05-24

for you to fetch changes up to d93ff5fa40b9db5f505d508336bc171f54db862e:

  bcachefs: Fix race path in bch2_inode_insert() (2024-05-22 20:37:47 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10-rc1

Just a few syzbot fixes

----------------------------------------------------------------
Kent Overstreet (17):
      bcachefs: Fix rcu splat in check_fix_ptrs()
      bcachefs: Fix ref in trans_mark_dev_sbs() error path
      bcachefs: Fix shift overflow in btree_lost_data()
      bcachefs: Fix shift overflows in replicas.c
      bcachefs: Improve bch2_assert_pos_locked()
      bcachefs: Fix missing parens in drop_locks_do()
      bcachefs: Add missing guard in bch2_snapshot_has_children()
      bcachefs: Fix bch2_alloc_ciphers()
      bcachefs: bch2_checksum() returns 0 for unknown checksum type
      bcachefs: Check for subvolues with bogus snapshot/inode fields
      bcachefs: Fix bogus verify_replicas_entry() assert
      bcachefs: Fix btree_trans leak in bch2_readahead()
      bcachefs: Fix stack oob in __bch2_encrypt_bio()
      bcachefs: Fix unsafety in bch2_dirent_name_bytes()
      bcachefs: Fix shutdown ordering
      bcachefs: Ensure we're RW before journalling
      bcachefs: Fix race path in bch2_inode_insert()

Youling Tang (1):
      bcachefs: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method

 fs/bcachefs/bcachefs_format.h |  6 ++++++
 fs/bcachefs/btree_iter.c      |  2 ++
 fs/bcachefs/btree_iter.h      |  2 +-
 fs/bcachefs/buckets.c         | 13 +++++++------
 fs/bcachefs/checksum.c        | 37 ++++++++++++++++++++----------------
 fs/bcachefs/dirent.c          |  3 +++
 fs/bcachefs/fs-io-buffered.c  |  4 ++--
 fs/bcachefs/fs.c              |  6 +++---
 fs/bcachefs/printbuf.c        |  7 +++++++
 fs/bcachefs/recovery.c        |  7 ++++++-
 fs/bcachefs/replicas.c        | 44 ++++++++++++++++++++++---------------------
 fs/bcachefs/sb-errors_types.h |  4 +++-
 fs/bcachefs/snapshot.h        |  7 ++-----
 fs/bcachefs/subvolume.c       |  9 +++++++++
 fs/bcachefs/super.c           |  2 +-
 15 files changed, 96 insertions(+), 57 deletions(-)

