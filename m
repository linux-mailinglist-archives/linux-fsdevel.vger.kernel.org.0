Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A917297E32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Oct 2020 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762482AbgJXThN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Oct 2020 15:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762379AbgJXThN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:37:13 -0400
Subject: Re: [git pull] vfs misc pile
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603568232;
        bh=P+xNND+41fcxkA8BmZpU6Isw1N+0YQ3XOwZH8/4gadA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J/EEM4GTLttgrC5NmFRqneknhkRjNaZ4EllRfAXSlr31quh4OXckflkyQlVJ04MhR
         j/VONhmVCkVUfoTXRzTnwy0uK4yDdZGxcEIcuwUUUzYc3tULzBHcvpmkuz+1CsjpzA
         rd49MHO4qg28bGO77GZcVQB1almZ3hp1feRKWq7g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201024184656.GB3576660@ZenIV.linux.org.uk>
References: <20201024184656.GB3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201024184656.GB3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: f2d077ff1b5c17008cff5dc27e7356a694e55462
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0eac1102e94807023e57d032bbba51830928b78e
Message-Id: <160356823272.4617.12213866098896505708.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 19:37:12 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 19:46:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0eac1102e94807023e57d032bbba51830928b78e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
