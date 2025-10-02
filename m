Return-Path: <linux-fsdevel+bounces-63207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A165BB2916
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 07:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AEE3212F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 05:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7F265CBB;
	Thu,  2 Oct 2025 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V/DlD+b0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9C7081C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759384638; cv=none; b=Vaun9dZTSFQzLWpcAldrixcTKbRHyk/IORsqmVD484kJBZqncG/tatC/cJZVq/JivncKdJu8LZ4Jz3qm04bgUEhrLg/Z0gnJ2DojxlxullnxavPaPRhnl9nbt7VtSx7joL0+8p3LnZRfnMA17uH4fWSEAb7GOP3SB3QsyUG/J+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759384638; c=relaxed/simple;
	bh=KEwQXhUZEbNKPnn2Yu4oat6WS2XPIkgMOrmrEuGRS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hcxt8khSGcoLg4epe5sicm5mPKjpbWpuYIMieKl2Wgn8wVAd/AQY10/tZnO6VHOzXEVD/KQxIt4eLVtS0/8TksIJSI1zQ4qC/6CzPcrz7/myZ3AyciSMYS/R092XlTgUrOcGMUXNLwCXEl9WR/Cgn3N85d7zTOMD/USp2X5k4T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V/DlD+b0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=FXYcV00QjnGZhK1WAXQShQJ/2nK9E/OHIuIgpbUrqDc=; b=V/DlD+b0e4m8HC7ekIW8TtmQO7
	6ES0mns3M+y1iHvsAXcAmo3mPI02ab5Ns2sXVUy1RMg+rB4TqGA8foDHs3nKkmhfbNEM31wIncxY3
	ZGRLyTwdzuMC4ST2yHLj1I8d/k3Kr2tjmzqttTxLXg8VCVsqV0RE28f0hujC3eKkYvERISQ+tYLEB
	OBlMPdi28oxcNSpvPUH9d/L8TVMe7aoCjeSDamS0pPCFs67eCM8qRGo5j1TcobBZPCmxHS623ZTDp
	7LYVoiN+C13gOO913EfVBtlWpiiIp4sxcgfSguy7dFBdmGTrZ/T/aIbJtoMKubPRlkNaG3OFXAqXi
	yBatGDMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4CJW-0000000CJva-3bOq;
	Thu, 02 Oct 2025 05:57:15 +0000
Date: Thu, 2 Oct 2025 06:57:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull] pile 2: fs_context
Message-ID: <20251002055714.GH39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

A trivial D/f/porting.rst conflict...

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fs_context

for you to fetch changes up to 57e62089f8e9d0baaba40103b167003ed7170db5:

  do_nfs4_mount(): switch to vfs_parse_fs_string() (2025-09-04 15:20:58 -0400)

----------------------------------------------------------------
vfs_parse_fs_string() stuff

change on vfs_parse_fs_string() calling conventions - get rid of
the length argument (almost all callers pass strlen() of the
string argument there), add vfs_parse_fs_qstr() for the cases
that do want separate length

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (2):
      change the calling conventions for vfs_parse_fs_string()
      do_nfs4_mount(): switch to vfs_parse_fs_string()

 Documentation/filesystems/mount_api.rst | 10 +++++++-
 Documentation/filesystems/porting.rst   | 12 +++++++++
 drivers/gpu/drm/i915/gem/i915_gemfs.c   |  9 ++-----
 drivers/gpu/drm/v3d/v3d_gemfs.c         |  9 ++-----
 fs/afs/mntpt.c                          |  3 ++-
 fs/fs_context.c                         | 17 ++++++-------
 fs/namespace.c                          |  8 +++---
 fs/nfs/fs_context.c                     |  3 +--
 fs/nfs/namespace.c                      |  3 ++-
 fs/nfs/nfs4super.c                      | 44 +++++++++------------------------
 fs/smb/client/fs_context.c              |  4 +--
 include/linux/fs_context.h              |  9 +++++--
 kernel/trace/trace.c                    |  3 +--
 13 files changed, 60 insertions(+), 74 deletions(-)

