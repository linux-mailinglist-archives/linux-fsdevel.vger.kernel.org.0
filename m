Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC79878B960
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 22:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjH1UPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjH1UPG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21938EC;
        Mon, 28 Aug 2023 13:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B10356514A;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26AADC433CC;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693253703;
        bh=PuxONe6A7ymNR7IGyEHTcvFYRYxO7U0lJgDMgXK5QBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MccCu2jeJK3imuqppCgWykaIQirf5qdYdamNNP4yMKLElQJjJ53iEVt/lrGDRvJ89
         5lRddgEcVcdqVej3DPYn7UDuRFYWkcj88B0Lhji/mR/3c+9zhMnta56Szw1o4bsrrY
         YUXxR9Ox5pyBT8i1h8vpKj2yA8nKdiIBmJMQErnCckdyPP1ozCugORuBNFPei7Gbmz
         HgKOPzQCsaSjQW9IOwbHeJ+GWHjyVFpvl4fu6eK6YOn0+saJpuCFf7GFQu00gUJBGB
         YoRI1TA41DAI5liiRV2shigfgGtUtA7Y1OK4yDvyUOMB+9zcv+zHsNtAlEbOryh5PT
         yIIpVD07XIhZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1419FC3274C;
        Mon, 28 Aug 2023 20:15:03 +0000 (UTC)
Subject: Re: [GIT PULL] misc updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824-umgerechnet-luftschicht-6dc072d6dbc2@brauner>
References: <20230824-umgerechnet-luftschicht-6dc072d6dbc2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824-umgerechnet-luftschicht-6dc072d6dbc2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.misc
X-PR-Tracked-Commit-Id: e6fa4c728fb671765291cca3a905986612c06b6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de16588a7737b12e63ec646d72b45befb2b1f8f7
Message-Id: <169325370307.5740.2891186284869851500.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 20:15:03 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 16:26:13 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-vfs.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de16588a7737b12e63ec646d72b45befb2b1f8f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
