Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75D6F92D5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjEFPqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEFPqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 11:46:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5662D1A1EE;
        Sat,  6 May 2023 08:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36FFD6103C;
        Sat,  6 May 2023 15:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B9C1C4339B;
        Sat,  6 May 2023 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683387964;
        bh=gJiabGseQmuYgZafSb6SWwlitqRWvem2Cby0eDbSweU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pI5ep2KQ8E9x/CeHbwIBgBkmAmFZIox/yMVgZF73J0td5jZ7j1v/Zl+OoxetQSUqh
         lQv4OoAzOh2a1MSzuUOvvTLi8clNO5ZDqBR6bWUWEzIBVIxoPqrSz0+Eg3drrrx5Wy
         Mg8kIMqeM/kpXIqk7lYRhIbtJ2sG+nMU+JL0rOjYuoXEhmrnN0OQnGd587XRtEeX+j
         bAegWtBByOuOGSCpw0DB3yRTjM3GpA0c0TvF6U6s1FtZsGgjfAO8M+c53dI3flFcna
         +cJhIa782nTvVY7wdRVjC+pr5jktNzUWo/LxZOF2fwKkKP2MM+RNl7cW6/Klh0Rz2H
         WKopaA519iJww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 884A2C41677;
        Sat,  6 May 2023 15:46:04 +0000 (UTC)
Subject: Re: [GIT PULL] Pipe FMODE_NOWAIT support
From:   pr-tracker-bot@kernel.org
In-Reply-To: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
References: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/pipe-nonblock-2023-05-06
X-PR-Tracked-Commit-Id: afed6271f5b0d78ca1a3739c1da4aa3629b26bba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7644c8231987288e7aae378d2ff3c56a980d1988
Message-Id: <168338796454.28822.4066762564187422370.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 15:46:04 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 6 May 2023 04:33:17 -0600:

> git://git.kernel.dk/linux.git tags/pipe-nonblock-2023-05-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7644c8231987288e7aae378d2ff3c56a980d1988

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
