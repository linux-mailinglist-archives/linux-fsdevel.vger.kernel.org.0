Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0070551F159
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiEHUf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbiEHUfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40564132
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=vBm0ZV9rB7YVCkC0uUNmFJTiY2skLjurlT/qsT1Jmy8=; b=P2O3FuErtTHoYqAvikKmn2MEni
        FgY6noD7mWtW2ax/jbCv8LY9GkZgNgg7vG+Rqm7yBLBQanREfNmBo8NFw4c7mps84Tah7Z3zSMFon
        gZwyTovmxFZqnEeORzGmzEnvDtW9vUHjYrapn3RWJ8JJxkBIeZtC99/4VMJZ17x3VHZJrPEiyDzxr
        wUEMyrKxv55Si0JgjH2bYyKDpcLfNAJ97HUBgNhHVYBy1wkPVvbLQuCGwZXUrJzx9ZboJIzOT/DCH
        b1QNdMDewzwxpia/6JVe/4A3MfRMY1clzNYBRXF7KnQIBEgH/amsBmKLI/xeWhZGG9EuaQ/g2Qpl8
        5i5D5Usg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYh-002nkP-By; Sun, 08 May 2022 20:31:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/4] Miscellaneous folio conversions
Date:   Sun,  8 May 2022 21:31:07 +0100
Message-Id: <20220508203111.667840-1-willy@infradead.org>
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

Mostly this is prep work for the following patches.

Matthew Wilcox (Oracle) (4):
  readahead: Use a folio in read_pages()
  fs: Convert is_dirty_writeback() to take a folio
  mm/readahead: Convert page_cache_async_readahead to take a folio
  buffer: Rewrite nobh_truncate_page() to use folios

 Documentation/filesystems/vfs.rst | 10 ++--
 fs/btrfs/relocation.c             |  5 +-
 fs/btrfs/send.c                   |  3 +-
 fs/buffer.c                       | 80 ++++++++++++++-----------------
 fs/nfs/file.c                     | 21 ++++----
 fs/verity/enable.c                | 29 ++++++-----
 include/linux/buffer_head.h       |  2 +-
 include/linux/fs.h                |  2 +-
 include/linux/pagemap.h           |  6 +--
 mm/readahead.c                    | 25 +++++-----
 mm/vmscan.c                       |  2 +-
 11 files changed, 86 insertions(+), 99 deletions(-)

-- 
2.34.1
