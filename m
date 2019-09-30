Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF959C1A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 05:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfI3DFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Sep 2019 23:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729010AbfI3DFF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Sep 2019 23:05:05 -0400
Subject: Re: [git pull] a couple of misc patches
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569812705;
        bh=liEQ2TLkk/4fCfmGWheBNc2GgWA0N1vPQE7NLMRtNDQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Raeac9uSaOtZu84FomjQw96NTgnqwOIiKCIR1doIaiFvnpLiuq4DUFBHdX6tsaY0X
         iZhnmWsDXvi7x6EIzlBTiyXgW+j/qz4NClM5H5K+DpxE5G/Yl9uKIQsZwJuk3TAP6t
         GgwUMU9Mv2Z0G8CZuySwnP1srBELdnw8R+k+2Gzo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190929194201.GC26530@ZenIV.linux.org.uk>
References: <20190929194201.GC26530@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190929194201.GC26530@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc
X-PR-Tracked-Commit-Id: 473ef57ad8edc25efd083a583a5f6604b47d3822
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1eb80d6ffb1759968374606c1e36ea88e043e66d
Message-Id: <156981270522.21310.6050719360337887546.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Sep 2019 03:05:05 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 29 Sep 2019 20:42:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1eb80d6ffb1759968374606c1e36ea88e043e66d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
