Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A853B28E886
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Oct 2020 23:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgJNVpL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Oct 2020 17:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgJNVpK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:45:10 -0400
Subject: Re: [GIT PULL] xfs: new code for 5.10, part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602711909;
        bh=mg0nndmHsuAtPlyKC/6MabvcsffqXZrJO74ybIKJrWM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x6zLF/qc/SC2k+WLrL9zQIRKI0O4QMJPQgOVn8BLGDnmfvLddyJW0GzgdUot2wvAg
         pIvQGTix4nr1oAyjutLCg9mwkv8dar/fhPn3vEBBXb3UczDjvoq4sHLVug8I+GIgvj
         zNC6fvSKmA+O+IdkeS1fnFYF2DzKl/7JTvdLRG0k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014205059.GD9837@magnolia>
References: <20201014205059.GD9837@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014205059.GD9837@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-2
X-PR-Tracked-Commit-Id: fe341eb151ec0ba80fb74edd6201fc78e5232b6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2fc61f25fb296827387a5f01129dbc00cbe3ca58
Message-Id: <160271190940.18491.17668718527744721482.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 21:45:09 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 13:50:59 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2fc61f25fb296827387a5f01129dbc00cbe3ca58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
