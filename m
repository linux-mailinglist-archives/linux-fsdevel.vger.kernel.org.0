Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAF07B42E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 20:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjI3SMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 14:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjI3SMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 14:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CC4D3;
        Sat, 30 Sep 2023 11:12:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23359C433C8;
        Sat, 30 Sep 2023 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696097532;
        bh=JJ3oQifbW5sx/P3UYD8gI1EK0o1jNk3ydEV+uGNjRo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rmSYFwTnHTlAu0nMIzhFaHj9YI5b6yadrv65qZBAFleqF5mgdTxAvsYtN6PMwJCfa
         dhDaITqHp9sFvRMQyMAomqONWex4K185FEMCqzKLNVWYbO84ReSzrnKqGWdaIJuYT4
         e2dY0ybfB+ZeG5oLeBQC0/R3a2dp09OoUJ4y94cZD6GDDox1Qpdsk4xCTtkTh2biGB
         svpWLXg4Ju23tS6sOy8ZBtBKyfX2l0f8zS0NHE+ldQWuFoMLvihS7kZUPu0deg2ebV
         sNhd/5Cnm8TwN0YYJFItoKEg/4eQWnhQy9RuTC5/D8hAZVkcdR/Sa+8a+nYdSrHZVh
         IwFjiPmJIrlPw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D8FEC395C5;
        Sat, 30 Sep 2023 18:12:12 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: bug fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
References: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <169608776189.1016505.15445601632237284088.stg-ugh@frogsfrogsfrogs>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-4
X-PR-Tracked-Commit-Id: 684f7e6d28e8087502fc8efdb6c9fe82400479dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25d48d570eeda62cf71e5b9cdad76a37b833f408
Message-Id: <169609753204.20440.10468431838239730592.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 18:12:12 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     djwong@kernel.org, torvalds@linux-foundation.org,
        bodonnel@redhat.com, geert+renesas@glider.be, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 08:31:14 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git iomap-6.6-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25d48d570eeda62cf71e5b9cdad76a37b833f408

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
