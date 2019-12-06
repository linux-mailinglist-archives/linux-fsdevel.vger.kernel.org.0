Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72C1157BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 20:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfLFTZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 14:25:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbfLFTZD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:25:03 -0500
Subject: Re: [git pull] vfs.git d_inode/d_flags barriers
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575660303;
        bh=PGQpDvt42R1DJDHfYDic+76P5cQTTcMg9LWqRGlb1EY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nTmyTXKQLkRk3OUyzUh200QZztiZj/BhZabzOZvSVFUktOx/uqZA5R9LfvlhaUROy
         SXOpXFFGxPgG/5NV2DJoNrPumIJa1IRcWNk7FztmK0fuNJE4NpVzl+ZWlTtmVQIP/u
         ipCy6mreNxE1A2ZV1ccN5rHdXAoE3W9h/Aj1iyF0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206013819.GL4203@ZenIV.linux.org.uk>
References: <20191206013819.GL4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206013819.GL4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 2fa6b1e01a9b1a54769c394f06cd72c3d12a2d48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aecba6173216931c436a03183f4759a4fd4c2f2
Message-Id: <157566030296.16317.15897821956117872121.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 19:25:02 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 01:38:19 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aecba6173216931c436a03183f4759a4fd4c2f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
