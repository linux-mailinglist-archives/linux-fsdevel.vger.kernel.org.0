Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3235891BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238625AbiHCRtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238530AbiHCRtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE46459A6;
        Wed,  3 Aug 2022 10:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCCABB822FF;
        Wed,  3 Aug 2022 17:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8607AC433B5;
        Wed,  3 Aug 2022 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659548936;
        bh=iEYxRHh1485E9SNCkC9hw3OJ3TkQYNoe53rtBk6q7XU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MlXYpduaELD/apo1MVbwhNhzgy/JXI9I+8C7QrtDDL7tr6EbwFPrziivB8toeTeT7
         lX0kBajR3HtRIubAoJ7z6JjGnG8N7b1iAkze/fVMng7tKjfl/V3UocOa7XBf3JY4Su
         4W23cwPxHC+JfqFgQwiFVoFu8M3B6QYOFumPUDmWDrq9UOKHNrPAzl3/UxbmEcHn9p
         TlTewrIQAvR4c09QV62m5N9jrdewl8wSI7/NBXQgHjZT+EmMRX8psy4qcFLuHzr9yu
         np5ZKqxuhqW83cl63+QkaTuinS0NTX28j205NpfBMrp5PfQOzvVqe3eA8JatlSYSz2
         bkxaNBqI+LD3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74FAFC43140;
        Wed,  3 Aug 2022 17:48:56 +0000 (UTC)
Subject: Re: [GIT PULL] XArray changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YulcdRuGoA4CpKGm@casper.infradead.org>
References: <YulcdRuGoA4CpKGm@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YulcdRuGoA4CpKGm@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/xarray.git tags/xarray-6.0
X-PR-Tracked-Commit-Id: 85656ec193e9ca9c11f7c75dc733c071755b189e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e087437a6fef3acc11aaa1ade84731fe1571b808
Message-Id: <165954893647.32324.13141906257901129281.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 17:48:56 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 2 Aug 2022 18:18:45 +0100:

> git://git.infradead.org/users/willy/xarray.git tags/xarray-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e087437a6fef3acc11aaa1ade84731fe1571b808

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
