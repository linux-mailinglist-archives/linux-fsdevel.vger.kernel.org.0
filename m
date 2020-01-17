Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1D96140F3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 17:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQQpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 11:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgAQQpC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:45:02 -0500
Subject: Re: [GIT PULL] fuse fix for 5.5-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579279502;
        bh=fVE+0N0oojmzHgj1pK+YMOh+N14ezNYscrWVCJbH5Z8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b4UmKhRgLBtOjcfBo94Dwi3Nh0xLbjvkoQa+yWUuEwn85lSFuGpbMEWHRNeC0EQAC
         aPUaORT5ALKEnrBJclXrkjDYxpebgyrjthFj251FS0zpnmhxq/mqLveqy9lCkYBAAB
         AW1hH104ow3ttrC10B9xRCZhIPcbgaquaQGNG9IU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
References: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200117123243.GA14341@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 tags/fuse-fixes-5.5-rc7
X-PR-Tracked-Commit-Id: 7df1e988c723a066754090b22d047c3225342152
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab7541c3addd344939e76d0636da0048ce24f2db
Message-Id: <157927950223.32282.1633384377186078257.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jan 2020 16:45:02 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Jan 2020 13:32:43 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-5.5-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab7541c3addd344939e76d0636da0048ce24f2db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
