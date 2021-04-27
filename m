Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADA36CC6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbhD0UiE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235610AbhD0UiC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:38:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E6C1613BC;
        Tue, 27 Apr 2021 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619555839;
        bh=PvEYDkf7uAo28ftXRBj2pXOtz9uNQzYF1I8uwdixnt0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GHcfP7kbs+Kz9nbvjJMvQk2ic9L5nhPtAucbDATH0s/Pa5LFtWSnMHygPJw3unIFP
         HuCN0DUe3rO3d5/dCafGjXgioRxq/Jqo8gaOLurzRVcjbv6wi4qrWGscfbK6/mVd8/
         n2kSK0zZWCEJAF5K1atT2+XU0e+w5Woy3+3bl2FLpKjkHSxSfaRjdtMBdyqJr5K1Sl
         0if70CdW8moppFrgah1TJDXcYqIC+9NCYr5BBJ1Iwns0j7pFBRKuY8if431YOH6nfL
         YwRijOKdpH83Xbrejq1HeYTpeTsXyaE2489xbF7topRpyVLvc+H9X6yskK45jjgtLx
         ElyEtDXLQPanQ==
Message-ID: <5035dded7d076718e2e3e6703c688f992e5f93de.camel@kernel.org>
Subject: Re: [GIT PULL] Network fs helper library & fscache kiocb API
From:   Jeff Layton <jlayton@kernel.org>
To:     pr-tracker-bot@kernel.org, David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Christoph Hellwig <hch@lst.de>,
        David Wysochanski <dwysocha@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Date:   Tue, 27 Apr 2021 16:37:16 -0400
In-Reply-To: <161955556055.29692.16460754787055823751.pr-tracker-bot@kernel.org>
References: <3779937.1619478404@warthog.procyon.org.uk>
         <161955556055.29692.16460754787055823751.pr-tracker-bot@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-27 at 20:32 +0000, pr-tracker-bot@kernel.org wrote:
> The pull request you sent on Tue, 27 Apr 2021 00:06:44 +0100:
> 
> > git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/netfs-lib-20210426
> 
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/820c4bae40cb56466cfed6409e00d0f5165a990c
> 
> Thank you!
> 

Hi Ilya,

With this, we should be clear to send a PR to Linus for what's in
master. The patches that Viro was carrying are also in mainline now too.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>

