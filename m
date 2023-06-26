Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39CA73EB8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjFZUGU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjFZUGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270B26BC;
        Mon, 26 Jun 2023 13:05:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC1A61353;
        Mon, 26 Jun 2023 20:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72FA5C433C8;
        Mon, 26 Jun 2023 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809756;
        bh=j6p92V+l2Aa37Cw8poxa6Wns5g2oudRBe7ajeqxq/nY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Phnc5YKozbRvGUGY5c0yS9XasxQYZON5sMLtyM3eeVOCyekj+AB+JZNAHoSrSOkVN
         NOP9zqJ/7lSL0c8ebC8m46wzg17PDQWiWPRlhB+o0mmioqPnopGSHx3X80bOVvInKM
         89jCZkb/zpORrIPRIddpKFzSqQaRpd4xajhI8hR427Nly9VteqVsuR1eD4jXL/HnAW
         pgwIi9A6e9fRfYw5USd2Da5EPe7P1i5rBeMFsAEY+xObjyIEeodEmMfeXCzjciXxnv
         0yeqMFt44CMNYrZs0zg15RFWEENy/0HsYKjB8EiOjALrAryz72BagVARiB0JgpEVkV
         FgVEYZm8Q2lGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5472BC43170;
        Mon, 26 Jun 2023 20:02:36 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626015131.GA1024@sol.localdomain>
References: <20230626015131.GA1024@sol.localdomain>
X-PR-Tracked-List-Id: <linux-fscrypt.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626015131.GA1024@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: d617ef039fb8eec48a3424f79327220e0b7cbff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d483ab702c5cd5e8953a123e0aab734af09cc77
Message-Id: <168780975633.7651.7263058741298299598.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:36 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 18:51:31 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d483ab702c5cd5e8953a123e0aab734af09cc77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
