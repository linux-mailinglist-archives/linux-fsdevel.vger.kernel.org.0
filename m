Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1619CB20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 22:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390214AbgDBUZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 16:25:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390187AbgDBUZH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:25:07 -0400
Subject: Re: [GIT PULL] xfs: new code for 5.7, part 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585859106;
        bh=crUtWhvJHcdPnFNX04wHX0bhEm1mI7LQJZoRuC7Rado=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AsP0XAAIInpgnMiEpgWIUdPiBLv7UW6r/egf7o1PZjgXWtMBrUEw4LZEicId7aoi0
         z+9iyRscqEhe9bbHoEGykKYculAQGplIq2FDA1bZ+SZOot6EoIxialEbTSfARJSXGd
         7dQTxYscgFL6t7ZPUwIJCimLGIaN9lQ+bIYBE790=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402164524.GJ80283@magnolia>
References: <20200402164524.GJ80283@magnolia>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402164524.GJ80283@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
 tags/xfs-5.7-merge-8
X-PR-Tracked-Commit-Id: 27fb5a72f50aa770dd38b0478c07acacef97e3e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7be97138e7276c71cc9ad1752dcb502d28f4400d
Message-Id: <158585910689.7195.12739446375744897811.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 20:25:06 +0000
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

The pull request you sent on Thu, 2 Apr 2020 09:45:24 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.7-merge-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7be97138e7276c71cc9ad1752dcb502d28f4400d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
