Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1151B586E75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Aug 2022 18:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiHAQSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Aug 2022 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiHAQSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:18:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215837F85
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 09:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCECB8159E
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 Aug 2022 16:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43D3DC433D6;
        Mon,  1 Aug 2022 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659370692;
        bh=++rbtA9vRXkQWU1ZBolPZY9bGypyQz8q7NtRR8r1EzQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t2kXwrxac6rPht2f39w48KNzTIsX9RmDeG4uZeuZxg+1L97L6dGu2iNSGbhXml39Y
         //An70LQmBGj4OmoE+rftqCnHC3ew4H/GTzgPzeH2KAzd1vGUkh5Vl/c0UvJTDTj4k
         wNhC/mMzRcNgYaBEq34+EV+f32g+xx/0xuSTDkrxjJB0A5LZOLKMsYAbuYhL+aDQh1
         nocwpv3l1GZUClCBOPTIMFPs/ah0Lq/97q3PmPOy7+61R6YLqu0eOoiHaPTrIcHUeC
         engBYJUQfWYpGW+a1W+FNiPhLbf9TXopvsFWBURf7neY8T1s1C73WChb/cH801reGx
         1QCg3C+e5M0ow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32316C43142;
        Mon,  1 Aug 2022 16:18:12 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220728131359.ssr6tzw7crt2ovfx@quack3>
References: <20220728131359.ssr6tzw7crt2ovfx@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220728131359.ssr6tzw7crt2ovfx@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.20-rc1
X-PR-Tracked-Commit-Id: feee1ce45a5666bbdb08c5bb2f5f394047b1915b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bec14d79f73e7bc2530e73b7c7ee0484029ea0ea
Message-Id: <165937069220.17475.6182527843105889327.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Aug 2022 16:18:12 +0000
To:     Jan Kara <jack@suse.cz>
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

The pull request you sent on Thu, 28 Jul 2022 15:13:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.20-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bec14d79f73e7bc2530e73b7c7ee0484029ea0ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
