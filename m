Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F93B65131
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2019 06:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfGKEkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 00:40:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbfGKEkF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 00:40:05 -0400
Subject: Re: [GIT PULL] iomap: new code for 5.3, part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562820005;
        bh=ibpxCOtkNsRkNO/RbXgJ+4KafRgVn3nq0vXIFuNIHV4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PkhAN/CtwkUtIa+31JhxBERbCphvEL2vqYdDF029HrbFiOPJEFA0v5l/Pk3NOx8db
         gYKeqYaCkl4Y+KGzx0zIFJjXkwxISznxzQEtJbAEqbOZF9zyNM5GSSpozbsWphUv4g
         dQ5DLYnJZcw797l1GKE1lsGCpAXsN80exK/GI9qU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190709153454.GQ1404256@magnolia>
References: <20190709153454.GQ1404256@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190709153454.GQ1404256@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.3-merge-1
X-PR-Tracked-Commit-Id: 36a7347de097edf9c4d7203d09fa223c86479674
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a47f5c56b2eb55290e2a8668e9ca9c029990dbf6
Message-Id: <156282000493.18259.18191947984895266150.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Jul 2019 04:40:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de, agruenba@redhat.com,
        rpeterso@redhat.com, cluster-devel@redhat.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 9 Jul 2019 08:34:54 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.3-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a47f5c56b2eb55290e2a8668e9ca9c029990dbf6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
