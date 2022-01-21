Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEEAC4965F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 20:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiAUTun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 14:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiAUTun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:50:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E8C06173B;
        Fri, 21 Jan 2022 11:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=TyT88I4wWo0H5jlbMaKdshZBKvPf77PgLxaHtxYK8JA=; b=ZtB1cDSaqZJ/nrSg3lbUv2BiX+
        6IoK9zkmlTprFALbS1fdyZKqArhidYaFX5UEh5Smp9/MPvEy6hPCXGJaRZd1OFBydSAaUi6ZnWSSo
        37MvjMP+duhZHLjES6dZfMhKMiuzXGB4CGQrmwCsrMOujBDIWliYsOaOAkz2238r7n9+njA4MtPkI
        sFcKg4LHZMm2JlSBrVePfYvIlIjcvpvPqvsgkC2BqFpDN/Sux6sUXYrDcYD+2STXdJo7966wt0KOg
        Flz6COw+KT9JxwX9tfqI2NTL2s8cedoCGsCGvcQLN9mjajpn0FrAQU+d86/qlDoAsZnEB+gXG03f6
        FHYUnERg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAzvk-00Fs3E-25; Fri, 21 Jan 2022 19:50:40 +0000
Date:   Fri, 21 Jan 2022 19:50:40 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Three small folio patches
Message-ID: <YesOkLfpJWxLxRWs@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The following changes since commit 455e73a07f6e288b0061dfcf4fcf54fa9fe06458:

  Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2022-01-12 17:02:27 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.17a

for you to fetch changes up to 3abb28e275bfbe60136db37eae6679c3e1928cd5:

  filemap: Use folio_put_refs() in filemap_free_folio() (2022-01-16 19:52:13 -0500)

----------------------------------------------------------------
Three small folio patches.

One bug fix, one patch pulled forward from the patches destined for 5.18
and then a patch to make use of that functionality.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (3):
      pagevec: Initialise folio_batch->percpu_pvec_drained
      mm: Add folio_put_refs()
      filemap: Use folio_put_refs() in filemap_free_folio()

 include/linux/mm.h      | 20 ++++++++++++++++++++
 include/linux/pagevec.h |  1 +
 mm/filemap.c            | 10 ++++------
 3 files changed, 25 insertions(+), 6 deletions(-)


