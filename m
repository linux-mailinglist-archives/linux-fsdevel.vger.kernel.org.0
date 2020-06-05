Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AC61F03A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 01:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgFEXuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 19:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728441AbgFEXuD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 19:50:03 -0400
Subject: Re: [GIT PULL] afs: Improvements for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591401003;
        bh=h0dhn9foy0oHVA9lAWRv6a28GFTGZK6615/30Nc0DcY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zc2VosVc5lbf2pyLupUAZhcn6FFli1byPX4c4hPU05z7P4x6WqXS2/jg5XBhROT0x
         k9t62ceWhFsQ55OKBVtFfvN8OHjFUf9D8//6/10jz+q/MSwu6fc0XTat5Kow3RWESD
         vaQbLX1rqUrRlWPYSgj/8n5l5P9vEJxcfAqwrkhI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <2240660.1591289899@warthog.procyon.org.uk>
References: <2240660.1591289899@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2240660.1591289899@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
 tags/afs-next-20200604
X-PR-Tracked-Commit-Id: 8409f67b6437c4b327ee95a71081b9c7bfee0b00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9daa0a27a0bce6596be287fb1df372ff80bb1087
Message-Id: <159140100342.11239.8868355253372056432.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 23:50:03 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Thu, 04 Jun 2020 17:58:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-next-20200604

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9daa0a27a0bce6596be287fb1df372ff80bb1087

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
