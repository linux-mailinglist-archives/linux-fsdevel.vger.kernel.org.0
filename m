Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9FB7145
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 03:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbfISBzE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 21:55:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387646AbfISBzE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:55:04 -0400
Subject: Re: [GIT PULL] overlayfs fixes for 5.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568858103;
        bh=uXZzj2pg548bMMX/96A4seX+x2dG50apH1oXnvBUQac=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Qhj398OSJ3DrJX0FkcRsDixbx5DpRq80P2Hsh5mOPkFLLK+KLbKltKbkGCZHRfBEV
         Ua40/dGvuuQX8KH10FKFvWIih12EF26ysGMQ28pAktCuMo8F+4/tWsNnbeNabqNisE
         bdcczYiOu4nL0/2GimUWLYAMxC+OFdN+WRgfls9s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917083135.GA19549@miu.piliscsaba.redhat.com>
References: <20190917083135.GA19549@miu.piliscsaba.redhat.com>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917083135.GA19549@miu.piliscsaba.redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git
 tags/ovl-fixes-5.3
X-PR-Tracked-Commit-Id: 5c2e9f346b815841f9bed6029ebcb06415caf640
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6c0d35772468173b5d3a7f6162079611e68a1e8
Message-Id: <156885810360.31089.4574667261875615828.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 01:55:03 +0000
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 17 Sep 2019 10:31:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-5.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6c0d35772468173b5d3a7f6162079611e68a1e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
