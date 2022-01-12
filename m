Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FBE48BBA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 01:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347077AbiALANw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 19:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbiALANo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:13:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFCC06173F;
        Tue, 11 Jan 2022 16:13:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9360B61601;
        Wed, 12 Jan 2022 00:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02973C36AE9;
        Wed, 12 Jan 2022 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641946423;
        bh=pFaM72whbblgyzXUu+CqxGnKc8WUMN4KB2ZK64DF98Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MJir1g91jkHrqkGI+MaTGkFHnVF/LqxC7O9IuDFwRfXhuEtYLK2+0iQosYyrahMwc
         xirQtQ+cCyB0H2JtN5dDO5vN7FIhmGfj+UDCicpn/+qp7vHwvXvQcFI9achPNAmptj
         NQX+W4/CHmq4ednAUgmXMk4MeEY1iQR0koZaK+keqf+rCPTs/iiKI+OiV0aTO80Rd/
         ycafWWIoG9JKZRb0nSg/QhGkIoDdMTMEx9XZqm/p9os96lVlYpzoT5QhDfF5EP4r6I
         FUYlwnr5cgAmN1AInprTDoHF9Gebh+/isiCrrpwBsUEW7r1nnxrykPLdSwR/ofQxVp
         Al5ZmFqAOWjBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E509AF60793;
        Wed, 12 Jan 2022 00:13:42 +0000 (UTC)
Subject: Re: [GIT PULL] fs idmapping updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220110125600.440171-1-brauner@kernel.org>
References: <20220110125600.440171-1-brauner@kernel.org>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220110125600.440171-1-brauner@kernel.org>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.17
X-PR-Tracked-Commit-Id: bd303368b776eead1c29e6cdda82bde7128b82a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dfbfe71e32406f08480185d396d94cf7fc7a7d6
Message-Id: <164194642293.21161.8199371161904371749.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 00:13:42 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 13:56:00 +0100:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/fs.idmapped.v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dfbfe71e32406f08480185d396d94cf7fc7a7d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
