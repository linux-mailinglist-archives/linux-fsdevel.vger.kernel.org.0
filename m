Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D05867743
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 02:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfGMAaD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 20:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfGMAaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:30:03 -0400
Subject: Re: [GIT PULL] vfs: standardize parameter checking for
 SETFLAGS/FSSETXATTR ioctls
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562977802;
        bh=iJbSToUKeVYGNujDmnFLtUwMKQq+JLbjdgAreetA7s0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lOZr7A+dZnT0PMtb2rXLyPCdO+SwOB5lZ92s0flb/WbGU18CxJZjJUqXjOoniJH11
         ajIEAS1i1x8CjvYZW+ZZetSPpYNb6UDdeJneEseTK/zcqcBX4bhvKUEkMUaiuOjdC1
         agBPmUihym+eQoWJIBnR0nRnebu/v4pjRsg7Sd9o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190711141825.GV1404256@magnolia>
References: <20190711141825.GV1404256@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190711141825.GV1404256@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-fix-ioctl-checking-3
X-PR-Tracked-Commit-Id: dbc77f31e58b2902a5e7643761c04bf69f57a32a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5010fe9f095414b959fd6fda63986dc90fd0c419
Message-Id: <156297780234.21817.9681885311019311111.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:30:02 +0000
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

The pull request you sent on Thu, 11 Jul 2019 07:18:25 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-fix-ioctl-checking-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5010fe9f095414b959fd6fda63986dc90fd0c419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
