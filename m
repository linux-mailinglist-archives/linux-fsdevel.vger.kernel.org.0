Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0074D38A6AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhETK3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 06:29:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:49328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235521AbhETK1s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 06:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4930DAD12;
        Thu, 20 May 2021 10:26:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F22701F2C9C; Thu, 20 May 2021 12:26:25 +0200 (CEST)
Date:   Thu, 20 May 2021 12:26:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota changes for 5.13-rc3
Message-ID: <20210520102625.GB18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git quota_for_v5.13-rc3

The most important part in the pull is disablement of the new syscall
quotactl_path() which was added in rc1. The reason is some people at LWN
discussion pointed out dirfd would be useful for this path based syscall
and Christian Brauner agreed without dirfd it may be indeed problematic for
containers.  So let's just disable the syscall for now when it doesn't have
users yet so that we have more time to mull over how to best specify the
filesystem we want to work on.

Top of the tree is 5b9fedb31e47. The full shortlog is:

Christophe JAILLET (1):
      quota: Use 'hlist_for_each_entry' to simplify code

Jan Kara (1):
      quota: Disable quotactl_path syscall

The diffstat is

 arch/alpha/kernel/syscalls/syscall.tbl      | 2 +-
 arch/arm/tools/syscall.tbl                  | 2 +-
 arch/arm64/include/asm/unistd32.h           | 3 +--
 arch/ia64/kernel/syscalls/syscall.tbl       | 2 +-
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 +-
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 2 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 +-
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 2 +-
 arch/sh/kernel/syscalls/syscall.tbl         | 2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      | 2 +-
 arch/x86/entry/syscalls/syscall_32.tbl      | 2 +-
 arch/x86/entry/syscalls/syscall_64.tbl      | 2 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 +-
 fs/quota/dquot.c                            | 6 ++----
 18 files changed, 19 insertions(+), 22 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
