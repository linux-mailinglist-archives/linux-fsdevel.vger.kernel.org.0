Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780AD23C8D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgHEJMp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 05:12:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:44346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgHEJMH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:12:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B671B66E;
        Wed,  5 Aug 2020 09:12:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A0A0B1E12CB; Wed,  5 Aug 2020 11:12:05 +0200 (CEST)
Date:   Wed, 5 Aug 2020 11:12:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext2, udf, reiserfs, quota cleanups and minor fixes for
 5.9-rc1
Message-ID: <20200805091205.GD4117@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.9-rc1

to get a few ext2 fixups and then several (mostly comment and
documentation) cleanups in ext2, udf, reiserfs, and quota.

Top of the tree is 9436fb4d8993. The full shortlog is:

Alexander A. Klimov (2):
      Replace HTTP links with HTTPS ones: DISKQUOTA
      udf: Replace HTTP links with HTTPS ones

Chengguang Xu (4):
      ext2: fix improper assignment for e_value_offs
      ext2: remove nocheck option
      ext2: fix some incorrect comments in inode.c
      ext2: initialize quota info in ext2_xattr_set()

Jan Kara (1):
      quota: Fixup http links in quota doc

Mikulas Patocka (1):
      ext2: fix missing percpu_counter_inc

Randy Dunlap (4):
      ext2: ext2.h: fix duplicated word + typos
      reiserfs: reiserfs.h: delete a duplicated word
      udf: osta_udf.h: delete a duplicated word
      reiserfs: delete duplicated words

zhangyi (F) (2):
      ext2: propagate errors up to ext2_find_entry()'s callers
      ext2: ext2_find_entry() return -ENOENT if no entry found

The diffstat is

 Documentation/filesystems/quota.rst | 12 ++++----
 Documentation/filesystems/udf.rst   |  2 +-
 fs/ext2/dir.c                       | 55 ++++++++++++++++++-------------------
 fs/ext2/ext2.h                      |  8 +++---
 fs/ext2/ialloc.c                    |  3 +-
 fs/ext2/inode.c                     |  7 ++---
 fs/ext2/namei.c                     | 39 ++++++++++++++++----------
 fs/ext2/super.c                     | 10 +------
 fs/ext2/xattr.c                     |  6 +++-
 fs/quota/Kconfig                    |  2 +-
 fs/reiserfs/dir.c                   |  8 +++---
 fs/reiserfs/fix_node.c              |  4 +--
 fs/reiserfs/journal.c               |  2 +-
 fs/reiserfs/reiserfs.h              |  2 +-
 fs/reiserfs/xattr_acl.c             |  2 +-
 fs/udf/ecma_167.h                   |  2 +-
 fs/udf/osta_udf.h                   |  2 +-
 fs/udf/super.c                      |  4 +--
 18 files changed, 86 insertions(+), 84 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
