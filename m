Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082D470120F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 May 2023 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240104AbjELWOO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 18:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239999AbjELWOM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 18:14:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2278830FF;
        Fri, 12 May 2023 15:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017CD6448B;
        Fri, 12 May 2023 22:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 616B2C433D2;
        Fri, 12 May 2023 22:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683929651;
        bh=mDDJeaxsNf1aXZ9wV8aCNURwkaggqylfJZ51rEeIK2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UycRwXbWWcm6kz1jJosVKs2E0sPD+m8b5kRTQpdSR8VpmO2jOmJtWdFKwP0aP8UR1
         k9QUgpxh51FMfF8X4gHCnC263KzV+vztjXmAqQpaSEVNdLWNRQPnYUGt+0QMzjzzVO
         Jsb2mkhAgh2/J7eJC48dakz6BW498mY5RfUt3EIYSF2ct7ORy1xJvdNwtjVZfWt5O0
         2SOxb70PzX2NKMf9W/Wt2BkjQrAmIxd//6ObWcMaodq8qSgAvORKp3D2qA5SiJ5hcT
         jqeh4UhtJGmPUIeFXVd1mfIqizGy5BWKe1XneU8BZKdshgkgu/6YT2d+U10CmoHXeQ
         ddcmxeFeCD+rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 475BAE26D20;
        Fri, 12 May 2023 22:14:11 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230512-physik-wahlen-16e1f37abbd6@brauner>
References: <20230512-physik-wahlen-16e1f37abbd6@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230512-physik-wahlen-16e1f37abbd6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs/v6.4-rc1/pipe
X-PR-Tracked-Commit-Id: c04fe8e32f907ea668f3f802387c1148fdb0e6c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df8c2d13e227e4670ebe777970f89db7802b1f56
Message-Id: <168392965128.28473.15729239394981255595.pr-tracker-bot@kernel.org>
Date:   Fri, 12 May 2023 22:14:11 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 12 May 2023 17:31:51 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs/v6.4-rc1/pipe

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df8c2d13e227e4670ebe777970f89db7802b1f56

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
