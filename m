Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9577B6ED6DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjDXVpo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjDXVpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01406E97;
        Mon, 24 Apr 2023 14:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FED561F73;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A85C433EF;
        Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682372739;
        bh=XpoGRHbbde5iaXIu/q00LyQZTDuyvWqXJD2LV+tA1Ck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Svi8cmj14YQnR0t2rZ0udtIVjd+ysCb7UuseWzdnFe32IP99HJCGfUNzCQZxvIfJt
         YsMJ12IhgXTWlfa7oedeCuLE/haiE4kZQldXXKEzIF5x0gspoqaq+LPeZpgR5uNpKS
         aU3xJaTObc0WaIUf7Tq5tf10xr6cexQ6PjU3eAJlu+SJ6jjune37KzeFdiepZbQDnY
         uM432W9vxMDwEQ2cqu+Y2YYgOkOIf4PhGK9nTRWDqg63FAxM9hfALav6FW2zi8Xypz
         hQVxN5kEqP2qgL2tQFZzvjK0IUFREEDXiCM92B4Qb04w60ulPY6thGiVXJRaOqmbFw
         khYRsQFbg07SQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA510E5FFC7;
        Mon, 24 Apr 2023 21:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] pidfd updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
References: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421-kurstadt-stempeln-3459a64aef0c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/pidfd.file
X-PR-Tracked-Commit-Id: eee3a0e93924f2aab8ebaa7f2e26fd0f3b33f9e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec40758b31ef6f492a48267e9e02edff6b4d62c9
Message-Id: <168237273969.2393.3081258903583039814.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 21:45:39 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 15:41:10 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/pidfd.file

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec40758b31ef6f492a48267e9e02edff6b4d62c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
