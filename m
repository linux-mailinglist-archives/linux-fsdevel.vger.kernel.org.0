Return-Path: <linux-fsdevel+bounces-19865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA338CA776
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 06:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97FA42822AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 04:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D802B9BC;
	Tue, 21 May 2024 04:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZaQB3+59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90288405E6
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 04:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716266258; cv=none; b=kB/KfPR2JGo49mEA8NtGiCt2euVqZyqAE6iU58FMFeGC70okatnCJO4wLfzC4zuvLHObNQli106zEiJ0p6vBHr20c6iP+rZKi3LvtStnm3GqT1YS5UDwgV3RCb0OIUV63YFs9CYMCjr0qsiXI0nMGRVjmcc5LVjGdEQsfMyQfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716266258; c=relaxed/simple;
	bh=uB7PyB8D4B3Os7vTAf/1yX/eqevHcbrWLU9OEnA22Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=b8KscppLK4B/hVRQOFpeRGIKoKiSbxR6Pnbqt91cQOzPqL8Tcr7uq08s6b7SY1WLxtRmuIOsYvxJSMxFi+yFqOvsPiE0mywZz7m/qqd11Iy8qmnmwqjehVEtxdv77J49pMCaR6krR6Fg8jLmJ4FiG374dIb4IBTC3aOaHP25osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZaQB3+59; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=tZ7FP2RZRevwkb3Ny4Mt3+wpL/t9PL2UlVMBZtK6su4=; b=ZaQB3+59q9UlSUCDoIzZaR+MTh
	I4DncbmGO56tiK/HOJCBR+NgZHlOaHwq8V4VnGhW5NC22l5nK/Z2YRF3D+nvQolV4VZkXv5tTkml5
	SZbv3oIc/7dFpsIkDisSA69l5O3g7mQmy/+mk2exDGsucUHQwZNbSIc68H528AjQ0HDV0CJ9mlRwD
	g76YC3vRk8SZ/5s6PvAvZpj/M3VSuLQBd373pWjqNVwz++iF+ywnsgsdkYi3BwoUwFj86jiVK0rb5
	XnVMebQrplVj1UQTSfbBa1LR1ff6QTqVAxaQkT/44EQPCp+azdgA5NPspt1XAXQSmTdRMROzmu75Z
	+V+Fb1Iw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s9HFj-00ELMp-1t;
	Tue, 21 May 2024 04:37:31 +0000
Date: Tue, 21 May 2024 05:37:31 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [git pull] vfs.git set_blocksize() (bdev pile 1)
Message-ID: <20240521043731.GO2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

First bdev-related pile - set_blocksize() stuff

The following changes since commit 0bbac3facb5d6cc0171c45c9873a2dc96bea9680:

  Linux 6.9-rc4 (2024-04-14 13:38:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-set_blocksize

for you to fetch changes up to d18a8679581e8d1166b68e211d16c5349ae8c38c:

  make set_blocksize() fail unless block device is opened exclusive (2024-05-02 17:39:44 -0400)

----------------------------------------------------------------
getting rid of bogus set_blocksize() uses, switching it
to struct file * and verifying that caller has device
opened exclusively.

----------------------------------------------------------------
Al Viro (9):
      bcache_register(): don't bother with set_blocksize()
      pktcdvd: sort set_blocksize() calls out
      swapon(2)/swapoff(2): don't bother with block size
      swapon(2): open swap with O_EXCL
      zram: don't bother with reopening - just use O_EXCL for open
      swsusp: don't bother with setting block size
      btrfs_get_bdev_and_sb(): call set_blocksize() only for exclusive opens
      set_blocksize(): switch to passing struct file *
      make set_blocksize() fail unless block device is opened exclusive

 Documentation/filesystems/porting.rst |  7 +++++++
 block/bdev.c                          | 14 ++++++++++----
 block/ioctl.c                         | 21 ++++++++++++---------
 drivers/block/pktcdvd.c               |  7 +------
 drivers/block/zram/zram_drv.c         | 29 +++++++----------------------
 drivers/block/zram/zram_drv.h         |  2 +-
 drivers/md/bcache/super.c             |  4 ----
 fs/btrfs/dev-replace.c                |  2 +-
 fs/btrfs/volumes.c                    | 13 ++++++++-----
 fs/ext4/super.c                       |  2 +-
 fs/reiserfs/journal.c                 |  5 ++---
 fs/xfs/xfs_buf.c                      |  2 +-
 include/linux/blkdev.h                |  2 +-
 include/linux/swap.h                  |  2 --
 kernel/power/swap.c                   |  7 +------
 mm/swapfile.c                         | 29 ++---------------------------
 16 files changed, 55 insertions(+), 93 deletions(-)

