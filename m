Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7F29C7E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 19:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371278AbgJ0S4q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 14:56:46 -0400
Received: from casper.infradead.org ([90.155.50.34]:53300 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S371274AbgJ0S4p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3fd4QovsxkD+IsTbUt2Y29Qvo236jDUaZ2H/7AqDGM0=; b=GDqbVprkk8nv44gjhCflxRp2TZ
        aN2e1xnZECgg8EjD568OWAnrf/g2aBEvmwUJ3oPELjZTNqebW/VHLNkBDMV4cLAXOGxC6q2BwWNeR
        EaNQn22R/+stgkG/9x9mwP9LPJYoGn0m7BsrmyrneUVUdW9mZf3FqB9j0abB8ABxo4VmNKqcVehpH
        YTlD4rzlsn6Nc+HdC6Qei/gzqs2Owb54i5e0nZ+wdb1dQ2e8Iv0HQJqxuRc5OM/pfipuCWyeNQRBX
        OArJaiNg9icNhE2qQGjXqUYSYQh/lSDwmRTWMG7MpIutyhOlGXshPa7yuibvZqad9qo6Omg3PdQPn
        E0KFoKhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXU9D-0004Ag-0p; Tue, 27 Oct 2020 18:56:43 +0000
Date:   Tue, 27 Oct 2020 18:56:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 03/12] mm/filemap: Add helper for finding pages
Message-ID: <20201027185642.GA15201@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026041408.25230-4-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +static inline struct page *xas_find_get_entry(struct xa_state *xas,
> +		pgoff_t max, xa_mark_t mark)

I'd expect the xas_ prefix for function from xarray.h.  Maybe this
wants a better name?
