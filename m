Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268A32DD9C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 21:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbgLQUVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 15:21:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgLQUVx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:21:53 -0500
Subject: Re: [GIT PULL] ext2, reiserfs, quota and writeback fixes and cleanups
 for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608236473;
        bh=n1dbpAphC50Yql/C+iBQTn8y9S56ihIXGgJ4Py24VhE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FV3YObRQ7sy0CWhWFRmDPoJnOvC7gUkoDMKASjOJeJ0DfukDw9+rAkWXwTRLVZv/7
         +CkiDifbQtGg/1kQy/ybP68wHLL7jhYBajNuQjy4wm3JHXWKq73alWdA7tMRqjTp2R
         w3wDC53b1G3QlmxzyNs55mshQCe6zH8dyHyJKgBCEfg8UrEmjaMMSFA54NN09Ncx7R
         M+SbZju0B2ZRAjPBaquyocgfPZ72bqPTUA94sJTXksErsvlKDgWlqiitVt+92g31xP
         LgCckJckfnqFFbqgzRdx/YomlVMZ4SxDLTnFG/kQazK6mEX+LMoqCw5HhQgMgW9pKh
         EHucmXHzjFMzQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201217112529.GD6989@quack2.suse.cz>
References: <20201217112529.GD6989@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-ext4.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201217112529.GD6989@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.11-rc1
X-PR-Tracked-Commit-Id: f7387170339afb473a0d95b7732f904346f9795e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b97d4c424e362ebf88fd9aa1b7ad82e3a28c26d3
Message-Id: <160823647332.7820.6208665092448617963.pr-tracker-bot@kernel.org>
Date:   Thu, 17 Dec 2020 20:21:13 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 17 Dec 2020 12:25:29 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git for_v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b97d4c424e362ebf88fd9aa1b7ad82e3a28c26d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
