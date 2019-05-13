Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1E641BABA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2019 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfEMQKr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 12:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:59194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731581AbfEMQKr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 12:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 126D3AF5B;
        Mon, 13 May 2019 16:10:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B14BC1E3E10; Mon, 13 May 2019 18:10:45 +0200 (CEST)
Date:   Mon, 13 May 2019 18:10:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota, udf, ext2, and reiserfs cleanups for v5.2-rc1
Message-ID: <20190513161045.GB13297@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.2-rc1

to get couple of small bugfixes and cleanups for quota, udf, ext2, and
reiserfs.

Top of the tree is 632a9f3acd66. The full shortlog is:

Bharath Vedartham (1):
      fs/reiserfs/journal.c: Make remove_journal_hash static

Chengguang Xu (3):
      quota: code cleanup for __dquot_alloc_space()
      quota: fix wrong indentation
      quota: check time limit when back out space/inode change

Jan Kara (1):
      udf: Explain handling of load_nls() failure

Jiang Biao (1):
      fs/quota: erase unused but set variable warning

Sascha Hauer (1):
      quota: remove trailing whitespaces

Shuning Zhang (1):
      ext2: Adjust the comment of function ext2_alloc_branch

Wenwen Wang (1):
      udf: fix an uninitialized read bug and remove dead code

The diffstat is

 fs/ext2/inode.c       |  4 +++-
 fs/quota/dquot.c      | 37 ++++++++++++++++++++-----------------
 fs/quota/quota_v1.c   |  2 +-
 fs/quota/quota_v2.c   |  2 +-
 fs/reiserfs/journal.c |  2 +-
 fs/udf/namei.c        | 15 ---------------
 fs/udf/super.c        |  5 +++++
 7 files changed, 31 insertions(+), 36 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
