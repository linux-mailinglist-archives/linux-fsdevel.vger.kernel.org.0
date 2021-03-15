Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7B33CA24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 00:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhCOXsW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 19:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhCOXr4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 19:47:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 348AE64DE7;
        Mon, 15 Mar 2021 23:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615852076;
        bh=TDQmUPGjbIzI1VQfs60wShG8S5Mn32Zls1wgiUNuMc8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vA3ECrtEccKDm1J27SjuvIy3SLJuOvf3imDXQwmwmuY1rzex5QxQj8vV1orNEvRYW
         XJAAs7EENwkXy/pMg0q3N83KIi9NY01jHNdp9jAaZBn17LnWWEQkANR0vXn6wqm0eZ
         fuE0XBgCs/dDjcYScakN1DFBsmjismIX7qfmjCZKjlINPhp/qFuEwXSz1tmGzKWCkD
         MvrfIeSPDJYwzvMVI9vMLYv36cm6h7C4JRFCc0mbbSNOYt0nhgj6O49QRf40GLESSl
         m5IWf/7HteCZe6Tw06wL0ld2ELyU9JUN3hdzsms/qBzZi0i0pWepy5j9VD4jNLzsWv
         qPHl6/mD52wgg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 25A2E609C5;
        Mon, 15 Mar 2021 23:47:56 +0000 (UTC)
Subject: Re: [GIT PULL] afs: Fix oops and confusion from metadata xattrs
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2932437.1615829093@warthog.procyon.org.uk>
References: <2932437.1615829093@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2932437.1615829093@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20210315
X-PR-Tracked-Commit-Id: a7889c6320b9200e3fe415238f546db677310fa9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a4431a5db2bf800c647ee0ed87f2727b8d6c29c
Message-Id: <161585207609.24330.2264312771113306180.pr-tracker-bot@kernel.org>
Date:   Mon, 15 Mar 2021 23:47:56 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Gaja Sophie Peters <gaja.peters@math.uni-hamburg.de>,
        Jeffrey Altman <jaltman@auristor.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Mon, 15 Mar 2021 17:24:53 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20210315

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a4431a5db2bf800c647ee0ed87f2727b8d6c29c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
