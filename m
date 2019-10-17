Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5FDDB8ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 23:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441516AbfJQVZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 17:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729780AbfJQVZC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:25:02 -0400
Subject: Re: [GIT PULL] xfs: fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571347502;
        bh=GR2F7fhR+5kzEwcnLOfJFwKMShr0YvJ4FxxLD3j4w6A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=GJBbF5l12kMU3BH5r3HkkEgPZVPLT2UvQvAo13qxMuMauYuZzT2jlzcBq/X3jPKb/
         q8xYOIWJAyIuRSqM7LYess+ItnEN2vAPhurqfn+QQlXXHedXyqXJpCm5yB0b49S8dU
         HCNaokNRohw4Dhzww9fYl+5HpGOxxhshyKabzdf8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191017211739.GQ13108@magnolia>
References: <20191017211739.GQ13108@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191017211739.GQ13108@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.4-fixes-4
X-PR-Tracked-Commit-Id: 5e0cd1ef64744e41e029dfca7d0ae285c486f386
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e8ba0098e241a5425f7aa6d950a5a00c44c9781
Message-Id: <157134750215.3013.5704792166591005219.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Oct 2019 21:25:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 17 Oct 2019 14:17:39 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e8ba0098e241a5425f7aa6d950a5a00c44c9781

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
