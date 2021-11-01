Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2BA441F3D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Nov 2021 18:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhKARbZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Nov 2021 13:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229541AbhKARbW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Nov 2021 13:31:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EAE7C60E78;
        Mon,  1 Nov 2021 17:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635787729;
        bh=GpUIHGamiecCJMEmJf9QkJMBht5BkCKEkA5aWNVlxl0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qiWmvTFvfsu6bf6tvzG+s4a4RjGadQC3AxaQLatp/ADv8okaz1NO1p724Nxr0nn8k
         +QX4s7FU9Yd0GpCCOnEjSk+0fm0p47bO42rBJWuYe2FMFhXgo2O/b3l6lN049zUCH8
         YMblz5F7/InbgxTlMEgr+FgWsR7R17jvMHpthCGKlV8oKqFx79aXKSFZsyzScH763G
         kDtIWwndabQI40OwzewsM+zrs9izO0/CkK9qUgGb03vhaHGo3wqyhn+ZNFQTUn5f6I
         wK/OxdgH5tOxlFpUPK/vE4IjMUsSFzJdErntGypG9WDFCmvbVoK2kUXupl0Bp8sPUf
         D0PiKHSww1+Nw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E136560A0F;
        Mon,  1 Nov 2021 17:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] Memory folios for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YX4RkYNNZtO9WL0L@casper.infradead.org>
References: <YX4RkYNNZtO9WL0L@casper.infradead.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <YX4RkYNNZtO9WL0L@casper.infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/willy/pagecache.git tags/folio-5.16
X-PR-Tracked-Commit-Id: 121703c1c817b3c77f61002466d0bfca7e39f25d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 49f8275c7d9247cf1dd4440fc8162f784252c849
Message-Id: <163578772891.18307.12885457442188276962.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Nov 2021 17:28:48 +0000
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        Yu Zhao <yuzhao@google.com>, Zi Yan <ziy@nvidia.com>,
        Nick Piggin <npiggin@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        Darrick Wong <djwong@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 31 Oct 2021 03:46:25 +0000:

> git://git.infradead.org/users/willy/pagecache.git tags/folio-5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/49f8275c7d9247cf1dd4440fc8162f784252c849

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
