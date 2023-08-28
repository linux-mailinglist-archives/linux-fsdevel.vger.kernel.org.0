Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989A78B957
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjH1UPb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjH1UPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A5318D;
        Mon, 28 Aug 2023 13:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FD8D6512D;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0402CC433C9;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253703;
        bh=MHoqQBQv06O4RAqZZ0aB1C7c3jGrax0ivXI5QhFItZU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VVskLiPNG3/42wmG5XbCbx2x5owmHt6qoz1PALuah9UsItXIm7u18T0R7cMp30yPx
         cblpm7vorXJN+d9qbwimR1IKi8cDohgRJ6B9vFmFP2yNIcoxIh/dhNIoBWMQn6Vw8h
         GrbELZEkK9WzbA51JNNMMIB3RdS7N5FvGg8kWV5zTH4bDO7qYOsog58OQKp7mazAqt
         xBWm8mKwvpcRcjoUQEVf8jo1aUBwDaJ8827tCOxQyWCBiZJ4B4MBJGS3GB/FxLhhtN
         sDQbz+O++eW3E9wsgS5jpQzGa/tNxdhm0oZ4QnKfxw8RhvSh13SsHE1dHfok0Q3fTd
         diMkNaQT3LJLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2C5DE21EDF;
        Mon, 28 Aug 2023 20:15:02 +0000 (UTC)
Subject: Re: [GIT PULL] libfs and tmpfs updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-poren-betanken-fd9aea241890@brauner>
References: <20230824-poren-betanken-fd9aea241890@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-poren-betanken-fd9aea241890@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.tmpfs
X-PR-Tracked-Commit-Id: 572a3d1e5d3a3e335b92e2c28a63c0b27944480c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecd7db20474c3859d4d01f34aaabf41bd28c7d84
Message-Id: <169325370292.5740.4820516637978399790.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:02 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 16:23:52 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.tmpfs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecd7db20474c3859d4d01f34aaabf41bd28c7d84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
