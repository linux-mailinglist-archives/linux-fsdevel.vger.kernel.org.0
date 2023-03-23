Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579A6C7010
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 19:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCWSPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 14:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCWSPg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:15:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3464430EA
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 11:15:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C321762806
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 18:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30129C433D2;
        Thu, 23 Mar 2023 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679595333;
        bh=jOEGADeEIKqqI39if9RwXDYnSsczMaARPaRZSkKiHpg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vHegQC1fukuS5aLNiG7F7/vCRoquRizNf84kUpc3+55HHyhB/2XvuHlIA6VIANgR1
         Kbh6TOiDynPlHaLD/RhVgTonNwKERRp/v4IPPowDyEOYQlu98c0RVz/x/3cCf4SShO
         ajm296cDVYihvjfKO7TolQJYer2k6lKK+HGbRmkrnYELwblFsKTc9trnO5RsGIkng8
         F5mEmSUd8nPanrKgt15xUwrISLp33DJVunkgNQKq+qsHqJj5+I8SzqxlNoG6fUuD2A
         +7dD0NIMG0136Qoj/YGJ40PsXySoHkdkmLWGKbOPj9rsOQlQjdrklrW7Bwnm8mdyzV
         sEnJY42WaS0NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D9AAE21ED4;
        Thu, 23 Mar 2023 18:15:33 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 6.3-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230323103530.365717-1-damien.lemoal@opensource.wdc.com>
References: <20230323103530.365717-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230323103530.365717-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc4
X-PR-Tracked-Commit-Id: 88b170088ad2c3e27086fe35769aa49f8a512564
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fd6ba5420ba2b637d1ecc6de8613ec8b9c87e5a
Message-Id: <167959533310.31611.3540131458984758190.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Mar 2023 18:15:33 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 23 Mar 2023 19:35:30 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-6.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fd6ba5420ba2b637d1ecc6de8613ec8b9c87e5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
