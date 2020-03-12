Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCA183CEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 00:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgCLXAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 19:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgCLXAD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:00:03 -0400
Subject: Re: [git pull] vfs.git fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584054003;
        bh=/uTogcCZcLOhFB2efWnNs6EflYCyYSyozbWixJ6Zm7M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0NNjc8hWBH0h5O9eq6k11CE0fWPIBXXBOOElks9kfzwRLLuFrtU/x0yFCetXnq/3k
         9soTwT9mFcJcuLLgRPOxLXvcCf0F7+kTSgdxsT9ZGVwodr57jAnxeGnfpncl8xtaZH
         ZOqyyez+Y2BRoy1dhGdZK2RKORoIgOl4I62WCZXs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200312223709.GM23230@ZenIV.linux.org.uk>
References: <20200312223709.GM23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200312223709.GM23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: d9a9f4849fe0c9d560851ab22a85a666cddfdd24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 807f030b44ccbb26a346df6f6438628315d9ad98
Message-Id: <158405400299.2379.17459309436383555997.pr-tracker-bot@kernel.org>
Date:   Thu, 12 Mar 2020 23:00:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 12 Mar 2020 22:37:09 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/807f030b44ccbb26a346df6f6438628315d9ad98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
