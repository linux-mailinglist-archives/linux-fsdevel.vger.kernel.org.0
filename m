Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902B751CD5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 02:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387208AbiEFAGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 20:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387514AbiEFAGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 20:06:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98138A1;
        Thu,  5 May 2022 17:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9DF3DB831CD;
        Fri,  6 May 2022 00:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E3BCC385A4;
        Fri,  6 May 2022 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651795365;
        bh=IOTIPUf9oDnVA/fvNqYESDC6pzvEbZFUrFNwdKt2O1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FuSKgeHvgG/a1jtOMKiFxXG+oQTaB9kcJeDP6EnlF5TDe6qvB1mRPFEGGSRR9kf4n
         EzELq/x8bBxdOVA+pbvsfJvqMTX+E4larLSrv0IHnWLPPjZz+VC0lPFMb56gwH94Sa
         eAiyGnEK84VWQDWz1gBRQ1W9ZHxqpYWwcxBvaoUVzwRPdrfpm1kNPuM/NqnbwPsLG6
         cv/yCpyro6lREtzY2zLhIe9EPBqdYpt3oAgfBPzrwnOxJsJ61OVm14VV9im04346Rb
         u026w6IAEQ0O0yPZ2bsAYzQdFHTkwQ//8XesK8CTHj934htHGHOHefY5LT/B230I59
         XTx4QDQAKeZsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B2A7F03870;
        Fri,  6 May 2022 00:02:45 +0000 (UTC)
Subject: Re: [GIT PULL] Two folio fixes for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YnRhFrLuRM5SY+hq@casper.infradead.org>
References: <YnRhFrLuRM5SY+hq@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YnRhFrLuRM5SY+hq@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18f
X-PR-Tracked-Commit-Id: b9ff43dd27434dbd850b908e2e0e1f6e794efd9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe27d189e3f42e31d3c8223d5daed7285e334c5e
Message-Id: <165179536523.13651.18022528698915911744.pr-tracker-bot@kernel.org>
Date:   Fri, 06 May 2022 00:02:45 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 6 May 2022 00:43:18 +0100:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18f

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe27d189e3f42e31d3c8223d5daed7285e334c5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
