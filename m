Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F454542A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 20:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344553AbiFISam (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiFISal (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:30:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CA2100B21
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 11:30:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CD2AE1FDF0;
        Thu,  9 Jun 2022 18:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654799438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Z5D/0p+bQ6tHXFb+5kzxXaWjJGB5nGAgQhBdxY7QYQQ=;
        b=EWSV+jazBwDMCb3UuX5qPdFpkelMbwYUHVRP0spY/4EhQeKXcJCBmMUhSb/TXKpuFmTA5m
        JkmBLs96d/TFg0UgjpZXYQMnANAwsxUVFgS8lq5jbrk7EXIlO6zOy3xItqpLweKH5V4DjI
        nmF3msXGBz4V7VzchClaS9++r8IDaR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654799438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Z5D/0p+bQ6tHXFb+5kzxXaWjJGB5nGAgQhBdxY7QYQQ=;
        b=ag1hy1yfkxnMEEyTCeaGlXRK6cyGNPIIrm1H7PdGWP4auDlNlnuBsJZu2nFtQEY7Z+GwHC
        OPrOd4qgRMISs+Aw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B5AD72C141;
        Thu,  9 Jun 2022 18:30:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83946A0633; Thu,  9 Jun 2022 20:30:37 +0200 (CEST)
Date:   Thu, 9 Jun 2022 20:30:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, writeback, quota fixes and cleanups for 5.19-rc2
Message-ID: <20220609183037.w67c7roxtkm7xsx2@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc2

to get a fix for race in writeback code and two cleanups in quota and ext2.

Top of the tree is 537e11cdc7a6. The full shortlog is:

Jchao Sun (1):
      writeback: Fix inode->i_io_list not be protected by inode->i_lock error

Matthew Wilcox (Oracle) (1):
      quota: Prevent memory allocation recursion while holding dq_lock

Xiang wangx (1):
      fs: Fix syntax errors in comments

The diffstat is

 fs/ext2/inode.c   |  2 +-
 fs/fs-writeback.c | 37 ++++++++++++++++++++++++++++---------
 fs/inode.c        |  2 +-
 fs/quota/dquot.c  | 10 ++++++++++
 4 files changed, 40 insertions(+), 11 deletions(-)

							Thanks
								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
