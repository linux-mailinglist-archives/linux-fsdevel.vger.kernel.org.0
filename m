Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4C67F0BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 22:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjA0V6k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 16:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjA0V6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:58:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F9C7E6B6;
        Fri, 27 Jan 2023 13:58:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A859B82147;
        Fri, 27 Jan 2023 21:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28619C4339B;
        Fri, 27 Jan 2023 21:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674856713;
        bh=8Uxndj7RnVDXwjueHKfFc6HT4KL9eGRLAXZTB6iDkg4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BPOs006JoskKqTxiq2JvziIn6UIPKBwYmCc5aeaiqQChDul7UA1xn/RK2DcSvT8VA
         RPB/1HwjyMsXNv7QzuzmGA5sPV0295Fk21hPAgAFOLW8/rX37e+8yHxbokcnFyY7pS
         mwBQhJotrcMIsxr0US0wmoYcSsO6Zroos2/Yb2PNckPuli2hirJVujK0T7YjLBwY/C
         ktoA0tYE4RPXNtwMkCuNcohkFvzmP8dXavr8Wn1tPcJmpH0KFNRBGqL4Fh4R6m3O33
         aYUYtk4JxoCZzWg+VdmkNFNwEXagys+1GErF4Pzt45L4JdHRcOMs1XTAbFutNwdK6a
         wlNcZ3rP8FTlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 159EEE52504;
        Fri, 27 Jan 2023 21:58:33 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJfpeguv6BpewqDjDLqQv2yaR+nPLmmAp++JWNquWpXt7eiepQ@mail.gmail.com>
References: <CAJfpeguv6BpewqDjDLqQv2yaR+nPLmmAp++JWNquWpXt7eiepQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJfpeguv6BpewqDjDLqQv2yaR+nPLmmAp++JWNquWpXt7eiepQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-6.2-rc6
X-PR-Tracked-Commit-Id: 4f11ada10d0ad3fd53e2bd67806351de63a4f9c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0acffb235fbf57f11a3da1098f9134825ac7c1c9
Message-Id: <167485671308.1722.4998992203009274552.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:58:33 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 16:26:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0acffb235fbf57f11a3da1098f9134825ac7c1c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
