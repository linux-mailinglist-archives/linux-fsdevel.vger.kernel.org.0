Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FBF3EBE84
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Aug 2021 01:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhHMXGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 19:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbhHMXF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 19:05:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94770C061756;
        Fri, 13 Aug 2021 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uAZTMo4Rfh5y3K2qzERRkfKi4Wt3yJD428edoeLiOiE=; b=fnL0JZj/h9CM/tXv8idY37OUly
        gB+cG/25fu0ElSyUDuFgAxX0/ykzuE3WUhpiITZYujBFcwLwzWiYrQCDbquS05vWMOIRRqCVAnNI6
        k6VB8ThQL/LYUVlDQ4WjOvSEYIVdliSPeAbdt4wYAIom28EzFCbEWcuht1iXf9HQnIO57E0kPy9cl
        vlAU54B5l/elAKbNGUc+6jDyn+4At0zARrv4tNWI3FdhueIr76hSSP/OW8mOdkzjVe4vLaUsaiZ0e
        IBMIOBoe/UXsr3H5NR7aTjyJLRrOS1/OswuxRf+vxgYv0d2iEUYC7BhYWfCN3J/qZq2kPdTi4Ci9h
        USR+0nqQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEgE2-00GADO-FD; Fri, 13 Aug 2021 23:04:36 +0000
Date:   Sat, 14 Aug 2021 00:04:30 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v14 038/138] mm/memcg: Add folio_memcg() and related
 functions
Message-ID: <YRb6fr/Czz9jwqLJ@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-39-willy@infradead.org>
 <1eb08e30-3a84-eaae-e9ee-07d59cbde807@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb08e30-3a84-eaae-e9ee-07d59cbde807@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 12:32:45PM +0200, Vlastimil Babka wrote:
> >  static inline bool PageMemcgKmem(struct page *page);
> 
> I think this fwd declaration is no longer needed.

I agree.  Deleted.
