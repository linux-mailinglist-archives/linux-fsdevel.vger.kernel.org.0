Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A65029B604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 20:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbfHWSAD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 14:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388081AbfHWSAD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 14:00:03 -0400
Subject: Re: [GIT PULL] xfs: fixes for 5.3-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566583202;
        bh=9zVW5Yk668xQEC2olWzJtm5tuua0+bS6EI+R3XCsOmk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rczOryyI1KRAthWWeQFwSk76y5X0I2W4iBJfDnAy2Asp6qDKtALLHsHzm6cghmxUR
         Zf+qQIr3V58Rs1U8v43kuECBZzdvcmz/G/Pm3RrkjCLW22yUfNZfIXwHhNcWi4rhYH
         h7i3w31mox1yDpRaw/lMWMibM0gN0VStjUXcZD+8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190823163439.GL1037350@magnolia>
References: <20190823163439.GL1037350@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190823163439.GL1037350@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.3-fixes-4
X-PR-Tracked-Commit-Id: b68271609c4f16a79eae8069933f64345afcf888
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f576518c9ab5a6fbc7a4b9bbfc9be31aa18a1cc7
Message-Id: <156658320245.8315.16229472322057905698.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Aug 2019 18:00:02 +0000
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 23 Aug 2019 09:34:39 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-fixes-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f576518c9ab5a6fbc7a4b9bbfc9be31aa18a1cc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
