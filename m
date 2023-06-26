Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27D173EB94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 22:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjFZUGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 16:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjFZUF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 16:05:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A791984
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 13:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF77660FCD
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40702C433C8;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687809762;
        bh=aOX8rQiUiZ0g/4jNED+pBPyRqhDvltclXRfxECyrU6w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NnFV4tLueuy1EwZtGQDnBiYPtNyiqT8M9RysjFiqJR5DNyMd+Bt3Gd8ZMneofnM0c
         xSh/I4DgmMlnpFgpNI4QmNwQYk5n5VcsDp3TIYasx0Vz5um5otLY+L9ft6ZNsKXRC9
         vo/T7JvD9MRx8xzPiMCwIi4HvOx/ObYRFoOX/cLBVvFwgk/icZk+hGGEM6ZZ23mneT
         4Ksyh/a/MO+7VoCSnF0TP2pUJl6pLFoT59fXfzJYMq5s0DECVd/J5zDlVst4ne4RqX
         N5LFz5hDXAiA6Gib8q5juujchIQHtQPKBewlBxqAfM89b9suaGfJ/IP3H1HoKuTdYh
         hMwAo8mZ5sD7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FC5FE537FE;
        Mon, 26 Jun 2023 20:02:42 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs changes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626125145.1865163-1-dlemoal@kernel.org>
References: <20230626125145.1865163-1-dlemoal@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626125145.1865163-1-dlemoal@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.5-rc1
X-PR-Tracked-Commit-Id: 8812387d056957355ef1d026cd38bed3830649db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e940efa936be65866db9ce20798b13fdc6b3891a
Message-Id: <168780976219.7651.14984523357729858520.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 20:02:42 +0000
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 21:51:45 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e940efa936be65866db9ce20798b13fdc6b3891a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
