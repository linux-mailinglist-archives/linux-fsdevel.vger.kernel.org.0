Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2C96189D3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 21:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKCUqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 16:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKCUqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:46:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E370B1CFD2;
        Thu,  3 Nov 2022 13:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 55827CE291D;
        Thu,  3 Nov 2022 20:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 703FEC433C1;
        Thu,  3 Nov 2022 20:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667508379;
        bh=dicxxTAT0Ju/mX63Fahe8q4UUgRqDzxzPi5aP5Th7mA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RFNl19VFeEScmFT4GdaqmnHcxQFWSBMflINKxxlXW1fu32h0EgDwJ+HKQUAEP5VRV
         lFwPkESKSGvAl2/Hsmiw/U2+mxoW9m60flCCWl2H8flulkJZothvTKhyAHrsFufYyn
         FNhzhgxLxba4S6SJ4KUJuqQ5iFlmYlvxFUgWsBguE3xeabJhHacc1ejgXqMjPKmu76
         SOUXLiKUjQzljAIf5ABkKQuYTROlng+PDQ2URBgtDxGkf2+YRpM41nFMMXSOuq7IuZ
         APlhKdV4X6Hq+l9orjSfTJqLMWdGd9hy3hknIRSae5Zjc6+skR45kRjJiGygsBwNmf
         Ok1unEjuPsZ6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C25BC41621;
        Thu,  3 Nov 2022 20:46:19 +0000 (UTC)
Subject: Re: Re: [GIT PULL] fuse fixes for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpegsU5ezACm_6CDSJfcN5fqz5vWje6UE_erNefr_e03nuaw@mail.gmail.com>
References: <Y2QZpV0sTSK1UViK@miu.piliscsaba.redhat.com> <CAJfpegsU5ezACm_6CDSJfcN5fqz5vWje6UE_erNefr_e03nuaw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpegsU5ezACm_6CDSJfcN5fqz5vWje6UE_erNefr_e03nuaw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.1-rc4
X-PR-Tracked-Commit-Id: 4a6f278d4827b59ba26ceae0ff4529ee826aa258
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f7bac08d9e31cd6e2c0ea1685c86ec6f1e7e03c
Message-Id: <166750837937.13092.17291632288441115987.pr-tracker-bot@kernel.org>
Date:   Thu, 03 Nov 2022 20:46:19 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 3 Nov 2022 20:44:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.1-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f7bac08d9e31cd6e2c0ea1685c86ec6f1e7e03c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
