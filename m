Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B70F0EC88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 00:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfD2WJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 18:09:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbfD2WJn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 18:09:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA8C520260;
        Mon, 29 Apr 2019 22:09:42 +0000 (UTC)
Received: from max.home.com (unknown [10.40.205.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA30517CCB;
        Mon, 29 Apr 2019 22:09:36 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Bob Peterson <rpeterso@redhat.com>,
        Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Mark Syms <Mark.Syms@citrix.com>,
        =?UTF-8?q?Edwin=20T=C3=B6r=C3=B6k?= <edvin.torok@citrix.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 0/5] iomap and gfs2 fixes
Date:   Tue, 30 Apr 2019 00:09:29 +0200
Message-Id: <20190429220934.10415-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 29 Apr 2019 22:09:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here's another update of this patch queue, hopefully with all wrinkles
ironed out now.

Darrick, I think Linus would be unhappy seeing the first four patches in
the gfs2 tree; could you put them into the xfs tree instead like we did
some time ago already?

Thanks,
Andreas

Andreas Gruenbacher (4):
  fs: Turn __generic_write_end into a void function
  iomap: Fix use-after-free error in page_done callback
  iomap: Add a page_prepare callback
  gfs2: Fix iomap write page reclaim deadlock

Christoph Hellwig (1):
  iomap: Clean up __generic_write_end calling

 fs/buffer.c           |   8 ++--
 fs/gfs2/aops.c        |  14 ++++--
 fs/gfs2/bmap.c        | 101 ++++++++++++++++++++++++------------------
 fs/internal.h         |   2 +-
 fs/iomap.c            |  55 ++++++++++++++---------
 include/linux/iomap.h |  22 ++++++---
 6 files changed, 124 insertions(+), 78 deletions(-)

-- 
2.20.1

