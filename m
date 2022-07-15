Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE85B57664C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jul 2022 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbiGORpp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jul 2022 13:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGORpi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C552F03C;
        Fri, 15 Jul 2022 10:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61E2F622D1;
        Fri, 15 Jul 2022 17:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD267C34115;
        Fri, 15 Jul 2022 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657907131;
        bh=KJQOJTp+Kxim88Hnx7j8ddoffMfuoqC3OegnwpkWNto=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CYyATvpog3APfS3S59CFbkpTo2N4dErEZryq5LDg2TnSZiD4LGtqSFVtlWvGq63gZ
         CH5fJ4LNd48bW/CsHp0Pkz8tUoPEM6mU0YUQXBTiHgjBG9sXlyTgmwfU2tLm00YNN5
         Rmwm0LSEUkzR3yqasQJC7+q0A35A5w3ic0OcF4fV3+vSyD6nxA8rrHwz/GxNlxLNwG
         zq8f2X6aVQ/d0zjYRwY9l8wcWe3XjMqd0HNp4XYx06wjj5S7qUbbRNNzl0/y/1Yszk
         R6bpZgvTOGSO4Gy4tCHQd/7+mC1qvnXRtPiCZUteoAiCgzyvCtoLFSwUwINlbK7h9B
         ga6oMyabb4h2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AAA45E4521F;
        Fri, 15 Jul 2022 17:45:31 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl fixes for v5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtB+YayGeq/KgOqK@bombadil.infradead.org>
References: <YtB+YayGeq/KgOqK@bombadil.infradead.org>
X-PR-Tracked-List-Id: <patches.lists.linux.dev>
X-PR-Tracked-Message-Id: <YtB+YayGeq/KgOqK@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-fixes-5.19-rc7
X-PR-Tracked-Commit-Id: 43b5240ca6b33108998810593248186b1e3ae34a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 862161e8af0db1b725c6ad5fd93aa636125f3db5
Message-Id: <165790713169.27298.18329462527509038102.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jul 2022 17:45:31 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        keescook@chromium.org, songmuchun@bytedance.com,
        yzaikin@google.com, mhocko@suse.com, mgorman@techsingularity.net,
        Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        kuba@kernel.org, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 14 Jul 2022 13:36:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-fixes-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/862161e8af0db1b725c6ad5fd93aa636125f3db5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
