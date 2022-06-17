Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A57F54FCE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 20:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiFQS0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 14:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiFQS0f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73C73150F
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 11:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 509CF61F6B
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 18:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9455C3411C;
        Fri, 17 Jun 2022 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655490393;
        bh=by65PZy70n02sYlHxnIHHEmXE+u9/ee93rUrttMHcnM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A/h+NZQpAEXSEL3B/80tDsFpkFHtAtIYCcUf65jk2u4nGO+wAfeLFu/Mu8en+IFVU
         IiYqIiQMUxDD4yTcMkgLR81kdu+S71/uEFOb4NCguaaTllD8IfDWcL4586zMnMDcO+
         FOsUTadns33JyBmp1kEldz3pvudA9AD7KKi7kSkdE8k02BIhjUMSRRsAUiDjVdbMl7
         DdxTDSJgC+NpV6Bkv1nJr5H8EIHaXMmTD+Aqi5uZYC/28H+NK2aZpVezxjn2LQyfUE
         IbsHm2TqqTcvtNjQLdGEOmC6mkfv6y/3Q4UBegYd4ILhCvEG8G+qg/RalRb1PQxW2S
         0aVYXBpE8OaBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A7D1EE73877;
        Fri, 17 Jun 2022 18:26:33 +0000 (UTC)
Subject: Re: [GIT PULL] writeback and ext2 fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220617101107.r6g2qnvqkhtntox7@quack3.lan>
References: <20220617101107.r6g2qnvqkhtntox7@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220617101107.r6g2qnvqkhtntox7@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc3
X-PR-Tracked-Commit-Id: 4bca7e80b6455772b4bf3f536dcbc19aac424d6a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c0cd3d4a976b906c3953ff0a0595ba37e04aaa6
Message-Id: <165549039368.23060.10349709287595170392.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 18:26:33 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 12:11:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c0cd3d4a976b906c3953ff0a0595ba37e04aaa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
