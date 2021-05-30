Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D88BE394F58
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 May 2021 06:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhE3Ebq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 May 2021 00:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhE3Ebl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 May 2021 00:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 54FCE611BD;
        Sun, 30 May 2021 04:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622349004;
        bh=rpxVla88WVhf02GRKeclOnXI97fBdoOIco0e3nhhjEU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VxFnbaLVykoMs3OcPd13Xj8pKMUsSsA/O9FsnPzAKnz5FFExdBhFkZpwhtb/DqQfd
         zIINTLmzuIcLDPM1vnDBcS5TFkbZFx5mxXAk0N2G6pAi9xFaiTEjso7xqDTRSy4XM7
         1KpRKYDg9+Fh3ez/hl+y265jlVM9BKa1rN8lLVlgXrVTg5kMyevLgLDsJRfSnf0T2y
         CWyEZNPuq+alvMT/eT7qlNc2+XQ0BzLKNpVeQBrOlIyEWdSVZSrxS/6HVc7yhCtrlU
         kMR9sYxfWGv1flfTS6e3LnGeXSV8cdjxpzTZBjrHlKhjtF4GYoIoovaqTpQlgnIZdt
         0KNjLZIO5NvuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4E0C4609D9;
        Sun, 30 May 2021 04:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210529171212.GQ2402049@locust>
References: <20210529171212.GQ2402049@locust>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210529171212.GQ2402049@locust>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-fixes-3
X-PR-Tracked-Commit-Id: 0fe0bbe00a6fb77adf75085b7d06b71a830dd6f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75b9c727afcccff7cbcf1fd14e5e967dd69bab75
Message-Id: <162234900431.23697.17510919033109580334.pr-tracker-bot@kernel.org>
Date:   Sun, 30 May 2021 04:30:04 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 29 May 2021 10:12:12 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.13-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75b9c727afcccff7cbcf1fd14e5e967dd69bab75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
