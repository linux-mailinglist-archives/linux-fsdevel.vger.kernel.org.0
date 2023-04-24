Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156F66ED6E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 23:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjDXVqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 17:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbjDXVpp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4537C7AA3;
        Mon, 24 Apr 2023 14:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B039762964;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2115FC433A4;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682372740;
        bh=/w1AYK80QM0oZvVpiF7pwQ53GbheRCtxznZnBBJpkR4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DtVRLL9021L2Pl/j5VKVXMUHnZbu+9Op7v5VpDqb149xeQYfWt4MZbzBuUM1zp3wp
         nWkjyQWDA0xB/AMa/mpZuAUqOKZiQkJKw/d23LGoI062hjfl7RpG2VD1rHazhQpbW+
         FpirfG5jKD9wSHZizkqYED/rCBrFJTFVEnhZJ8m/2WhnnEDz0mfSJjarzuqa2Ul7bY
         zsldWlFi66GOuFpxmF0OwnbrvqxgoERGGnxCtg5pBWbxdT7cyxn0aBZlYaqCGVCaq+
         UpsiREDlGpSHDQb9u30QtJYbYgRwzVSDf0yK1zSrCUPHtnjjac42JCyu3W2VSwyZDs
         nlcWjJoZaO4Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 106D1E5FFC7;
        Mon, 24 Apr 2023 21:45:40 +0000 (UTC)
Subject: Re: [GIT PULL] open: fix O_DIRECTORY | O_CREAT
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
References: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421-freimachen-handhaben-7c7a5e83ba0c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.open
X-PR-Tracked-Commit-Id: 43b450632676fb60e9faeddff285d9fac94a4f58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97adb49f052e70455c3529509885f8aa3b40c370
Message-Id: <168237274006.2393.7677205091394324612.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 21:45:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 16:02:56 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.4/vfs.open

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97adb49f052e70455c3529509885f8aa3b40c370

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
