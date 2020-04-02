Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF0EF19CB1B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390182AbgDBUZG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 16:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389588AbgDBUZF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:25:05 -0400
Subject: Re: [GIT PULL] iomap: new code for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585859104;
        bh=X4O+f1KizNrpSzYMWWnktY+It/NVJevKAVg214P6nSM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Sn6pzpgLjVnj8gZ9rUjZlzRDm3iZCHVv/5O6hy36dRBApKsSbVD491GxtYc5y3jHZ
         BtxFeLcD3gNFny8fCqB33cp+x3zCDVrYXn3F4L/1HLPwvJ6zG84A3+p4WjneLo9Xx/
         5UzOuneN+UL/7iQHfmeOwZr5/HAesX7gmFm1K93o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402160756.GA56932@magnolia>
References: <20200402160756.GA56932@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402160756.GA56932@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.7-merge-2
X-PR-Tracked-Commit-Id: d9973ce2fe5bcdc5e01bb3f49833d152b8e166ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35a9fafe230bdefe3c37b06589bf622c857030c1
Message-Id: <158585910472.7195.13666355868655579468.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 20:25:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 09:07:56 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.7-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35a9fafe230bdefe3c37b06589bf622c857030c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
