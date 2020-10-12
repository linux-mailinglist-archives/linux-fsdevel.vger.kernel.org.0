Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB928C570
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 01:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbgJLXuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 19:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389654AbgJLXuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:50:05 -0400
Subject: Re: [git pull] vfs.git csum_and_copy stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546604;
        bh=XqwSc6XjeSbQ1PQKdeO+jCn2q/PRuWtuo+IjBypnFBE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Vay2FrCkzrdI+zC/IP0alDxow5m80S4jeBT7xjwIJpkQgZ8UEptza2ma2K+H8Azod
         zuACRbllFuBL8pgTH6t1iuW41iCens707ICjilXypex91agK28+tGKONitQFF0/X5M
         HHtgzfPvMcxoSc4eUdknxehDX5Ij2DBg4bwBjUiY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012031455.GE3576660@ZenIV.linux.org.uk>
References: <20201012031455.GE3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012031455.GE3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum_and_copy
X-PR-Tracked-Commit-Id: 70d65cd555c5e43c613700f604a47f7ebcf7b6f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c90578360c92c71189308ebc71087197080e94c3
Message-Id: <160254660447.9131.8706745970731858801.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 23:50:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Miller <davem@davemloft.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 04:14:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.csum_and_copy

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c90578360c92c71189308ebc71087197080e94c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
