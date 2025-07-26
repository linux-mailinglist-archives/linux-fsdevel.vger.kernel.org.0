Return-Path: <linux-fsdevel+bounces-56067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359B4B129B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 10:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA773B03A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 08:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986C202F67;
	Sat, 26 Jul 2025 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TFG4om47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFE78F4C
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753517117; cv=none; b=pRRbLHIJy3OcK6+z0TBKjY1kUM3DogTM3BMC1o0b7lXULU0ZvwtPVFzcCYtlPcyiDUwoMNwPdDaK3o/4Z4+jNKlQuo3x1wuXA9uRKZVmnLbczb7Ic+PBRBTp6hP+NEO4+UySn993OW3/XglD/hyEhDvn3hiR6MIcWfRt922NnQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753517117; c=relaxed/simple;
	bh=b0aGdyRtPF/L269yfSkEwqaHUGzvD15FqaJom3AcQZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAFsgrWO2ZrzkYjDPuhAjSfYJuCNfW+hrPzPcFEscxEZVr8fGS9x4+pyNkZRVd6hZtqjzgaypI3FaDWdIILrMJMV8QmQ8+bzkkOD5koJzyprUfQmLq/splL8Yk5pkYvccONrMshtncSFWlhNqnujXJSpdsKojBcXk+fA3Vg7D1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TFG4om47; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dkkrSKijLYEBLDMaJasFfmL/P9Cfrx0ijYDcgNkhicU=; b=TFG4om47ospwbJBwHGnNSPqRJQ
	CDScNZmovSoEeafZJ0xM666IRP+o6dgxKpnjvewGMiaOG2wpfY3RLrGuKu14rHPND3orhAr5OisLZ
	E9Ut2l0ZwQT/ZySf93/EIjBSo1MhiiyHIIRYBOl0916FvmxcmLV76Sbby8yPMtEl6BAwScEbJi92u
	g/ccRo+8GUZ23cbQ1mkSpk1+2mOQYC2/snQLsIcv/zmynaDtlejmfqptZBhSUqXnjgpVfdXg1IQcn
	TfykKwYqMzE4v9tmwWhYkcjmQgDq9TdUmHqgxwdCOtJ7gMNyoeOa9Tz0doxaQ2CIPAv+3vq59hsNz
	cU43FSmQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufZu5-000000068X4-0Rii;
	Sat, 26 Jul 2025 08:05:13 +0000
Date: Sat, 26 Jul 2025 09:05:13 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [git pull][6.17] vfs.git 5/9: securityfs
Message-ID: <20250726080513.GD1456602@ZenIV>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-securityfs

for you to fetch changes up to f42b8d78dee77107245ec5beee3eb01915bcae7f:

  tpm: don't bother with removal of files in directory we'll be removing (2025-06-17 18:11:01 -0400)

----------------------------------------------------------------
securityfs cleanups and fixes:

* one extra reference is enough to pin a dentry down; no need
for two.  Switch to regular scheme, similar to shmem, debugfs,
etc. - that fixes securityfs_recursive_remove() dentry leak,
among other things.

* we need to have the filesystem pinned to prevent the contents
disappearing; what we do not need is pinning it for each file.
Doing that only for files and directories in the root is enough.

* the previous two changes allow to get rid of the racy kludges
in efi_secret_unlink(), where we can use simple_unlink() instead
of securityfs_remove().  Which does not require unlocking and
relocking the parent, with all deadlocks that invites.

* Make securityfs_remove() take the entire subtree out, turning
securityfs_recursive_remove() into its alias.  Makes a lot more
sense for callers and fixes a mount leak, while we are at it.

* Making securityfs_remove() remove the entire subtree allows for
much simpler life in most of the users - efi_secret, ima_fs,
evm, ipe, tmp get cleaner.  I hadn't touched apparmor use of
securityfs, but I suspect that it would be useful there as well.

----------------------------------------------------------------
Al Viro (10):
      securityfs: don't pin dentries twice, once is enough...
      securityfs: pin filesystem only for objects directly in root
      fix locking in efi_secret_unlink()
      make securityfs_remove() remove the entire subtree
      efi_secret: clean securityfs use up
      ima_fs: don't bother with removal of files in directory we'll be removing
      ima_fs: get rid of lookup-by-dentry stuff
      evm_secfs: clear securityfs interactions
      ipe: don't bother with removal of files in directory we'll be removing
      tpm: don't bother with removal of files in directory we'll be removing

 drivers/char/tpm/eventlog/common.c        |  46 +++-------
 drivers/virt/coco/efi_secret/efi_secret.c |  47 ++--------
 include/linux/security.h                  |   3 +-
 include/linux/tpm.h                       |   2 +-
 security/inode.c                          |  62 +++++---------
 security/integrity/evm/evm_secfs.c        |  15 ++--
 security/integrity/ima/ima_fs.c           | 137 +++++++-----------------------
 security/ipe/fs.c                         |  32 +++----
 security/ipe/policy_fs.c                  |   4 +-
 9 files changed, 97 insertions(+), 251 deletions(-)

