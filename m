Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD93A1CD68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfENRFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 13:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfENRFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 13:05:03 -0400
Subject: Re: [GIT PULL] fuse update for 5.2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853502;
        bh=gW4ODTSZ9gWxZPFs+wds3sb/89m4vZDdtK+HsK9r1Mo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=E3VuLJBbgyWQbLFVFU6tRWHyxFokHT2eukEva1UgJMV0jXcBLJy+wXWJy7GAq2Umg
         /F+abVpXAGvmDqjbhh/v0rMnXM+UM9aO7TJg4YqcWT4dI/9LKUN5ZGNcyU4ijTzI+V
         gW/ktc8+MMYtZ7I8Ut0tTqSdfriOf0yOsmGd0KTc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
References: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190514075136.GA7850@veci.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-update-5.2
X-PR-Tracked-Commit-Id: 9031a69cf9f024a3040c0ed8b8ab01aecd196388
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4856118f4953627e9a087253766b9e7361f5f4a0
Message-Id: <155785350294.31213.11114554884607214967.pr-tracker-bot@kernel.org>
Date:   Tue, 14 May 2019 17:05:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 14 May 2019 09:51:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4856118f4953627e9a087253766b9e7361f5f4a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
