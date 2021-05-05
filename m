Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E963749C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 22:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbhEEVAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 17:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbhEEU7K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 16:59:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6624C061574;
        Wed,  5 May 2021 13:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N+KvME0S3ibXvB6OWZh2BBzP3XVViWK1IhoWZTST5js=; b=lwMyBcwd62H3iEw6gtXtIaXOD9
        4AVeEiayURwcKzuI5VbN2jqJZYuH5/uZ9JRgf1fnzThnbI3U2LwOUr985bfNPKeTo7rzsqK+WDSXH
        yAf+mQDN7+gDoxwrgXFetPosEjMfWKGz1bLyBxy+km0xGyzYaBHwirJH2He8oKHWdVwyZK3cXcisG
        qMxbO2PMUrT5Ne/dFbBDlPVse9MzFkx/OifYGIgss/sebgi5S9kmzyYP2X2PUq1rhc0c+zp4kVjmd
        9dQnof2jhF7mlDlRggeEM4Xk2i1yIuILkFoh58umkQYVVBIOA+0B0xfBkaprLt6x3x/XOOVMWuM+t
        YMuNJ+mw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leOaa-000uDJ-IW; Wed, 05 May 2021 20:57:52 +0000
Date:   Wed, 5 May 2021 21:57:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 74/96] mm/workingset: Convert workingset_refault to
 take a folio
Message-ID: <20210505205748.GJ1847222@casper.infradead.org>
References: <20210505150628.111735-75-willy@infradead.org>
 <202105060454.QWwnGhDV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105060454.QWwnGhDV-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 04:17:27AM +0800, kernel test robot wrote:
>    In file included from mm/workingset.c:8:
>    include/linux/memcontrol.h: In function 'folio_uncharge_cgroup':
>    include/linux/memcontrol.h:1213:42: error: parameter name omitted
>     1213 | static inline void folio_uncharge_cgroup(struct folio *)
>          |                                          ^~~~~~~~~~~~~~

Fixed (also reported in your other report)

>    mm/workingset.c: In function 'unpack_shadow':
>    mm/workingset.c:201:15: warning: variable 'nid' set but not used [-Wunused-but-set-variable]
>      201 |  int memcgid, nid;
>          |               ^~~

I didn't introduce this one; not trying to fix it ;-)

>    mm/workingset.c: In function 'workingset_refault':
> >> mm/workingset.c:348:10: error: implicit declaration of function 'folio_memcg' [-Werror=implicit-function-declaration]
>      348 |  memcg = folio_memcg(folio);
>          |          ^~~~~~~~~~~
> >> mm/workingset.c:348:8: warning: assignment to 'struct mem_cgroup *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>      348 |  memcg = folio_memcg(folio);
>          |        ^
>    cc1: some warnings being treated as errors

Fixed.  Thanks!

