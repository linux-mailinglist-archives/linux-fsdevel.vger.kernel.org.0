Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7FC2930BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgJSVqC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 17:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbgJSVqB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:46:01 -0400
Subject: Re: [GIT PULL] fuse update for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603143960;
        bh=SZuHy5/vgSK+InrgCLMz3n32ExXEt7N9ScH0XO4jlKU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MdfHwlwK8S+7ZZdbEVjm8uRCfagE/M2C+lUd/ffAat///F1OXtgwo0T9d7ElwlWCS
         41Hiv30uVIdtWO/nwcdVE6DM5sm05nDJRm6yUNjkzl8i+zALW4HI4EtB+6HDQua7Vu
         5Gfnxzl80KmiCpMqF0b2tVLMKfzbIQHAI8jn+VZQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201019144846.GB327006@miu.piliscsaba.redhat.com>
References: <20201019144846.GB327006@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201019144846.GB327006@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.10
X-PR-Tracked-Commit-Id: 42d3e2d041f08d1f8f078da005c936648ba77405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 694565356c2e06224d94774a42709cc8dfab49ee
Message-Id: <160314396051.24665.12203737803931896119.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Oct 2020 21:46:00 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 19 Oct 2020 16:48:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/694565356c2e06224d94774a42709cc8dfab49ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
