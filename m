Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58AD67A4D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 22:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjAXVSM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 16:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjAXVSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:18:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550B521E4;
        Tue, 24 Jan 2023 13:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8CE6134F;
        Tue, 24 Jan 2023 21:16:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C230C433D2;
        Tue, 24 Jan 2023 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674595019;
        bh=s1zs0WyGeKXAC/DydA7ShaIPwIC03u1UtcwEAUkUj9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YZiH+BAUS4vP3iBsTlsGUaEMZuTezot1Rf3aV1Q+w//8eY0LtiGInqDcWv06F3qEr
         4Nhd9yNkZ79pwTOdINiUi3+OPmPgSmObClwGQ5ygFcC+R1R9SPf2X11RDKiAHShtV3
         GZp5nXcoaCK2BUo6MYNnnTOqLMnn0qov/IM5Z+2rjiLN22J0p6aLjOn0TSrweM0jqF
         rFGUTfVau36WrZYVWs/xfN33MvBkIVK2aBAgvQsuFTxL19pszykZpaycN9kSYfaj4F
         N5kmMGV9awS3gqWJ+ptYNlXA0wFsmBP0tM096bOoSwncLApGVe//t/no0soMwc4Rmp
         BhBpTTHmScOtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1443AC04E33;
        Tue, 24 Jan 2023 21:16:59 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt MAINTAINERS entry update for 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y88g398lWBul+756@sol.localdomain>
References: <Y88g398lWBul+756@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y88g398lWBul+756@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 31e1be62abdebc28bd51d0999a25f0eea535b5af
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50306df38ac4edbeb1eac29d68128f84630405d8
Message-Id: <167459501907.6044.5610473642802691277.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Jan 2023 21:16:59 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 23 Jan 2023 16:05:51 -0800:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50306df38ac4edbeb1eac29d68128f84630405d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
