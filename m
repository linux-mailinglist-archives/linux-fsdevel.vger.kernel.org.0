Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00616B835B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404793AbfISVaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404772AbfISVaG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:30:06 -0400
Subject: Re: [git pull] autofs-related stuff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568928605;
        bh=/1YnAoV8FXGKe359v7hYwVQoWFmcMHnLjYZwE92naUQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gO6NHaxA+x0fFrnvPI7wX5YPZ9d0JFT7YYyJkDka4114VmBwZrIGlO8DPt+G2SWGP
         Ly399UFBqPqes56p7e2EW3bf82JAyJLsxXCP/dcwzx7uEmDgDxTgduRHgT4x8cZJyr
         3PDjzchtzNuwkxkva+7nZ5hX0mE92KXtph/5nymo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190919021111.GK1131@ZenIV.linux.org.uk>
References: <20190919021111.GK1131@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190919021111.GK1131@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.autofs
X-PR-Tracked-Commit-Id: 5f68056ca50fdd3954a93ae66fea7452abddb66f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e6ee05d8aa9c802d999c79aa22f3f6ca92d7d27
Message-Id: <156892860548.30913.9711724275182913665.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 21:30:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 19 Sep 2019 03:11:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.autofs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e6ee05d8aa9c802d999c79aa22f3f6ca92d7d27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
