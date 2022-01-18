Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5753491EB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 05:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiARExP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 23:53:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53194 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbiARExJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:53:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C4CC61040
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 04:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B19E7C00446;
        Tue, 18 Jan 2022 04:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642481587;
        bh=m/4vkbbSH64CrD9BxnT8winA5R05gZ7kIIExw9tX6Tc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Eqzwf/yAK7mGX10WZxDLpNPKl0SPtDXhtI5f6c8jA14bKcbl/v1ComusbY9ONnp4z
         MdeJEtvT35gK25w2Ds4JlqzjJtQCVynT4+MKay3ctDyK84wEbhRDXPcp+pMn2zL3Gm
         WWiB/2H/nVBOQeTyvwocn1DLjlkbv2T0joXAe8yP9BcTgXfGr+6NZqRdQLKMLi7dEd
         w9PJJnNMzRYoCYrkDLarDmX2pjXLkd5PhVlu2+SByiOh4ahZmoz+CBNFOzsCDMLo6Q
         tLnPHZjZtVhxKTGEc9xEHnZqiBFdm9Ym+ABxwToRycnAsdrkHSLodW3A/v/9eE/jT4
         oH3TfY4UhXxTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6F40F60794;
        Tue, 18 Jan 2022 04:53:07 +0000 (UTC)
Subject: Re: [GIT PULL] orangefs: fixes for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAOg9mSQ6pvuOTOoTkzwwsYmrVLOO8kYrEJ0fOWDE+ewec_1Svg@mail.gmail.com>
References: <CAOg9mSQ6pvuOTOoTkzwwsYmrVLOO8kYrEJ0fOWDE+ewec_1Svg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAOg9mSQ6pvuOTOoTkzwwsYmrVLOO8kYrEJ0fOWDE+ewec_1Svg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.17-ofs-1
X-PR-Tracked-Commit-Id: 40a74870b2d1d3d44e13b3b73c6571dd34f5614d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0033681f0fe8421baf8db125e57fa6157824c2d
Message-Id: <164248158767.2547.1088690193352161071.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Jan 2022 04:53:07 +0000
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 17 Jan 2022 09:58:20 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git tags/for-linus-5.17-ofs-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0033681f0fe8421baf8db125e57fa6157824c2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
