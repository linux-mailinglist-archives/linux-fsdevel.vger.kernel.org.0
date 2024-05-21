Return-Path: <linux-fsdevel+bounces-19934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9688CB3C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BDB81C20E3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D92148FFE;
	Tue, 21 May 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D4AnLMwV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D77A148FEC
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317044; cv=none; b=UpetCk1tXp9Y4xUsbchITtjFN9f/DSlaCXe+pEbr1A0dnOiSNFOyVRRjq36LDuFnIngkv4j1NuXVT8WQMvAiDbyncGtXaIEhbi0IEdwXS6cYgs/L7V3QZnCCO5XTZLHVQtP9LaxOqULZM9kBuzU6Jbwdkr1umy97R/Tl0MarMxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317044; c=relaxed/simple;
	bh=PXHsMsPE2xx/n+2w5D6ApBwcu+LDA3PzrdBQxd5CGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Bdr72Egl4545gYeD7EC84wwR12u6cU5my4LlmSsF81YFcn4dUSmR6SBt/j6aGPw15rCAiN8iRG7YjXLS5Rnxnw6Sz0naAOA+f5j37wEGD1eBEPD88yLMCg5MdfvIAX1jpUdurIfsBU3t+KMv2Q2tYx9dpLDehbcP61V4D9x3jRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D4AnLMwV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=EqKeww21i2+UfHcKL21ydpcQf1JC5Knv/WgG50vquWc=; b=D4AnLMwVl1w2kWp4zz00UVADOb
	1n2jyLQ2j4+UiTrQPtPq4fPyYYhiAHkJ6HzfK0iXCPBs5dkzr0sgVCADVbqx+5vllvL1BNxvLfdzN
	J4llOFB4srhijanJ/E49pIs6hGuVjE5ryQmnQa0noctDJEDxYKzWi04VRbNOuQWeauIQUw/JsbL+I
	z1UYHcMsthCA1Mzj8hhiQ8zDaeTzMi4YHGHF+mZr2qhcf8VmEnIXENjCtvxBgPrh8DMQlKXvtCWDX
	py2nGImhGxhSEKPmeB3neEwWJAecex/snIHUJb1hZStx3HGCewASwvGFyIz9m4tCbXtKGkQqQnjW6
	usW/ZSPQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s9USt-00FdAG-1I;
	Tue, 21 May 2024 18:43:59 +0000
Date: Tue, 21 May 2024 19:43:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git misc stuff
Message-ID: <20240521184359.GR2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Stuff that should've been pushed in the last merge window,
but had fallen through the cracks ;-/

	One trivial conflict in io_uring.c/rw.c:io_write()
(with removal of call_write_iter()).

The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-misc

for you to fetch changes up to 7c98f7cb8fda964fbc60b9307ad35e94735fa35f:

  remove call_{read,write}_iter() functions (2024-04-15 16:03:25 -0400)

----------------------------------------------------------------
Assorted commits that had missed the last merge window...

----------------------------------------------------------------
Al Viro (5):
      close_on_exec(): pass files_struct instead of fdtable
      fd_is_open(): move to fs/file.c
      get_file_rcu(): no need to check for NULL separately
      kernel_file_open(): get rid of inode argument
      do_dentry_open(): kill inode argument

Miklos Szeredi (1):
      remove call_{read,write}_iter() functions

 drivers/block/loop.c              |  4 ++--
 drivers/target/target_core_file.c |  4 ++--
 fs/aio.c                          |  4 ++--
 fs/cachefiles/namei.c             |  3 +--
 fs/file.c                         | 19 ++++++++-----------
 fs/open.c                         | 11 +++++------
 fs/overlayfs/util.c               |  2 +-
 fs/proc/fd.c                      |  4 +---
 fs/read_write.c                   | 12 ++++++------
 fs/splice.c                       |  4 ++--
 include/linux/fdtable.h           | 15 +++++----------
 include/linux/fs.h                | 14 +-------------
 io_uring/rw.c                     |  4 ++--
 13 files changed, 38 insertions(+), 62 deletions(-)

