Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2A44647A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhKEN5B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 09:57:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhKEN5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:57:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7A1E0217BA;
        Fri,  5 Nov 2021 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636120460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=A+et6cwF2QaQ4dC4N6ZwegWjYwv3Ag8iJT5KcZuIaGw=;
        b=YQ4UubIUtKyKd/gJ4Lr6/AXBnkLeGCtnQM2KjHkfxwv/PPubXcM1hRbeGlnf5JI98SMAz9
        7n1PeuGgZQ7gAv/lDqld+9T4hgW/+MEtc5CvrehIhzHHndZK37rkv+F4GFhun2h1WWeiWP
        MolLwL+oybPpIpi+NR/5AFnqR/YRG6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636120460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=A+et6cwF2QaQ4dC4N6ZwegWjYwv3Ag8iJT5KcZuIaGw=;
        b=e/YdlXGn/Qj+GZ4imbthqtnuZUnQcxmwp7TX3Mtitet5Hg1aSe7wQN8Tf63e791V32xTj6
        /HXc9io8IDc9TlCA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 6C5032C154;
        Fri,  5 Nov 2021 13:54:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3EEDB1E0BDF; Fri,  5 Nov 2021 14:54:20 +0100 (CET)
Date:   Fri, 5 Nov 2021 14:54:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota, isofs, reiserfs fixes for 5.16-rc1
Message-ID: <20211105135420.GA5691@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.16-rc1

to get fixes for handling of corrupted quota files, fix for handling of
corrupted isofs filesystem, and a small cleanup for reiserfs.

Top of the tree is 81dedaf10c20. The full shortlog is:

Dongliang Mu (1):
      fs: reiserfs: remove useless new_opts in reiserfs_remount

Jan Kara (1):
      isofs: Fix out of bound access for corrupted isofs image

Zhang Yi (2):
      quota: check block number when reading the block in quota file
      quota: correct error number in free_dqentry()

The diffstat is

 fs/isofs/inode.c      |  2 ++
 fs/quota/quota_tree.c | 15 +++++++++++++++
 fs/reiserfs/super.c   |  6 ------
 3 files changed, 17 insertions(+), 6 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
