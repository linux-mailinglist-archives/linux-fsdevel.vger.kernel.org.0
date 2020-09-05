Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD525E947
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Sep 2020 19:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgIERS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Sep 2020 13:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgIERST (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Sep 2020 13:18:19 -0400
Subject: Re: [GIT PULL] xfs: small fixes (2) for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599326299;
        bh=RAQ4c3VNoOhZRKvVwWBdsYPhu7/YMGF/LOA+JwNMCvo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZRi51ApAoVN5LGyL9r/m9km8xkvR57WYe7DO9l2KSUTv98GZ/ahcJNEfuFYQAFPIW
         GujMD9MQGzrLq6JvjKkBRllUxf2nycJIbl5k2nZFxK23wPT1Z/J3pfaR+GGq+2ozHg
         vvLYIQ6n3xIebAGZLv0TAtbV2wt5NewCtRWOmrvo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200905155243.GB7955@magnolia>
References: <20200905155243.GB7955@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200905155243.GB7955@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.9-fixes-2
X-PR-Tracked-Commit-Id: d0c20d38af135b2b4b90aa59df7878ef0c8fbef4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9322c47b21b9e05d7f9c037aa2c472e9f0dc7f3b
Message-Id: <159932629910.1747.12909105499699699907.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Sep 2020 17:18:19 +0000
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

The pull request you sent on Sat, 5 Sep 2020 08:52:43 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.9-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9322c47b21b9e05d7f9c037aa2c472e9f0dc7f3b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
