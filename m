Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCBC534924
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 04:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346522AbiEZC7k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 May 2022 22:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbiEZC7h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 May 2022 22:59:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF33BDA1C
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 May 2022 19:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B5B4B81E6C
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 May 2022 02:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F6AEC34117;
        Thu, 26 May 2022 02:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653533974;
        bh=x9p2cL741kqiCLgldDqO+qjVZ0ZzlgkL6Adq3pkk6UU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KTT3M6ZqJpcHZg5mVU2QwUhZxPiK0l7k2rU78pqLXp2hmvqwn3q2CWGne++M999kv
         NuooC4R/nZFs6+6quxiSceShm2Zkyrx1frDkZS49LAjMQTnrWm/4aCWgd2J3U9taYu
         Pi1J69T6hMtrdx7U9spJyUP5E/btMYjpqswPOtdh+vX5CG0xEdKFifF1+RMj0eyv2+
         8kO3qnKjDsLQcTEL8tP2saqepSALkCHVA3NbnMdx6e7RuHY8V/UNxDZPVG7Ab9J9/w
         Ybtb/jx3Ooi1wavSeGW97lRV7wD+7cocuaWCBI/XTN7NsHI8WaAlt/q1a8yqErHsEP
         rd0uwTlDgTfwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A43EEAC081;
        Thu, 26 May 2022 02:59:34 +0000 (UTC)
Subject: Re: [GIT PULL] Fsnotify changes for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220525123350.nogcycin4qjnk5jp@quack3.lan>
References: <20220525123350.nogcycin4qjnk5jp@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220525123350.nogcycin4qjnk5jp@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.19-rc1
X-PR-Tracked-Commit-Id: dccd855771b37820b6d976a99729c88259549f85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e375780b631a5fc2a61a3b4fa12429255361a31e
Message-Id: <165353397410.29187.850700464736170261.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 02:59:34 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 14:33:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e375780b631a5fc2a61a3b4fa12429255361a31e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
