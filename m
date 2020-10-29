Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B8829F34A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 18:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgJ2Rbn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 13:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgJ2Rbn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:31:43 -0400
Subject: Re: [GIT PULL] afs fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603992702;
        bh=fEMErob+rsYf9z7pCz+9TVHQd41F49Pz7IHjl6KfzdQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=bd++f6psbBTvP2adGa2+indshUjpTrrkkKsO07xnCO9/R9VRZSkxcd1ArwCAv0PlC
         B6hoWVvOgGKUi7tUAj5WWmuEIzX/8eHB3iwYb8UeAagZAhCLkElpXlGM2ckynOuPMB
         FMkl6V/s3xzifGyqQiNFj/qxwww43kKQLcL2nQNw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1130576.1603980446@warthog.procyon.org.uk>
References: <1130576.1603980446@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1130576.1603980446@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20201029
X-PR-Tracked-Commit-Id: 2d9900f26ad61e63a34f239bc76c80d2f8a6ff41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 598a597636f8618a0520fd3ccefedaed9e4709b0
Message-Id: <160399270289.15179.7546166158882275774.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Oct 2020 17:31:42 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nick Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        kernel test robot <lkp@intel.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 29 Oct 2020 14:07:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20201029

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/598a597636f8618a0520fd3ccefedaed9e4709b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
