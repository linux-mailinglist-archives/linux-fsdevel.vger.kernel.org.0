Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F0745019
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jul 2023 20:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjGBS4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Jul 2023 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjGBS4Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8003F121;
        Sun,  2 Jul 2023 11:56:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EF0060DDD;
        Sun,  2 Jul 2023 18:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78969C433C8;
        Sun,  2 Jul 2023 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688323983;
        bh=NXJWNqcTIbq5svjCIgwegCWmmE+lJo+SDOM9IQE/VeE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gfrXTGD8YLsdXoU2p6MDo+WGIssQVtdSN3kq3PFPN51PDEFA6izh1jrpZtNBOz1YS
         PkrW2Nnj/k9AysRjYzrHxCcGuEj7H0HZea8rgdqYyroeQ4NbHq7QwON9u5o7PpX/LG
         3AlFyN+kqJgG09hBAr381DCGwZNiETb8pEu4c6c9JrUWM1BxiPD0zXr2BfWTb/2jGe
         j+5lLpfZ24qkVZ53bbJSq5+46ksRC5c+gsTUUXK1lF43IUlNSp6YlnbxkxV/au3iSm
         Lxs9jbzmc61VvEPUFOpIr+y7sOznOBv9BGrtFom0mnB38wE7M9h98szDfC4UMS29dL
         8/cG68x8c7HzA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66171C395F1;
        Sun,  2 Jul 2023 18:53:03 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230702-wohlklang-heilkraft-839e2439651b@brauner>
References: <20230702-wohlklang-heilkraft-839e2439651b@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230702-wohlklang-heilkraft-839e2439651b@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.fixes
X-PR-Tracked-Commit-Id: dff745c1221a402b4921d54f292288373cff500c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28c7980fa14a3fbd8926686cfffb89b9542b0da1
Message-Id: <168832398341.18363.7184591957538463075.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Jul 2023 18:53:03 +0000
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

The pull request you sent on Sun,  2 Jul 2023 13:28:43 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28c7980fa14a3fbd8926686cfffb89b9542b0da1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
