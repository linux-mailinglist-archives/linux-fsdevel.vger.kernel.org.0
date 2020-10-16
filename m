Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51683290DC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Oct 2020 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406442AbgJPWbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 18:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406125AbgJPWbx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:31:53 -0400
Subject: Re: [GIT PULL] overlayfs update for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602887512;
        bh=NG/GWsisAfNbHXAGwOQgk1ozWocu1lvF7zSRynTEYdM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oXpEfvLs72lBqTgyMcc5XA19Rwgg3vPKZMNM0Q0rWfGB5D+AFrsaFop6ySg3N4e0w
         68qXcybjuFX77jJV2GIjGTAwPktcwfzKlwh9bAsNh2aatu2Ys4dOgnxom8BOaaeoSu
         F8kfEai6eXMwe0Nb2gCFsTQEp6ptCgkrD0JQ0W+c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201016203453.GA327006@miu.piliscsaba.redhat.com>
References: <20201016203453.GA327006@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201016203453.GA327006@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.10
X-PR-Tracked-Commit-Id: be4df0cea08a8b59eb38d73de988b7ba8022df41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 071a0578b0ce0b0e543d1e38ee6926b9cc21c198
Message-Id: <160288751244.30401.9448530647466023663.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 22:31:52 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 22:34:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/071a0578b0ce0b0e543d1e38ee6926b9cc21c198

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
