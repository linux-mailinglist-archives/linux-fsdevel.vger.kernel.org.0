Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106AD243F76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMTrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 15:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMTrQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:47:16 -0400
Subject: Re: [GIT PULL] xfs: small fixes for 5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597348036;
        bh=vL0TQpwe3Znt0DCJf/5W/eGvAGLnfTNV1hDhp2Dib9U=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=db7WFkktX/FcTNC7t9tOJeq470KonxWcBbl26H09MJYEgoe7fDCpcXAmcyAjpNbB5
         qt46osmSBOdEEqSdkD+MnO7F1DXZSeqs6khhTf6/tn+bSH8ObE2RDfEA+hHE2drqN9
         4TJ/+0+Uz/I5pHaMOM9HbDkKmJP90VKgV0j/Rdks=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200813021624.GH6096@magnolia>
References: <20200813021624.GH6096@magnolia>
X-PR-Tracked-List-Id: <linux-xfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200813021624.GH6096@magnolia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.9-merge-8
X-PR-Tracked-Commit-Id: 96cf2a2c75567ff56195fe3126d497a2e7e4379f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69307ade14de7d9e9b14961ae7a6168e7165b6ab
Message-Id: <159734803613.27850.16512962923874411071.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Aug 2020 19:47:16 +0000
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

The pull request you sent on Wed, 12 Aug 2020 19:16:24 -0700:

> git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.9-merge-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69307ade14de7d9e9b14961ae7a6168e7165b6ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
