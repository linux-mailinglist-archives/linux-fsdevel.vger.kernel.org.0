Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71879759E58
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 21:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGSTUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 15:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGSTUK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B89199A;
        Wed, 19 Jul 2023 12:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D24B617E1;
        Wed, 19 Jul 2023 19:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E70D4C433C8;
        Wed, 19 Jul 2023 19:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689794408;
        bh=RyGFReZIp3EwbsBtVHroy017/Y1zNF/0hF406X35kIU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TzkOpYMHPcgHUFiEn82rW7z6PG81MHbR+GQgzZvy9e/Yo45nU4T+YoHp+DU2g4dSe
         xJPrl7gad712Z97diMFOWHQ3Z58eqbAeuSfySjNCAYsWz+M6kviv0kOpYtJxCpcSKC
         Omjdq79YJYPisvpI+muTs2NFiNOtwn+5aU2qvSidMK2mbq6d5RwMjFsn/H8bheYyBj
         UYR4/JTju9Na/3oyKoR/94mHbjrTn78psPprHR/sKajHZ2Ny4FdJa77TWpeRsQwb5F
         bBtQmbc3UhK0iPY4SzipzfZnXdsvlVTehGusvUbuJM4Pr07cqctOsm9MORlz/FF+2T
         tRGPH6jLZ1dew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C91E6E21EFA;
        Wed, 19 Jul 2023 19:20:08 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZLfxJKGLH8IpG7Ja@miu.piliscsaba.redhat.com>
References: <ZLfxJKGLH8IpG7Ja@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZLfxJKGLH8IpG7Ja@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.5
X-PR-Tracked-Commit-Id: 6a567e920fd0451bf29abc418df96c3365925770
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfa3037d828050896ae52f6467b6ca2489ae6fb1
Message-Id: <168979440877.1405.4496489658250733171.pr-tracker-bot@kernel.org>
Date:   Wed, 19 Jul 2023 19:20:08 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 19 Jul 2023 16:20:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfa3037d828050896ae52f6467b6ca2489ae6fb1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
