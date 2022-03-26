Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BE34E7E4E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 02:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiCZBBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 21:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiCZBBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 21:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7B549911
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 17:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE8D618C2
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Mar 2022 00:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1234C340F0;
        Sat, 26 Mar 2022 00:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648256375;
        bh=9FIa8LFxMZfkIR1+5TZydRkaPAOQnLvp27MiJT1i2So=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zx89imZoUnePk5lw/o273Hy0Rsipbqa0ygFC1uhlFynrjBx0gFyWtpwUNz6cyOEGV
         5kwBm74hpVFVoSiV8M5uzwJJsl3B/gRb39+HpawdAHO0O60CUJHT9SLGAq3ozMtA6e
         cuCxwdUnddq67hwCjXv8K4TVj4de04RI5WGT53MkWQDJZdV5CQp3oI2GIAIUyOIGng
         aYQaju9BnoZ+92aud7W673C//YTEilDM0DWZhFh06d/FH+HrA5E4EE1gYKmkKnP6VA
         ko1/W8fw9srcJ0zLrJ/gOvHH27ravyxrZYOoRGYHxPloVym2Zi0QT0kRP3dt4pWjQC
         nULLjQOa9Y6hQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDBF3E6BBCA;
        Sat, 26 Mar 2022 00:59:35 +0000 (UTC)
Subject: Re: [GIT PULL] Reiserfs, udf, ext2 fixes and cleanups for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
References: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.18-rc1
X-PR-Tracked-Commit-Id: 31e9dc49c2c03c3f166248f16dbe1248ffb5c6a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a452c4eb404df8a7f2a79a37ac77b90b6db1a2c9
Message-Id: <164825637583.25400.8730458223954692071.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 00:59:35 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 16:37:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a452c4eb404df8a7f2a79a37ac77b90b6db1a2c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
