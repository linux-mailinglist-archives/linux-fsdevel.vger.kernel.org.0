Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70E8460194
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Nov 2021 22:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356279AbhK0VI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Nov 2021 16:08:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48916 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhK0VG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:06:27 -0500
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C6AB60F1A;
        Sat, 27 Nov 2021 21:03:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id E77B260230;
        Sat, 27 Nov 2021 21:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638046991;
        bh=WARZ0x0eASHQpFWRjb73JcBkMXgwfCp5XhgO0AzLT+Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GrNThQNidVM+gkexe9J2/7WKN2ed+B3gaELO6BgP3G5/K43jENq9jNReGSIgRS618
         iXBgZar2/kGsVOKNobWzdZyG9J+i/2Ie08o8hV8h8UPOidS5PVURL9TlyXFsRVlR7p
         ei7ys/QjvzgIQvWrfXrY6dOMSA4DTKIXrIbjhO+FnFLcBf2/c9DTJTxmeX9zAunIND
         RLpBh8mS6YJHPDKy9zcovPBXrIHg3+/kr0/mCg5WPE7cxMwsOLgroAYAfhy3vBTHVB
         NJUkoAAbRec5yupafxnDzKaW9OSBpnR1O1HDLZHeavSVfRF0AavRs4P05TxQjSJ4C9
         wuu+fU/jWQzUw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DC45B609D2;
        Sat, 27 Nov 2021 21:03:11 +0000 (UTC)
Subject: Re: [GIT PULL] xfs: bug fixes for 5.16-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211127200606.GB8467@magnolia>
References: <20211127200606.GB8467@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211127200606.GB8467@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-1
X-PR-Tracked-Commit-Id: 1090427bf18f9835b3ccbd36edf43f2509444e27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f0dda359c4563cbb1b0f97b0dbbcdc553156541
Message-Id: <163804699189.3764.12554584751673448384.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Nov 2021 21:03:11 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 27 Nov 2021 12:06:06 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.16-fixes-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f0dda359c4563cbb1b0f97b0dbbcdc553156541

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
