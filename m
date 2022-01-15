Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FCF48F54B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jan 2022 06:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiAOFyU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Jan 2022 00:54:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37508 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiAOFyT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Jan 2022 00:54:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 629ADB8267E;
        Sat, 15 Jan 2022 05:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34B5CC36AE3;
        Sat, 15 Jan 2022 05:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642226057;
        bh=tPK6A+KAurLSbT04ZK/PwxUXvru4+gqg5l3FBa2AjM8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uyVU3cP9c0s196Cs1rV0uoVgrtEc7GjMH9xaSFiOQcXMcX1TV1zuiKltnVUpHTrVO
         TMnhgL2WUHH0ZwWHgUGb8smnwWP4HeNNImK8ntPv/ToH2O/FlRw4gPmlSQdXjHWViz
         nR6x9hNTFYwkSqamvk6aYrJwQlp256T/r8c8GfHyJ9t2BhDz1/q+Z5ri/XHfllfH8p
         I9nFPliJdMiH4Vm+vyB22iBtrQ/9cK8LmFuZYzuRfz5Rzb5x25bZQtjmxyiMk2g3XA
         KPeqYZ6NKxqZcz8xxNCnATsGBxTL9PH1XNu5Hn/mXynPwX98/BajFQ2d98MV19/WtL
         VmYHKjR7v6nPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22694F6078E;
        Sat, 15 Jan 2022 05:54:17 +0000 (UTC)
Subject: Re: Re: [GIT PULL] xfs: new code for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220115041712.GD90423@magnolia>
References: <20220110220615.GA656707@magnolia> <20220115041712.GD90423@magnolia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220115041712.GD90423@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-3
X-PR-Tracked-Commit-Id: 4a9bca86806fa6fc4fbccf050c1bd36a4778948a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a33f5c380c4bd3fa5278d690421b72052456d9fe
Message-Id: <164222605713.3683.14066920600931696273.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jan 2022 05:54:17 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 14 Jan 2022 20:17:12 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.17-merge-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a33f5c380c4bd3fa5278d690421b72052456d9fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
