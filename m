Return-Path: <linux-fsdevel+bounces-56065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75E5B129B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6A917459B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAD78F4C;
	Sat, 26 Jul 2025 08:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="M0zHPy7b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDD14A82
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517010; cv=none; b=tMMxVxy8ZF4A8kVwUwle2AWRzauq5A5daC2sbmgXulGID42X4uCAAR+yCmZMUchVFQftrpwncha/ka0XBHODozzhDNmSBZJHDtj0TnxeQbUWflUmi6+P+pbB+sB5ydsPQyHwN97LANNiF2+iKGoEvYVbr+tJAHwyHu5d8iV+45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517010; c=relaxed/simple;
	bh=ZwigSY9z+xSRzu3DKge87K4aD8yMpVGUyKyzaO6fJPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0PoyKVJroPYwAuucUIVzpvP/4xD2/s04hoXzRYy3BF7iEfda6jMfT3qLnoALfOl0pclgcOzLsZm35IZnZSUBG7kVylw+mo7vlfwoOcpA27kltBkAKmkbxogdzDGC+qvc+l2aLrkBbLF0FSZ+T7hPqF4ltJaX+elQ9d5IRtWlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=M0zHPy7b; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IG8ffiCcWb8EMWY328Tyls2GyxVaNDgpHX3LsA0RH24=; b=M0zHPy7bOGhHdahLHEgGLXqhLW
	eBwccSDivh0rz7zp3nXMiOJmiJv6enkmJvvweZYkpjfKzfJLYMgCBuereewSE/IsNoSZ+u8SQPZYa
	OPgv5bRUeBIrTMekES+d6pp4Xuztd5SnE2qFTSNBjruGSmANF1oYhCwHpEMRWC30i30MBDTRCTDKF
	96oYtEgDrbLBbQpk95sNWnBo2oLGffqv3BtO4f19K133C+M6lqPvnASY++swaDUH0n3NTv0X4fZNI
	rOFHUQ6Qtot3ETLT4fwPr1Jl0RwOA3ie1PvSaGI7Ldx5FBUg4rKSa+spKkedRslAqJvS7oaOAjfd9
	qU4l+Dig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZsM-000000067lT-3Eee;
	Sat, 26 Jul 2025 08:03:26 +0000
Date: Sat, 26 Jul 2025 09:03:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 3/9: rpc_pipefs
Message-ID: <20250726080326.GB1456602@ZenIV>
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

[the first couple of commits is shared with #work.simple_recursive_removal]

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-rpc_pipefs

for you to fetch changes up to 350db61fbeb940502a16e74153ee5954d03622e9:

  rpc_create_client_dir(): return 0 or -E... (2025-07-02 22:44:55 -0400)

----------------------------------------------------------------
Massage rpc_pipefs to use saner primitives and clean up the
APIs provided to the rest of the kernel.

----------------------------------------------------------------
Al Viro (18):
      simple_recursive_removal(): saner interaction with fsnotify
      better lockdep annotations for simple_recursive_removal()
      new helper: simple_start_creating()
      rpc_pipe: clean failure exits in fill_super
      rpc_{rmdir_,}depopulate(): use simple_recursive_removal() instead
      rpc_unlink(): use simple_recursive_removal()
      rpc_populate(): lift cleanup into callers
      rpc_unlink(): saner calling conventions
      rpc_mkpipe_dentry(): saner calling conventions
      rpc_pipe: don't overdo directory locking
      rpc_pipe: saner primitive for creating subdirectories
      rpc_pipe: saner primitive for creating regular files
      rpc_mkpipe_dentry(): switch to simple_start_creating()
      rpc_gssd_dummy_populate(): don't bother with rpc_populate()
      rpc_pipe: expand the calls of rpc_mkdir_populate()
      rpc_new_dir(): the last argument is always NULL
      rpc_create_client_dir(): don't bother with rpc_populate()
      rpc_create_client_dir(): return 0 or -E...

 fs/debugfs/inode.c                 |  21 +-
 fs/libfs.c                         |  34 ++-
 fs/nfs/blocklayout/rpc_pipefs.c    |  53 ++--
 fs/nfs/nfs4idmap.c                 |  14 +-
 fs/nfsd/nfs4recover.c              |  49 ++--
 fs/tracefs/inode.c                 |  15 +-
 include/linux/fs.h                 |   1 +
 include/linux/sunrpc/rpc_pipe_fs.h |   6 +-
 net/sunrpc/auth_gss/auth_gss.c     |  13 +-
 net/sunrpc/clnt.c                  |  36 +--
 net/sunrpc/rpc_pipe.c              | 530 ++++++++++---------------------------
 11 files changed, 230 insertions(+), 542 deletions(-)

