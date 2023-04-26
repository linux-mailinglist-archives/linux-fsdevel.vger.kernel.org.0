Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1946EF8F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Apr 2023 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbjDZRGm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 13:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjDZRGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:06:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438D17AAB;
        Wed, 26 Apr 2023 10:06:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 249156367A;
        Wed, 26 Apr 2023 17:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8587DC433EF;
        Wed, 26 Apr 2023 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682528790;
        bh=vY3vR2SIoVfoXXvvxBzyFBrB8Bp1NwwLXPkNsWLh1iE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d/KJoUP67kXRAeEvgilxA5kgtwxhimwo54e5/VKwygQK4blC/NHxB/5DVZVuFQ74W
         kFUUS6YZ6kB0hnBttiMcB8dj/u0q5YHOjoSn9SwrD09jbbp7ZHr8x7Xavc8OLHn3Ko
         GA3DaAO6tAmQQ48KE+gxxguV8XGUL80+rSlNDL0UzBM6gBlCK87RRohMxf2ypdrBi4
         V037PdFWzIkruFU2Xx+CMp/zPalsF7lT3yLGqrdMG8bvu3XuKCNrSRVeEnIwfxlxJo
         0CmMXhkL30Cj+mBKAtDYjbIRfJg4yGkJ/0wpDi+Jd3DHPITrxISbmFv3d00por4nGl
         xce4ufeNoj1TQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 704B9E5FFC8;
        Wed, 26 Apr 2023 17:06:30 +0000 (UTC)
Subject: Re: [GIT PULL] fsverity updates for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230425062707.GB77408@sol.localdomain>
References: <20230425062707.GB77408@sol.localdomain>
X-PR-Tracked-List-Id: <fsverity.lists.linux.dev>
X-PR-Tracked-Message-Id: <20230425062707.GB77408@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus
X-PR-Tracked-Commit-Id: 04839139213cf60d4c5fc792214a08830e294ff8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3558a6b2a75d9adacf15dd7fae79dbfffa7ebe4
Message-Id: <168252879044.19907.1440082376684042155.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 17:06:30 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 23:27:07 -0700:

> https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3558a6b2a75d9adacf15dd7fae79dbfffa7ebe4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
