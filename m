Return-Path: <linux-fsdevel+bounces-34924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E8A9CEA23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 16:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733B31F21665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482CE1D4604;
	Fri, 15 Nov 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SdJ7oQun"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E661CEEB8;
	Fri, 15 Nov 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683290; cv=none; b=M6hUbx+RQKVkld+yWPnNPYaxM9s3ytUQjMwZphfs+QHyKjaF0z6UEv0Aa85B+zzojjN35US1Lietqyot+CwubKi3LcMJ/FSjgBjefVUw4Sgq58CAE104H3a/5C24O2pp8tUnqlfbsNFdZrZpCjt2FqGBZ2WltKAFAkT9tUXdaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683290; c=relaxed/simple;
	bh=g3vaK+eV2t22zYdfEhDcy2DD3ymzRl3RWUggTjvlD2g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r67z4QiZ0fORIDzHBSRrsUEFp3UL9nRAb74vrY0Sq9KR7KT71pjwz+QADb/IWMjzqtqB9HEeR3M1uRWobuJmgavh/Wxu+zUd38PMQ6gD6m6ybgH/4cVFcExK/b8TLcRZ36yBbxoEvsSDYDYy4IG6I/P4TcnSTYLWKMJ3EGfCmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SdJ7oQun; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dEkygzGBrVrxYBoFEBhol8J41N3J2RmPR47EVguFlvg=; b=SdJ7oQun0nKYqFcV3z6ErKGJjo
	dz0XRtoW3eOTXWVKbyenYkmTsPAB5F+qGju5l12X/Fc4ESu3s9RbxTGJrgaEXTcFmHsrPMuDwkg8E
	D28GVVYtyuJh8/F+LBikfIu1OYQxOHAsf9O35S7oUAfJC94Tg16584SRhEZ1rabPNAjuYuLIgBeCf
	wreK452jzBckND2MxewLEePNc7FNO5MLqhrWA3f5QR7mvwfK78zxH5yk40bTRcthnjwbz3Vnj2n0n
	Z+kDtxqkLk8fxcRv5FcfY+p8AQgKUUXjQ/5rFBvQzx6bxC0JSfFRPnzQRU1Lw5V2SndbvGwCKrnz8
	QIQ1fD5g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBxva-0000000FTZK-1kd5;
	Fri, 15 Nov 2024 15:08:06 +0000
Date: Fri, 15 Nov 2024 15:08:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] xattr stuff
Message-ID: <20241115150806.GU3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-xattr

for you to fetch changes up to 46a7fcec097da5b3188dce608362fe6bf4ea26ee:

  xattr: remove redundant check on variable err (2024-11-06 13:00:01 -0500)

----------------------------------------------------------------
	sanitize xattr and io_uring interactions with it,
add *xattrat() syscalls, sanitize struct filename handling in there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (9):
      teach filename_lookup() to treat NULL filename as ""
      getname_maybe_null() - the third variant of pathname copy-in
      io_[gs]etxattr_prep(): just use getname()
      xattr: switch to CLASS(fd)
      new helper: import_xattr_name()
      replace do_setxattr() with saner helpers.
      replace do_getxattr() with saner helpers.
      new helpers: file_listxattr(), filename_listxattr()
      new helpers: file_removexattr(), filename_removexattr()

Christian Göttsche (2):
      fs: rename struct xattr_ctx to kernel_xattr_ctx
      fs/xattr: add *at family syscalls

Colin Ian King (1):
      xattr: remove redundant check on variable err

Jens Axboe (1):
      io_uring: IORING_OP_F[GS]ETXATTR is fine with REQ_F_FIXED_FILE

 arch/alpha/kernel/syscalls/syscall.tbl      |   4 +
 arch/arm/tools/syscall.tbl                  |   4 +
 arch/arm64/tools/syscall_32.tbl             |   4 +
 arch/m68k/kernel/syscalls/syscall.tbl       |   4 +
 arch/microblaze/kernel/syscalls/syscall.tbl |   4 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   4 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   4 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   4 +
 arch/parisc/kernel/syscalls/syscall.tbl     |   4 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |   4 +
 arch/s390/kernel/syscalls/syscall.tbl       |   4 +
 arch/sh/kernel/syscalls/syscall.tbl         |   4 +
 arch/sparc/kernel/syscalls/syscall.tbl      |   4 +
 arch/x86/entry/syscalls/syscall_32.tbl      |   4 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   4 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |   4 +
 fs/internal.h                               |  17 +-
 fs/namei.c                                  |  34 ++-
 fs/stat.c                                   |  28 +-
 fs/xattr.c                                  | 446 ++++++++++++++++++----------
 include/asm-generic/audit_change_attr.h     |   6 +
 include/linux/fs.h                          |  10 +
 include/linux/syscalls.h                    |  13 +
 include/linux/xattr.h                       |   4 +
 include/uapi/asm-generic/unistd.h           |  11 +-
 include/uapi/linux/xattr.h                  |   7 +
 io_uring/xattr.c                            |  97 ++----
 scripts/syscall.tbl                         |   4 +
 28 files changed, 474 insertions(+), 267 deletions(-)

