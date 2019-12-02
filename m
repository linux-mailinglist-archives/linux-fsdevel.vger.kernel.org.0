Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0002910F34B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 00:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLBXUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 18:20:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfLBXUD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 18:20:03 -0500
Subject: Re: [GIT PULL] xfs: new code for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575328803;
        bh=sfgdL2LQqm+W45UayVtTeQKA+2wuRbpuIpDo2SVwMu4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TDGcnHXMXTK2kWeXRhIAB5yrdMzSghrhZoOUO4XI8l4mKGVpzALbWWMCbz69jRNwi
         qmoPtZxnyIVAAHN8bnHZB4gWGWo6oQO+PyNUYOSYl/OkQ+C8l6LkG2J+v6vYPPYiZU
         ltQECt1kr2e1cataFjqnuLcVRXjSWbBbE2UgSrQk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191201184814.GA7335@magnolia>
References: <20191201184814.GA7335@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191201184814.GA7335@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.5-merge-16
X-PR-Tracked-Commit-Id: 8feb4732ff9f2732354b44c4418569974e2f949c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 97eeb4d9d755605385fa329da9afa38729f3413c
Message-Id: <157532880315.12899.5574268640487156676.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Dec 2019 23:20:03 +0000
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

The pull request you sent on Sun, 1 Dec 2019 10:48:14 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.5-merge-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/97eeb4d9d755605385fa329da9afa38729f3413c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
