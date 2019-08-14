Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5FF8E0D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2019 00:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbfHNWfC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 18:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbfHNWfC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:35:02 -0400
Subject: Re: [GIT PULL] afs: Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565822101;
        bh=FlnPkqgHy5T6T3OPFXc7nhSpwpi5ci6Jdc5n4cQTtpQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HHsKo1NEpfGB+Gn9JzGrxbObTriGKoIrYgqswSI8kfca6K+srVGP5XvswXcvnW0NO
         13uihYXFMyCNusYNmbuTsNmzRLtIaO27Ibe2uahyBb+9z1arTIScio5Itx3UZilKhM
         2mFFepY37At+Qh5w1Jc3WKIYSD/hQCvtNmQCXVx4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <13851.1565792320@warthog.procyon.org.uk>
References: <13851.1565792320@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <13851.1565792320@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-fixes-20190814
X-PR-Tracked-Commit-Id: 9dd0b82ef530cdfe805c9f7079c99e104be59a14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e22a97a2a85d2a0bdfb134cbbc7ff856ae67edba
Message-Id: <156582210191.11528.8553610434794038321.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Aug 2019 22:35:01 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        marc.dionne@auristor.com, baijiaju1990@gmail.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Wed, 14 Aug 2019 15:18:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20190814

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e22a97a2a85d2a0bdfb134cbbc7ff856ae67edba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
