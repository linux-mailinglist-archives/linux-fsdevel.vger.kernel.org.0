Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8B562143
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 19:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiF3R2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 13:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiF3R2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818F9205EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 10:28:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39F11B82CD1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 17:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 019D2C34115;
        Thu, 30 Jun 2022 17:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656610117;
        bh=yMLLPxntlZItKr6ltRCOTpux/KrzKHhncxfVgb765J8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BNbx0R1SAAxQTjH/A/16pzlN649eO7Z1M02fb1plbmiWm95gNoGuwHNaqPIIRpFxu
         4xBYZPhOfb4ru102YIzKUQivwxIqikVNtbeuOaEuj/yt6i1Dblff2XoNVo6Cg4+grk
         FApjPyDBfS9I/dEoaVKU6m/S1Jht5yazxYFlx7KqTlLkPxDgH/Wv5Co5x05E6LSaxC
         lHVZlOvwLPXQqOXBK0HM7PPXz3JVbYZf3N7sF96YT6mGj4x2SCK/31mZJLEynMBwji
         VDf29jCIy2tcZ2ANQ/C2p/MQsMCNymyu4GlSErEVbkBG1sqmufcy2JOnZU0kIEQZQE
         GrS2KTakFY2DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1027E49BBB;
        Thu, 30 Jun 2022 17:28:36 +0000 (UTC)
Subject: Re: [GIT PULL] Fanotify fixup for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220630092341.qseqfhjgcndaupns@quack3.lan>
References: <20220630092341.qseqfhjgcndaupns@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220630092341.qseqfhjgcndaupns@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.19-rc5
X-PR-Tracked-Commit-Id: 8698e3bab4dd7968666e84e111d0bfd17c040e77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fb3bb25d15326464e2183a5eb4b1ea8725d560c
Message-Id: <165661011691.6493.13772523619017011009.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Jun 2022 17:28:36 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 30 Jun 2022 11:23:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fb3bb25d15326464e2183a5eb4b1ea8725d560c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
