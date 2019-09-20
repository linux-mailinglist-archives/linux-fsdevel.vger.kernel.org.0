Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61E94B8ED7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438160AbfITLNy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 07:13:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:43852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438154AbfITLNy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 07:13:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1435AAC7;
        Fri, 20 Sep 2019 11:13:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 86B141E443E; Fri, 20 Sep 2019 13:14:04 +0200 (CEST)
Date:   Fri, 20 Sep 2019 13:14:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, quota, udf fixes and cleanups for 5.4-rc1
Message-ID: <20190920111404.GC25765@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.4-rc1

to get:
 * two small quota fixes (in grace time handling and possible missed
   accounting of preallocated blocks beyond EOF).
 * some ext2 cleanups
 * udf fixes for better compatibility with Windows 10 generated media
   (named streams, write-protection using domain-identifier, placement of
   volume recognition sequence)
 * some udf cleanups

Top of the tree is 6565c182094f. The full shortlog is:

Chao Yu (1):
      quota: fix wrong condition in is_quota_modification()

Chengguang Xu (3):
      ext2: fix block range in ext2_data_block_valid()
      ext2: code cleanup for ext2_free_blocks()
      quota: fix condition for resetting time limit in do_set_dqblk()

Jan Kara (3):
      udf: Use dynamic debug infrastructure
      udf: Verify domain identifier fields
      udf: Drop forward function declarations

Markus Elfring (2):
      ext2: Delete an unnecessary check before brelse()
      fs-udf: Delete an unnecessary check before brelse()

Steve Magnani (1):
      udf: prevent allocation beyond UDF partition

Steven J. Magnani (4):
      udf: refactor VRS descriptor identification
      udf: support 2048-byte spacing of VRS descriptors on 4K media
      udf: reduce leakage of blocks related to named streams
      udf: augment UDF permissions on new inodes

The diffstat is

 fs/ext2/balloc.c         |  10 +-
 fs/ext2/super.c          |   3 +-
 fs/ext2/xattr.c          |   2 +-
 fs/quota/dquot.c         |   4 +-
 fs/udf/balloc.c          |  11 ++
 fs/udf/ecma_167.h        |  14 +++
 fs/udf/file.c            |   3 +
 fs/udf/ialloc.c          |   3 +
 fs/udf/inode.c           |  55 +++++++++-
 fs/udf/super.c           | 261 +++++++++++++++++++++++++++--------------------
 fs/udf/udf_i.h           |   6 +-
 fs/udf/udfdecl.h         |  11 +-
 include/linux/quotaops.h |   2 +-
 13 files changed, 249 insertions(+), 136 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
