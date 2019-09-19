Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1061B714B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 03:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbfISBzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 21:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388321AbfISBzG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:55:06 -0400
Subject: Re: [GIT PULL] xfs: new code for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568858105;
        bh=LbMVLdUCXbbx37Bu36ETeHsP+708Gt4fU3nELNvNIp0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IjrXlO8ylHdqtP5hgQISjkTTwq02rFDZYnsU2Ht6nfBzuezutoGyGilmpnfPbmLBZ
         wgAyMch2VdXMMQUFm9ZQJlR7CQT/8nF6vZNB4ybcXNTrVBVoF2i0hlLU0jxOovRIKW
         x8J+h97F70sGrUkCZl4i/8beDmkYiMvd+7VP89Cg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190917171645.GZ568270@magnolia>
References: <20190917171645.GZ568270@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190917171645.GZ568270@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.4-merge-7
X-PR-Tracked-Commit-Id: 14e15f1bcd738dc13dd7c1e78e4800e8bc577980
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b41dae061bbd722b9d7fa828f35d22035b218e18
Message-Id: <156885810581.31089.14155971480176458867.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 01:55:05 +0000
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

The pull request you sent on Tue, 17 Sep 2019 10:16:45 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.4-merge-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b41dae061bbd722b9d7fa828f35d22035b218e18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
