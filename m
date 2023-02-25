Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD706A2706
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 04:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBYDkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 22:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBYDkK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:40:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0C412054;
        Fri, 24 Feb 2023 19:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB3C6B81D8C;
        Sat, 25 Feb 2023 03:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90DABC433D2;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677296406;
        bh=+ya2aTbqPU1jRSryx1y/EVxOp6foWqIwYiHzMFeeg7w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YPsHQcJRDP0w2jiKKajKJuHSHVWe1PHsXu8WF4yDh7XMhzhHoTK+gH594UmU2la1L
         LgeWykWIJmxxfakiKTQ8UK2FtFk2CCeYH4c+6+3kFr9gt4JmTGp1CAf+cS0vBG+CZv
         x+PjqJc1s6qz5Y6aDBh+mJR1F8yqMaElQcYk4b8iEndmtMCCyr2enOKMtCGFQxslvV
         1LoqKh4IkB1YV1p2Ro7srclEIO1qxqRWJTRAgs7ZeoPlLaBO3+4Xj5YrhTA0Gtdn1Z
         Rz7/SkMB9m6LoqLyUo8WBVlZbt29LJzpw66M7DGI1sVSzYEy9Y9M3kEE1zeWPzesE/
         sXIxhmnmV0iCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C82AC43151;
        Sat, 25 Feb 2023 03:40:06 +0000 (UTC)
Subject: Re: [git pull] vfs.git namespace stuff
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/gwdJrHLvEC1lCn@ZenIV>
References: <Y/gwdJrHLvEC1lCn@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/gwdJrHLvEC1lCn@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namespace
X-PR-Tracked-Commit-Id: da27f796a832122ee533c7685438dad1c4e338dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3df88c6a175d883b58fc3c31e36c94eb5e2ad180
Message-Id: <167729640650.19216.9818114627898493243.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 03:40:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 03:35:16 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namespace

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3df88c6a175d883b58fc3c31e36c94eb5e2ad180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
