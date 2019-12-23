Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6490712908E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 02:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfLWBFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 20:05:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfLWBFD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:05:03 -0500
Subject: Re: [git pull] vfs.git assorted fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577063103;
        bh=aR8HgMr9sVfdM1sinAHswE6Al8jS5kKjmYHCO+5blso=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ftFj2oo9hIx4X7aefxLIIvEs22eHiJ5NuXoOhi886iYTi7vCKV6/54M64ehI0XNsq
         aLRMiwjoiVnLQNx4VYjGs3N7u2WLff8MJtRd+cWjL9FQ6bQ+JR6GNNgzn3b9SNHNo8
         fOXYuUEG7t1u20YUixKTg1yLoROa2ebhq/vq/MT8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191222232304.GN4203@ZenIV.linux.org.uk>
References: <20191222232304.GN4203@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191222232304.GN4203@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 1edc8eb2e93130e36ac74ac9c80913815a57d413
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9efa3ed504edb1c1fc88dba96fd32168f50ab77c
Message-Id: <157706310320.12683.17468967300222566381.pr-tracker-bot@kernel.org>
Date:   Mon, 23 Dec 2019 01:05:03 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 22 Dec 2019 23:23:04 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9efa3ed504edb1c1fc88dba96fd32168f50ab77c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
