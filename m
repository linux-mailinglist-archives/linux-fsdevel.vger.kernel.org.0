Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7FF1A2E98
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 06:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDIEzJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 00:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgDIEzF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:55:05 -0400
Subject: Re: [GIT PULL] iomap: bug fix for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586408105;
        bh=m98uH8OLAJC+JHxIZ2H6jiYyM9KAeIiWwD5/Ked43no=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CIsbiMfalFCQgb9fgO7r4Xu99V+aQVCpw/BQVmQbGaQg1o/xCdOmO5IjWiljghFZG
         o7yKlok8bcb+CBxn/Bb8cAZhNL9cVNRxtrF3sdhAnkt2U65TW4xZaTn4l6jibZcbGJ
         Ndh9AhTvkoOm6hgT1O16QG64JPRawVx0otgGmLco=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200408155813.GB6741@magnolia>
References: <20200408155813.GB6741@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200408155813.GB6741@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/iomap-5.7-merge-3
X-PR-Tracked-Commit-Id: 457df33e035a2cffc6561992f3f25a6c61605c46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9744b923d50810bb489e49bfe89d0b4d5c84be31
Message-Id: <158640810582.3202.9362182758979165280.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 04:55:05 +0000
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

The pull request you sent on Wed, 8 Apr 2020 08:58:13 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.7-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9744b923d50810bb489e49bfe89d0b4d5c84be31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
