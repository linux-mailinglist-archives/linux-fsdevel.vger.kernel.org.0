Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8592D48CF63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 00:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbiALXuF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 18:50:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59124 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiALXtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:49:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0033C61B76
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 23:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69880C36AE5;
        Wed, 12 Jan 2022 23:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031372;
        bh=CuZ/1PNp+y11ANwVTu69Xi4XOh06J2dTI6nk4qEJ3wU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fiP6DMKYHWvc2LWHpeUinwJvIDbyvKwa+cfVEjntgOvier0czRS0x/qM7lgM5/WiU
         Cq8kgMVQm4pFIT5ime2OmItHv3m21TKQgVSPc22SZ8JPNP1mTn3MtMm08g1PPX67Vh
         IcE3IHdfqfGzhsdcKfB3JxY5P5/znm5PAqO6RlCpRaw95npLTk+Xw0ieBElxpGp09c
         Ha5S1pl/pcMnT3UXgw+vUBoEwHm8HNCQ3Ic64PCjqczC9+aso1HdIgWhzBrXg8nXZW
         lJIGQNpco8BqP7Smw66xFoloqZGrGpFizx6hWi+ND3Yb+uf2uiVhTt8pmFpQVjmG4i
         9I1xH88pNYNXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58AD2F6078C;
        Wed, 12 Jan 2022 23:49:32 +0000 (UTC)
Subject: Re: [GIT PULL] UDF & reiserfs fixes for 5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220112084131.tqofmh4xfeh462br@quack3.lan>
References: <20220112084131.tqofmh4xfeh462br@quack3.lan>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220112084131.tqofmh4xfeh462br@quack3.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.17-rc1
X-PR-Tracked-Commit-Id: f05f2429eec60851b98bdde213de31dab697c01b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fb38c934c6e6fad1559f7fe22504b42b7110f8a
Message-Id: <164203137235.22460.936708518232227077.pr-tracker-bot@kernel.org>
Date:   Wed, 12 Jan 2022 23:49:32 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 12 Jan 2022 09:41:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fb38c934c6e6fad1559f7fe22504b42b7110f8a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
