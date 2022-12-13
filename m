Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4064AEDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiLMFAZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiLMFAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BCD1DDED;
        Mon, 12 Dec 2022 21:00:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974A76131C;
        Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEE16C433F2;
        Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907612;
        bh=7zq2bCbwCQ3XKh+Pnjz1CRm7o9yMqmUU7OIVHQ02muA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jAk0I6A5kIlMi6VscLGa4kVcpCiEiBTUMEVlxxDqRVfYEaD1j5Bek8tu0y42Bj6TS
         pBSjI0vu1t5/69aFQg0JOT8a1hGnhM2FiGLpkxxWaJItsaFHK0WO//dk2chj94cypl
         wh/bEIs+hX1lw3FKZc3zSOb2plJEIveF5Gjc0L/4yROpPTSjKi5K2ftCrPqDOB6wYy
         U7vk0tToAGMUM4FGMfDVFM+Y5eJkc2XcKNsrfSBKBhB5GEAUYEVHjn8QKRk+dMNXRi
         deaC3nCZWgg3XPROtnddYPsJf55AX0ztCt+7PKgKk35jJHht67kJttcP/7/rmAqZDa
         TNekUi+WUpHgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9A0BC00445;
        Tue, 13 Dec 2022 05:00:11 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs update for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5cIxrmoeQSCJMlQ@miu.piliscsaba.redhat.com>
References: <Y5cIxrmoeQSCJMlQ@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5cIxrmoeQSCJMlQ@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-6.2
X-PR-Tracked-Commit-Id: 637d13b57d853dfc7f5743dfdfb9995c266a6031
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6df7cc2268745e91d090830c58689aa7fcbde6f9
Message-Id: <167090761188.4886.7827565826597583123.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:11 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 11:56:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6df7cc2268745e91d090830c58689aa7fcbde6f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
