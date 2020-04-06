Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8035719FAB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 18:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgDFQpG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 12:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729558AbgDFQpF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:45:05 -0400
Subject: Re: [GIT PULL] Fsnotify patches for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586191505;
        bh=Eb9/p3tPfEW2FZyQtWO4tth0gKeFT2CSFPzM9TbZn2M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=s/rTY0ZKTJ6zZ/HH44ywEt/ADD20tploIMSWzhLB8ovpSbIMEnJVw4Ft2OaQQAxn7
         MPGlFqw97KypMR32ODEu8tjjBwQNRQQaob8dzyfAAWTI4WhfNsffh8PSlbDoeskaDx
         SV9uMn+dahp3TeuKfwjtiZBS7a9G+kD4h2MXaHZs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406114431.GF1143@quack2.suse.cz>
References: <20200406114431.GF1143@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406114431.GF1143@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.7-rc1
X-PR-Tracked-Commit-Id: 6def1a1d2d58eda5834fe2e2ace4560f9cdd7de1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6ff10700d1bf33c4323d34eca1e80bc8a69f9f5
Message-Id: <158619150513.17891.4173544571227221702.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Apr 2020 16:45:05 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 13:44:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6ff10700d1bf33c4323d34eca1e80bc8a69f9f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
