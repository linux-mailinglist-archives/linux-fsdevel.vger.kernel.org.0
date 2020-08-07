Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9694523E5E4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 04:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgHGCjQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 22:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgHGCjK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:39:10 -0400
Subject: Re: [GIT PULL v2] iomap: new code for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596767950;
        bh=zFOyHZS18PBPXv24TPjZot4Y7THCDOAZOYL0pNQ8Wi0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gaj/Ebh7DmnIZITl9QB+5jrj3tGA1PNpahqKbcxD95KflA3ENJUBuviCfoacXzvSb
         bApi4u9QzNK3DOdLmKbmtGrj3fACpx0yGvUc4b9r3iG+zL/O8SnylpubrChW55m07m
         oi1hoZQL06Hyz1+fAVPFbxMjxdTgyPuwF5+KUE8U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200806150743.GC6090@magnolia>
References: <20200806150743.GC6090@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200806150743.GC6090@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.9-merge-5
X-PR-Tracked-Commit-Id: 60263d5889e6dc5987dc51b801be4955ff2e4aa7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e4656a299db8484933a143259e7e5ebae2e3a01
Message-Id: <159676795001.23087.7465580263799667328.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 02:39:10 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, riteshh@linux.ibm.com,
        rgoldwyn@suse.de, agruenba@redhat.com, linux-btrfs@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 6 Aug 2020 08:07:43 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.9-merge-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e4656a299db8484933a143259e7e5ebae2e3a01

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
