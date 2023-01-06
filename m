Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBB6608B7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 22:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbjAFVTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 16:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjAFVTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:19:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E281D5F
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 13:19:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C3F61F7B
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jan 2023 21:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E84C433F0;
        Fri,  6 Jan 2023 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039947;
        bh=6PB+fviYqDHzzavsZTYV6ng/4cBqzRe9jSkMl7OChHQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NaA+dVVVvMg7HDO1ipyQi9UaDGfBoWsG7+YlOD6PkPH5mfmixNuuofgd5xKZihbq7
         yBwmxjllc3mUBB+JboBbuWzYG17RHtrHzuxgt0aQayC/NhJRvHG6+qJTf1zYliWcF6
         3H+YnaodgZcjXGgDcl4t4ZZqMa6BVZaEHRmgIs2HdtVjZb+0Pjsp/2Oh+T6peyR9sD
         tgfjjktDnZMJF3bMDktdl/t5Q8+oXceuXaksjsVVXP/7fuSUa4ixK0WixBRot0xI/i
         m3i+4OJ7LjqM+NxtBUS30hS2BrENNEAFvpKwX3DcJqkGwXyRn82RtRE1gUrvrRcSSZ
         LkW+eBFbx7FDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58681E5724D;
        Fri,  6 Jan 2023 21:19:07 +0000 (UTC)
Subject: Re: [GIT PULL] UDF fixes for 6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230106150939.ox6rrzbrbu3fhvhn@quack3>
References: <20230106150939.ox6rrzbrbu3fhvhn@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230106150939.ox6rrzbrbu3fhvhn@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.2-rc3
X-PR-Tracked-Commit-Id: 23970a1c9475b305770fd37bebfec7a10f263787
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b8c854cfe8c94b2ec382a3632b1bd7c970c80b4
Message-Id: <167303994735.10294.8882557034420509583.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:07 +0000
To:     Jan Kara <jack@suse.cz>
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

The pull request you sent on Fri, 6 Jan 2023 16:09:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b8c854cfe8c94b2ec382a3632b1bd7c970c80b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
