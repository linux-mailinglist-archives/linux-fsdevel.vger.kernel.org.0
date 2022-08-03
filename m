Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2CF5891BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238641AbiHCRtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238536AbiHCRtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:49:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94E113D1A;
        Wed,  3 Aug 2022 10:48:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80B69B82311;
        Wed,  3 Aug 2022 17:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4321CC433D7;
        Wed,  3 Aug 2022 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659548936;
        bh=F6xLHA/wHiUub8EflLhc7nQxl3fyVYeheHSuuqsJZOo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nBWGMTNRB0lY5M5SfdsL30N2awCjl5a0x/irUoHlbtG2eg761xu5ytEzVJvZKM1IA
         jp6TE3a5HgXXIqPoe2+AmwKmjKXjLuThBfpPozKgddZE4H+YbVIXInc7kqFHb6rfF/
         S+IfVsxBxVUF+gkNQ+Lk/yfsBEBQ7FYHp1Wm+qZtnaDYOcakYXSHkJg9NhIEUbRwgV
         ar0oKOUfgBv1uXsqPTC/fTKUl35S8PG48tMo5+MSMQWWmm63miHQjdxBG6O7pBr+3Q
         /ablqu6X0kF1eIEKDyEgJRDKfOM4U4APWM1oLI6sJLHLABGgvthlBNUKmUvz+W1YQX
         kEiw3I/xyqgeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F1E2C43142;
        Wed,  3 Aug 2022 17:48:56 +0000 (UTC)
Subject: Re: [GIT PULL] Pagecache changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YulXSSBzxPPGkNaV@casper.infradead.org>
References: <YulXSSBzxPPGkNaV@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YulXSSBzxPPGkNaV@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-6.0
X-PR-Tracked-Commit-Id: cf5e7a652168fba45410ac6f5b363fcf8677dea5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f00654007fe1c154dafbdc1f5953c132e8c27c38
Message-Id: <165954893618.32324.11867592300806771379.pr-tracker-bot@kernel.org>
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

The pull request you sent on Tue, 2 Aug 2022 17:56:41 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f00654007fe1c154dafbdc1f5953c132e8c27c38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
