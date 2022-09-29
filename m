Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1935EFF5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiI2VtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 17:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiI2VtI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:49:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F494598C;
        Thu, 29 Sep 2022 14:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F5DD6213E;
        Thu, 29 Sep 2022 21:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E11B1C433D6;
        Thu, 29 Sep 2022 21:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664488146;
        bh=xWBf8UgiyJeaTrwnpZzf/vgdvG7OXLLm89haOnqx8xU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SwwmpBubRKIh3Nw83O1o8bqUnQpxufN/SQGrYVK+OzywRq89tesRAahxocEyxYrVz
         iWB17QeHYil+ZBy6j+ZBMSEa6oYZ+1sg48j402j0F3L8zIrWAIrNaJkHa7iLpj1zzF
         3oFbB9i9BuJ+5QyzPJrA7djY43kR79whxwxPzbqTrRClPfrm/FFhdEiI0B+j3ALoWy
         6PhJtGr6lZQWfshJjU8QsN4dozMUJrZAFi0284vVfQaY/rXeG0X3gHGfU5Zu7VHRWu
         MNikJTHqCbqXZ8yKoxU4jLXQp6TSvOm8xgdTwm6JR0GxQeWy1BWPZMU3M8hQJ8cIiv
         12n3gbMbHzPGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C72B5C395DA;
        Thu, 29 Sep 2022 21:49:06 +0000 (UTC)
Subject: Re: [git pull] coredump fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzXpLm049wRqYIN6@ZenIV>
References: <YzXpLm049wRqYIN6@ZenIV>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzXpLm049wRqYIN6@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 06bbaa6dc53cb72040db952053432541acb9adc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 987a926c1d8a40e4256953b04771fbdb63bc7938
Message-Id: <166448814680.23284.10173596572310170780.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Sep 2022 21:49:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 29 Sep 2022 19:51:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/987a926c1d8a40e4256953b04771fbdb63bc7938

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
