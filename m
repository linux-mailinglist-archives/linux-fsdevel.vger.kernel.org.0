Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 427A06512F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 06:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfGKEkH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 00:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbfGKEkG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:06 -0400
Subject: Re: [GIT PULL] ext2, udf, and quota fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820006;
        bh=RyaQJ3w0TNT5zZvDaZI8iEVLgO0bdR4e10nrFNBYQis=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CJpzBXN5I4V4E4Nk0gKN3ABT7A2hlhn05rjFHxK9bTpFVsVDo/ab5tr39B8qZiHMT
         JdC9Kn4k9+1FR7GjfZjVJ8LYsMirABUY6/oFP0/j+PcV0D2LwKrTK1gQcTkI2a8iik
         cReI5Edy8vx9dhstYROc8Dyw3W32yVTgE2nTzXXQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190710162338.GA14701@quack2.suse.cz>
References: <20190710162338.GA14701@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190710162338.GA14701@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.3-rc1
X-PR-Tracked-Commit-Id: fa33cdbf3eceb0206a4f844fe91aeebcf6ff2b7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 682f7c5c465d7ac4107e51dbf2a847a026b384e8
Message-Id: <156282000615.18259.13126157467249172523.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:06 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 10 Jul 2019 18:23:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/682f7c5c465d7ac4107e51dbf2a847a026b384e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
