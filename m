Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD50248CF5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 00:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbiALXtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 18:49:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58990 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiALXtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:49:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478B961B8C;
        Wed, 12 Jan 2022 23:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABD5BC36AEC;
        Wed, 12 Jan 2022 23:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031359;
        bh=6LIOU8YFSzbKtOEIq3Eni0RCENIgNqvsOWfA8tRJcO0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p1dgzmulzPS/LrKCor7Kd78cQ0L2pSOE+UsIbXM4a4Q+0GomTVdIvjYyjUwBsk8IF
         4EgD4kxmaruxesutjh8fd2gWUwAlRQFZyb+5ZrXSjFweyZhZfXhQ4oSI2jXKyV6mzd
         Ti/F6nKiM1L0Avp5U/VQfilr0kEuiZrvLCajnkrOH3CS2Rp+6KoUJbEg4W+Tm7d8Kj
         Y2Ex9/z5AiSx75zTaQGIk+56oIPLYdJBOyxpILa7eQM9+Cz1hRma80XZtYWXBpMiTI
         Jp7v6cK95jdO8zpM0gFpVdMsJnis+l+x4Jl0/CvMYIww28qt13vFAkgP/IY7YujToV
         e751h4IlZRmgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99BD9F6078C;
        Wed, 12 Jan 2022 23:49:19 +0000 (UTC)
Subject: Re: [GIT PULL] DAX / LIBNVDIMM update for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4jWm57gAL_P2JiU1vm3-CaJwzRQsoNhh_A2C-Jh1trk+w@mail.gmail.com>
References: <CAPcyv4jWm57gAL_P2JiU1vm3-CaJwzRQsoNhh_A2C-Jh1trk+w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4jWm57gAL_P2JiU1vm3-CaJwzRQsoNhh_A2C-Jh1trk+w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.17
X-PR-Tracked-Commit-Id: 9e05e95ca8dae8de4a7a1645014e1bbd9c8a4dab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3acbdbf42e943d85174401357a6b6243479d4c76
Message-Id: <164203135961.22460.18259836821302118281.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 23:49:19 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-xfs <linux-xfs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 12:58:11 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3acbdbf42e943d85174401357a6b6243479d4c76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
