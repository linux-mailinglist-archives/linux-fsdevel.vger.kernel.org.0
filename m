Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E303B3D8F00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhG1N06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 09:26:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48446 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1N06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:26:58 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 269B8201AF;
        Wed, 28 Jul 2021 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627478816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=j7yhpOxwjJ78x0wN/zOzIyZtZ4n5rn70DcyUwVeOtSQ=;
        b=lmyyR80nJ93uRXuiiSliXBzaHeiiUUpI2kFRIKs6SHt+8gc6XOw36LUNB0Iji6LkMKd40S
        2Ag9G5ia4dzsEnrcucVaB3rFfq1++qKrIjOj0P9CkCww7vo1krA7WUbU88BL4n9ZTuHWtI
        yoEA6iLoH6U65Ap54v6IGTMjSYwUuso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627478816;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=j7yhpOxwjJ78x0wN/zOzIyZtZ4n5rn70DcyUwVeOtSQ=;
        b=946i5x8e9CcIYsoKmskZkX5zhDABWERTKEXN8ZUvc2slAP9CeFlRmDf5UDlBkvHhkTQk+a
        UzAJinNzCGltx3Bg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 1794CA3B81;
        Wed, 28 Jul 2021 13:26:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D702F1E1321; Wed, 28 Jul 2021 15:26:55 +0200 (CEST)
Date:   Wed, 28 Jul 2021 15:26:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2 and reiserfs fixes for 5.14-rc4
Message-ID: <20210728132655.GI29619@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.14-rc4

to get a fix of ext2 conversion to kmap_local() and two reiserfs hardening
fixes.

Top of the tree is 13d257503c09. The full shortlog is:

Javier Pello (1):
      fs/ext2: Avoid page_address on pages returned by ext2_get_page

Shreyansh Chouhan (1):
      reiserfs: check directory items on read from disk

Yu Kuai (1):
      reiserfs: add check for root_inode in reiserfs_fill_super

The diffstat is

 fs/ext2/dir.c       | 12 ++++++------
 fs/ext2/ext2.h      |  3 ++-
 fs/ext2/namei.c     |  4 ++--
 fs/reiserfs/stree.c | 31 ++++++++++++++++++++++++++-----
 fs/reiserfs/super.c |  8 ++++++++
 5 files changed, 44 insertions(+), 14 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
