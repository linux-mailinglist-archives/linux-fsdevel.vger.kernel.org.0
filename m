Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD9822420D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgGQRkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgGQRkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:02 -0400
Subject: Re: [GIT PULL] fuse fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007602;
        bh=4PbvnwdzKOHco+EiBnqlhonES2SQpJbFWKWIOUiTPPU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sG7wj9zUD+vMWzCYqnZwHcVWTiqCOrc89YNbzqyHrbZAgmDCQgJF2XgTi2Ys4w4O1
         SItaEMXmZXdG6SfmXPRC3WuCMYYBZIMqRhZ+Br247Fy81ME3J2fHQG9boP0/lPUB/x
         jtkDohvvXbuxjNPAnYkI66WjAB5+mEZe586SR/xM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200717123139.GE6171@miu.piliscsaba.redhat.com>
References: <20200717123139.GE6171@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200717123139.GE6171@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.8-rc6
X-PR-Tracked-Commit-Id: 31070f6ccec09f3bd4f1e28cd1e592fa4f3ba0b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0dd68a34eccd598109eb845d107a7e8e196745db
Message-Id: <159500760228.14528.6150023914462520492.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 17:40:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 14:31:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0dd68a34eccd598109eb845d107a7e8e196745db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
