Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00D5331F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiEXTxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241320AbiEXTxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 15:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279463BE5;
        Tue, 24 May 2022 12:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5698616C9;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28CFAC36AE5;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653421994;
        bh=7vCQf4vTrafHpbFlTVFe9qAPgMyoesliZ7cB5zsfznE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l7nVX+XLhiNFzMN0IvOoXAjS2btaJ/At8c3DNT5Wwu8r/LU3IYAD4o7dGumNySCAX
         25C5LLzWDn+zC7WRnNcfg1JxD/U/kWv9gxLRNAS3Q428K/p3t0Z30qAbz6/mskVsYF
         lp1lG0lMJh0rq8q7gtbwk93/ODvOPbSduCrWisWx3+/bcoDvyKy/zrsKNZYXZMM96p
         +vigOT/A2S7qrxwYfK04YcIKzNT2wdTOiIDve+6/ZpVRoKdOSC0QuddJHnPDcGA5Sm
         0OKOU+a78vQlmQ/YIn1Ckf274wuu2y3k8XACcgCzj2cBfE9GPDy2BnKSmuHIuOaz4d
         tGu4sK+qXKW+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CD80F03943;
        Tue, 24 May 2022 19:53:14 +0000 (UTC)
Subject: Re: [GIT PULL] fscrypt updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yosyx2FYZOIOWs9g@sol.localdomain>
References: <Yosyx2FYZOIOWs9g@sol.localdomain>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yosyx2FYZOIOWs9g@sol.localdomain>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus
X-PR-Tracked-Commit-Id: 218d921b581eadf312c8ef0e09113b111f104eeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1f4cfdbef409971fd9d6b1faae4d7cc72af3e20
Message-Id: <165342199404.18932.5994094539908457947.pr-tracker-bot@kernel.org>
Date:   Tue, 24 May 2022 19:53:14 +0000
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 23 May 2022 00:07:51 -0700:

> https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1f4cfdbef409971fd9d6b1faae4d7cc72af3e20

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
