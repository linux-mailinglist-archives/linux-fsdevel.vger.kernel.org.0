Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0551849F842
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 12:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiA1LZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 06:25:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiA1LZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:25:33 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2426F1F385;
        Fri, 28 Jan 2022 11:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643369132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=5kGe5CphpsWJXgZPv4os2MQYEQQqXxBik5J4pkmgKJM=;
        b=ry5Ynt/MIyS/7SBaU0reMDIpKdeQ4uvyFtTDZ+DAjQHdfSbCoNK0lbSmJLw2nG/ToVF8Nz
        0L5EcYXFM2wMgzzWfVAKzbcd4Jr0ADA7EHzSv5akgo/N5VJauXIpFmlSS3YxCi0geHGpjW
        TmaHN3KjoE3fn+JRA0dK9gWb8CaED30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643369132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=5kGe5CphpsWJXgZPv4os2MQYEQQqXxBik5J4pkmgKJM=;
        b=A1XhPeYxybaag6zzFPS4pCETTrQ13ZDcWeiGPSSXOVPpPMkHpOxCa9Y2vl1Ekzt315g5DY
        +hpyByryTtDDQ7Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1BB35A3B84;
        Fri, 28 Jan 2022 11:25:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D3C95A05E6; Fri, 28 Jan 2022 12:25:31 +0100 (CET)
Date:   Fri, 28 Jan 2022 12:25:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify fixes for 5.17-rc2
Message-ID: <20220128112531.pgttgwgavqxk7xwq@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.17-rc2

to get fixes for userspace breakage caused by fsnotify changes ~3 years ago
and one fanotify cleanup.

Top of the tree is 29044dae2e74. The full shortlog is:

Amir Goldstein (2):
      fsnotify: invalidate dcache before IN_DELETE event
      fsnotify: fix fsnotify hooks in pseudo filesystems

Yang Li (1):
      fanotify: remove variable set but not used

The diffstat is

 fs/btrfs/ioctl.c                   |  6 ++---
 fs/configfs/dir.c                  |  6 ++---
 fs/devpts/inode.c                  |  2 +-
 fs/namei.c                         | 10 ++++----
 fs/nfsd/nfsctl.c                   |  5 ++--
 fs/notify/fanotify/fanotify_user.c |  3 ---
 include/linux/fsnotify.h           | 49 +++++++++++++++++++++++++++++++++-----
 net/sunrpc/rpc_pipe.c              |  4 ++--
 8 files changed, 59 insertions(+), 26 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
