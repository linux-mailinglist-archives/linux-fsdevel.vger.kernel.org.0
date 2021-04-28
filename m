Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2E436D734
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhD1MZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 08:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:37022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234534AbhD1MZS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 08:25:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1731CB156;
        Wed, 28 Apr 2021 12:24:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E24E41E150F; Wed, 28 Apr 2021 14:24:32 +0200 (CEST)
Date:   Wed, 28 Apr 2021 14:24:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota, ext2, reiserfs cleanups & improvents for 5.13-rc1
Message-ID: <20210428122432.GC25222@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.13-rc1

to get support for path (instead of device) based quotactl syscall
(quotactl_path(2)), ext2 conversion to kmap_local(), other minor cleanups &
fixes.

Top of the tree is a3cc754ad9b8. The full shortlog is:

Darrick J. Wong (1):
      quota: report warning limits for realtime space quotas

Ira Weiny (2):
      ext2: Match up ext2_put_page() with ext2_dotdot() and ext2_find_entry()
      fs/ext2: Replace kmap() with kmap_local_page()

Liu xuzhi (1):
      fs/ext2/: fix misspellings using codespell tool

Sascha Hauer (2):
      quota: Add mountpath based quota support
      quota: wire up quotactl_path

Tian Tao (1):
      fs/reiserfs/journal.c: delete useless variables

The diffstat is

 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 fs/ext2/dir.c                               | 94 ++++++++++++++++++-----------
 fs/ext2/ext2.h                              | 12 ++--
 fs/ext2/namei.c                             | 34 +++++++----
 fs/ext2/super.c                             |  2 +-
 fs/quota/quota.c                            | 50 ++++++++++++++-
 fs/reiserfs/journal.c                       |  6 +-
 include/linux/syscalls.h                    |  2 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 include/uapi/linux/dqblk_xfs.h              |  5 +-
 kernel/sys_ni.c                             |  1 +
 28 files changed, 168 insertions(+), 62 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
