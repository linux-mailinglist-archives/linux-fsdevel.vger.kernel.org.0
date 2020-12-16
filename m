Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D852A2DB9C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 04:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgLPDpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 22:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLPDpb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:45:31 -0500
Subject: Re: [GIT PULL] exec fixes for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090253;
        bh=QytAumS65RD1XJRcPCbdnHPnbErfLwbpcEp50UY8hl4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A9SEzPvmQOzPb1Xz/tGuYduLjjN8E9tfFj/lIPQTh6kzrR45Yj2TBbrpbsWU0KCc9
         sSjUpGUA8NIa/blFqwNV/2v3wpyjU+zZ0F9wF6Lw0ew0OMCF3EQ2YJLA/2uhTMe0a1
         B+3oTQ5Lt+PH8c08pSvghOGNLmbTopT9zA/86JF6MT0WUFScga4ernh8lm/cW2xaTz
         rJ13eK5DvKrpvZ9wR0g2yAEOpD3cnkpCXa4Bx+Zzq5gDPht/DVOdIiq4FVv5N00SoH
         EwO0M/eO5xKTkcAb5vkVOAjQLog8iXmwk8q4p+CxKE+zemXpMa80dFR9FRzcIC4CIr
         UM5+bAxIC6OsQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rfqad5g.fsf@x220.int.ebiederm.org>
References: <871rfqad5g.fsf@x220.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871rfqad5g.fsf@x220.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-for-v5.11
X-PR-Tracked-Commit-Id: 9ee1206dcfb9d56503c0de9f8320f7b29c795867
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: faf145d6f3f3d6f2c066f65602ba9d0a03106915
Message-Id: <160809025361.9893.8363263679895919837.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:13 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 16:59:55 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-for-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/faf145d6f3f3d6f2c066f65602ba9d0a03106915

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
