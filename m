Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA133C76DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 21:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhGMTUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 15:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhGMTUI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 15:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 80CFE61183;
        Tue, 13 Jul 2021 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626203838;
        bh=WVO04aJNM7JGpGtpTtM4WJVSo3sDuIPCHBiQZr6JPIc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VTRMmCAYNSbtPsHbPGHXQ9SMyAAMwca0vr5gS9jZ5gS4n3FOySjKvQ+J0ZHV01iE3
         cjRtSDL1JqfXLL/y9mjR0Efsy4EG14YCMTLgy7MStFGCXVMpdATwTVRMhBOoyXRTbl
         JA1GAPVo+N4V1UWuz5nhaQaulo1g/zJupAQpha8jCP12FH01aR5ZYICs1heODdsHv9
         A0VTSov5e55AeFekFzjZhNPRScf4LExRYnGoBvTTdc5MuO2yoablmoD8BfHesQLts7
         K1qJX/ZLq+ryY2tOsrLqHe9ZkBUoExR+K/2gP4FVRMWXHK/Fd6Hu59ht2BeuNC+PaD
         9KHJ9fXeOtZSA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7A40E609CD;
        Tue, 13 Jul 2021 19:17:18 +0000 (UTC)
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v5.14-1
X-PR-Tracked-Commit-Id: 52dfd86aa568e433b24357bb5fc725560f1e22d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40226a3d96ef8ab8980f032681c8bfd46d63874e
Message-Id: <162620383849.18788.16593954436474336431.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Jul 2021 19:17:18 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 13 Jul 2021 12:45:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git tags/vboxsf-v5.14-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40226a3d96ef8ab8980f032681c8bfd46d63874e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
