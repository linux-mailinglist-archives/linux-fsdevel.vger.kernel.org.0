Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B95638F9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 19:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiKYSWq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 13:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiKYSWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:22:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258C0A1AB;
        Fri, 25 Nov 2022 10:22:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B818D60A51;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D325C433D6;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669400562;
        bh=SykwYyrEQBZTDG+JIz7hik3pLnp3z/woSG8wtLMGapU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YvVD3rUkFMfCnT8AbQJhUmIM6hHznXZdXX1J2n1j1Siuab+Rc/qR14DghUbOxLBPI
         ErMq/6UdUgCk4MTWYUnIndiSY+C/s95KY5GLvYypZAentlbv3uSYb2k/8/VZlYqXIg
         JRjPJqUu9dfbdFepJpMG+Iuiwt5yeezAna0mHGyqG+mxsVrphcj6Eb1HnRUCbfW/zB
         nyMfAeAb5hIIQ7Wkm6WqQcNmSyGMlv4AlOd28gVMazgiEJPb5hgdjNYqrH+xFdgQvx
         k+5rYzc/a/1jHRrg4EtceWoHLA1UHFM2bpHz9p2sqEfzAxtmGPL79iayCXFue7WEQX
         Zx5uPfjxjS2NQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A628E29F3C;
        Fri, 25 Nov 2022 18:22:42 +0000 (UTC)
Subject: Re: [git pull] (vfs.git) a couple of fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y4A79tAvPFcC3Hu7@ZenIV>
References: <Y4A79tAvPFcC3Hu7@ZenIV>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y4A79tAvPFcC3Hu7@ZenIV>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes
X-PR-Tracked-Commit-Id: 406c706c7b7f1730aa787e914817b8d16b1e99f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b308570957332422032e34b0abb9233790344e2b
Message-Id: <166940056210.17840.1985749726714637794.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Nov 2022 18:22:42 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
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

The pull request you sent on Fri, 25 Nov 2022 03:52:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b308570957332422032e34b0abb9233790344e2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
