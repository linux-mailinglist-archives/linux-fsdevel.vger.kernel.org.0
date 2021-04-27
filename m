Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8A36CC58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbhD0UdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235416AbhD0UdY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:33:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A496A6112F;
        Tue, 27 Apr 2021 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619555560;
        bh=4gt03mTcqQmbSZtAfLXQq5ZIUn/1FOWKVpj8VYzvF7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mOxujVs+Fgdau8zdzq2K7vxHteNdW5KCJuRzEsR8YYeriMrhVkzvzDNyU5+/IxFA7
         cdsQbsLF4MDnqVfszzqMfvFb9OYmy/llYn9s9GfwJIhnyJ9Vff+V8Hn0shWQOvJA15
         LjVBtvcXuezv92O3MEdBRbUwCNKFtSjFNL5ZCz4YKcHKAUttZ2d+xhCafVJPOGzEBe
         Yvka5WEvVjUNJ6HUlMy5NBj6H0BayaR0FTNgGckNHWK/43xJXuHwtV35tduX99wWxx
         ZlAnxBys7tfYfUE4hUuOOxg7mqfIqTIGDdN2t4SjVflaCO7l1ycaXYVJdwGE56Bgvv
         Zb2IE2IWrjvZw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 98538609B0;
        Tue, 27 Apr 2021 20:32:40 +0000 (UTC)
Subject: Re: [GIT PULL] Network fs helper library & fscache kiocb API
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3779937.1619478404@warthog.procyon.org.uk>
References: <3779937.1619478404@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3779937.1619478404@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-lib-20210426
X-PR-Tracked-Commit-Id: 53b776c77aca99b663a5512a04abc27670d61058
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 820c4bae40cb56466cfed6409e00d0f5165a990c
Message-Id: <161955556055.29692.16460754787055823751.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:32:40 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@lst.de>,
        David Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 27 Apr 2021 00:06:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-lib-20210426

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/820c4bae40cb56466cfed6409e00d0f5165a990c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
