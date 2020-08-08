Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623DF23F67A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 06:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHHEf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Aug 2020 00:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgHHEf6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Aug 2020 00:35:58 -0400
Subject: Re: [git pull] regression fix in syscalls-for-init series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596861357;
        bh=fbEKI5UJt4oAvWLs7qkrQjT/6IkiZBbqxvsZzRQBtec=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Zpa3ij64/rPOEJZ8F36REKtOt9Gn8gcifW3llw3BsxbOJ/7PvshfVZsNTtz71LQiZ
         tXOeoDHgbBkUHcj2JlAuOq68Ul8WCYgbt9gwcVlYT23kneBm+MuFvyQzElbzBZhx0m
         GdZ9V47zN1Agq6Z6SdsdAlNIIDkbinPfxfhLDB+0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200807232353.GX1236603@ZenIV.linux.org.uk>
References: <20200807232353.GX1236603@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200807232353.GX1236603@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 25ccd24ffd9119c452d711efa2604a7a0c35956e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d57b2b5bc4301f37d1b07e3351d575bd634c7300
Message-Id: <159686135788.18048.17800758162649652453.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Aug 2020 04:35:57 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 8 Aug 2020 00:23:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d57b2b5bc4301f37d1b07e3351d575bd634c7300

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
