Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6A54688DE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Dec 2021 02:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhLEBba (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 20:31:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36128 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhLEBb3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 20:31:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5680DB80D40;
        Sun,  5 Dec 2021 01:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3BE2C341C0;
        Sun,  5 Dec 2021 01:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638667681;
        bh=x/fGfUY2oNx8jHFZm5dAp1OimT43bokcJgnNjwjavi4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T/M9tDnUIHJJ60Ydd5tYm/7fJo4FQQK1VTEh07RMGTxg0Ya0eIRXxG5D9LX76IMOe
         C344sE2kHfOj8dEKna6dy+svoNu2wgvQMBHRmgW7N7UW86jwxcWFlJg2egzfDjIVh7
         pZwUvqcFmwK/AulvG7udR0EEdVIPFM7YqhVkZmoktcXrymc0TT5nqkHgJrW9PggDYy
         uodKOd6xBIElh+cloNWemCET12BZJBZSwfYNNTLRXwYdTeDPLjliVrLcwfXlPka0ez
         RHsCm1jdsRRv7+iyDYeqW0aeBc8VE7yR4W/9CENgH/d3dff9X/AC7b8zDPvD61gceX
         09RAJ27PFWBow==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C2F5A60A7E;
        Sun,  5 Dec 2021 01:28:00 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211204235020.GO8467@magnolia>
References: <20211204235020.GO8467@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211204235020.GO8467@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-2
X-PR-Tracked-Commit-Id: e445976537ad139162980bee015b7364e5b64fff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79a72162048e42a677bc7336a9f5d86fc3ff9558
Message-Id: <163866768073.6146.4028609779231917827.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Dec 2021 01:28:00 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 4 Dec 2021 15:50:20 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79a72162048e42a677bc7336a9f5d86fc3ff9558

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
