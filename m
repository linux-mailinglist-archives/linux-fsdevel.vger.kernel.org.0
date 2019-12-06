Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE692114A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 02:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfLFBUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 20:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfLFBUE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:20:04 -0500
Subject: Re: [git pull] vfs.git autofs-related stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575595203;
        bh=fwK3BcHo1+dVZkoSSxwpYLxOqYRZgUM2EgpjJ9piv9s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fvbPOF6UvqJZCwUgb2Nnjkl+RZbJFRTKKLKxzhJ6VnHPGKUyI1LOZ0vw2aCJf1Gzq
         KQHgNVCObcglbknqnfsiZc/uMcCVkyiJG20vOFFGTphlleWLxVcC3sfBhoitKyXI0b
         prHGypj3RUkKkGCrKw5VDTIGVivnNQIxi/gJGoLI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206005853.GK4203@ZenIV.linux.org.uk>
References: <20191206005853.GK4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206005853.GK4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git next.autofs
X-PR-Tracked-Commit-Id: 850d71acd52cd331474116fbd60cf8b3f3ded93e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b0d4beaa5a4b7d31070c41c2e50740304a3f1138
Message-Id: <157559520361.10034.8784267850677909678.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Dec 2019 01:20:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Kent <raven@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 6 Dec 2019 00:58:53 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git next.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b0d4beaa5a4b7d31070c41c2e50740304a3f1138

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
