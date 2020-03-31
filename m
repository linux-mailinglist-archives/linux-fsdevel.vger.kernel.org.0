Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC1A199A47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgCaPuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 11:50:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53390 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730760AbgCaPuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SJY8Ah1dGXGWYAKsfhcz7RmiMYaoFOi+y3XZzaOfyBI=; b=l8uXtGsnoWIna4Qc/PK2vPSVhJ
        9ZeUgi6lcMfbmZlX0CITMLdIw41ScRoMjHL8x8ceyGVA5uRwnI4O0D47bin+5RU/MDTLRiJArI3zq
        I5VIz3d105chXaa9lusPzRtHJ3kPdk6clWYjnuDMD36V+Rc6jJANSoMO+2QeP7JX4vjl0J74A+U84
        c3p2H+VuoDS0lOJgBP/5USdws8h2PWfCq/CZ92zejy6Lnk5qFjivnUJWVQwXtnfTwVr/HCUVJYUKz
        cfyBu08Uq9tNhVhKdMZWbu30aMuCIqb7ZEohZKqfpinwyiqlcUHpxOyUl//R8YqpdkUtrbEl827cC
        qJuPBGXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJHi9-0006v0-Ti; Tue, 31 Mar 2020 14:17:49 +0000
Date:   Tue, 31 Mar 2020 07:17:49 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 5.7-rc1
Message-ID: <20200331141749.GB21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.7

for you to fetch changes up to 7e934cf5ace1dceeb804f7493fa28bb697ed3c52:

  xarray: Fix early termination of xas_for_each_marked (2020-03-12 17:42:08 -0400)

----------------------------------------------------------------
XArray updates for 5.7-rc1

 - Fix two bugs which affected multi-index entries larger than 2^26 indices
 - Fix some documentation
 - Remove unused IDA macros
 - Add a small optimisation for tiny configurations
 - Fix a bug which could cause an RCU walker to terminate a marked walk early

----------------------------------------------------------------
Alex Shi (1):
      ida: remove abandoned macros

Chengguang Xu (1):
      XArray: Fix incorrect comment in header file

Matthew Wilcox (Oracle) (5):
      XArray: Fix xa_find_next for large multi-index entries
      XArray: Fix xas_pause for large multi-index entries
      XArray: Optimise xas_sibling() if !CONFIG_XARRAY_MULTI
      radix tree test suite: Support kmem_cache alignment
      xarray: Fix early termination of xas_for_each_marked

 include/linux/xarray.h                       | 10 +++-
 lib/radix-tree.c                             |  8 ---
 lib/test_xarray.c                            | 55 ++++++++++++++++++
 lib/xarray.c                                 |  9 ++-
 tools/testing/radix-tree/Makefile            |  4 +-
 tools/testing/radix-tree/iteration_check_2.c | 87 ++++++++++++++++++++++++++++
 tools/testing/radix-tree/linux.c             | 32 ++++++----
 tools/testing/radix-tree/linux/slab.h        |  6 +-
 tools/testing/radix-tree/main.c              |  1 +
 tools/testing/radix-tree/test.h              |  1 +
 10 files changed, 182 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/radix-tree/iteration_check_2.c

