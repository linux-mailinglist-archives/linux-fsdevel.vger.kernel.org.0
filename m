Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71EE29646A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369493AbgJVSFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 14:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900769AbgJVSFQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:05:16 -0400
Subject: Re: [GIT PULL] nfsd change for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389915;
        bh=YCO2OfNO8TxiTAo/+72JuIBhMv5Aczn6CjivR7xLJKA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=X34u577H9qgTfIro2N3JBwcAMSMNxuBgEDUvyiJcDC/lkXX4wlEcbQm/byjaNYSdQ
         l1xj4ErsoZ/7mspJVe8KWGcopwdeBBkSCQqfo0j/zui5eexfz5zmwvEYTavavZCwfo
         AiTJYyA0jRIs0dncDM6utvq4ca5yXxtnl1f9fC1k=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022020741.GA6074@fieldses.org>
References: <20201022020741.GA6074@fieldses.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022020741.GA6074@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10
X-PR-Tracked-Commit-Id: 0cfcd405e758ba1d277e58436fb32f06888c3e41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 24717cfbbbbfa415d1e3dca0f21c417e5faf8208
Message-Id: <160338991590.20886.4669008791743851331.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 18:05:15 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 21 Oct 2020 22:07:41 -0400:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/24717cfbbbbfa415d1e3dca0f21c417e5faf8208

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
