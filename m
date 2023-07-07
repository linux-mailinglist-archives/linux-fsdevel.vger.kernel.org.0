Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47B674A903
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbjGGC2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 22:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjGGC1v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B219B7;
        Thu,  6 Jul 2023 19:27:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FABC61522;
        Fri,  7 Jul 2023 02:27:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D31AEC433C8;
        Fri,  7 Jul 2023 02:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688696867;
        bh=qMUlhjYADyjsJ5HsQ9m6IIC70XkxDK1QorQY+1BhkxM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N92AWJcaJ8F9VkIuTmyzkZqtre+l4xig1gY2hu1plZ5sQq5tGQ7FcYgZW5hXulBiA
         jSn3OCd6g9rL6YGoCxIDzX4LHqXW16q844bQkdVlNf27IAWgHPoMJCXWQK39JEJ1n4
         JLid1ZpiVMvMmyqFDM83cfMjCb8fVBv8eVGuUcf21LeKSkYneNYx9AFfTq8n0vtN9X
         jsHk8J18tIZPt4oee3evwiD834N+t9+2DyDy7oWqKvFzSHltiwwfvLqrathzZSZQKs
         Ztx5TFgJUC0F8o6WNEbV8SziiwnQKnQ0DL1DKlGuZgv7Yy8KwiGmp7E1WiRIADzuyI
         v8EZjPUp1uV1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7CCFE53801;
        Fri,  7 Jul 2023 02:27:47 +0000 (UTC)
Subject: Re: [GIT PULL] vfs fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230706-anlehnen-fichtenwald-1b7c46c068f6@brauner>
References: <20230706-anlehnen-fichtenwald-1b7c46c068f6@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230706-anlehnen-fichtenwald-1b7c46c068f6@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.fixes.2
X-PR-Tracked-Commit-Id: 33ab231f83cc12d0157711bbf84e180c3be7d7bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fdeb23f32d6843c34ad1a4200d04069ff339906
Message-Id: <168869686774.32373.12529589172751170796.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 02:27:47 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu,  6 Jul 2023 13:52:59 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.5/vfs.fixes.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fdeb23f32d6843c34ad1a4200d04069ff339906

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
