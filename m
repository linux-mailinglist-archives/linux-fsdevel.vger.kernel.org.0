Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340F220A67F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 22:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436501AbgFYUPD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 16:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436497AbgFYUPD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:15:03 -0400
Subject: Re: [GIT PULL] fsnotify speedup for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593116102;
        bh=QpQpxbqKYxf/mIIwNoqd0ArngEYbI5IWcpFzDL2hfGw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=G0TD1tcSQA9zu4zmP1KncvTWEGRvmzIIzTftKOghezzxWPO/XEzWRrgiJBkYZYFUG
         j2ZJf9/pMOv4fimCegtFHKQqfkQ/mQQnCMZBlfLpIunINHqnnB8qijhlr6ZZtzBRmY
         tXB63tt695dql5f8NOiUA0zT6KwqYJbymaN88MqE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200625181948.GF17788@quack2.suse.cz>
References: <20200625181948.GF17788@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200625181948.GF17788@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fsnotify_for_v5.8-rc3
X-PR-Tracked-Commit-Id: e9c15badbb7b20ccdbadf5da14e0a68fbad51015
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 52366a107bf0600cf366f5ff3ea1f147b285e41f
Message-Id: <159311610290.12359.18198266268070363749.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jun 2020 20:15:02 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 25 Jun 2020 20:19:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.8-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/52366a107bf0600cf366f5ff3ea1f147b285e41f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
