Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB41EE4AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 14:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFDMnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 08:43:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:56720 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgFDMnj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:43:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB2F3ADFE;
        Thu,  4 Jun 2020 12:43:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 289661E1281; Thu,  4 Jun 2020 14:43:38 +0200 (CEST)
Date:   Thu, 4 Jun 2020 14:43:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2 and reiserfs cleanups for 5.8-rc2
Message-ID: <20200604124338.GB2225@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.8-rc1

to get two smaller cleanups for ext2 and one for reiserfs.

Top of the tree is 5626de1e96f7. The full shortlog is:

Chengguang Xu (2):
      ext2: Fix i_op setting for special inode
      ext2: code cleanup by removing ifdef macro surrounding

Liao Pingfang (1):
      reiserfs: Replace kmalloc with kcalloc in the comment

The diffstat is

 fs/ext2/file.c      | 2 --
 fs/ext2/namei.c     | 6 ------
 fs/ext2/symlink.c   | 4 ----
 fs/ext2/xattr.h     | 1 +
 fs/reiserfs/inode.c | 2 +-
 5 files changed, 2 insertions(+), 13 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
