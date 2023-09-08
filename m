Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB00798B8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 19:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244955AbjIHRoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 13:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjIHRoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:44:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22441FCF;
        Fri,  8 Sep 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zyF0jvVhbr8PSp/2Xh6a0Bf8cbSHNg5Ra4S8V/25hsw=; b=BxFupsDJl5Xc8SZpg5zCOi2QJU
        Hs1ZYTl4fnfw96yWSuBvf33JUCGZOl0aO9XnbzjJCJXbJepXjgdtmn+P6zof1QBjM0GCCYUIBgRRU
        pChwakrt+jqOh4XH40G/Uvf9meAJB6uCFciyoAOiN/U50oBLnCwyAr80e0yBj7/oNmxupI25PmSqN
        hy2fFuw+fn9Yw1FHhgaFPN2rxk8bPDayikiUos0vRaCDUooDmgYH3AXWHuVC+oJY3ByyOuHvkh2t/
        CiLoOx56FwCzc5BAdz5v5iVAXwEKjVlQgFg7lYxMr8Iogzmz562NIDpHeTvJAEE8fa9idlO+IZX+m
        ZmTufnGw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qefWf-001Ugv-8P; Fri, 08 Sep 2023 17:44:13 +0000
Date:   Fri, 8 Sep 2023 18:44:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] XArray for 6.6
Message-ID: <ZPtdbS6FTadc3LVA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I had to update the expiration on my signing key.  I don't know if you
pay attention to that, or whether my attempts to get my updated expiration
date into the system were successful.

The following changes since commit f837f0a3c94882a29e38ff211a36c1c8a0f07804:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2023-07-28 11:21:57 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray.git tags/xarray-6.6

for you to fetch changes up to 2a15de80dd0f7e04a823291aa9eb49c5294f56af:

  idr: fix param name in idr_alloc_cyclic() doc (2023-09-05 19:01:38 -0400)

----------------------------------------------------------------
XArray/IDA updates for 6.6

 - Fix a bug encountered by people using bittorrent where they'd get
   NULL pointer dereferences on page cache lookups when using XFS

 - Two documentation fixes

----------------------------------------------------------------
Ariel Marcovitch (1):
      idr: fix param name in idr_alloc_cyclic() doc

Matthew Wilcox (Oracle) (1):
      XArray: Do not return sibling entries from xa_load()

Philipp Stanner (1):
      xarray: Document necessary flag in alloc functions

 include/linux/xarray.h                | 18 ++++++++++
 lib/idr.c                             |  2 +-
 lib/xarray.c                          |  8 ++++-
 tools/testing/radix-tree/multiorder.c | 68 +++++++++++++++++++++++++++++++++--
 4 files changed, 92 insertions(+), 4 deletions(-)


