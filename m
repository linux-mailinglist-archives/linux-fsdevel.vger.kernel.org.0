Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF13FD8B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhIAL2I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 07:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhIAL2H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 07:28:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581C5C061575;
        Wed,  1 Sep 2021 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qJyGw4NWU2xh3wgW9g3b8HI/iYa9vwmH5odM1mLlpw8=; b=DiRxBh+iYAUjD6RpLOvScb5BIJ
        BXVV3aY2geuibWeaK6pJwwe7scEhMG19GYlHQFkWAGEAyNXZsq5Rx/UZKqNSDaYJRyr+8/tMJAu+e
        cHibRGqwKEWjc0CR0rGGL4jCBOCc6XhI8anwNi3ZAFKu34YbjNNSbYXQtARLOzFAP66WbMgz0wkEw
        Dl30FjfbtlP1ffjpzOCdmWu2oNBWsgTXweGYghErlOp3Pmrel33fW6dR+oCcw2OIxLMlEmpVc/OUw
        E3anfd8xEhmN5RJEL+U+VC5JFrSyGyo+/Dn7Lpnb/qVnh36cKncRv1KEgf1XqfX89dNzfYD6OTCKQ
        n1/rwkgw==;
Received: from [2001:4bb8:180:a30:2deb:705a:5588:bf7d] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLON1-002EJF-LQ; Wed, 01 Sep 2021 11:26:15 +0000
Date:   Wed, 1 Sep 2021 13:25:29 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Subject: [GIT PULL] configfs updates for Linux 5.15
Message-ID: <YS9jKWxJxj0+kqBE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Note that Joel reviewed this very recently as well, but I suspect
 you're rather not see a rebase for a few new Reviewed-by: tags]

The following changes since commit 769f52676756b8c5feb302d2d95af59577fc69ec:

  configfs: restore the kernel v5.13 text attribute write behavior (2021-08-09 16:56:00 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.15

for you to fetch changes up to c42dd069be8dfc9b2239a5c89e73bbd08ab35de0:

  configfs: fix a race in configfs_lookup() (2021-08-25 07:58:49 +0200)

----------------------------------------------------------------
configfs updates for Linux 5.15

 - fix a race in configfs_lookup (Sishuai Gong)
 - minor cleanups (me)

----------------------------------------------------------------
Christoph Hellwig (3):
      configfs: return -ENAMETOOLONG earlier in configfs_lookup
      configfs: simplify the configfs_dirent_is_ready
      configfs: fold configfs_attach_attr into configfs_lookup

Sishuai Gong (1):
      configfs: fix a race in configfs_lookup()

 fs/configfs/dir.c | 87 ++++++++++++++++++++-----------------------------------
 1 file changed, 31 insertions(+), 56 deletions(-)
