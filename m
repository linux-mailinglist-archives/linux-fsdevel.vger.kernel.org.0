Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DBB28F34E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 15:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgJONet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 09:34:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgJONet (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:34:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1709AD64;
        Thu, 15 Oct 2020 13:34:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5A1AA1E133C; Thu, 15 Oct 2020 15:34:47 +0200 (CEST)
Date:   Thu, 15 Oct 2020 15:34:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF, reiserfs, ext2, quota fixes for 5.10-rc1
Message-ID: <20201015133447.GG7037@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.10-rc1

to get:
* couple of UDF fixes for issues found by syzbot fuzzing
* couple of reiserfs fixes for issues found by syzbot fuzzing
* some minor ext2 cleanups
* quota patches to support grace times beyond year 2038 for XFS quota APIs

Top of the tree is c2bb80b8bdd0. The full shortlog is:

Darrick J. Wong (1):
      quota: widen timestamps for the fs_disk_quota structure

Denis Efremov (1):
      udf: Use kvzalloc() in udf_sb_alloc_bitmap()

Eric Biggers (1):
      reiserfs: only call unlock_new_inode() if I_NEW

Eric Dumazet (1):
      quota: clear padding in v2r1_mem2diskdqb()

Jan Kara (8):
      reiserfs: Fix memory leak in reiserfs_parse_options()
      quota: Expand comment describing d_itimer
      udf: Fix memory leak when mounting
      reiserfs: Initialize inode keys properly
      udf: Avoid accessing uninitialized data on failed inode read
      udf: Remove pointless union in udf_inode_info
      udf: Limit sparing table size
      reiserfs: Fix oops during mount

Jing Xiangfeng (1):
      udf: Remove redundant initialization of variable ret

Wang Hai (2):
      ext2: remove duplicate include
      ext2: Fix some kernel-doc warnings in balloc.c

The diffstat is

 fs/ext2/balloc.c               |  6 ++---
 fs/ext2/inode.c                |  1 -
 fs/quota/quota.c               | 42 ++++++++++++++++++++++++-----
 fs/quota/quota_v2.c            |  1 +
 fs/reiserfs/inode.c            |  9 +++----
 fs/reiserfs/super.c            |  8 +++---
 fs/reiserfs/xattr.c            |  7 +++++
 fs/udf/directory.c             |  2 +-
 fs/udf/file.c                  |  7 +++--
 fs/udf/ialloc.c                | 14 +++++-----
 fs/udf/inode.c                 | 61 +++++++++++++++++++++---------------------
 fs/udf/misc.c                  |  6 ++---
 fs/udf/namei.c                 |  7 +++--
 fs/udf/partition.c             |  2 +-
 fs/udf/super.c                 | 47 +++++++++++++++++---------------
 fs/udf/symlink.c               |  2 +-
 fs/udf/udf_i.h                 |  6 +----
 include/uapi/linux/dqblk_xfs.h | 16 ++++++++---
 18 files changed, 143 insertions(+), 101 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
