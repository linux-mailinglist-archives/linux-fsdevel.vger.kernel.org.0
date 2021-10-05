Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD865422F76
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 19:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbhJER5y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 13:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234432AbhJER5x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 13:57:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9610C61251;
        Tue,  5 Oct 2021 17:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633456562;
        bh=cfUXIRWvM1njK3vXSxZq4gUhIJdbDuAy1roOz0OCtn0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uiYQLoXUL4UlaUtH8uyBgzP2o02xs46Yv6pVx2RbYPnCBAvIqyxvU4CbD077Rn7bi
         BxiNC356sZNgYi+1Bwk4opy5PUvM8l3+dGZa/rEQrspUjGRTg9goimR+cDB7ExJzti
         tkE2em7nATFD1iOEm4EBODKNFDg6wZ+v5H7nhIxIpjE/thGYY19J6szi6FLHEU0ILi
         RMhNe8ZZLiwd1X8vJse+CWE8rIb4EBNs/ktRORhgTiqx6ij/aQg9y7vuLwj63MVwca
         Hezpa10NzAxVMZqpNNv67tGQe7rJrKMTV51v5zwKdVpbxTivSSgDgEWbIv46menkEQ
         EVPVEKIm119FQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88C6460971;
        Tue,  5 Oct 2021 17:56:02 +0000 (UTC)
Subject: Re: [GIT PULL] fscache, 9p, afs, nfs: Fix kerneldoc warnings and one unused variable
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1082805.1633440879@warthog.procyon.org.uk>
References: <1082805.1633440879@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <1082805.1633440879@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/warning-fixes-20211005
X-PR-Tracked-Commit-Id: ef31499a87cf842bdf6719f44473d93e99d09fe2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
Message-Id: <163345656254.17694.3656534862663952653.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Oct 2021 17:56:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 05 Oct 2021 14:34:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/warning-fixes-20211005

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/60a9483534ed0d99090a2ee1d4bb0b8179195f51

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
