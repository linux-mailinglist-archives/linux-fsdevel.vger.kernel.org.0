Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9070E6D0B8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjC3Qps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjC3Qpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:45:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67336CC38
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:45:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041FF61E46
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 16:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E19AC433D2;
        Thu, 30 Mar 2023 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680194745;
        bh=kvDXRywEAc1KQKoSazNsVsl4Ac1Qq9iTcGxeR+506NI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UxmGWOfpY1+dl6jgDedfnVLKnsqqkWl2SobfVNCsVA9VHqGyIJn+hd3837XHjO8sX
         Tr9SmsFnj10h7eOqqgOF5RNQuXSLypHj1G80gx0NxaDeYCxs3OhuQYDoHbxNzADssU
         A9rUAh4fAj6iE+tVTLCSvypK/EGLGVwlb4bb3S6TNxGKqwNnLwU+P2oJqELoS8egvN
         kijW/U4POFyogBeesMDAb07kc8+KB4E5Sxn1+r7PtPcrbMDkJi7/yU3Bor71sLqmsS
         TYeYXOztlgSobXYtwm6l3at0gtq46fqPHXoDswFbGRSv1CQRmfoKygN7gRg+5jGJu6
         p76XY/U6KAS4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BF5AC41612;
        Thu, 30 Mar 2023 16:45:45 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230330122200.2663128-1-damien.lemoal@opensource.wdc.com>
References: <20230330122200.2663128-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230330122200.2663128-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc5
X-PR-Tracked-Commit-Id: 77af13ba3c7f91d91c377c7e2d122849bbc17128
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ee772243af1a6f5955413a64c5b36e8daed49bb
Message-Id: <168019474536.8090.16465117848432426273.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Mar 2023 16:45:45 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 30 Mar 2023 21:22:00 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ee772243af1a6f5955413a64c5b36e8daed49bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
