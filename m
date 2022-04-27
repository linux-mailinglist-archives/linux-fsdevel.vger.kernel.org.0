Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA7511FC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbiD0Rid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244118AbiD0Rid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:38:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B462F02E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 10:35:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E93761E52
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 17:35:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B025EC385A7;
        Wed, 27 Apr 2022 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651080920;
        bh=Z3Qt13OqWwrjMnLDnN1kVKH4H61rsXv7oPKxHdiAVp4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pqNmjATakp0pT1bRhf0Xc0szqwhrrSCOYbNGl/1Q2G8XwA05vVivoE9yfccS2g2M4
         R1wNOatRtVHkDSSCz5gUJgX/M016qbQp3fLKOFuLW61uAVLvUPf3WF90Bykk0EUuuS
         GqkBc97VGgdTLp1w/BReyyEXoBlOMwQg18P6MzrUgHP2OcMjM1c+yA+rB7M1s4o7ZQ
         zMyCzXShux27x8CTLITA9OR848r0KNcuCZzML7uLo+q7C9gY9bTBVIJnxyL34iccB4
         Iz0JWpVwxxE/zHlgDdpmWr5m7jRYLvFJQqoJiN+A0e/vetw1zltwvw8QeYtd1gq8IH
         eonIjrMzEImdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B8CCE8DD67;
        Wed, 27 Apr 2022 17:35:20 +0000 (UTC)
Subject: Re: [GIT PULL] zonefs fixes for 5.18-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220427052107.9812-1-damien.lemoal@opensource.wdc.com>
References: <20220427052107.9812-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220427052107.9812-1-damien.lemoal@opensource.wdc.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.18-rc5
X-PR-Tracked-Commit-Id: 1da18a296f5ba4f99429e62a7cf4fdbefa598902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 211ed5480aff457ac1a9e333e68522ef4a0c6ce9
Message-Id: <165108092061.1271.17628730855687142510.pr-tracker-bot@kernel.org>
Date:   Wed, 27 Apr 2022 17:35:20 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 27 Apr 2022 14:21:07 +0900:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs tags/zonefs-5.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/211ed5480aff457ac1a9e333e68522ef4a0c6ce9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
