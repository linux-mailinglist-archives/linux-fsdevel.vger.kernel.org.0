Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84FE22420A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgGQRkC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 13:40:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGQRkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:40:02 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595007601;
        bh=TH2Fb3gNyU4J9bGpnlHrZm7ZQjonUvKvpKhYXb7z+iw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qyxOFWYRbq1LFP6TYMPXucC2rEnDgF1GujjYgyejTK9Peas4UMK+aam+0waVEtT9Z
         3b6C0Q3GWgyQslsTJyB4qQNQ56FbV9b+dN9joOrLe2M4hvGn/I2vGJo/zGzqxgs4D+
         8QKL+WfhvLWVLG4atyPQkIDJIWdOwqPnwJZKf1WU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200717115237.GD6171@miu.piliscsaba.redhat.com>
References: <20200717115237.GD6171@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200717115237.GD6171@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.8-rc6
X-PR-Tracked-Commit-Id: 4518dfcf761e3c44632855abcf433236cf7ab6c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44fea37378bf735de63263d558763ce50fca05ef
Message-Id: <159500760166.14528.4179344717566879349.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jul 2020 17:40:01 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 17 Jul 2020 13:55:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44fea37378bf735de63263d558763ce50fca05ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
