Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 448581A48EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDJRaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 13:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbgDJRaE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:30:04 -0400
Subject: Re: [GIT PULL] xfs: new code for 5.7, part 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586539804;
        bh=zO5L6bExP9Vn6H54tOeXhCYaOoSrMwNm1GL0YwwAzNM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gFiG4RaC3ploy5R6VzEfsvQGQwgGFlZwTA3qRYZkszO6WLs98FDfbtppzrxyEBlzc
         YV4+Mhr4S82c1YqOhADCWcRf1am6593mEh6Nh5k63NM1p1QZy+lkyWAQe9A7YrR1sn
         0QWZ+bsz16fGyBv6uAZSUvjxC8lp/RMvw0McD7DA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200409181526.GM6742@magnolia>
References: <20200409181526.GM6742@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200409181526.GM6742@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.7-merge-12
X-PR-Tracked-Commit-Id: 5833112df7e9a306af9af09c60127b92ed723962
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c3c07439e1d793d8803a404df86e487875f3340
Message-Id: <158653980468.6431.14242531724269213337.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 17:30:04 +0000
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

The pull request you sent on Thu, 9 Apr 2020 11:15:26 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.7-merge-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c3c07439e1d793d8803a404df86e487875f3340

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
