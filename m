Return-Path: <linux-fsdevel+bounces-22780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E130891C13B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 16:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4EC11C2103E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77971C0DC9;
	Fri, 28 Jun 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGUhr/Q+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E31C0DEC
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585559; cv=none; b=MrGakVV32Tlp/oIL4lXQ34M8QTg5Uus8Sjth0jh6KeYtaziQLXNiyQi6Tba6b8rPBA+djhbXQRXdOIf9I+4c/d4i2RYYqewQtro5bWFvYk8fq60lUZuBLbTXT+XHAdpzfbZtiI+kfC6Md2FgVOyYuY2IgvRg3dBAzoz1gVfarp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585559; c=relaxed/simple;
	bh=DnPbeFhnpqo7ICi6RF3F2geQeT0KbWfD+cwPIsOtWoc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e6zLYt/16ujx0mXD15DYpAD/Q9L16g3M8TLIp+HiwBPQ8SOLVl87NFWtca2Vj98KIwXhfl5lssP1HGOuf5eBFhnk73V3BYtD3KxFDab/iO50H4djfiYGlpczfzlop8wtM/NFdKsw+6XJxkcXhtU5TZwkiLuQz7R9INtmRpmxsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGUhr/Q+; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719585555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=d/hVC8tJYHzflhtDbd2o075Ru39jFiSORBp8C8axaVU=;
	b=uGUhr/Q+8TWgW3+NPJRnDhMwJ0tl9QM0ehv4wnF5gt//Y//SfZPyLBjMmny6GW5n5y2wux
	8KY6zSCJvn49wSBD4oCVoC7of+QCTwVZeHXLItRyOCbQQoa2M1svIpyz4Z/Jlzhv6ttkco
	eS8OTEOfHhKU6J7v/vZWTj1GKLb6ftM=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 28 Jun 2024 10:39:11 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.10-rc6
Message-ID: <2taurilom54hdpzwsk5qwfln3elficdoarykhakvmhaoneg455@iylhhiq7mauv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, fresh batch of fixes for you...

Cheers,
Kent

The following changes since commit bd4da0462ea7bf26b2a5df5528ec20c550f7ec41:

  bcachefs: Move the ei_flags setting to after initialization (2024-06-21 10:17:07 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-06-28

for you to fetch changes up to 64cd7de998f393e73981e2aa4ee13e4e887f01ea:

  bcachefs: Fix kmalloc bug in __snapshot_t_mut (2024-06-25 20:51:14 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.10-rc6

simple stuff:
- null ptr/err ptr deref fixes
- fix for getting wedged on shutdown after journal error

- fix missing recalc_capacity() call, capacity now changes correctly
  after a device goes read only

  however: our capacity calculation still doesn't take into account when
  we have mixed ro/rw devices and the ro devices have data on them,
  that's going to be a more involved fix to separate accounting for
  "capacity used on ro devices" and "capacity used on rw devices"

- boring syzbot stuff

slightly more involved:
- discard, invalidate workers are now per device
  this has the effect of simplifying how we take device refs in these
  paths, and the device ref cleanup fixes a longstanding race between
  the device removal path and the discard path

- fixes for how the debugfs code takes refs on btree_trans objects
  we have debugfs code that prints in use btree_trans objects. It uses
  closure_get() on trans->ref, which is mainly for the cycle detector,
  but the debugfs code was using it on a closure that may have hit 0,
  which is not allowed; for performance reasons we cannot avoid having
  not-in-use transactions on the global list.

  introduce some new primitives to fix this and make the synchronization
  here a whole lot saner

----------------------------------------------------------------
Kent Overstreet (10):
      bcachefs: Fix freeing of error pointers
      bcachefs: fix seqmutex_relock()
      bcachefs: Make btree_deadlock_to_text() clearer
      closures: closure_get_not_zero(), closure_return_sync()
      bcachefs: Fix race between trans_put() and btree_transactions_read()
      bcachefs: Fix btree_trans list ordering
      bcachefs: Add missing recalc_capacity() call
      bcachefs: Fix null ptr deref in journal_pins_to_text()
      bcachefs: Add missing bch2_journal_do_writes() call
      bcachefs: Discard, invalidate workers are now per device

Pei Li (3):
      bcachefs: slab-use-after-free Read in bch2_sb_errors_from_cpu
      bcachefs: Fix shift-out-of-bounds in bch2_blacklist_entries_gc
      bcachefs: Fix kmalloc bug in __snapshot_t_mut

 fs/bcachefs/alloc_background.c      | 263 +++++++++++++++++++-----------------
 fs/bcachefs/alloc_background.h      |   6 +-
 fs/bcachefs/alloc_foreground.c      |   4 +-
 fs/bcachefs/bcachefs.h              |  16 ++-
 fs/bcachefs/btree_iter.c            |  19 +--
 fs/bcachefs/chardev.c               |   9 +-
 fs/bcachefs/debug.c                 | 109 +++++++++------
 fs/bcachefs/journal.c               |   5 +
 fs/bcachefs/journal_io.c            |   7 +
 fs/bcachefs/journal_seq_blacklist.c |   2 +-
 fs/bcachefs/sb-errors.c             |  14 +-
 fs/bcachefs/seqmutex.h              |  11 +-
 fs/bcachefs/snapshot.c              |   3 +
 fs/bcachefs/super.c                 |   6 +-
 include/linux/closure.h             |  23 ++++
 lib/closure.c                       |  52 ++++++-
 16 files changed, 342 insertions(+), 207 deletions(-)

