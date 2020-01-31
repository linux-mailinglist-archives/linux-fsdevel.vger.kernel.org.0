Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041E214F396
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 22:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAaVKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 16:10:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgAaVKE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:10:04 -0500
Subject: Re: [GIT PULL] iomap: new code for 5.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580505004;
        bh=MCkR/ng7bUbpozJhY4zARLxv1MqEKe/eRZIzdiuzBpY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HZsATbrqIem72P9LB8QleE0QUROvKJ5Gl4owE8YRYhBDDRbjHL1kNlGHbXfEtiqJ8
         J08VkzmdwLvrygp/eV4g/5kz5mhFLq6cxrXaAmFLjnM803Q5XrvLKtIMuMdxby1vUz
         ZICGVt9Uaa1mHfs6XT9FXJROYwNXDcaPiPLmXp5U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200131040753.GB6869@magnolia>
References: <20200131040753.GB6869@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200131040753.GB6869@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.6-merge-3
X-PR-Tracked-Commit-Id: 243145bc4336684c69f95de0a303b31f2e5bf264
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 677b60dcb68a0c43822b5a8ad97733b4193386b9
Message-Id: <158050500400.4115.17533922606838474963.pr-tracker-bot@kernel.org>
Date:   Fri, 31 Jan 2020 21:10:04 +0000
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

The pull request you sent on Thu, 30 Jan 2020 20:07:53 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.6-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/677b60dcb68a0c43822b5a8ad97733b4193386b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
