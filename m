Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5643164AED4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiLMFAO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiLMFAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC11DDFF;
        Mon, 12 Dec 2022 21:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E58EB810DB;
        Tue, 13 Dec 2022 05:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA7F8C433D2;
        Tue, 13 Dec 2022 05:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907605;
        bh=bWHTLgFxQc2o39iSKlfIsi3HueJcoojwB6FD6+BZaL4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UACdc+N63MewVjY1V87dLL3dUoq4j35AW4bq3IwmzddfYe0NAX8dTXtLGXrvkAN3L
         NsOAZnPyfr8JAUj/Vo7+rPZ/q1tz1vMlZ+12mVFjAOMTOYTzt1Ge7gGSi3OQUg/ToU
         y4eko5o2ShNW7a9wl6lMBVHezZU0vQ4NLQ6VZPyu5jbt5MvoQo2aTlvm1V6Vgt3KIX
         TysN2qxL6Ymi4z0bJbJIrwZdLOPWVOqBsT2YwuvQeQeRBrF31DrWFDkN6fZn4VhY8W
         /awKEYGXDmBksT3tH3Crh2I6OVdws60pNX/k+7cAKkyg49mjpSPam5UJTrr2jcSnvp
         cdi2ZNPGvS33g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEB28C395EE;
        Tue, 13 Dec 2022 05:00:04 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5ayAsXkTF3jK13s@sol.localdomain>
References: <Y5ayAsXkTF3jK13s@sol.localdomain>
X-PR-Tracked-List-Id: Linux MTD discussion mailing list <linux-mtd.lists.infradead.org>
X-PR-Tracked-Message-Id: <Y5ayAsXkTF3jK13s@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 41952551acb405080726aa38a8a7ce317d9de4bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8129bac60f30936d2339535841db5b66d0520a67
Message-Id: <167090760471.4886.14328396193429514472.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:04 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 11 Dec 2022 20:45:54 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8129bac60f30936d2339535841db5b66d0520a67

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
