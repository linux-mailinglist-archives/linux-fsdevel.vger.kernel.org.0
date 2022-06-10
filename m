Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63572546D2C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 21:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbiFJTWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiFJTWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 15:22:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A2C56386;
        Fri, 10 Jun 2022 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jA3sc+sxCh5X1xWeDF8wDNwVEiGJ6rJJEWh12pIvuxI=; b=Uk6dDHgnw3eeMD+Hx0HE4ERTdj
        3J671Dlfqeh3yUD3AlvOHXNojsh7uNNR7gGoak/yDn0TKVupOAC2dXUjqiHJe88N8j5UeM832Ms0h
        ofthDJ04lWZ8EmBN2fcTKBk5oadgxfz+JuZfsC16xon1S4r1UHFGTGMFaivOY5IsGWnry65vOPpxt
        DVibjguWJCJv9gi71yLltabKE7UdPu+hkkhOtBwWPaGDeymLf2ymDJef9z8n99RV/SNhS9zflUAQO
        tjVltUfnkbzNbGmW6Jz38DixusUSkIOIRIveo1PR1KfFJiJrJxINLCDg8a48AB398o7/OaTH2Eu+S
        CszfIp5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzkCs-00Eght-8S; Fri, 10 Jun 2022 19:22:06 +0000
Date:   Fri, 10 Jun 2022 20:22:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Folio fixes for 5.19
Message-ID: <YqOZ3v68HrM9LI//@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 3d9f55c57bc3659f986acc421eac431ff6edcc83:

  Merge tag 'fs_for_v5.19-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs (2022-06-09 12:26:05 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19a

for you to fetch changes up to 334f6f53abcf57782bd2fe81da1cbd893e4ef05c:

  mm: Add kernel-doc for folio->mlock_count (2022-06-09 16:24:25 -0400)

----------------------------------------------------------------
Four folio-related fixes for 5.19:

 - Don't release a folio while it's still locked

 - Fix a use-after-free after dropping the mmap_lock

 - Fix a memory leak when splitting a page

 - Fix a kernel-doc warning for struct folio

----------------------------------------------------------------
Matthew Wilcox (Oracle) (4):
      filemap: Don't release a locked folio
      filemap: Cache the value of vm_flags
      mm/huge_memory: Fix xarray node memory leak
      mm: Add kernel-doc for folio->mlock_count

 include/linux/mm_types.h | 5 +++++
 include/linux/xarray.h   | 1 +
 lib/xarray.c             | 5 +++--
 mm/filemap.c             | 9 +++++----
 mm/huge_memory.c         | 3 +--
 mm/readahead.c           | 2 ++
 6 files changed, 17 insertions(+), 8 deletions(-)

