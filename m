Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4744073E683
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFZReQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjFZReK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F02910E9;
        Mon, 26 Jun 2023 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4065A60F0E;
        Mon, 26 Jun 2023 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6D2AC433C8;
        Mon, 26 Jun 2023 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800845;
        bh=WESzn2VKR6WeYhB7tc1WqFjiCwY0HXQ/hFypb6mYufc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IRSig2Cmj8HV4L8bShi58ly5B4C6MI6u7D0ctnsfU1RXDNK1fQ5PBF6Bo/g5Xp/wU
         Qs+TWD8lLjJ2LJZoh3fako7RQbnfIPpzknNq8fqYwJtNH8wJQVbJ+l+JlPFxKz782c
         kYUIicULYnVrNv51sVIeYOdg+2aJAr7p3+MgKxqmbS0gFKRoZwQN9j+DF0uFx9IrzA
         KO4/VOZ/gonjv0UlRUkec3rIpD9vTDxSZRtsjb9fVCbST9E3yVkjxawA1wG1oGvzCV
         zp9qNI5NeMM5LpbJmRPtTukz3zBJxeKbzNOC60/z97Syvn58VMk9foSv1K/dcDRafC
         r0UaEPb98AZxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EBB9C41671;
        Mon, 26 Jun 2023 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] fs: ntfs
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230623-pflug-reibt-3435a40349d3@brauner>
References: <20230623-pflug-reibt-3435a40349d3@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230623-pflug-reibt-3435a40349d3@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/fs.ntfs
X-PR-Tracked-Commit-Id: aa4b92c5234878d55da96d387ea4d3695ca5e4ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c1c88cddb79d3ed3fb1d02a3eaf529eded76f05
Message-Id: <168780084558.11860.16199724130954626717.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:05 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 12:58:08 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/fs.ntfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c1c88cddb79d3ed3fb1d02a3eaf529eded76f05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
