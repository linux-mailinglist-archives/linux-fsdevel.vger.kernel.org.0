Return-Path: <linux-fsdevel+bounces-24087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D409392FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 19:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64B91F2252F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C116EC18;
	Mon, 22 Jul 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUKyMs/+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B84C2FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668361; cv=none; b=alG3KE07y6djYsZNb+PPg+EoT3EX6i0V1VSYNoBpAvtpBb4EK8V7CshsCXW5R9+x7mqoTc0+k57btnN+MYkNpW7fVrkCOSp73Epp10oCgUlncRJ7CxUYfPkm5OKG7UZ0pBwArXNz4yWEOC9KWTH6IxXcLIMY+Cpa1Ez9VSInDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668361; c=relaxed/simple;
	bh=U+jhlLsB3er5pFyppCFimjnuwAkRV6bPPbh6jjWc0jE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tZ0LbbAoyckP3ZvMkW4N9+HrMot+CuXfm6A9CjuhzHEyFYqL6Evvp3tHJ49Bs4KHpRttDQ0GIxRASTlMKCmSWGmobV/p0PdA2OZtiAJ043xZPzJx6Th5uCxrLhx5gw4H6GSb0F5LhtL05UQxGFCz6mt/guhRhI4G6L4iO7pUsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUKyMs/+; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: torvalds@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721668355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=pNqNFa2jzuKiO2MnZKwQUKkcQt+tLkR5wIAMc1ClXfo=;
	b=IUKyMs/+gD+qEd+dRMAERnFlE7aIXhlZN54eVxLUp+2vFfTRWMHpsaj+CoGbxuYmHdXC3i
	xAW2bcK8k5vfB+Tgnby04TCk82qwZAVYM0GCxhsFa+ktjxoypeG5a3wCT6nL7FZ+toJGEv
	klr0lIfouODklM38MUjW8vU7QQCCofw=
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 22 Jul 2024 13:12:31 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] bcachefs fixes for 6.11-rc1
Message-ID: <xcuhxvqskxdrcjpxufbor3u4ud4sxufofh36y3p4a4y5ovvaqa@ldn4qyogpw2j>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

The following changes since commit a97b43fac5b9b3ffca71b8a917a249789902fce9:

  lockdep: Add comments for lockdep_set_no{validate,track}_class() (2024-07-18 18:33:30 -0400)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2024-07-22

for you to fetch changes up to 737759fc098f7bb7fb4cef64fec731803e955e01:

  bcachefs: Fix printbuf usage while atomic (2024-07-22 11:27:15 -0400)

----------------------------------------------------------------
bcachefs fixes for 6.11-rc1

- another fix for fsck getting stuck, from marcin
- small syzbot fix
- another undefined shift fix

----------------------------------------------------------------
Kent Overstreet (3):
      bcachefs: kill btree_trans_too_many_iters() in bch2_bucket_alloc_freelist()
      bcachefs: More informative error message in reattach_inode()
      bcachefs: Fix printbuf usage while atomic

Tavian Barnes (1):
      bcachefs: mean_and_variance: Avoid too-large shift amounts

 fs/bcachefs/alloc_foreground.c  | 6 ------
 fs/bcachefs/fsck.c              | 7 +++++--
 fs/bcachefs/journal_reclaim.c   | 1 +
 fs/bcachefs/mean_and_variance.h | 6 +++---
 4 files changed, 9 insertions(+), 11 deletions(-)

