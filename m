Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA253359D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 05:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiEYDIY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 23:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbiEYDIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 23:08:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7635372E;
        Tue, 24 May 2022 20:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0245AB81C28;
        Wed, 25 May 2022 03:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9294CC34100;
        Wed, 25 May 2022 03:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653448100;
        bh=YiZS6n0h6kFNa2uLipNZc4as0ANHqgdnU1TCtmR7xJE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UhcZvKsAMiHN8rzDHzTIMesOJJbSJ54TwAqCAm11om+YayLdyRPA7JGvu7WB1Ix+W
         t6YiNtk6BnCY7LritzBJbwYJL1e1YEAm9qIcAMm4CdU2TYqjj5ymPckgtWeGKysXFG
         gQe9sRe/UCNLkO318zmeKnp8WIz/o1gN6+KaFG5kiLnETkJM0rI8tM+Ry4216t6OgC
         VODIU2PUKoYoOTYxHjap48sqMopXH9kX8ShvWGIScBXXHgVp73aHP7uV9U1kzMJOes
         xtNHvtTSaPW00q0DvAZs6/a5EuMCxz9IR+/EsmepM0WyforoOoGS7qrfg2d7Bp5gpo
         iYkr9EbNznPTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7F66AE8DD61;
        Wed, 25 May 2022 03:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo06uCPonxSkD0Md@magnolia>
References: <Yo06uCPonxSkD0Md@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yo06uCPonxSkD0Md@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.19-merge-2
X-PR-Tracked-Commit-Id: e9c3a8e820ed0eeb2be05072f29f80d1b79f053b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8642174b52214dde4d8113f28fb4c9be5a432126
Message-Id: <165344810051.13784.2293510166540716212.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 03:08:20 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 13:06:16 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.19-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8642174b52214dde4d8113f28fb4c9be5a432126

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
