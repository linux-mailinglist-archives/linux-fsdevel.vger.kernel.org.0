Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E087AF065
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 18:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbjIZQOp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 12:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbjIZQOn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:14:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409AD121;
        Tue, 26 Sep 2023 09:14:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD8D5C433C9;
        Tue, 26 Sep 2023 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695744875;
        bh=6QT8sPoqNA4aS6lqhGTTohgYUQtUd2cZJTSS5Bx2fIw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UGyjXLw2VHa0Jzb4SPfqr641fIHS48PVCpXZxzKFUPuGkoqG5HCxy3U+Otn6iFR09
         WifgtOyWzpmk9TCaJ3Hu9ZZvaiHA52FAwSeBGPh2eJ6NmxgTWu2jRsIE+AgxSxAUsI
         8qAjGjqgJb3SBG6Zzq6g3/rTg4aJv7WyPbuMAoni9a8H3eme9crdRmDVOPQO27K7Yz
         RkQWrwRazvO3ydMRyHjC4h0vv2Vk9eVA9LX0R9V9BOt8QfEEDpnqKXdqzObqTHZOwu
         9O1LS8PWa0eLenewN95VvnwEf6ESr4c9Bmj4jDtDrONhYq7e5c2iLtIlGhIyejo9r9
         0mHcX26j+MMfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5621C64459;
        Tue, 26 Sep 2023 16:14:35 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230926-vervielfachen-umgegangen-07e8d8f5a3a7@brauner>
References: <20230926-vervielfachen-umgegangen-07e8d8f5a3a7@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230926-vervielfachen-umgegangen-07e8d8f5a3a7@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc4.vfs.fixes
X-PR-Tracked-Commit-Id: 03dbab3bba5f009d053635c729d1244f2c8bad38
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84422aee15b9c6fd75ea01a7eedaad1aa0ec9081
Message-Id: <169574487580.15087.291441534812615094.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Sep 2023 16:14:35 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 26 Sep 2023 12:39:55 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc4.vfs.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84422aee15b9c6fd75ea01a7eedaad1aa0ec9081

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
