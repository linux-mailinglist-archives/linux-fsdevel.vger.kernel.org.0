Return-Path: <linux-fsdevel+bounces-56064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E4B129B4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B8189EB37
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87811F8EEC;
	Sat, 26 Jul 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="YbTCLtVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF4414A82
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753516948; cv=none; b=cE23pi0bPgHs49InpPSts4s0mJA4z/IWu2mzyfjw2BBK5/267ev1tWziVhBb2+HYok7MeOHnUY55c/GWDvkOhGOfud5skgbWpx6RKqH7PmtLqciOFnojNi5eznRwa4eU1cib44UjNGZ9WIk3SiJ6yNY+eFiNhmAllKSmdJqoWO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753516948; c=relaxed/simple;
	bh=e2hY6xsTklJLVrYUlkrrnWRdZsJpGkHsbG+y4TZre3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUOwn6Z29MjrK1KjGo7i+Lq0uqnU/o4phFzRlVHnyHsmZInN+zpoVSb3AHCKvQEdDhQ+8rEvgcbHgfJHzVxxru1QDsvSg6panCcrPTuUgtRzO1XPXUMZ5Cc0AraH0uBOszPfyGy3IcQEVK8bI/ltue28FUGsRbpAknR40x1dmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=YbTCLtVT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cLiqKbD/ZDrtsH8y5I5Mb37CsSVfGUFrMJZ7yleB0K8=; b=YbTCLtVTLNMbsJX8MwRxaQp8sb
	Gr3YqY+5rsVgA6QRqpFXPGAjIqzHm/AwcsLlPcv6k8qll5917T+FUdw+cji7NCMB8kjqaKa1Tox6X
	RHhhcTX1YpAZzM/o15bswmhTOzKIFJGm3IvBgcuEO423YpXBlbSzC2E/xIPbfpTanmcruB7aqBZaS
	uvJZs83Qm4wlDZ7+9Jg4pvctFYjvuVUa1NB8oprb+5gZybHQwgVjSbaQRL43ZqZPW1dKyFWQkA2nz
	yLDhXC84W9bt/jqg+5nuEhc/Oa73CC14uUW2yS1DHgk4dkwoy+ycuHlx1JpUei/qrjEUaTy5GHh6t
	/l24qk9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZrM-000000067L9-2thC;
	Sat, 26 Jul 2025 08:02:24 +0000
Date: Sat, 26 Jul 2025 09:02:24 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 2/9: simple_recursive_removal
Message-ID: <20250726080224.GA1456602@ZenIV>
References: <20250726080119.GA222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250726080119.GA222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-simple_recursive_removal

for you to fetch changes up to bad356bb50e64170f8af14a00797a04313846aeb:

  functionfs, gadgetfs: use simple_recursive_removal() (2025-07-02 22:36:52 -0400)

----------------------------------------------------------------
        Removing subtrees of kernel filesystems is done in quite a few
places; unfortunately, it's easy to get wrong.  A number of open-coded
attempts are out there, with varying amount of bogosities.

	simple_recursive_removal() had been introduced for doing that with
all precautions needed; it does an equivalent of rm -rf, with sufficient
locking, eviction of anything mounted on top of the subtree, etc.

	This series converts a bunch of open-coded instances to using that.

----------------------------------------------------------------
Al Viro (9):
      simple_recursive_removal(): saner interaction with fsnotify
      better lockdep annotations for simple_recursive_removal()
      add locked_recursive_removal()
      spufs: switch to locked_recursive_removal()
      binfmt_misc: switch to locked_recursive_removal()
      pstore: switch to locked_recursive_removal()
      fuse_ctl: use simple_recursive_removal()
      kill binderfs_remove_file()
      functionfs, gadgetfs: use simple_recursive_removal()

 arch/powerpc/platforms/cell/spufs/inode.c | 49 ++++++-------------------------
 drivers/android/binder.c                  |  2 +-
 drivers/android/binder_internal.h         |  2 --
 drivers/android/binderfs.c                | 15 ----------
 drivers/usb/gadget/function/f_fs.c        |  3 +-
 drivers/usb/gadget/legacy/inode.c         |  7 +----
 fs/binfmt_misc.c                          | 44 ++-------------------------
 fs/fuse/control.c                         | 30 ++++++++-----------
 fs/fuse/fuse_i.h                          |  6 ----
 fs/libfs.c                                | 32 ++++++++++++++------
 fs/pstore/inode.c                         |  5 ++--
 include/linux/fs.h                        |  2 ++
 12 files changed, 55 insertions(+), 142 deletions(-)

