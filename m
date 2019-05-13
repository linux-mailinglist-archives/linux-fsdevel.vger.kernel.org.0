Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27B71BFA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEMWzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 May 2019 18:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfEMWzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 May 2019 18:55:03 -0400
Subject: Re: [GIT PULL] Quota, udf, ext2, and reiserfs cleanups for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557788103;
        bh=+hR6ia9HFzALUCR6KXkM8ufSPpS2K1TkCRtQLGt9Wc0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NBVu28pKqe3w2eenR8gHrkYVuFgcaDTeWC7Ce3MqnTEzZWxlNan08ZdJtYfdF33wZ
         l/RgNyDHTz6cP6n+k4RGkEFHm1PuMdzWyTov8om6bBs1UIifwX007pAAU9+0lpFTNp
         ySuDESrIA8QpgDOIYiTENDg3c9VzIfWPR6ZowBps=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190513161045.GB13297@quack2.suse.cz>
References: <20190513161045.GB13297@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190513161045.GB13297@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 fs_for_v5.2-rc1
X-PR-Tracked-Commit-Id: 632a9f3acd6687376cbb0b178df6048e19cbacc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 29c079caf584ad9a333c0d32292d036d1ae3205f
Message-Id: <155778810311.1812.10175858000352369492.pr-tracker-bot@kernel.org>
Date:   Mon, 13 May 2019 22:55:03 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 13 May 2019 18:10:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v5.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/29c079caf584ad9a333c0d32292d036d1ae3205f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
