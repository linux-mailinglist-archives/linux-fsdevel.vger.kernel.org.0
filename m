Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ADC64AEE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiLMFA4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234313AbiLMFA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833A1DF07;
        Mon, 12 Dec 2022 21:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8613C61316;
        Tue, 13 Dec 2022 05:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB1EFC433EF;
        Tue, 13 Dec 2022 05:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907623;
        bh=945PP3QzEP1Zy/JShvCFiSHHixuAv3EUjx1FowEBAUM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RBZfWL18xdfZYgDROqrJpY2ACeMBl4GLdSrmyURUoAQJWCWQW9LCWVdNJzjBv4+oF
         s1XE+aCakyH/0bsMoIT1lwim/y8JnexNVdHVC8PAEv/BXZPItT6SLYqPNLLHswt/4M
         PfbUFVcvrqaYu1BjtSP98sUkmIUAlQ8vjaeIKnZFWeMshgX2tYx2IwBDsfzHoTczQQ
         8yzO+4z48WFA4RGkutoMu7VX7izGqJ0aJkwwXViKZ8lZRCiPThGDF5hA3ME5A1M5My
         1ma+Hg0YD5oKTNrr16wF6h18yEVyYNrMbw8Fawq1Lgw3DCosBzid8c/7yK9BhoMllP
         o1Xw3+YnSD8yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA4FFC00445;
        Tue, 13 Dec 2022 05:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] udf and ext2 fixes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212170402.w4mqtu4a65kphtju@quack3>
References: <20221212170402.w4mqtu4a65kphtju@quack3>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212170402.w4mqtu4a65kphtju@quack3>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.2-rc1
X-PR-Tracked-Commit-Id: 1f3868f06855c97a4954c99b36f3fc9eb8f60326
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cda6a60acc95cba93e9c17352ed485555adc661f
Message-Id: <167090762288.4886.15154123032214940421.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:22 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 18:04:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fixes_for_v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cda6a60acc95cba93e9c17352ed485555adc661f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
