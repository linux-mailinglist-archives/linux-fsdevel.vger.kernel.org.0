Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C322561AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH1T6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 15:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgH1T6S (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:58:18 -0400
Subject: Re: [GIT PULL] Writeback fixes for 5.9-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598644697;
        bh=RfFySc37He0eyh0wXpTYR+cC119pcyZ11t9QOQDT1WQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rXv0Q3aMrcWYV4FO3Nz1dBceWNk5TT7PCEwmaV2LUMVuwa2B/DhwIEe8lxas73+o+
         P3wv01gEw2nJCxCpnLzXDNeeEyytVetI0gOu5IO9SHM/2vjcwWIBGTMHOB46UW01iF
         /ebAzSu3C0WhwRsEIFsQZ/J6E969a5O7s6y5lUbk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200828150355.GA4614@quack2.suse.cz>
References: <20200828150355.GA4614@quack2.suse.cz>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200828150355.GA4614@quack2.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git writeback_for_v5.9-rc3
X-PR-Tracked-Commit-Id: 5fcd57505c002efc5823a7355e21f48dd02d5a51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e30942859030199dab5ad73f95faac226133c639
Message-Id: <159864469772.31636.9926269443710679348.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Aug 2020 19:58:17 +0000
To:     Jan Kara <jack@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Fri, 28 Aug 2020 17:03:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git writeback_for_v5.9-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e30942859030199dab5ad73f95faac226133c639

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
