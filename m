Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80484436C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Nov 2021 20:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhKBTzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Nov 2021 15:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhKBTzA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Nov 2021 15:55:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8AEF660F56;
        Tue,  2 Nov 2021 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635882745;
        bh=ethvcXAgw7hAXhV6rcxbmeIEGf0BDTarDxmil7yV9RQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kS9+Jxm6iAIV+kY7hAzPC3KysfZczc3HEAQ68wVbXVM3IxrXnDYuDAcViMT6wrd60
         KJLn0J19lYXJLO0wQWWovh4sC7976poerFU8fpPuFWpVoS97+N8+PmDHDSZm+xahdm
         iyX3Ih/KtaTFprJE2r9egCG8P2txe3JafnYYkjFBeUAUOYbn9ddezE+eXXwRmcud5g
         jqDevM0HkzPaZ+qM3L7op5VYYo2txsY7P1i/yIxCgCH70fIAxCO5F8EaBa62O9z4Gh
         /wyqgX9MLZUiKz8QlrCX1+I4NDUa23bmvV45YWxUlHz78ADFbjy4WTw6L+OgIdn3Eg
         FnGX7ViRC2GKQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7B75D60A90;
        Tue,  2 Nov 2021 19:52:25 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Split readpage and fix file creation mtime
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4096836.1635850852@warthog.procyon.org.uk>
References: <4096836.1635850852@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4096836.1635850852@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20211102
X-PR-Tracked-Commit-Id: 52af7105eceb311b96b3b7971a367f30a70de907
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a64a325bf6313aa5cde7ecd691927e92892d1b7f
Message-Id: <163588274544.22794.11941161138322676189.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 19:52:25 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 02 Nov 2021 11:00:52 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20211102

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a64a325bf6313aa5cde7ecd691927e92892d1b7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
