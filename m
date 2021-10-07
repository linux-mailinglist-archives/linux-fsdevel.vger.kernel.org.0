Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5648E425AB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Oct 2021 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243662AbhJGS2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Oct 2021 14:28:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243695AbhJGS2N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:28:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 51B0E60F4C;
        Thu,  7 Oct 2021 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633631179;
        bh=MpEug++mWGWLlEBYAtKQLQwrCkI0Qw0K1mH2W1igvEk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QIrX/iUlhGhm3L+YdDjUVzbblGHfZGzh54QgHB2sDCGELLSFbwYyiivwJAXrYw/tS
         9b5MbhPofsrfBh9Fy9KTJLTkaDFvmkmXWUHUbNCMiFCfsoC3r5+epgbwVvxKpH6Cri
         F4l6vYDk61jzradWGoanD5rXiPpIAfnwBKHwwEom9/2cMIh/0nfP+QhiVP+ZawG3/1
         G7lYnu/OtpP3UWS9EU4qdgYKZa33AG3VC1IIqVcxIBLkMGf/1c92GKVTFXaqkNwvA3
         KJKrkngQtJP0Sf5OSDxs8XY5KahJwEcRSdzloE4ibTUt6vq4ZjRoVrHUQEWo3uIeoV
         gPGO5dFmt0s3Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3FB7E60A23;
        Thu,  7 Oct 2021 18:26:19 +0000 (UTC)
Subject: Re: [GIT PULL] netfs, cachefiles, afs: Collected fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1961632.1633621984@warthog.procyon.org.uk>
References: <1961632.1633621984@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <1961632.1633621984@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/misc-fixes-20211007
X-PR-Tracked-Commit-Id: 5c0522484eb54b90f2e46a5db8d7a4ff3ff86e5d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7041503d3a5c869e4b4934df57112ef90ce7e307
Message-Id: <163363117920.25708.8076103177394410914.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Oct 2021 18:26:19 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Dave Wysochanski <dwysocha@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@kvack.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 07 Oct 2021 16:53:04 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/misc-fixes-20211007

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7041503d3a5c869e4b4934df57112ef90ce7e307

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
