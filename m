Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3F21BB9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGJQzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 12:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbgGJQzC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:02 -0400
Subject: Re: [GIT PULL] clean up kernel read/write helpers
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400101;
        bh=yIt4ewafHy7TYnqAojKwDR7EuaWKcJYEPp6KzZQ0Q1g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CPCKPpNdTAz1jIlYLjKBgf2ggT0+XQmLpTeUkAYF/HHU6ld9ddTVlU0wg/w80gEfe
         rh9jGcvBc+2acGG95SRyigYGbiy7mj6QExn8UepSnX+8D+kNkw4eRCwja3UNJcoaRH
         Ke7l1tjkygK2yrhmJiyePiD5kOBPPpfVVDz9QkKA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710160058.GA540798@infradead.org>
References: <20200710160058.GA540798@infradead.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710160058.GA540798@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/misc.git
 tags/cleanup-kernel_read_write
X-PR-Tracked-Commit-Id: 775802c0571fb438cd4f6548a323f9e4cb89f5aa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1b11d0063aab28aaf65f63cff56470bc01dc290
Message-Id: <159440010185.18761.3577889747642971493.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:01 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 18:00:58 +0200:

> git://git.infradead.org/users/hch/misc.git tags/cleanup-kernel_read_write

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1b11d0063aab28aaf65f63cff56470bc01dc290

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
