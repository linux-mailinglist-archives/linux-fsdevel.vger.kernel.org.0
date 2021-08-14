Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37073EC107
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 09:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbhHNHAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Aug 2021 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhHNHAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Aug 2021 03:00:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760BDC06175F;
        Sat, 14 Aug 2021 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9IFkyEwAplzkujVr9VlDg7KecgUw4BOS0pEfW+M8BE4=; b=qc5CxvBzp++2UWHqMPXHqGykkK
        xEnhXZOSAJouORFLNWK7iIyYU1BI3iTp4hoE5NkYl2LUze3MIBh8o2DG04Or+e1mX5UPLuY/TefNk
        vc1IImfZg2Kw+CWbOp6jBWb/EWxXbO2CISJ8q+j98Xlg9rSSATG0BCMWTdz7U7zgd4mVlQZCRLilS
        JDFkk87oudAfNK2Y2Q/jAAE7cXmFcNLERPUXrOIgA60Cdc6jsfjIA6sHepMsE6L7JsdeFO5gQGW5Q
        LQBZOU1aMTLnWNpv911P/HmX49epdbGm+bmk9J8j+waIQITXS9pNCpT3+5V0EiCccKpqfFNbfF1KV
        pQyXqR/w==;
Received: from [2001:4bb8:188:1b1:f87f:f1a4:2ce8:33b9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEndt-00GTGa-LG; Sat, 14 Aug 2021 06:59:49 +0000
Date:   Sat, 14 Aug 2021 08:59:39 +0200
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>,
        linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] configfs fix for Linux 5.14
Message-ID: <YRdp2yz+4Oo2/zHy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-5.14

for you to fetch changes up to 769f52676756b8c5feb302d2d95af59577fc69ec:

  configfs: restore the kernel v5.13 text attribute write behavior (2021-08-09 16:56:00 +0200)

----------------------------------------------------------------
configfs fix for Linux 5.14

 - fix to revert to the historic write behavior (Bart Van Assche)

----------------------------------------------------------------
Bart Van Assche (1):
      configfs: restore the kernel v5.13 text attribute write behavior

 fs/configfs/file.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)
