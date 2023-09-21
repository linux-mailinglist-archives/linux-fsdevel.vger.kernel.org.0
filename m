Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5DA7AA2CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjIUVe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 17:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjIUV0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:26:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F213E91;
        Thu, 21 Sep 2023 13:10:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B033C433C7;
        Thu, 21 Sep 2023 20:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695327013;
        bh=4KsdMLJ+HnHIRllOr9G3nDUGU4RoWhf/tTMOwfIhB1g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=owpcn4EzSFAT4ve+gOvv+2LMlzBObTt9Diy3pAM9e1NyETzxUiGe6qvvDVx0L8PSB
         ixxd2Tlinlok/djrJSoZBun7/1/vsZHxTb2fEpzjRzWVEBqWXRytZCwlrHQywWNEzf
         R/qykz2eGMQbhqgi+zNYI8t1Ka8yinbJdC8Ok+bFam6/ki220eBUoTFYCJZcaaLcmY
         grxuCw7DC0kKsVu8mVvUvoZgS+aOLk6qKV1Lc4gfFpmd4RFmhae2si/kiJgchzT4aO
         6ZRW2vqULiW6GMXw/Pecq+bbMhsitsCvBtPF4B7M5lNjc/XxJ4ClVHJzuAOSK2CC2Z
         srXciMGs7JPnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF506C595C0;
        Thu, 21 Sep 2023 20:10:12 +0000 (UTC)
Subject: Re: [GIT PULL v2] timestamp fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc3.vfs.ctime.revert
X-PR-Tracked-Commit-Id: 647aa768281f38cb1002edb3a1f673c3d66a8d81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5cbe7c00aa0f7a81ec40c007f81a3e9c84581e3
Message-Id: <169532701290.19794.13116070756213364040.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 20:10:12 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 21 Sep 2023 13:20:46 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/v6.6-rc3.vfs.ctime.revert

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5cbe7c00aa0f7a81ec40c007f81a3e9c84581e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
