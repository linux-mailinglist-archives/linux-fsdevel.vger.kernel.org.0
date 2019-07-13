Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B616A6773F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 02:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfGMAaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 20:30:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727261AbfGMAaD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:30:03 -0400
Subject: Re: [GIT PULL] xfs: new features for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562977803;
        bh=84yLdhb+ng2NsiZuy70m9kqgPDqXfrXNfgZuHull9yE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aWVvGY9K7Qd9mGCKX2tUGpRzLmNmHKIcKFqRvU88aAZtQuipS44dzyV2JDUiI2ojv
         QWqhY0Yq+LQxRIfJ8Sk0dUfIxSaWpCXQIbI/2y5zEbov/7iJbjY9cA53ErM13v8qAC
         X79qJPBsF1E51RKX5WvNlAaKqNDK+0DgI+k+vCyQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190712180205.GA5347@magnolia>
References: <20190712180205.GA5347@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190712180205.GA5347@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.3-merge-12
X-PR-Tracked-Commit-Id: 488ca3d8d088ec4658c87aaec6a91e98acccdd54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ce9d181ebe53abbca5f450b8a2984b8c3a38f26
Message-Id: <156297780313.21817.8539094998508232059.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jul 2019 00:30:03 +0000
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

The pull request you sent on Fri, 12 Jul 2019 11:02:05 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-merge-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ce9d181ebe53abbca5f450b8a2984b8c3a38f26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
