Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAE276EB4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2019 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfGSTpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jul 2019 15:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733265AbfGSTpG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:45:06 -0400
Subject: Re: [git pull] vfs.git misc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563565505;
        bh=nIR/mvax0/8WkuFZexyB0nUVmHi3Xia1FwLebG9sY3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rSplWeXCJ7IBvdCdiPeJnnIM+ilrAvnpKrZAqAL1aO0Ei0a2r/gXyAsxpHK0Li82k
         pdyQlZeOhS/G8Fd0w7UPoLwCsJNlJiUhLyrxonZjvYYKIEbUCdKXnbp/2nCuxLUOK/
         uqkr6DODl0IeyaGKvk1pcuZYL/Xwslvpms5VC/wA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190719034604.GZ17978@ZenIV.linux.org.uk>
References: <20190719034604.GZ17978@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190719034604.GZ17978@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 02e5ad973883c36c0868b301b8357d9c455bb91c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f5ed1318c0108369a76f4a56242fbeea537abe9
Message-Id: <156356550594.25668.14556352795370141913.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Jul 2019 19:45:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 19 Jul 2019 04:46:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f5ed1318c0108369a76f4a56242fbeea537abe9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
