Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953BD64AE6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 04:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiLMDtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 22:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiLMDtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 22:49:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2511DF1B;
        Mon, 12 Dec 2022 19:49:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B51861311;
        Tue, 13 Dec 2022 03:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0BF1C43392;
        Tue, 13 Dec 2022 03:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670903373;
        bh=aBK50kjDyyZ6WDG+BH2x9zjJkQyeeGCiBEJCorqidA8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zx5DZ/jQ07NLok0J1YssU+LIfinXGXGAxNsVpdhmtvGu9RHSyR6hSGUBK1gjNxj7S
         1NJU7yF1BRDFEcNryBzId0FqSctY4S3b+q9b15Sc616TuGION8qcSJ2MkuQGMKqOmS
         dNu9L7qM99m7E9hJT0Nk4a/5y+ioiJAD6/BRN7LQtQ9nrbbu7VP0WgWSBb8ZU3QRam
         +8HZrSz9KCpdVig8cujhehVeiL37BeEc9BKALc8+nssHwCjC77JnalRCKZXKzKGkJO
         wCuhQAdnVOOzGM5/O78OJ3/xLCT18fKvhSJ70sh4emleJCPsE+0yGYIbSs9IuLj2r0
         Qcd32nFGymnUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F7B0C395EE;
        Tue, 13 Dec 2022 03:49:33 +0000 (UTC)
Subject: Re: [GIT PULL] setgid inheritance updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212112053.99208-1-brauner@kernel.org>
References: <20221212112053.99208-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212112053.99208-1-brauner@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.ovl.setgid.v6.2
X-PR-Tracked-Commit-Id: 8d84e39d76bd83474b26cb44f4b338635676e7e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf619f891971bfac659ac64968f8c35db605c884
Message-Id: <167090337364.3662.16039337163837484767.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 03:49:33 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 12:20:53 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/vfs/idmapping.git tags/fs.ovl.setgid.v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf619f891971bfac659ac64968f8c35db605c884

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
