Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B936FE714
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 May 2023 00:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbjEJWNV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 May 2023 18:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236613AbjEJWNQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 May 2023 18:13:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71C87AB7
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 15:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68EF2636F0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 May 2023 22:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D11F1C433EF;
        Wed, 10 May 2023 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683756777;
        bh=Z3YJ4toZl7k85fIMfqS9gWHnWXIsyIQHYPD6/3t2AYI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=amBY0spd5NkKKXn5N/Obe5hXASJ/uwofsIhV54aNWVBl8FqwznWO44YALcXKSW+Ml
         i6+zA5SyeFR9qZLyD9lN5G1NXZxQ9z2zeXKqXgdzTLcZI/rJlb6zX7pVE0sXvNL+sF
         JT7dRf0Xpg4B2YxI9UKnY3pTzExZywRzeB+WnL9CEdXPl9YMHkoUZzOXas8Odf3IDv
         BdCLeQCUkbSrrgREgLy6sgVSJybMom3m60xw7KRAO3Xg0hSxiKIuxiu83MmK48U2zq
         r1D2keW6xi+v1Man+1x4H7wnmxylGUw3X0sa7VuAV6WjSJQu4jL6nmT0tyJuLih+zC
         2DMRM80yAPKTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF8B7E26D21;
        Wed, 10 May 2023 22:12:57 +0000 (UTC)
Subject: Re: [GIT PULL] inotify fix for 6.4-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230510220642.4srw4ajhpbjzd7t7@quack3>
References: <20230510220642.4srw4ajhpbjzd7t7@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230510220642.4srw4ajhpbjzd7t7@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.4-rc2
X-PR-Tracked-Commit-Id: c915d8f5918bea7c3962b09b8884ca128bfd9b0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d295b66a7b66ed504a827b58876ad9ea48c0f4a8
Message-Id: <168375677778.24436.1165849762990511717.pr-tracker-bot@kernel.org>
Date:   Wed, 10 May 2023 22:12:57 +0000
To:     Jan Kara <jack@suse.cz>
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

The pull request you sent on Thu, 11 May 2023 00:06:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.4-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d295b66a7b66ed504a827b58876ad9ea48c0f4a8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
