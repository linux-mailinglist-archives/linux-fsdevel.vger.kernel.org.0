Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862634E841A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 21:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbiCZUTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Mar 2022 16:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiCZUTo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0207C37010;
        Sat, 26 Mar 2022 13:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 927A560E08;
        Sat, 26 Mar 2022 20:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F272AC340E8;
        Sat, 26 Mar 2022 20:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325886;
        bh=iAwxDGh+OHSMeCgxI58kcKBhJGTYDbhjZPNea+uTHrI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=acHbmy+6nkSdqIJaKsQA+U3Gws76yA3FqE2bKyqWKb1E4mywfWQJU8dz3E6TgSPjs
         eCGLGq59T2wI/YE659OlkfdQJomI+fSYy5txkOz6ExqfszZJMMX5SlqeCvCc6ou+Rz
         mx05BajZ85lUDOHL6WGhcPPc3JD+3nfwEqP2EfafJ8gmppotpOiKnFO2h4sxdfrtJ2
         wb0QT2rOXA+N/rnsdiddjLkW7ME6sNICd4P1CEWwKBYa2ZYE87VRm/Q5K5koa650CP
         FxEY42aeMuK2skrx13FxlNnNDk5ctbsZ3mAQC4iN7WvTqpwo3C+zfdBcSwDKZHic09
         ocCTvlQvWnrZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFB28E6D44B;
        Sat, 26 Mar 2022 20:18:05 +0000 (UTC)
Subject: Re: [GIT PULL] fs/iomap: Fix buffered write page prefaulting
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220325143701.144731-1-agruenba@redhat.com>
References: <20220325143701.144731-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220325143701.144731-1-agruenba@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/write-page-prefaulting
X-PR-Tracked-Commit-Id: 631f871f071746789e9242e514ab0f49067fa97a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a060c9409e25d573c23fccb8e02f098aa33f812e
Message-Id: <164832588591.7233.8578715497331096134.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:18:05 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 15:37:01 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/write-page-prefaulting

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a060c9409e25d573c23fccb8e02f098aa33f812e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
