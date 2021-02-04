Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4253530FAF4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhBDSLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238380AbhBDSLf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:11:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1D46264E7B;
        Thu,  4 Feb 2021 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612462255;
        bh=SijOYe6Rzrcnoxk0Nt6Cd9PDA60+fzeqL9hEecQZtCE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oZFUwn4+w8dLM29Lv97wEyEak7dGec2AJU3ybIH2GRceh4wYIbimX506zKWuQK25U
         dK6PKXWsppbJj1uDs80HZfdmmiotDr3crAf1+aODVLEU/knsoYspXddGd2KcsnJM+Q
         ntwkjiJH5Uxti6+hHKGgOeT4uhyuSlPtpK77jzTjSD+Ojv7Gx5mjtr8fNJ1e17ob4k
         TfYLt6HfBGV76o37VRuIkeNgxLZRSIUV/QxUxBWX/I7fKGzYsDaNEOwPOh1PHHQkd0
         0nzAuoNRGBu1Lo4hFPBdjR6equoHJN/ROtT0LLQjE+owZJyKFuI82gX/sn2QnVSV+s
         2KYlTsNhN4t9A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 10F0D609EB;
        Thu,  4 Feb 2021 18:10:55 +0000 (UTC)
Subject: Re: [GIT PULL] overlayfs fixes for 5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210204091943.GA1208880@miu.piliscsaba.redhat.com>
References: <20210204091943.GA1208880@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210204091943.GA1208880@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.11-rc7
X-PR-Tracked-Commit-Id: 335d3fc57941e5c6164c69d439aec1cb7a800876
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cb2c00c43b3fe88b32f29df4f76da1b92c33224
Message-Id: <161246225500.14859.2607746918262523354.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Feb 2021 18:10:55 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 4 Feb 2021 10:19:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.11-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cb2c00c43b3fe88b32f29df4f76da1b92c33224

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
