Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B872F38D6A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 19:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhEVRhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 13:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhEVRhT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 13:37:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 363F9610A6;
        Sat, 22 May 2021 17:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621704954;
        bh=YiAUGbC1eZTaeY09i6V48FJhBZ5QyLTpldal65bH9Ng=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pvKlnJ8WpfXh6zcK+CC7cA+OS+uixIHKMwbug7rXks7ZLUN3D5HtzchIWyCFSlRaQ
         R+SWeXR3fGDMAs2me+yShxl7HEa7I6Bk95hgS1jWxaX7wIo1wgx7D2h5TBbkt63d8P
         hKU3VHmSf8LKm6QcMkdY1OK5vaRt5a/RX6UnfgkZhnTRpcnx0whTiRXhzChdoFP4/J
         gFXbayt81Xa4NoQpD5DwkbXGQnwoIONB6yFhczbHGfti3aU9ENI9fWo9zbGVZ5moyk
         cPjDZ/iVpZM6h99wsXOU/TA9KPVu4j4RVhXuwvOPOnwp+wAV/UO+ujfGn9kLrMobYJ
         e1L5MX3btSG3Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 232A2609E9;
        Sat, 22 May 2021 17:35:54 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: fixes for 5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210522041115.GB15971@magnolia>
References: <20210522041115.GB15971@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210522041115.GB15971@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-fixes-1
X-PR-Tracked-Commit-Id: e3c2b047475b52739bcf178a9e95176c42bbcf8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a3969ef463f970c6ad99f32ca154fbd2a62bf97a
Message-Id: <162170495407.3077.13033559630823026395.pr-tracker-bot@kernel.org>
Date:   Sat, 22 May 2021 17:35:54 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 21 May 2021 21:11:15 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a3969ef463f970c6ad99f32ca154fbd2a62bf97a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
