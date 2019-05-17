Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D10DB21268
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 05:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfEQDL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 23:11:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:38286 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfEQDL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 23:11:28 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hRTHK-0001RR-EC; Fri, 17 May 2019 03:11:26 +0000
Date:   Fri, 17 May 2019 04:11:26 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git mount followups
Message-ID: <20190517031125.GF17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Propagation of new syscalls to other architectures + cosmetical
change from Christian (fscontext didn't follow the convention for anon
inode names).

	What is _not_ included is cloexec changes - I really don't see
the benefits for the cloexec-by-default for new syscalls, when there's
no chance in hell of switching to that policy for old ones.

The following changes since commit 05883eee857eab4693e7d13ebab06716475c5754:

  do_move_mount(): fix an unsafe use of is_anon_ns() (2019-05-09 02:32:50 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to d8076bdb56af5e5918376cd1573a6b0007fc1a89:

  uapi: Wire up the mount API syscalls on non-x86 arches [ver #2] (2019-05-16 12:23:45 -0400)

----------------------------------------------------------------
Christian Brauner (1):
      uapi, fsopen: use square brackets around "fscontext" [ver #2]

David Howells (2):
      uapi, x86: Fix the syscall numbering of the mount API syscalls [ver #2]
      uapi: Wire up the mount API syscalls on non-x86 arches [ver #2]

 arch/alpha/kernel/syscalls/syscall.tbl      |  6 ++++++
 arch/arm/tools/syscall.tbl                  |  6 ++++++
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           | 12 ++++++++++++
 arch/ia64/kernel/syscalls/syscall.tbl       |  6 ++++++
 arch/m68k/kernel/syscalls/syscall.tbl       |  6 ++++++
 arch/microblaze/kernel/syscalls/syscall.tbl |  6 ++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  6 ++++++
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  6 ++++++
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  6 ++++++
 arch/parisc/kernel/syscalls/syscall.tbl     |  6 ++++++
 arch/powerpc/kernel/syscalls/syscall.tbl    |  6 ++++++
 arch/s390/kernel/syscalls/syscall.tbl       |  6 ++++++
 arch/sh/kernel/syscalls/syscall.tbl         |  6 ++++++
 arch/sparc/kernel/syscalls/syscall.tbl      |  6 ++++++
 arch/x86/entry/syscalls/syscall_32.tbl      | 12 ++++++------
 arch/x86/entry/syscalls/syscall_64.tbl      | 12 ++++++------
 arch/xtensa/kernel/syscalls/syscall.tbl     |  6 ++++++
 fs/fsopen.c                                 |  2 +-
 include/uapi/asm-generic/unistd.h           | 14 +++++++++++++-
 20 files changed, 123 insertions(+), 15 deletions(-)
