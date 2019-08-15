Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED00A8F4F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 21:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbfHOTpD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Aug 2019 15:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730406AbfHOTpD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Aug 2019 15:45:03 -0400
Subject: Re: [GIT PULL] xfs: fixes for 5.3-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565898302;
        bh=to1hUdVUSbeaMquXC+F9EI+rjV4vn9hUe3HUOhk280I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R0u0aVFR+d8jd29IlC7i0ow+254Xk+aC1wqpBZbkw2jJJKDdMlk0xajsQWvSvhSDd
         ajiWklUd+xPPzmlSQb88QO3N79m+mEF6WtOQ+MKw6MYhYgrih3Z8FJ5P4Y52GiGTCy
         mi3vbX9S1jYHtqdxFCwnRASq3IzdWv4Lj3LpuCvg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190815171347.GD15186@magnolia>
References: <20190815171347.GD15186@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190815171347.GD15186@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.3-fixes-2
X-PR-Tracked-Commit-Id: 8612de3f7ba6e900465e340516b8313806d27b2d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a69e90512d9def6bd8064d84cff9ffd8b15eaa1b
Message-Id: <156589830195.13301.9419620703978124542.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Aug 2019 19:45:01 +0000
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

The pull request you sent on Thu, 15 Aug 2019 10:13:47 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a69e90512d9def6bd8064d84cff9ffd8b15eaa1b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
