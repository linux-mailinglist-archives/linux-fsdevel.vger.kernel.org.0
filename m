Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7519664AEDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiLMFA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiLMFAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:00:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA91DDFF;
        Mon, 12 Dec 2022 21:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8E1C6131A;
        Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 504FFC433F1;
        Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670907612;
        bh=Q3TKICMZ3zdGvsbD5KRqQh5YbxsD/33zheSKFrxFXhg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uUTXdlDsoq6oRcJn4eAQxW8FwjeCttblcpLe4jpE0+atbhQcJVHUKEjnpgVW3A+hT
         JFmOZ26+vHuDC72kAlrMOjHOzre6GY2fzzdx/+aaZp7rgJh1zdBHabDjeD4U12qLWA
         jHgcTDDBUItAKJagdONk6ajt5Ld3jkH2PoqDcna9ElCRCrUygLo9YOYrS++D0lQxwu
         mIdAZg40fZVXdDWrfkxUQXaWPP0QywvZmN0age2ZRwi6ErsqzCZ+KhP/2dO6yikS94
         TgjDXBs2PYQOQjP7/IZ25ozkFIYhsVfjwHefxNl8xNgMUc5XG28DZN6cxFxSmdRzk4
         g2GOHb/IxaEtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36525C00445;
        Tue, 13 Dec 2022 05:00:12 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5cMNDpL5digt1rJ@miu.piliscsaba.redhat.com>
References: <Y5cMNDpL5digt1rJ@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5cMNDpL5digt1rJ@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.2
X-PR-Tracked-Commit-Id: b138777786f780b9d5ce1989032608acbede0493
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 043930b1c8895d626d340decfe9e418f7233edb8
Message-Id: <167090761221.4886.2265528479278779838.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 05:00:12 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 12:10:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/043930b1c8895d626d340decfe9e418f7233edb8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
