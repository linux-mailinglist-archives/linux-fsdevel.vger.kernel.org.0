Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DA53D92D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jun 2022 04:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbiFECOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jun 2022 22:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbiFECOE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jun 2022 22:14:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A695186D4;
        Sat,  4 Jun 2022 19:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE47BB80AD5;
        Sun,  5 Jun 2022 02:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 632C9C36AE2;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654395240;
        bh=s3uKl5OAMT3Z/oUweQOH0bGjeIh5SO/iVlznTtsf2bU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mBAfpvEsx0aTlT0Timw8ivW1VW4SXmSNxokJ5jIA0qkDeZMwTxptpBZyiO4fn+xVh
         klsSexbJJFmAan+vS2mvWwdaju65nzjjgB/JwGwkJVdjJxMLylJsje3zL94cylaVTX
         S4/E1RpCR43kEU6QBOvViWjBgnBOZQkNGiaiH7xyWJeuV6NOjzGWfCxAwnK5eytG2R
         Q1cHeEc3rBngEgTEdWyVVbs9Lj/FAgcIvge38oZSO98U30djwiSXEOsgtZ0BK0CClA
         tNkpuX4FdWW9ngD3cjUyw4sa2mi7mxdaHqFH3hHfBDLTOBa55nXA7Hz4zIeFApIH8/
         bgqvqxwXko8WQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E926EAC081;
        Sun,  5 Jun 2022 02:14:00 +0000 (UTC)
Subject: Re: [git pull] mount-related stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YpwFQLi1eeo3TmkQ@zeniv-ca.linux.org.uk>
References: <YpwFQLi1eeo3TmkQ@zeniv-ca.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YpwFQLi1eeo3TmkQ@zeniv-ca.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.mount
X-PR-Tracked-Commit-Id: 70f8d9c5750bbb0ca4ef7e23d6abcb05e6061138
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cbd76edeabd5ed078391abb2323b7aee790cdc04
Message-Id: <165439524031.29822.5642416161447241442.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jun 2022 02:14:00 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 5 Jun 2022 01:22:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-18-rc1-work.mount

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cbd76edeabd5ed078391abb2323b7aee790cdc04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
