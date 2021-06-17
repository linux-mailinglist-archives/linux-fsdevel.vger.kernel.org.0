Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41233AB26E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhFQLZc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 07:25:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbhFQLZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:25:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 95F0521AAB;
        Thu, 17 Jun 2021 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623929002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=U3yW2M6w6ilA/P3pBH7ymrqfBibxYCgjRYbX2uROZ84=;
        b=Mu/A1gjdD4TGCTieeoCcMsNY1liWlJC2jjdi+DChgOj73lXtz2qKuc2LT6opL6tgvKvOu/
        HQ4m5ES7ro532QG1nukuNbTqnojCZJXsIKJ1X3Z61rTKAAyO5G7iZIfBPTZyEqmakYfZPl
        TLgdpX7xYwHVP1HRorzTTJ/MLFEr/48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623929002;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=U3yW2M6w6ilA/P3pBH7ymrqfBibxYCgjRYbX2uROZ84=;
        b=1zgGbaWWJ1bUgLtxumfK5Re3/McqkQRAWlCFKJzwX2309LVMd9rxAWB3M46kczHhzBSWjS
        D9W9Ap8yCFcu1BDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 8B619A3BB8;
        Thu, 17 Jun 2021 11:23:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5D4FF1F2C64; Thu, 17 Jun 2021 13:23:22 +0200 (CEST)
Date:   Thu, 17 Jun 2021 13:23:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota and fanotify fixes for 5.13-rc7
Message-ID: <20210617112322.GF32587@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v5.13-rc7

to get a fixup finishing disabling of quotactl_path() syscall (I've missed
archs using different way to declare syscalls) and a fix of an fd leak in
error handling path of fanotify.

Top of the tree is 8b1462b67f23. The full shortlog is:

Marcin Juszkiewicz (1):
      quota: finish disable quotactl_path syscall

Matthew Bobrowski (1):
      fanotify: fix copy_event_to_user() fid error clean up

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 4 ++--
 include/uapi/asm-generic/unistd.h  | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
