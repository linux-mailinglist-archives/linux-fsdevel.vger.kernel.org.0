Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982A7111B7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfLCWPH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 17:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfLCWPF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:15:05 -0500
Subject: Re: [GIT PULL] iomap: small cleanups for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575411305;
        bh=uxAYgjvrlHNlmiCCJJqc9Q/JExua1lXYWmd3ARgKnts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kRoYWwWl0CPBdqprVYYTyLwIi8ius2GbIqlj69oudyF3ehvVhfIlHd0eDNdCNsok4
         GzHPk8SsiAeGOW7ONJH3IWp1P0UfPV47gMy+Z0pjaXEE8Uig+7B3zyjlOu+jO0Qhvp
         04OfXS/BGnJJndqMZNaV+4gHYtwiapbON1EnSD9g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191203160856.GC7323@magnolia>
References: <20191203160856.GC7323@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191203160856.GC7323@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.5-merge-13
X-PR-Tracked-Commit-Id: 88cfd30e188fcf6fd8304586c936a6f22fb665e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a31aca5006749f7d4655836c61d4a53bfae8e53
Message-Id: <157541130508.3528.9113610201591318656.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Dec 2019 22:15:05 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 3 Dec 2019 08:08:56 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.5-merge-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a31aca5006749f7d4655836c61d4a53bfae8e53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
