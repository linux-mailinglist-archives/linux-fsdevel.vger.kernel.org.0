Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB02930BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgJSVp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 17:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgJSVp6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:45:58 -0400
Subject: Re: [GIT PULL] xfs: new code for 5.10, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603143958;
        bh=6OMvQcVTpld6OUSOM4TYOfR56sFLelF+qoIXIPgIWDc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JwGl1F+h6qpB3AMNrq0EDGKc+yB3xqtfqBramljq+4OSASTBxDnv7VGb95tp65qSf
         IosqoOKyd5a0Z0aecrON2iX44jv1SFzGIxOf/r3lzG6W9AKAhET7CA7ac7V4uzZKky
         rmejbxmS/4v6PJOcEWoXmoU3yUTQlqEyZ6fGQ51Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201019172055.GK9832@magnolia>
References: <20201019172055.GK9832@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201019172055.GK9832@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-5
X-PR-Tracked-Commit-Id: 894645546bb12ce008dcba0f68834d270fcd1dde
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbe85027ce8019c73ab99ad1c2603e2dcd1afa49
Message-Id: <160314395845.24665.9773037148007496415.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Oct 2020 21:45:58 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 10:20:55 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbe85027ce8019c73ab99ad1c2603e2dcd1afa49

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
