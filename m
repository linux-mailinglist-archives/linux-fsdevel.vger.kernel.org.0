Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3C1F4A01
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 01:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgFIXKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 19:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgFIXKG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:10:06 -0400
Subject: Re: [GIT PULL] fuse update for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591744206;
        bh=qmI64jy9sALQh/mzdpicitd6ZfDm/3dEZcyw+0oxcCA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1BjTyJcru4jtxVmg9FYQKFU+YUyLlp3XhyRrv6W5YbXhVnIa0/jreH/zIWiVYSFo0
         Eeyl4ooL+78ssxquNwjw/Ss+pG+GzptQ/eA915Mp/5Ovwm/YaZ3TSYvphAj3405RFV
         9nH+LS94Jm61+cdC8bNilTWksi8S0f+/n33+zDI4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200609205118.GC6171@miu.piliscsaba.redhat.com>
References: <20200609205118.GC6171@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200609205118.GC6171@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-update-5.8
X-PR-Tracked-Commit-Id: 9b46418c40fe910e6537618f9932a8be78a3dd6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b14671be58d0084e7e2d1cc9c2c36a94467f6e0
Message-Id: <159174420615.2962.1374567357107636417.pr-tracker-bot@kernel.org>
Date:   Tue, 09 Jun 2020 23:10:06 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 9 Jun 2020 22:51:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b14671be58d0084e7e2d1cc9c2c36a94467f6e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
