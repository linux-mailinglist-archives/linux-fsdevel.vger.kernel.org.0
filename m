Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3041F8501
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 21:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgFMTuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 15:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgFMTuE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:50:04 -0400
Subject: Re: [GIT PULL] 9p update for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592077803;
        bh=TLD8xFmWTGGIfcfYoHvl6FbeT6NluqOOwhP2GkGDUIQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=seZb+iCiR5/N2sRCWJ8UAZvHCKPgdvGPhAT1F1wdVlxRQ5HHJO/2cXNaICgIE0+gD
         /sX2QjVwsFE9N6H+iJtxVYBRZhPr3BYAXdU+xmry1rMSvjeJFBojRH0v0J5zgXnf2x
         TE+x75HKX2cZsqAsb2nvCs/KI3kXcKkZbtUQlGN8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200612221748.GA5666@nautica>
References: <20200612221748.GA5666@nautica>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200612221748.GA5666@nautica>
X-PR-Tracked-Remote: https://github.com/martinetd/linux tags/9p-for-5.8
X-PR-Tracked-Commit-Id: 36f9967531da27ff8cc6f005d93760b578baffb9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61f3e825bec7364790cb7d193a9a156c46119cff
Message-Id: <159207780367.22916.12178095841307999537.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 19:50:03 +0000
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 13 Jun 2020 00:17:48 +0200:

> https://github.com/martinetd/linux tags/9p-for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61f3e825bec7364790cb7d193a9a156c46119cff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
