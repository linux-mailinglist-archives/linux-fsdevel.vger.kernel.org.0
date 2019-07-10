Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF364AB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2019 18:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfGJQXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jul 2019 12:23:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:50134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727797AbfGJQXo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:23:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF699ACD1;
        Wed, 10 Jul 2019 16:23:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1CFB21E43B7; Wed, 10 Jul 2019 18:23:38 +0200 (CEST)
Date:   Wed, 10 Jul 2019 18:23:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, udf, and quota fixes
Message-ID: <20190710162338.GA14701@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.3-rc1

to get some ext2 fixes and cleanups, a fix of udf bug when extending files,
and a fix of quota Q_XGETQSTAT[V] handling.

Top of the tree is fa33cdbf3ece. The full shortlog is:

Chengguang Xu (12):
      quota: add dqi_dirty_list description to comment of Dquot List Management
      ext2: introduce helper for xattr header validation
      ext2: introduce helper for xattr entry validation
      doc: ext2: update description of quota options for ext2
      ext2: code cleanup by using test_opt() and clear_opt()
      ext2: code cleanup for ext2_preread_inode()
      ext2: merge xattr next entry check to ext2_xattr_entry_valid()
      ext2: introduce new helper for xattr entry comparison
      ext2: optimize ext2_xattr_get()
      ext2: add missing brelse() in ext2_new_inode()
      ext2: fix a typo in comment
      ext2: add missing brelse() in ext2_iget()

Eric Sandeen (1):
      quota: honor quota type in Q_XGETQSTAT[V] calls

Fumiya Shigemitsu (1):
      ext2: Fix a typo in ext2_getattr argument

Fuqian Huang (1):
      ext2: Use kmemdup rather than duplicating its implementation

Jan Kara (3):
      ext2: Merge loops in ext2_xattr_set()
      ext2: Strengthen xattr block checks
      ext2: Always brelse bh on failure in ext2_iget()

Steven J. Magnani (1):
      udf: Fix incorrect final NOT_ALLOCATED (hole) extent length

The diffstat is

 Documentation/filesystems/ext2.txt |   8 +-
 fs/ext2/balloc.c                   |   3 +-
 fs/ext2/ialloc.c                   |   5 +-
 fs/ext2/inode.c                    |   7 +-
 fs/ext2/super.c                    |  17 ++--
 fs/ext2/xattr.c                    | 164 +++++++++++++++++++++----------------
 fs/quota/dquot.c                   |  11 ++-
 fs/quota/quota.c                   |  38 +++------
 fs/udf/inode.c                     |  93 +++++++++++++--------
 9 files changed, 195 insertions(+), 151 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
