Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1C558D030
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 00:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbiHHWhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Aug 2022 18:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244676AbiHHWhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:37:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAE1160;
        Mon,  8 Aug 2022 15:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B575760FF6;
        Mon,  8 Aug 2022 22:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18212C433D6;
        Mon,  8 Aug 2022 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659998225;
        bh=CB3IlzICwwzixr0/fFL5ImJfsUXY/1be1/7c2IWLHgI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FqqLEjZbBLYlaOSnU12r53VkYcuptz7a7dMeXGBkNoNjzm7v9TXft93isis44+nOB
         jBjIvjoW/Ag+YWSAYZaAQKM2SvzKuCJbWPjxO3OyeHy3VRLvmAZlw7EcVYD1CTsZ2S
         S0sU6lHT3ohu2miWuiNfQ3ox5fEBilHbggT2v2N1XLlYz7mF5+w/HXkFGw9SLXBHAx
         hrYFQIAw1piTQ9pRXlLNsej4IiCGkD5OCnkRn8kqJKcMCS9Z+i5AnR9mpdz97iPp3G
         eqkYZRZTdvBkLCk3/OnJ+tulCnmihTmnZ++8wFYdl1SydMZSqPe5Q6M+mhWT5N1cj0
         7nB1mwjhIKlaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06E41C43142;
        Mon,  8 Aug 2022 22:37:05 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YvFAMLmwPoO14KqD@bombadil.infradead.org>
References: <YvFAMLmwPoO14KqD@bombadil.infradead.org>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <YvFAMLmwPoO14KqD@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.0-rc1
X-PR-Tracked-Commit-Id: 374a723c7448bbea22846884ba336ed83b085aab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5af75f77c52c6193fdf34bdb780cb615edadd76
Message-Id: <165999822502.1400.15667125054968885656.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Aug 2022 22:37:05 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        keescook@chromium.org, songmuchun@bytedance.com,
        yzaikin@google.com, bh1scw@gmail.com, geert+renesas@glider.be,
        Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, patches@lists.linux.dev, mcgrof@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 8 Aug 2022 09:56:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5af75f77c52c6193fdf34bdb780cb615edadd76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
