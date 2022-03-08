Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7D4D1F90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 19:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348787AbiCHSBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 13:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbiCHSBE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:01:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA684ECC2;
        Tue,  8 Mar 2022 10:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73838B81BEB;
        Tue,  8 Mar 2022 18:00:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17CDBC340EB;
        Tue,  8 Mar 2022 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646762405;
        bh=G6cJ/vicz5Yx6o35RjZqIgi4Jqdo7o5dfXmOlvlVWNQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gzu2ha5n2IB21UlU3TQ1bPqN85kIrV11n1IDe6Ul87Vs/Chz+KIe5fSjeLabhMfkh
         F/lQTQQ+Xu8wkTd3pnNTpiM3nFFhQBtRh3kIdORtQeTz5EGR4ni+dam6IcnNDHHwWn
         bhDgZk3k74Ok57dcMimxjpIaevym+06ASUQ1PSwPBx4KSm6iHxvVKLFCDkOW27rGf2
         KgYMoIJheHjO5zwd1U9gFb7MQLRnDilK+EgcLNsm2W39DnSzeeWtg6hQxEM/0c8/eh
         FdmmCch/lLte9ztvJYj6vLegQXdisBIwquTzL65nm0FSgni+lVdGf6SUQMiruY5uwL
         z8wZTmMiCllAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0D69E7BB08;
        Tue,  8 Mar 2022 18:00:04 +0000 (UTC)
Subject: Re: [GIT PULL] fuse fixes for 5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yidt3VEGFzuZwe1g@miu.piliscsaba.redhat.com>
References: <Yidt3VEGFzuZwe1g@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yidt3VEGFzuZwe1g@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8
X-PR-Tracked-Commit-Id: 0c4bcfdecb1ac0967619ee7ff44871d93c08c909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
Message-Id: <164676240493.31262.15313271983493699725.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Mar 2022 18:00:04 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 8 Mar 2022 15:53:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
