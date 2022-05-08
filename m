Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2645451F19D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiEHUjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiEHUhd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B6112629
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RetA2UCpHUto/oRN4k6Kuc0g58/asXTg3Qi7bEBb6RI=; b=LPCk7yE9dsGtZ+gCWVte7IJ4HG
        ujNt/80pGN4vadv2kmV4e0YWZneZxba2E0q3DBN2ZSCSjxz7d+UboN5RFGtb+iNlaE4P2ktOm7xRO
        Ts2xHpMMpErTVCJYvo/p3aIv6PNLhsM8ksNOGGPb0MXvMV0EyeHG6uitYUE02E0BSZc012BSP89wk
        lO5fiFGHwIDGRVJSJBfewH2obb2D3d2cXo/v0yUY8ARDS0J7Ns7EdrkPstQjhkJQ0SZ3pQGEOKHef
        CjaI9zwDlvM5+5RCUuZjPtV9LXGGl8W9KtPTyIh2e4XYAt2r6jmoOzwWF8GuDmS7sQEHDUB1W6DIe
        qcOQRuBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaS-002o6R-Oa; Sun, 08 May 2022 20:33:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/5] Convert aops->freepage to aops->free_folio
Date:   Sun,  8 May 2022 21:32:56 +0100
Message-Id: <20220508203301.669147-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YngbFluT9ftR5dqf@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Not a lot of filesystems implement ->freepage, thankfully, so this
is a slightly smaller patchset than the last few.

Matthew Wilcox (Oracle) (5):
  fs: Add free_folio address space operation
  orangefs: Convert to free_folio
  nfs: Convert to free_folio
  secretmem: Convert to free_folio
  fs: Remove aops->freepage

 Documentation/filesystems/locking.rst | 10 +++++-----
 Documentation/filesystems/vfs.rst     |  6 +++---
 fs/nfs/dir.c                          |  9 +++++++--
 fs/orangefs/inode.c                   |  6 +++---
 include/linux/fs.h                    |  2 +-
 mm/filemap.c                          | 16 ++++++++--------
 mm/secretmem.c                        |  8 ++++----
 mm/vmscan.c                           |  8 ++++----
 8 files changed, 35 insertions(+), 30 deletions(-)

-- 
2.34.1

