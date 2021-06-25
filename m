Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06E3B4865
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 19:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhFYRvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Jun 2021 13:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFYRvU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Jun 2021 13:51:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 0E18961919;
        Fri, 25 Jun 2021 17:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624643339;
        bh=Cfsc0Qcdd7u2pNiZ/CESKDbh0QvPb1dnyX4ARqxNTZo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mj1iwkiraMKwm1fnCUR+ui3N58HudD6a7c8z6ATx0r8tZ5tOjFZf2eKsEyOSrFYqS
         ySLXQTsh0EHRLziQzr1sCtkN6b/oaTUzVZ5hNU3vkh9w3QmuNVQBaXQn6y+hdb+EiP
         Qy9dkggxB5RPbtIhqK6HphxQ3+icc7ob6miZxaJc/hUsNcYR9Dh8vytQN7LFZvSMds
         yc20VZP5setSKG6X4M7km0mmQXpPLhDOltVT60rN8rCvZei3bP/kgWoR2mJdhQeqxv
         2Of+dqPDsH/a6OwIUQFe3jMHKLpUoIcJoTuSMfkKP7u21ttzB8HgRzI0DWn5tAFjgz
         8tFDy/vAuBbWg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 079F160A38;
        Fri, 25 Jun 2021 17:48:59 +0000 (UTC)
Subject: Re: [GIT PULL] netfs, afs: Fix write_begin/end
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2842348.1624308062@warthog.procyon.org.uk>
References: <2842348.1624308062@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <ceph-devel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2842348.1624308062@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20210621
X-PR-Tracked-Commit-Id: 827a746f405d25f79560c7868474aec5aee174e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e736cf7d6f0dac63855ba74c94b85898485ba7a
Message-Id: <162464333902.2214.16258138937762470940.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jun 2021 17:48:59 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Andrew W Elble <aweits@rit.edu>,
        Jeff Layton <jlayton@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>, ceph-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 21 Jun 2021 21:41:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-fixes-20210621

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e736cf7d6f0dac63855ba74c94b85898485ba7a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
