Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A11EC7F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 05:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgFCDuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 23:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgFCDuE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:50:04 -0400
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591156203;
        bh=tNXEgKaclopa1HBy2MEvrGIRWP8U+3pE2GRVbQ+w28A=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pDTF1+leqLGubMgkjVnRGh2INl1NlTZO5eogbws52nMO315gJ2HnM46hoVORSqovy
         eZhIj3K7wPmi1mtkTBUEzp80LBalYVMipvmROc+0/wSMEKgfqHL4qVv4sncR22V/c4
         6v9orlMQ40pnMVsMT+0VIKONyObNpbSHgHRCemkU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200602165852.GB8230@magnolia>
References: <20200602165852.GB8230@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200602165852.GB8230@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/vfs-5.8-merge-1
X-PR-Tracked-Commit-Id: 83d9088659e8f113741bb197324bd9554d159657
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dae2f8ed7992e88c8d62c54e8295ffc8475b4a80
Message-Id: <159115620387.30123.11594287027052753733.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Jun 2020 03:50:03 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, ira.weiny@intel.com
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 2 Jun 2020 09:58:52 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/vfs-5.8-merge-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dae2f8ed7992e88c8d62c54e8295ffc8475b4a80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
