Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2240D53359B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 May 2022 05:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbiEYDIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243925AbiEYDIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 23:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9C5372E;
        Tue, 24 May 2022 20:08:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE48F61566;
        Wed, 25 May 2022 03:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4710BC34100;
        Wed, 25 May 2022 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653448094;
        bh=hIMWRD5RoXStTDjIVeo7GYWurWoP+X/HpyG8DlRWiNI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ApdC8NzGzXGEeGj3JSycIzALGhQwN6eqwk+RY3pW4+PHnuTQQoBSR4K0q1AByiSBv
         ukOXb9U/aIGZi7NYanMaO/ZTtV80+vSkOfrjX92A89pMAvLdjGkUYOykX+xnRqU6tl
         aKoLU0R0aZp3U1vk1oigtkcs4K1S4uNxcYzNv2Wo1DaDIswMGTgrPEHqqX+oLizTuS
         s94grYE+2+mAgPTX17YUFMmCOuPCld8213JMTnqCmBowUhQdripX8UzJ3MFbP1xd+6
         7IRamA+9omQXbJ/R48DETUjO0xKmQxcMyX7SHodw4oVyeaxMilGp8aXoFapPey3KMB
         I3xooq32/NklA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34CB1F03938;
        Wed, 25 May 2022 03:08:14 +0000 (UTC)
Subject: Re: [GIT PULL] Page cache changes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
References: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19
X-PR-Tracked-Commit-Id: 516edb456f121e819d2130571004ed82f9566c4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdaf9a5840acaab18694a19e0eb0aa51162eeeed
Message-Id: <165344809420.13784.10301028224447213540.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 03:08:14 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 20:34:45 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdaf9a5840acaab18694a19e0eb0aa51162eeeed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
