Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B65B7144
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 03:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfISBzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 21:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387646AbfISBzC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:55:02 -0400
Subject: Re: [GIT PULL afs: Development for 5.4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568858102;
        bh=h5EbUi2YKlgLrGkHKTD9u4kmqulfEU8Juz+gspWMpAI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IVXRkwvsFfkvut90JB27p/Stfm0ap1x5vP9IQDEWruOTSG3DvCxYaARNcA+WatC2K
         hP6+fqD9KtIN4e639gPMdmBuuUScBwXnBQ3Zj8HBmndIiHFsfzgCJ1eItBm385yn8U
         p5+dZA6iuyE3ME7TU1T5c3TIRo5DpaDFSmB94Ljs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <16147.1568632167@warthog.procyon.org.uk>
References: <16147.1568632167@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <16147.1568632167@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-next-20190915
X-PR-Tracked-Commit-Id: a0753c29004f4983e303abce019f29e183b1ee48
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0bb73e42f027db64054fff4c3b3203c1626b9dc1
Message-Id: <156885810200.31089.6710579917930332156.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Sep 2019 01:55:02 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        yuehaibing@huawei.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 16 Sep 2019 12:09:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20190915

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0bb73e42f027db64054fff4c3b3203c1626b9dc1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
