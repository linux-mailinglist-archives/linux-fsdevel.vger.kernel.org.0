Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E705A374D8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 04:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhEFCaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 22:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbhEFCaz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 22:30:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1114DC061574;
        Wed,  5 May 2021 19:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jLbvTtzsMHsiCpP+jmrHZgsjl8t2eDomB5Z8sBnaQ/w=; b=q+7qKE7dHFXk9r9iVAkdEOUK40
        nBpcixf8QRyJmjugB3QBqIdRgssrbCwbnhDgZQSXvVIKjgLSoDgfh3fgyV/NqT3PK3lt7r94XS5M+
        QyBln1ZPM7PJzugGDewgse55bwKI5oydKKvk1EGnAmGNM07eGsBqTWdB7vLDFZYc+ZFeXye22TSLN
        VH3paeaHC1DDPKy8kFu901U7izoVlWDPWsOuMtRo1T1R5E/hYp/HUnL521IZOy0rXftBUiIv8xn0R
        l4DUMQHat5UBrG7SOSGvwBvmx3uXYG/2Y4ReC3uQT9f/JPJJzBJIZ1jffLNkxClIahptVZP2akXr6
        /9eg/oVw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leTks-001C6I-1Q; Thu, 06 May 2021 02:29:25 +0000
Date:   Thu, 6 May 2021 03:28:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 77/96] mm/filemap: Add filemap_alloc_folio
Message-ID: <20210506022846.GL1847222@casper.infradead.org>
References: <20210505150628.111735-78-willy@infradead.org>
 <202105060717.iCOhoRD0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105060717.iCOhoRD0-lkp@intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 06, 2021 at 08:00:25AM +0800, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
> >> mm/filemap.c:1000:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted gfp_t [usertype] gfp @@     got int [assigned] n @@
>    mm/filemap.c:1000:52: sparse:     expected restricted gfp_t [usertype] gfp
>    mm/filemap.c:1000:52: sparse:     got int [assigned] n
> >> mm/filemap.c:1000:55: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int order @@     got restricted gfp_t [usertype] gfp @@
>    mm/filemap.c:1000:55: sparse:     expected unsigned int order
>    mm/filemap.c:1000:55: sparse:     got restricted gfp_t [usertype] gfp

fixed


