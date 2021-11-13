Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D9E44F500
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Nov 2021 20:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbhKMTrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Nov 2021 14:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233898AbhKMTrH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Nov 2021 14:47:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B66F760EB4;
        Sat, 13 Nov 2021 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636832654;
        bh=EGUOMj5xc5vntvFCMogfm6YhCFkW3/nioe88e+Sf3Lg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HNvHEV+3TpQjdLRtANHMHAbpN9MwhyLoqb6iskMnnJuSCutayMYsXaBuc22n6n3YH
         8Wd9vv1nlYWZEFFkjGpTSMuY5S7ICPUcBtoPGD52KKonENhRIqZrpEUhdrby4D/b16
         2Zn45uI2242w6O6IX+/5EZqNSWGeP2gbUs+4eqaG97148Ywp0vNMgS/F0l8V86kjN9
         QOKH8or52nYGsiFgkOsKgcNkM9h4VUICsBR9y9CUmiJb4tYCoFg1OZtoTt1T6lCPq+
         gR8TosRnoxxJmHAGyNVovfZMNHXJdenDaMndNAolntiGw9MC/j3/ehqLKdJFdkLmFy
         OYpRYuy3G3u4Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9F4F660721;
        Sat, 13 Nov 2021 19:44:14 +0000 (UTC)
Subject: Re: [GIT PULL] netfs, 9p, afs, ceph: Use folios
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1134871.1636647952@warthog.procyon.org.uk>
References: <1134871.1636647952@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <1134871.1636647952@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-folio-20211111
X-PR-Tracked-Commit-Id: 255ed63638da190e2485d32c0f696cd04d34fbc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f7ddea6225b9b001966bc9665924f1f8b9ac535
Message-Id: <163683265459.24678.13171467044016264147.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Nov 2021 19:44:14 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey E Altman <jaltman@auristor.com>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cachefs@redhat.com,
        ceph-devel@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 11 Nov 2021 16:25:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-folio-20211111

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f7ddea6225b9b001966bc9665924f1f8b9ac535

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
