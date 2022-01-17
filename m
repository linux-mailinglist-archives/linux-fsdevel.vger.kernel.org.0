Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7840C490114
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 06:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiAQFSw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 00:18:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:44116 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiAQFSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:18:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D617B80D94;
        Mon, 17 Jan 2022 05:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03800C36AED;
        Mon, 17 Jan 2022 05:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642396729;
        bh=NoAkdTtev+HNuPcLbeSn9K4A3H/YPjNlqwRima0N01E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kzfy9X25ngGdKl5mucevDwJknh+BBMoe06E/RgWZijQh4p0XOMKZ/Kt9o8YKTBRvY
         PXuzJpNnj8YaTYHZiTysAxxtBvfCHFcxGwQyA6EsVQb8JVG02Zbg5qKtVDF1pGw76F
         Koycen+JjohRUqg+ULyvB1T108JluOB2BTQjx6KGdww6nIZIShmMFMSH628bJYkagl
         JzSmuKJRjJgAHZ8ojAU2EZCu/81rnJHTDspIEgDEvVI830PD1/Yxe2Q/zyyGGCjAYb
         qpd6qXe2tpiWaIOWVyZVGDxwI+Le5gEGEylQ3dyOXV31aDrIF/Ycg6+LdM6+SYGN2c
         q5R2x+FzOl6nQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E5D3CF60799;
        Mon, 17 Jan 2022 05:18:48 +0000 (UTC)
Subject: Re: [GIT PULL] unicode patches for 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87a6g11zq9.fsf@collabora.com>
References: <87a6g11zq9.fsf@collabora.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87a6g11zq9.fsf@collabora.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-5.17
X-PR-Tracked-Commit-Id: e2a58d2d3416aceeae63dfc7bf680dd390ff331d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6661224e66f03706daea8e27714436851cf01731
Message-Id: <164239672893.10913.18407387537720759248.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Jan 2022 05:18:48 +0000
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, hch@lst.de,
        chao@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 20:58:54 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-for-next-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6661224e66f03706daea8e27714436851cf01731

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
