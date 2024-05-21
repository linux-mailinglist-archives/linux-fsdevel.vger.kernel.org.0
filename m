Return-Path: <linux-fsdevel+bounces-19933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892B8CB38C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAF31F2196F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EC31487F7;
	Tue, 21 May 2024 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r/Rnhh2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119C2B9A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316530; cv=none; b=mli5NLvjRsj3vCuddoQ6OFPvCyhdoDjrcKnON2uIthgNe2rfzhLM3YOPC7I49K4KM+V0GCh+CxvIjGH2MqGhvXPhGindTbG1wWckKNhTYd4UQk8ubkfRlVKCSBqUQviQP2bqg2kCM2b6f5l2M5NYhx21jjUa5ByrQYhTmb0hnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316530; c=relaxed/simple;
	bh=q5xr3TZCnUhp5u+RIeVoi5bxokVuZtYnTZOdqiaTpzc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pgvdmloCnNZ64Bt70WBDllbU0hpzIld8gtTLpStA+SyfSxYvlDoWOn4XLBqNzWy/EKF9BRBclbaDIRkCm6URMYPO9L71GyQPvUYdfdHeib6qRe756CaLwtq+JYQ2IyE+LbBPEKRYA9Njy7VlW84XCakB9jZ5excmhDYcLQES2x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r/Rnhh2t; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Hq2MADPhwPt7G/wMZILLbhikX6P6yDoF3w4pQm3OHOI=; b=r/Rnhh2to+mpfZqfIFJMayB73u
	l6CjrvJYZje9YAZvZuAPn3veAcDWry48zMcwBbBpthlCl164Tdji5vU8IMjaNE/ygc62atMJTpfXb
	4QAfYJaySn6G+LXky/XoPMAnjeakcozbvbDLo9Ox+uXZIDWp6q44rdWdgtpK5A1ctP86iSB9jaCl5
	xJ0T2+al13wPw5BleYOwvYczT379TdPXMAss3bYxGa822YS1iwzdUDUS9ko0rpDN4NKeSHoDSeR8u
	qpb9wQVzSb0ChEQhlw1WBuN9acpSCPrvfUqRjxDWNPZlbni1vKNGWeVJnlAL2hgX09+fvhrWq+Q1s
	k2atH3qw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s9UKa-00Fc0v-1s;
	Tue, 21 May 2024 18:35:24 +0000
Date: Tue, 21 May 2024 19:35:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [git pull] vfs.git last bdev series
Message-ID: <20240521183524.GQ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	bdev flags pile.  Two trivial conflicts (block/bdev.c and block/blk-core.c)
and one place block/blk-zoned.c where git does not detect a conflict between
the access to ->bd_has_submit_bio added in mainline and switch of ->bd_has_submit_bio
checks to bdev_test_flag() in this branch.  #merge-candidate contains proposed
resolution.  So does (tree-identical) #pull-bd_flags-3, with the branch rebased
on top of bd_inode-1 merge - same resulting tree, easier on git blame, but that
one does have a rebase.  If you would prefer a pull request for that one, just
say so...

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-bd_flags-2

for you to fetch changes up to 811ba89a8838e7c43ff46b6210ba1878bfe4437e:

  bdev: move ->bd_make_it_fail to ->__bd_flags (2024-05-02 20:04:18 -0400)

----------------------------------------------------------------
	Compactifying bdev flags

We can easily have up to 24 flags with sane
atomicity, _without_ pushing anything out
of the first cacheline of struct block_device.

----------------------------------------------------------------
Al Viro (8):
      Use bdev_is_paritition() instead of open-coding it
      wrapper for access to ->bd_partno
      bdev: infrastructure for flags
      bdev: move ->bd_read_only to ->__bd_flags
      bdev: move ->bd_write_holder into ->__bd_flags
      bdev: move ->bd_has_subit_bio to ->__bd_flags
      bdev: move ->bd_ro_warned to ->__bd_flags
      bdev: move ->bd_make_it_fail to ->__bd_flags

 block/bdev.c              | 17 ++++++++---------
 block/blk-core.c          | 17 ++++++++++-------
 block/blk-mq.c            |  2 +-
 block/early-lookup.c      |  2 +-
 block/genhd.c             | 15 ++++++++++-----
 block/ioctl.c             |  5 ++++-
 block/partitions/core.c   | 12 ++++++------
 include/linux/blk_types.h | 17 +++++++++--------
 include/linux/blkdev.h    | 26 +++++++++++++++++++++++---
 include/linux/part_stat.h |  2 +-
 lib/vsprintf.c            |  4 ++--
 11 files changed, 75 insertions(+), 44 deletions(-)

