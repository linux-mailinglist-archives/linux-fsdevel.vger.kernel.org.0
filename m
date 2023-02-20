Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1590669D4E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 21:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjBTUWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 15:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjBTUWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:22:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEBD21297;
        Mon, 20 Feb 2023 12:22:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B98EC60F42;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89DCFC433D2;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924405;
        bh=JyGV8yw4mj8+xSfKsXtjm0iGZnX8Bs1nuO41lGPdd4w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hH0oHdvciDk8nYEvlJht77tHGQl0ZWuXf3OKqGTiiUmT72rHJ7uAu0Vuzk/Q8K5ND
         M1fCcNmooGZCWGUWolROhinvvGPfreMObZJuQ6Jy6bPwwABHEhUyK81u8ZVJvHWqPf
         njxTEzsKUTUB/85rklw5MwmxobzSn8hAjIhnemMuSYvRXh18+mGlFTrrIE6ieR6Nmu
         9aVq0dW+I2CVtBj7nsku5BQ525Hv6UX9FWgu5qZ5SduWZ1oaSXPn3PVcN3N8i7rva5
         LUn4GV31l1zyoLwnsJrjgipjm2sEROUT+zq4m65SkZvq9Td6gtz44Gv9a9SvOe/+/L
         bPv2y0gPk4Vzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A0C8E68D20;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] fs idmapped updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217080552.1628786-1-brauner@kernel.org>
References: <20230217080552.1628786-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217080552.1628786-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.v6.3
X-PR-Tracked-Commit-Id: 7a80e5b8c6fa7d0ae6624bd6aedc4a6a1cfc62fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05e6295f7b5e05f09e369a3eb2882ec5b40fff20
Message-Id: <167692440542.19824.14356187295592401434.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:05 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 09:05:53 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.idmapped.v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05e6295f7b5e05f09e369a3eb2882ec5b40fff20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
