Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879CA10DEE2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 20:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfK3TkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:44432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfK3TkF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:05 -0500
Subject: Re: [GIT PULL] splice: fix for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142804;
        bh=oYlvQXwGXB7bQPQQTSX35TSJAULbCqgsl1u8X1uhdsU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UElH2clmOGF0H+TAGDwgmbOplpyvvJXjaGrUZ7I9hBFfm7EiWvC9CWA3YDNnN+IMY
         JjbL999v32iUvhVAfxqUAvqeAS871RvFxUteV/W0PTyXYeC53jzXKebxoBpUE8E3/x
         HwAxLdXe3uQLMYDdQspLG6MbE90Z0ftuyTNU9XB8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125230326.GS6211@magnolia>
References: <20191125230326.GS6211@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125230326.GS6211@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-5.5-merge-1
X-PR-Tracked-Commit-Id: 3253d9d093376d62b4a56e609f15d2ec5085ac73
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f112a2fd1f5999c6029551f901952392d900cf99
Message-Id: <157514280449.12928.9927837015042569301.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, agruenba@redhat.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 15:03:26 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.5-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f112a2fd1f5999c6029551f901952392d900cf99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
