Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436E610DEEB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 20:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfK3TkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 14:40:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:44376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfK3TkD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:40:03 -0500
Subject: Re: [GIT PULL] iomap: new code for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575142803;
        bh=RkiMjudXwV4F9qFajC2mPQLgq7PsOmLsVNlxCJ+H2KU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Do3brzd7q+WuN/096bEpjf7rV6pYWfWfU2qPrSwQdMyB2z3OQo3GZ1DHVTiohL6Gh
         14CUpP3OqckCV6hP0zj/ivqZxIpFPgx6Bd66K8jrpJT+uNcCK4ohjIfq6rnuEhAZEJ
         bV2cirq+V2TxXQWcoi8gn4GtLrFg4SjcZRPTOytc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125190907.GN6219@magnolia>
References: <20191125190907.GN6219@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125190907.GN6219@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.5-merge-11
X-PR-Tracked-Commit-Id: 419e9c38aa075ed0cd3c13d47e15954b686bcdb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b266a52d8d6e02ea6c1bb52c96342128e624554
Message-Id: <157514280298.12928.5427720879261656936.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Nov 2019 19:40:02 +0000
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

The pull request you sent on Mon, 25 Nov 2019 11:09:07 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.5-merge-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b266a52d8d6e02ea6c1bb52c96342128e624554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
