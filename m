Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10E26308FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Nov 2022 02:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiKSB6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 20:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiKSB56 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:57:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54897B7FD
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Nov 2022 17:50:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00FCCB825A8
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Nov 2022 01:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4A64C433D6;
        Sat, 19 Nov 2022 01:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668822612;
        bh=UhVfg4KPiwPcZZB4RKqr9+cPXR1w/pUNJvC6vpYuRzU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DM0SoUY8kdKU2j/tBmwlLXXm/GthQbxXHdgCyTQT1MrFoGqEODer6rlZz/joS+OtZ
         7YhxN4IHzYa0JpukztAic426mjM2FF5Lzock9XCqeBdhc5o+paLwPF6wynupG+2ea4
         JwBvNB+I9rl/jXN9pyVGKiq3F8mG/7n7HEd3pDExs5VRL5ilLVjJJKX9lLzBBeU4HC
         eeTbL7C9qnGmjNf95l1bQVkj1m5BKVmLdwwFlxkTJyGalX6r2i825c7FiPsxWq5raM
         L/C4QiYldudBTINs4osilnCQTz7euXyNILb6qMBnfwwaCz+iMMq3CuEuH9wUeUdQ1F
         TIr+/bCfSKExw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94DA6C395F3;
        Sat, 19 Nov 2022 01:50:12 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
References: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221119010906.955169-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.1-rc6
X-PR-Tracked-Commit-Id: 61ba9e9712e187e019e6451bb9fc8eb24685fc50
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf5003a0dc5024987eb3193a19aa802fc6235af0
Message-Id: <166882261254.29898.6013572924233603556.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Nov 2022 01:50:12 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 19 Nov 2022 10:09:06 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf5003a0dc5024987eb3193a19aa802fc6235af0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
