Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C37A2B29B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Nov 2020 01:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgKNAPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 19:15:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgKNAPF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 19:15:05 -0500
Subject: Re: [GIT PULL] xfs: fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605312905;
        bh=8rorPmrehKT1pkNY9qWmOhFhyvZQHNsZxBH5WpU2fmo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pHwYHH0+fKNCRlIQHIaJzxyMFLnw1fMNkLU3L1LsCHIvJG4kIJVhrPAnwf9p0veJJ
         +WlO8b1PKixDacusQrmsdQ/PjmdIwyxcW928Mdsq0j5TDdmOkfaerlowLfDOVsqtkL
         6LkoEj3dkzh2eueaWU0juIdR0qG+B2QwVapMTuMw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201113231738.GX9695@magnolia>
References: <20201113231738.GX9695@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201113231738.GX9695@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-5
X-PR-Tracked-Commit-Id: 2bd3fa793aaa7e98b74e3653fdcc72fa753913b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d9315f5634c94500b91039895f40051a7ac79e28
Message-Id: <160531290531.27003.5569179539253030810.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Nov 2020 00:15:05 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 15:17:38 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d9315f5634c94500b91039895f40051a7ac79e28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
