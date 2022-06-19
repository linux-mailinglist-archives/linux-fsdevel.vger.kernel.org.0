Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669E6550B67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 17:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiFSPLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jun 2022 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiFSPLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jun 2022 11:11:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CC4AE50;
        Sun, 19 Jun 2022 08:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GpbBghc2KUTT+YonqGGQ/ud3qNGpEps0gpZxehyGdwc=; b=vbFQO/gLXhdG8+OLUzl+HNpsd4
        f67IaNDMpjESyWpvAxSSZc8EO960nphUATLBGwXVx+lbSpHhlaiw2UUIX6qa/K4YRSCdleJC3Blj6
        Wx2ngsULRRTJy0XksSSu5gNxw6E4vyC37vGefDuFY5Sf7H3FW6RDBdxYjzuPYj+xLoE9+3GfWJW3U
        X5pNdAM0JNSx7D1+Z6sdItZpmFvFNUf7QIRmAkIHlfQrUwLlWdKrsqtn888s+IwhsXmKNp5Nqp9yw
        p31WJVVs4+747C0BFwT4IlZwZljIGDA/cUXMytgPLnS7vgrLE6dKMUpgHP1zw2o2PLeaZ1SMM3gT7
        1QmY1fCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2waZ-004QOo-0t; Sun, 19 Jun 2022 15:11:47 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fixes for 5.19b
Date:   Sun, 19 Jun 2022 16:11:40 +0100
Message-Id: <20220619151143.1054746-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
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

I intend to send these three fixes for 5.19 during the next week.
They're also at the top of the for-next branch.  I'll fold in any
reviewed-by tags I get by Tuesday.

Matthew Wilcox (Oracle) (3):
  filemap: Correct the conditions for marking a folio as accessed
  filemap: Handle sibling entries in filemap_get_read_batch()
  mm: Clear page->private when splitting or migrating a page

 mm/filemap.c     | 15 ++++++++++++---
 mm/huge_memory.c |  1 +
 mm/migrate.c     |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.35.1

