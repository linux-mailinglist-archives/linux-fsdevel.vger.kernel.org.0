Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396672AACD0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Nov 2020 19:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKHS3e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgKHS3d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:33 -0500
Subject: Re: [GIT PULL] xfs: fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860173;
        bh=THFqTXAA4yMHALpHIc6pZ3ddHFYaIDzAq6L1GIC3lJk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=W4F7xIT6oUJpC5XXSHF+KvtpcON62T9VGLD+yU5JMXaoytk6apY5ADnpECl6fS7fT
         lphZOFMdAvd8BS901S1TBr2OvU4PjRD72Rgae8QtQ77OgsIi4P0BKsAgw632Ssg/5a
         c1RqLKgMaQaRG1BPl/f4ur1P7RqchYLheU4yXo7U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201108172235.GA9695@magnolia>
References: <20201108172235.GA9695@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201108172235.GA9695@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-3
X-PR-Tracked-Commit-Id: 46afb0628b86347933b16ac966655f74eab65c8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dbc1c03eeb534b82647cccb059aca0685d449a7
Message-Id: <160486017351.13369.1949013647647886765.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:33 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sun, 8 Nov 2020 09:22:35 -0800:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.10-fixes-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dbc1c03eeb534b82647cccb059aca0685d449a7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
