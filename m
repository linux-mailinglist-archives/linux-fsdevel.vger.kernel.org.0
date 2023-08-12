Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144A1779CD3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 04:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjHLC4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 22:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjHLC4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 22:56:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030C211B
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 19:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A58564A3B
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Aug 2023 02:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F6B4C433C8;
        Sat, 12 Aug 2023 02:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691808962;
        bh=+PlOFW9POGSm/AgbLPSmFmvwzGIZfq7d9EW7lFAuAls=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pEOGqW9hvDfBTj5BHO5f0Br6q9Mk07rSgAQtqY3+F6RFfHWD3tKOfZXLPH3gCeRB0
         fj3GGlQ11ol2pQOPFIGFfBg8AM9RLrZMzLk1k5RpqJRf4Rxx8zl1DNHpBnqHm7Bn71
         CLXTzAyelO3GvuqeweYCNd7tg0Z9Ry6wjZf2iXIN0EdR90+Be+KvqyKM6T58VcsE53
         9cF4JGUMgLCME+URL+21cdqWDdKA5xUwXdRGXZHAbbU1yr06wcZibp3g0MwCNMsgHc
         NM/RYd9NeSnJ0kKi1Nsd9h/V1XXsmMlLgCVWdHFP99uwSIxsyqyiNKIwUFYXtJDvqg
         9LM+cfYsmh8ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A7D7C3274B;
        Sat, 12 Aug 2023 02:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230811234850.101951-1-dlemoal@kernel.org>
References: <20230811234850.101951-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230811234850.101951-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.5-rc6
X-PR-Tracked-Commit-Id: fe9da61ffccad80ae79fadad836971acf0d465bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0725a70411bd836231c3e78090ac47cac51246b1
Message-Id: <169180896236.32599.15074314397721541726.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 02:56:02 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 08:48:50 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0725a70411bd836231c3e78090ac47cac51246b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
