Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D49591D4E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 02:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240109AbiHNAj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 20:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiHNAj5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:39:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF977755B;
        Sat, 13 Aug 2022 17:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 163EFCE092D;
        Sun, 14 Aug 2022 00:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 634E4C433D6;
        Sun, 14 Aug 2022 00:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660437593;
        bh=oUWB27MLokU9Or2RcR9TejfQIeQxTNbHsDBHyonA3sM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t3qt2N+a9vT7ZTLgxIeQOS6CLEUGXsI61MFn+YlBx9wH6wq5OXOxcyoJoTnCqGjxY
         pJWJcE/BfATAhVYpLGHXavebGYPvuwcsXEVvt0ROUVMdidWZX0+E31Kj0C1dIX8EdX
         4RF7viVNaqG15LF7Ojs7763/Oig45Ibk3XWih3n4iDzcgA14D8GQmQ3DFrFhp6DSmU
         rx0GRKhGNkeE4w1TQsn2yGiWuzrvYjb0sZO7XDhpbQ1TpuuxhNinFfebqF4DPjcK0p
         R0xzXF/TSfwQ1sQltTvf7cRVIXWw8vNkTRGjjKJGgT94xB25BVgW0wq++R4I7g/QLa
         +LLJ17xL4Q7iA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 501E9C43141;
        Sun, 14 Aug 2022 00:39:53 +0000 (UTC)
Subject: Re: [git pull] vfs.git #work.misc
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvhAZYm1T4ni+y01@ZenIV>
References: <YvhAZYm1T4ni+y01@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YvhAZYm1T4ni+y01@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.misc
X-PR-Tracked-Commit-Id: ed5fce76b5ea40c87b44cafbe4f3222da8ec981a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aea23e7c464bfdec04b52cf61edb62030e9e0d0a
Message-Id: <166043759332.507.6122345660806763126.pr-tracker-bot@kernel.org>
Date:   Sun, 14 Aug 2022 00:39:53 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 14 Aug 2022 01:23:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aea23e7c464bfdec04b52cf61edb62030e9e0d0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
