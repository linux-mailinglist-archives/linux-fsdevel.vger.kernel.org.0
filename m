Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6DA4E5560
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 16:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbiCWPio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232483AbiCWPio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:38:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8D26245
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 08:37:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D5D8210F6;
        Wed, 23 Mar 2022 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648049832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=soBuA80xsDH8VOJ/JoeFtL6JQDQQpaLTK5D//Ypey2I=;
        b=l857lWwTGRD1Sf1Qw3C9UXD4ZP1qLPKStZnFVM5DPVF7M9Og6NYWPsLcmP3rTDxJI5x36A
        +yxUwjjrofenmxaBKNyZVCavGZVhGpTa5/ubMH8xDKc8m8za5gwkU9ywO4lR7Zw7/5GhZ2
        lPNUMKKzUOvPOfwAl+HYkOXdhU9ppB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648049832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=soBuA80xsDH8VOJ/JoeFtL6JQDQQpaLTK5D//Ypey2I=;
        b=8Nf15BgcQJajwbAvIp8XeZpV6EVng2PV5glDBOsq5KSsfClHOxL+Luf3TmT8IpHr0X0Wcg
        i660PJVAY9xOp0CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6FB96A3B89;
        Wed, 23 Mar 2022 15:37:12 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 257F7A0610; Wed, 23 Mar 2022 16:37:12 +0100 (CET)
Date:   Wed, 23 Mar 2022 16:37:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Reiserfs, udf, ext2 fixes and cleanups for 5.18-rc1
Message-ID: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.18-rc1

The biggest change in this pull is the addition of a deprecation message
about reiserfs with the outlook that we'd eventually be able to remove it
from the kernel. Because it is practically unmaintained and untested and
odd enough that people don't want to bother with it anymore... Otherwise
there are small udf and ext2 fixes.

Top of the tree is 31e9dc49c2c0. The full shortlog is:

Colin Ian King (1):
      udf: remove redundant assignment of variable etype

Edward Shishkin (1):
      reiserfs: get rid of AOP_FLAG_CONT_EXPAND flag

Jan Kara (1):
      reiserfs: Deprecate reiserfs

Zhang Yi (1):
      ext2: correct max file size computing

The diffstat is

 fs/ext2/super.c     |  6 +++++-
 fs/reiserfs/Kconfig | 10 +++++++---
 fs/reiserfs/inode.c | 16 +++++-----------
 fs/reiserfs/super.c |  2 ++
 fs/udf/super.c      |  3 +--
 5 files changed, 20 insertions(+), 17 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
