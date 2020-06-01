Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5326C1EB267
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 01:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgFAXzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 19:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgFAXzC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:02 -0400
Subject: Re: [git pull] uaccess readdir
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055701;
        bh=+q+n+z8emUHCucO7YvEiOKwQoUCiAF9waXSkIhHSzgw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Kn9h4H4etM9xV28MEszhjLoV4LcGuUlRI48hQCe+sOXZ1wPdRqLOUHcT+BCoh4eEj
         3dIcpOTGP6Vtc55tQAQV23W+b5eAq7fAUjM3P4vFi1rl4eMZpJHFayibpd7ajLdchA
         q+G2Z3hj9N+m+cxOBP/BsPPHeQGM7jyY9nZD+GiU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601182741.GC23230@ZenIV.linux.org.uk>
References: <20200601182741.GC23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601182741.GC23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.readdir
X-PR-Tracked-Commit-Id: 5fb1514164de20ddb21886ffceda4cb54d6538f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e148a8f948afc0b1eeb5c157b23b3d0a4d4517a5
Message-Id: <159105570177.29263.15090743496246924081.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:01 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:27:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.readdir

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e148a8f948afc0b1eeb5c157b23b3d0a4d4517a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
