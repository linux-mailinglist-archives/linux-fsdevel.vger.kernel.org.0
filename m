Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2151792FCF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjIEUTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 16:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbjIEUTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:19:14 -0400
X-Greylist: delayed 253 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:18:57 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E819B;
        Tue,  5 Sep 2023 13:18:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 593AAC433BD;
        Tue,  5 Sep 2023 20:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693944841;
        bh=GFO5GRJejDTxCXECXiFVVLrIOOshgiMddxUgAHIkTE4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S1L2siA1e8otRX4aviagit6PAHoAtkeUwOGbICCrPC+/m9/vo80TPfxnOYLf01SE+
         qNslU4lnAZ4DfCctFo+GcNo0TsPljujlwmuwdrsqlpZKGMkS3HmcCmUj1r3Zvuo0p2
         k+GLFkaeeVC7FcmCPAou/CIeHumcXtpMA2caAWiwaoF1VACBecMNZ6a8Vy5WHYkQpc
         KM05iAfr4zY4QOOo8mr0yO0SyHco/pBuWHpcz9oKUhUxtymdZGp+3KPs/cK58SKP62
         Xz4evbfFgoTbWvlJ656E27EZIk6HiFbsH0TGf8rtyBHHAMQAQVVU4eRcQI5jjtEeDZ
         3/WcaL9yxB2bw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45EB1C04E24;
        Tue,  5 Sep 2023 20:14:01 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPYxd0g9S4og17QN@maszat.piliscsaba.szeredi.hu>
References: <ZPYxd0g9S4og17QN@maszat.piliscsaba.szeredi.hu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPYxd0g9S4og17QN@maszat.piliscsaba.szeredi.hu>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.6
X-PR-Tracked-Commit-Id: f73016b63b09edec8adf7e182600c52465c56ee7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e310ea5c8f6f20c1b2ac50736bcd3e189931610
Message-Id: <169394484127.28658.8202824816427131970.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 20:14:01 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 4 Sep 2023 21:35:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e310ea5c8f6f20c1b2ac50736bcd3e189931610

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
