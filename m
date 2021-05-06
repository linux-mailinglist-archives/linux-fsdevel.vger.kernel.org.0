Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B0374D90
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhEFCey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 22:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhEFCey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 22:34:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CACC061574;
        Wed,  5 May 2021 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lJhsfLdiShCVCFTVkuBSUSKQ7SSGri8tABxwLddsMas=; b=BQwfXNXWmctipdvcC+WjXHeVZ3
        PaulRVvYfUxB433ISfhJZWpIdSSp8/HlIrP1bRq7Rpc1Gm+cUiB7actvmxdjmBSlRf1ZkYneBTK9n
        J1gzyDL4LuyaT61jUfkiK0YDVlcptfVPUZXcbzmun24mluNdMRZp66DpxdjttZN03WJqCWiGtdyRN
        /Vu5UFhqeoJKtPfdfrZZw9vyKwcS0haXtma4qDwZ4t0FPZ5cfJRvbH5xHx4HODNA7yJb0W0RpPCp8
        /zc4NyDtaVMyNhzGdGrEoz2Z0ila3bAgFbcbkiwQNCcZ2gcqQeidtkwXYN+vdu1Ru6XmpEaqtnBNh
        78ReL12w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leTpR-001CJe-TH; Thu, 06 May 2021 02:33:43 +0000
Date:   Thu, 6 May 2021 03:33:29 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 46/96] mm: Add flush_dcache_folio
Message-ID: <20210506023329.GM1847222@casper.infradead.org>
References: <20210505150628.111735-47-willy@infradead.org>
 <202105060752.es5znqMC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105060752.es5znqMC-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 07:35:16AM +0800, kernel test robot wrote:
>    In file included from arch/ia64/include/asm/cacheflush.h:31,
>                     from arch/ia64/include/asm/pgtable.h:153,
>                     from include/linux/pgtable.h:6,
>                     from arch/ia64/include/asm/uaccess.h:40,
>                     from include/linux/uaccess.h:11,
>                     from include/linux/sched/task.h:11,
>                     from include/linux/sched/signal.h:9,
>                     from arch/ia64/kernel/asm-offsets.c:10:
>    include/asm-generic/cacheflush.h: In function 'flush_dcache_folio':
> >> include/asm-generic/cacheflush.h:61:19: error: implicit declaration of function 'folio_nr_pages'; did you mean 'folio_page'? [-Werror=implicit-function-declaration]

Ugh, I can't be bothered to untangle the ia64 header file mess.
I'll just move the function out of line.

