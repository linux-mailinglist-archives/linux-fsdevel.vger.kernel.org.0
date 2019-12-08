Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD311600F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 02:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLHBKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 20:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfLHBKK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 20:10:10 -0500
Subject: Re: [GIT PULL] xfs: fixes for 5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575767410;
        bh=I4OGha+3VAVrD9SnMMu1BsMjvSHuArMUfrX2VbVnTJU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=eAzLKoiXtJ2tOCAN65wn+PT/oujSVxG/Wz5pCgib3VM3C6wnpIH99YpYiRFLE5SA9
         i5yptHdlcm1YlfLA3UA/M7dyxAYMPpwFfmPnTYSslfi3F066r14wIEFfhrrB9ovrk1
         TiwCLGR5z0S3oCe2udocxL0V2hqBjhzEXvC+75YQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191206195142.GA9464@magnolia>
References: <20191206195142.GA9464@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191206195142.GA9464@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.5-merge-17
X-PR-Tracked-Commit-Id: 798a9cada4694ca8d970259f216cec47e675bfd5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50caca9d7f633bb2aad7f979c40db01a4811abcd
Message-Id: <157576741020.7292.7819954603059504247.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 01:10:10 +0000
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

The pull request you sent on Fri, 6 Dec 2019 11:51:42 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.5-merge-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50caca9d7f633bb2aad7f979c40db01a4811abcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
