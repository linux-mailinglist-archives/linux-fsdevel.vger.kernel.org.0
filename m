Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B10F011600C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2019 02:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfLHBKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 20:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfLHBKG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 20:10:06 -0500
Subject: Re: [GIT PULL] nfsd change for 5.5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575767405;
        bh=+aXi0y29sp+1fBUlwrX8MFWtBjL3VzO0IV0Gwhgi9NI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Yzy4jxFJrXDRE6AfsKrACVKzSZhGu4NEVTQyRAFXLfDmAz51O1Qr38GZ4+J9WEN5n
         iJC7AUhY4RquLfIkXAbALl8naTBPeX0UV+/E2RqmrpARyIKmQt+YGZwbosR5mGhTAs
         /Y9yfP66tMT/lpImMMblcZKHpcPdG/KO2mb6uZ+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191207171402.GA24017@fieldses.org>
References: <20191207171402.GA24017@fieldses.org>
X-PR-Tracked-List-Id: <linux-nfs.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191207171402.GA24017@fieldses.org>
X-PR-Tracked-Remote: git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.5
X-PR-Tracked-Commit-Id: 38a2204f5298620e8a1c3b1dc7b831425106dbc0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 911d137ab027e6dac03695bfe71702e64b6aa161
Message-Id: <157576740563.7292.8729033731998452747.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Dec 2019 01:10:05 +0000
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Sat, 7 Dec 2019 12:14:02 -0500:

> git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/911d137ab027e6dac03695bfe71702e64b6aa161

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
