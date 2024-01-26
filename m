Return-Path: <linux-fsdevel+bounces-9136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC583E6EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9F6B256E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A866560DCC;
	Fri, 26 Jan 2024 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="neuwBrnZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2077D60BB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 23:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311446; cv=none; b=p1esgiYn/JJH5Nb4HWc+kiF2jhzZAMNUtkz381mJEoaj7c9TYCqMx2QJNO4VHwwT6QE2myPaDWAKSPmHZgfquqIX+aQnPPM1c8j6c9DMCs855eYHAtQ6aHFY9qW8uDTwMvYRU5uGyN9zdp7RJsI4hKo3ZpRntjTy0/3BURr9KwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311446; c=relaxed/simple;
	bh=9k0+0MRRScrtJmXZnrTBg0SOltDF/bYgIYtRGEDzy3g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BEdXKmM5wBqDp/7PYp/8UV+zwLJlIiZkR2EluGga28FS8VUWgLu0Sl5B0D2jze2yhGAvZSKkzrpBUdM6HQgMYjcAPRLJC09PtLCPIaWz8FRh35pNY4dfHGpmZutPiXmcEY7fltoYzx+2/AYszJ5/zSuFVFy8ME24jXBXEleCJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=neuwBrnZ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jan 2024 18:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706311440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3IVct3oI0LRYRN4Y8WqiNTFlsssxyg4vCK9ZmvlVxXM=;
	b=neuwBrnZEJIB+yNMzfBSGZNpOSIQlBIWIazfFK84rDJdeS1n4Bzc9j+Q0Ox7r4FiEWhg+f
	MBt26b0cGUU1Ef4aIV9zPhf2tTIBXn5oTO5Z1tDigJatLwhxK1x7U5yzWSi2wjm/cXMgEm
	H/1xYS1l6DSpmEaw7p8Tw/Z69vhBjbQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.8-rc2
Message-ID: <5refsn7ruuo654gyiou74x2xdisjuulkqpnaj34xnncwyq2wos@etq73tlxpcyq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus, couple bcachefs fixes for you

Cheers,
Kent

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-01-26

for you to fetch changes up to d2fda304bb739b97c1a3e46e39700eb49f07a62c:

  bcachefs: __lookup_dirent() works in snapshot, not subvol (2024-01-25 20:02:11 -0500)

----------------------------------------------------------------
bcachefs fixes for v6.8-rc2

 - fix for REQ_OP_FLUSH usage; this fixes filesystems going read only
   with -EOPNOTSUPP from the block layer.

   (this really should have gone in with the block layer patch causing
   the -EOPNOTSUPP, or should have gone in before).
 - fix an allocation in non-sleepable context
 - fix one source of srcu lock latency, on devices with terrible discard
   latency
 - fix a reattach_inode() issue in fsck

----------------------------------------------------------------
Christoph Hellwig (1):
      bcachefs: fix incorrect usage of REQ_OP_FLUSH

Kent Overstreet (3):
      bcachefs: Add gfp flags param to bch2_prt_task_backtrace()
      bcachefs: discard path uses unlock_long()
      bcachefs: __lookup_dirent() works in snapshot, not subvol

 fs/bcachefs/alloc_background.c |  2 +-
 fs/bcachefs/btree_locking.c    |  4 ++--
 fs/bcachefs/debug.c            |  2 +-
 fs/bcachefs/fs-io.c            |  2 +-
 fs/bcachefs/fsck.c             | 23 ++++++++++++-----------
 fs/bcachefs/journal.c          |  2 +-
 fs/bcachefs/journal_io.c       |  3 ++-
 fs/bcachefs/str_hash.h         | 22 +++++++++++++++-------
 fs/bcachefs/util.c             | 10 +++++-----
 fs/bcachefs/util.h             |  4 ++--
 10 files changed, 42 insertions(+), 32 deletions(-)

