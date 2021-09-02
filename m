Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE6A3FF278
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbhIBRiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346740AbhIBRiS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5EA3561100;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630604239;
        bh=lOIInIIOXQJqRUQVg1Ez+aC9lKjwRaOyr1jAQeMM5WQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YsYA+cSNC/ZERZVf2i2FRMl0akHHGlc+fft71j7/32qayPivKtRsTpxeaJGrVxJBr
         muSjRmQJbUlaCMyAVsQkcAmzt7JYpymqO0D46g6lJ0LLvew4GxGEzBumPYJIhZgtM0
         LbpG8D+sNoJJ0UwH1NXobviAJoH/ybSwgBNpMg6XS0XQZMgt5p+vsq4/NcsjAcgRSG
         PQoyw0vr3b7RK7hOI4OxHTiW7RsztKsVPj17WTtedrefNjoXJzF7rPBTpdjdMZXooa
         6kSUlin8En5bEu807xyQHQu9mBLussq4b/Ibh/xLexZ25lkNt/JHZYRubX86+tmYFJ
         IKoIaTGqUyCwQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 552BE60982;
        Thu,  2 Sep 2021 17:37:19 +0000 (UTC)
Subject: Re: [GIT PULL] fscache: Fixes and rewrite preparation
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3282508.1630445914@warthog.procyon.org.uk>
References: <3282508.1630445914@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3282508.1630445914@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-next-20210829
X-PR-Tracked-Commit-Id: 20ec197bfa13c5b799fc9527790ea7b5374fc8f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89594c746b00d3755e0792a2407f0b557a30ef37
Message-Id: <163060423934.29568.15954193420309840599.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Sep 2021 17:37:19 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 22:38:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/fscache-next-20210829

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89594c746b00d3755e0792a2407f0b557a30ef37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
