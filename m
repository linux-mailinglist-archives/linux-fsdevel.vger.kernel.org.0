Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C436CC1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 22:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbhD0UId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 16:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235440AbhD0UI0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 16:08:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DE76A613CA;
        Tue, 27 Apr 2021 20:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619554061;
        bh=/gHae1ohK50bbuTiSYQqx6MW8RDhHlCG9X2gqdC9nrY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LBwAeL+xWjRms6CgIk7Iyk51mA3xdtp64a+YkLxRBIav8voqWqVfTf0DzdJBXeeNI
         UnNEw7uBii/GewezOdzpWNRW77EAX9pCAc7Po24rtrsj/vlnWZR0q4dzQ3bqfUVWkt
         Dmf7JrzYD940WXblSk3uzXzS1X84uIJMBa9YDlbTUczsy4WnJLKHifBnjoMxElKq35
         J3Qg0wubCIVe2PBEZoRCXPRtMRX5qXfMjghSFsnGdrgAjNcbMCV1LiTEqh5R+Fr9fJ
         riYmeTjUGUaaL65erQiDs+uAcF9IljIp+3vffP9mZn8+kRx5I0aA8+gaZ2kzDWv+R9
         h4JmsWpQ407VQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D3897609CC;
        Tue, 27 Apr 2021 20:07:41 +0000 (UTC)
Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210427025805.GD3122264@magnolia>
References: <20210427025805.GD3122264@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210427025805.GD3122264@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.13-merge-2
X-PR-Tracked-Commit-Id: ad89b66cbad18ca146cbc75f64706d4ca6635973
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b34b95ebbba9a10257e3a2c9b2ba4119cb345dc3
Message-Id: <161955406180.17333.16753327403378209092.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Apr 2021 20:07:41 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 26 Apr 2021 19:58:05 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/iomap-5.13-merge-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b34b95ebbba9a10257e3a2c9b2ba4119cb345dc3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
