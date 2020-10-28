Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF4229D617
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgJ1WLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730702AbgJ1WLg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D5C0613D2;
        Wed, 28 Oct 2020 15:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V0F6qvxrqJ6CiZ4OmTie3wm3lFL7SwoxTHVUYB1s9t8=; b=bdbrP2jW1bhOFUqCro/B307iv7
        IsTZdcg/hiqUqj+BlCA7grV6NdBIGTlhabSRw8pczcp8MXpBVoVCytNCWzMun1VXWgUeRw5QYMlJe
        EgHS+5ca1YA0v8kAm+WMEI/KaEZkrrLLUPBuH5Z6AypKjNYSOmsBUhha3rvTbtfVCu3Q9rt4eGl1T
        Zq29ido7GQUdZ+xfm9hfqNztHvan+w4Ye/Bb3R2jdoyi0kNv8zWgkjZ+GvrNbn41QoHXaqa/84suu
        fCps5EV+ZSSECfouHoUfdKHApa1LcfPRBE7H9RRXM/Hd0vynQW0F6ElmWRX+cZB9qnU51MSSIW/WH
        dy5bEfqg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXf8U-0005z1-J9; Wed, 28 Oct 2020 06:40:42 +0000
Date:   Wed, 28 Oct 2020 06:40:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v3 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20201028064042.GA22361@infradead.org>
References: <20201026041408.25230-1-willy@infradead.org>
 <20201026041408.25230-5-willy@infradead.org>
 <20201027185809.GB15201@infradead.org>
 <20201027200458.GX20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027200458.GX20115@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 08:04:58PM +0000, Matthew Wilcox wrote:
> I have that patch here:
> 
> http://git.infradead.org/users/willy/pagecache.git/commitdiff/a4e435b5ed14a0b898da6e5a66fe232f467b8ba1
> 
> I was going to let this patch go upstream through Andrew's tree, then
> submit that one through Darrick's tree.  But I can add that patch to
> the next submission of this series if you'd rather.

I think keeping the two patches together would be useful.
