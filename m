Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02A63B86F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 18:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhF3QWS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 12:22:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60180 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3QWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 12:22:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BA600227B7;
        Wed, 30 Jun 2021 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625069988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Y8hBuCt9RhY04I0RPOpnWVG2MmUp0bAnv0DpNSzTN1Q=;
        b=UKn/6i+vH2GB9Yd+XxW+TRDR/+npaiYvqXqXNvvAxBA6cRGEyrXl2JyEhXKa4vzonH6+B2
        rDDHKQIwejdw4W/70vHwDjB5b1pjIVsEIoQgQPOw0DrQHm180XS5zGMlhNeIbMmzrnZKrz
        NRSTbZ2gPmPWglGoDIiQKs7ACkT97no=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625069988;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Y8hBuCt9RhY04I0RPOpnWVG2MmUp0bAnv0DpNSzTN1Q=;
        b=W5Tq0mvyAuWaQ06w9V4VmUkxAMgS6/qfsXGxLz8t9TLOAVk1hgqrWz2lgeirRif/zhVNiZ
        YKsytx/ZuTfGhJCQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id AF6BBA3B8A;
        Wed, 30 Jun 2021 16:19:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8DB0B1F2CC3; Wed, 30 Jun 2021 18:19:48 +0200 (CEST)
Date:   Wed, 30 Jun 2021 18:19:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota, udf, isofs, reiserfs, writeback changes for
 5.14-rc1
Message-ID: <20210630161948.GA13951@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.14-rc1

to get implementation of the new quotactl_fd() syscall (remake of
quotactl_path() syscall that got introduced & disabled in 5.13 cycle),
and couple of udf, reiserfs, isofs, and writeback fixes and cleanups.

Top of the tree is 8b0ed8443ae6. The full shortlog is:

Arturo Giusti (1):
      udf: Fix NULL pointer dereference in udf_symlink function

Colin Ian King (1):
      isofs: remove redundant continue statement

Jan Kara (2):
      quota: Change quotactl_path() systcall to an fd-based one
      quota: Wire up quotactl_fd syscall

Muchun Song (1):
      writeback: fix obtain a reference to a freeing memcg css

Pavel Skripkin (1):
      reiserfs: add check for invalid 1st journal block

YueHaibing (1):
      reiserfs: Remove unneed check in reiserfs_write_full_page()

Zhen Lei (1):
      quota: remove unnecessary oom message

The diffstat is

 arch/alpha/kernel/syscalls/syscall.tbl      |  2 +-
 arch/arm/tools/syscall.tbl                  |  2 +-
 arch/arm64/include/asm/unistd32.h           |  3 ++-
 arch/ia64/kernel/syscalls/syscall.tbl       |  2 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  2 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  2 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |  2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    |  2 +-
 arch/s390/kernel/syscalls/syscall.tbl       |  2 +-
 arch/sh/kernel/syscalls/syscall.tbl         |  2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl      |  2 +-
 arch/x86/entry/syscalls/syscall_64.tbl      |  2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  2 +-
 fs/fs-writeback.c                           |  9 ++++++--
 fs/isofs/dir.c                              |  2 --
 fs/quota/quota.c                            | 28 ++++++++++++------------
 fs/quota/quota_tree.c                       | 33 +++++++++++------------------
 fs/reiserfs/inode.c                         |  4 +---
 fs/reiserfs/journal.c                       | 14 ++++++++++++
 fs/udf/namei.c                              |  4 ++++
 include/linux/syscalls.h                    |  4 ++--
 include/uapi/asm-generic/unistd.h           |  4 ++--
 kernel/sys_ni.c                             |  2 +-
 27 files changed, 74 insertions(+), 65 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
