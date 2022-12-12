Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1964A5F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiLLRd7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 12:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiLLRdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:33:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4B814088;
        Mon, 12 Dec 2022 09:33:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7514661198;
        Mon, 12 Dec 2022 17:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7F87C433D2;
        Mon, 12 Dec 2022 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670866399;
        bh=dgbOreq2+9ogIExFZGD4+OIZzBTjfO+LyrrdHLkAyYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ta87ayO91/p5HoB/Yt5vNqwqsjvLxFznHs5u3Xm7gmO0MggQuQ6B9vEOzB6kfo/5X
         RahnZjnVXZwmuZAdyrZyV4MkBm5mKMdrkwVM0BxauLUmnW7XW5MfXZnZoDJQOArPGX
         oSyMrQuqB/AgWPANyw8EPLfTndrqLl9xgWSIF0DkjSVLQYzhZCl2GgW3aIsE8cd5Ga
         NA4BR2i10PjXxCnH8EekjfRoYhhOEynuEALKosQ794a48e0H0PgDP039m9s+jLVuhH
         iaAk5p7AFnnLjB35G/yRTmr8hUSR2q98BJMchAoXgTR7+HaLyUrxGdtqyQlrrcPS9U
         8CG7fs7ANQuuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0684C00445;
        Mon, 12 Dec 2022 17:33:19 +0000 (UTC)
Subject: Re: [GIT PULL] file locking changes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d3ba2c7f26958242c0a31b8f966e7c3d251a9e0f.camel@kernel.org>
References: <d3ba2c7f26958242c0a31b8f966e7c3d251a9e0f.camel@kernel.org>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <d3ba2c7f26958242c0a31b8f966e7c3d251a9e0f.camel@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v6.2
X-PR-Tracked-Commit-Id: f2f2494c8aa3cc317572c4674ef256005ebc092b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73fa58dca80293320f5cfeb06f5b2daeb8d97bd5
Message-Id: <167086639978.22610.6556749360002379813.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 17:33:19 +0000
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 06 Dec 2022 08:11:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git tags/locks-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73fa58dca80293320f5cfeb06f5b2daeb8d97bd5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
