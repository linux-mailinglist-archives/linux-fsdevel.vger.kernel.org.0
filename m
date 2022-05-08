Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FB251F146
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiEHUfT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiEHUfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB48411C1E
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LGBJYrt01/NV27YnFIlhUKTFY1ceKg2FcvK3mfYe0uY=; b=tTRNMM7RnDHrCqqdKnIRvoQBED
        /rNmz47F65wfX6Aly9x1pO4WHOmw2+FEhpmmOC8gEYe0gQGWPyegh7y17YVyyqSHFW4YaV7O7pbu1
        RbaCgXGacxg9l69ntgxkoWz1m7dDPCbe0V6ct9px5OsMnRNAESnsV+JDMSKPc8EecVa+u3ULvIL3m
        CIalBm4Huts4ws/Vl/A4tOxSO7wVcZmaWZPXY+w7nnQ0C3xQeU8GKSw3WTHaSlFdFStkkW8QZrXIO
        c9blxlBzPxCOSDcBMcCNwsUBE/dVTXlQ9NmaE6+JOuxawiAIHySd4631NEDURPbfHz7I5FrMK9k39
        x/Z53m1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnYL-002nhw-0u; Sun, 08 May 2022 20:30:53 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 0/3] Pagecache documentation updates
Date:   Sun,  8 May 2022 21:30:45 +0100
Message-Id: <20220508203048.667631-1-willy@infradead.org>
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

Hopefully the documentation updates here speak for themselves.

Matthew Wilcox (Oracle) (2):
  filemap: Update the folio_lock documentation
  filemap: Update the folio_mark_dirty documentation

Miaohe Lin (1):
  filemap: Remove obsolete comment in lock_page

 include/linux/pagemap.h | 60 ++++++++++++++++++++++++++++++++++++++---
 mm/page-writeback.c     | 10 ++++---
 2 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.34.1
