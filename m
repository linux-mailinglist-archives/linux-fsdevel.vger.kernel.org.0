Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FD23EBC02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhHMSZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhHMSZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:25:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61033C061756;
        Fri, 13 Aug 2021 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pZC9h+8AIFu30Mxf6zOHexUoRDHw8r38yo5U+t3x+9I=; b=hOfZh1vFQ7dZythvngAQjYWhCZ
        mgg8/qLkoMjAHIMhHS5i4qNpl3MUF08FqnCjfcv6HKS+Rpb/6kPnkkWtwMNZ5RD20mokDMu2aD+A4
        Lyye4osCRMt5qgPwzEl1ePF4lMkMTkxfJ8zmjFXUdz3HHIBgms5OWe1ykVYMDrJalMmHoTVrZjQGN
        ikorNgTbb4NCF720gJyHMO08eLvlRkPhQDt2oDalHEGeGHHjIZZrcd1Nsx1l3PbPhdRkHfSKIIJ4Q
        HB/p5HqDkdFW23T04BnYo6BaG/SPa9fzERflb9L7AP0d0a20vL1TL7D1YMNMqrLpGwWN9ASSlbpG/
        UEjs0ZhA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEbqz-00Fxfn-EQ; Fri, 13 Aug 2021 18:24:37 +0000
Date:   Fri, 13 Aug 2021 19:24:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v14 022/138] mm/filemap: Add __folio_lock_or_retry()
Message-ID: <YRa42cj4Oc0pDdST@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <20210715033704.692967-23-willy@infradead.org>
 <984ee3c0-7189-3481-8a1f-9e2765906224@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984ee3c0-7189-3481-8a1f-9e2765906224@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 06:08:03PM +0200, Vlastimil Babka wrote:
> >   * If neither ALLOW_RETRY nor KILLABLE are set, will always return 1
> 
> s/1/true/ ? :)

Fixed; thanks.
