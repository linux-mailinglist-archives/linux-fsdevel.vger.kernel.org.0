Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE48428C56E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391045AbgJLXuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 19:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390391AbgJLXuF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:50:05 -0400
Subject: Re: [git pull] vfs.git quota compat series
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546604;
        bh=obFWxt3/ipW3oVeI1x6uBxQPIUZD7GBvYxQhHdvKXrQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uM+fD77MkXA6x1vdghOJ3Np/Hoekl4DqK5AjY61pVJPptPKw2ggopxBwMFCQJGh2e
         uzoPD4WGdftCkHeG2KNFaISmjJzDj0LTQzdOoFzQCLp4BhGdSeExSKG+cIojnVR8Y3
         frtiAWyIisDkEMg8w9ru+2FdUIiSgKTh5nfXukgc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012031953.GG3576660@ZenIV.linux.org.uk>
References: <20201012031953.GG3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012031953.GG3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.quota-compat
X-PR-Tracked-Commit-Id: 80bdad3d7e3ec03f812471d9309f5f682e10f52b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e18afa5bfa4a2f0e07b0864370485df701dacbc1
Message-Id: <160254660490.9131.3777598263467812790.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 23:50:04 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 04:19:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.quota-compat

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e18afa5bfa4a2f0e07b0864370485df701dacbc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
