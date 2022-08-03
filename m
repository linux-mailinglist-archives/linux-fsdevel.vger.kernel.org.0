Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A632589289
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiHCTAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 15:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238422AbiHCTA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D59B482;
        Wed,  3 Aug 2022 12:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D16AC613DC;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 432EBC433D7;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659553225;
        bh=ubPfF/AldSGIeMaSQs1PtN5RJEGQ/lPZiSQ5IdfV/Wc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T7D/2aw9Rj9dV58THGRhzNLjXX63lXp4MmUeUbRlCAiFhe4H7Yjzhg5zWR1fO5hOp
         vb46FzdAmgVGtdI/U6YjVUpLDI6ieEMrK41G5oXU0iM+6YwKyfIaRS7wx/F+ErzQun
         7/s+lSYwlPqkjgyHDfdtXQfIfv//12NFUrXzmi3LNyqGoChVsttdc3HrsxUv6wr8yT
         6fU6EJveV8gefX8DU40KI0vPRMfOxkwrzSS3qa2rhhdWxbLMehExw/ZBqe60EM0ph1
         pN10dIGTWhMnXheTAsj6M77jft53FNUb8D6yPR8vPZJWanJFAdyvE7K9IYYcZSwBRy
         WeID1yFdpCDIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DE86C43140;
        Wed,  3 Aug 2022 19:00:25 +0000 (UTC)
Subject: Re: [git pull] vfs.git pile 1 - namei stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yug0x5GvaInf3opV@ZenIV>
References: <Yug0x5GvaInf3opV@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yug0x5GvaInf3opV@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.namei
X-PR-Tracked-Commit-Id: 3bd8bc897161730042051cd5f9c6ed1e94cb5453
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9395512c5bd326924ba0b36ee0d5d51d763a8d6
Message-Id: <165955322516.6947.4198227068927156943.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 19:00:25 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 21:17:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.namei

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9395512c5bd326924ba0b36ee0d5d51d763a8d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
