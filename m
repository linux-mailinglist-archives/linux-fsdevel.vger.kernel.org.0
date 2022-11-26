Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1E639357
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Nov 2022 03:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiKZCZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 21:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKZCZj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:25:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E022FC17
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 18:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1A21B80B3F
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Nov 2022 02:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AEBCC433D6;
        Sat, 26 Nov 2022 02:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669429535;
        bh=A6kdRcbyORys41WXoLq4eBjNend1hMiZPoaBWHR2pLk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NqpQ6OCMs+YhHNhwQmBsF93VgtxRhPFw6ZhSpjZt2++KeIP6ufp2Oh8LUdOZkIsOW
         cOKd4SD5o9LvUvXg0P+2h1wj4CsG+5kPtMFM/qpCugYtet+QpKzVySoJ613ncFgFQO
         LnyAN+ITYpeATs091AUN5Sf3MJFu2AQavgKy8DqaJsDFA8VZp/Jw1bSbs0qQof/2zo
         43xqU5qGTjTF56ip7pT5qTngCpC6aq5GnKyDCbf91l+KbssmRw8Uuen8Wryj7fUw65
         5N+BbWMYqrk6zFYliVTR1VtJfmwTivqvwfXiICoB0CrPzb0QBh1uSKzGFrG4Nv7yNF
         jhEyAx3VOpazA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88A65E270C7;
        Sat, 26 Nov 2022 02:25:35 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221125225408.769615-1-damien.lemoal@opensource.wdc.com>
References: <20221125225408.769615-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221125225408.769615-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.1-rc7
X-PR-Tracked-Commit-Id: db58653ce0c7cf4d155727852607106f890005c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e0d88f911fb6815ac8349766859c99a2f0aa421
Message-Id: <166942953555.27056.7719373679760941558.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Nov 2022 02:25:35 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 26 Nov 2022 07:54:08 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.1-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e0d88f911fb6815ac8349766859c99a2f0aa421

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
