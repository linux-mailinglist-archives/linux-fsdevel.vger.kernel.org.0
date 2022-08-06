Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0738858B886
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Aug 2022 00:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241861AbiHFWIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Aug 2022 18:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241849AbiHFWIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Aug 2022 18:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D3FD133;
        Sat,  6 Aug 2022 15:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0766D60C67;
        Sat,  6 Aug 2022 22:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AFBCC433C1;
        Sat,  6 Aug 2022 22:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659823715;
        bh=AUi9CmohuUxbR7hJFM/LAOBJUvNSiAFjOg1ZEOTVKKQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GC1ox6lqirovi2R51ORdoz7HQ3c58XFMCj8iR5+tP/u3f7zc2YPSMVJeNmL8QbBdU
         6pGKIh7Mjstvir0X0upCSYb+Yd8pwnSvjw22nr/XTLTcgOr3tC+pq/QostXKWE9DGN
         YNswiehgXSOTW6AaIRTF3MXrNyZfUttoJdl+tBziE1OLj4bZJ9yVIUJ6f7gr6DqWMw
         v24BQ6WHxNhulOI6CGLG1eCOoBs9Y7QFAEGHXImG05qha0XWHbTf/Ubwc6M3YDbt1l
         +Si13fzVqKr8P+uvP7tjwp4ZAd2BD+UblFJn2ZNWZj72Y2wus1qMBHU0g3K5Jzxog/
         QR1E4yN0aGyBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BB72C43140;
        Sat,  6 Aug 2022 22:08:35 +0000 (UTC)
Subject: Re: [GIT PULL] 9p for 5.20 (or 6.0)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yu4soPL07+/xDd3D@codewreck.org>
References: <Yu4soPL07+/xDd3D@codewreck.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yu4soPL07+/xDd3D@codewreck.org>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-5.20
X-PR-Tracked-Commit-Id: aa7aeee169480e98cf41d83c01290a37e569be6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea0c39260d0c1d8e11d89c9d42ca48e172d1c868
Message-Id: <165982371537.16627.14380994567532665626.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Aug 2022 22:08:35 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 6 Aug 2022 17:56:00 +0900:

> https://github.com/martinetd/linux tags/9p-for-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea0c39260d0c1d8e11d89c9d42ca48e172d1c868

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
