Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E5B48CF66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 00:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiALXuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 18:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236140AbiALXuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:50:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AC8C061759;
        Wed, 12 Jan 2022 15:49:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F386B8218B;
        Wed, 12 Jan 2022 23:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A6C3C36AE5;
        Wed, 12 Jan 2022 23:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031367;
        bh=r7bUnBAI9wVW44XIK+WnHU9Lzj5DbTTAVysifMEKXNE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VdJ5EK5E8oU4YJE8T0iOJv9rBhGfb2vDEXIX8KOJJONDehGmg8VtgXhCSAjrk+IOZ
         RSksncFtgVgAw/J5HwawPYhleXJmx3GG3NpJEzVwS3yxKISDn8F8uVFPv6hN9Pzm2/
         qYj+dzth5XM5QUUuFXWr4484136akFBAaq8ETdYRx37GvrAFAjiPdu9JM6UbR8gQBv
         /SW3fMsPil2V9lTbdGYVZjkjhf6ue5XI2fj9dMPMhlzbeKdwLRedAx4WPOIO2eLGVZ
         4TFc7anM1lXn+yWAKO2WKXFJm+ebMv0ayNDvISAyFUbPkf/i2Ka+KOHa2HRy2aCv6C
         2TKISDXt6sprw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A69AF6078C;
        Wed, 12 Jan 2022 23:49:27 +0000 (UTC)
Subject: Re: [GIT PULL] fuse update for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yd71i1Yul3rPO2Lp@miu.piliscsaba.redhat.com>
References: <Yd71i1Yul3rPO2Lp@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yd71i1Yul3rPO2Lp@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.17
X-PR-Tracked-Commit-Id: 073c3ab6ae0123601b5378e8f49c7b8ec4625f32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8975f8974888b3cd25aa8cf9eba24edbb9230bb2
Message-Id: <164203136723.22460.16198679667354025783.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 23:49:27 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 16:36:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8975f8974888b3cd25aa8cf9eba24edbb9230bb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
