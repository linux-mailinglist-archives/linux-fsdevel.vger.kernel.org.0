Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9E3F459A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbhHWHIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhHWHII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:08:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04785C061575;
        Mon, 23 Aug 2021 00:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y5iKIOSmRPhkzl8GZ3V0iZBSQOEkqisco0K4MYwWkt4=; b=bkAyQ6pJYgc6iG6ofrVyRGpZ8U
        bJus/XYSiMV57GEypgDk9VMUWtFxUGUtRC0s2RMOX/H45F1T1xJbTdz3rqfjQodWCVuky0Sq6iWaw
        vGQHFbcczOJBFuHx/8HsPpXnxOdH5xsLAE6Yhuo4d3AppOLeUD4XfnXNbq+3MgVKnGWHZQhF9kaxC
        1n0tPKOq4ACRPbnp3AvnTZKuvBdAsjLuMnXJuj9B46r9lzX+PaUjngvPeM9i9ZjQeNME0YrDaiKYX
        /q0eVbfvoSKU0e5E0ITcB+/heVjW9HOOJX/vW9FOgTc+eefNe0a5EljNwyya+8CMOG4WZnVJ/ZoUp
        klIto19Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI41M-009PAx-AC; Mon, 23 Aug 2021 07:05:51 +0000
Date:   Mon, 23 Aug 2021 08:05:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] iomap: standardize tracepoint formatting and storage
Message-ID: <YSNItPxSRWEsODGi@infradead.org>
References: <20210822023223.GY12640@magnolia>
 <YSHE0MwgIugfkAzf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSHE0MwgIugfkAzf@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 22, 2021 at 04:30:24AM +0100, Matthew Wilcox wrote:
> On Sat, Aug 21, 2021 at 07:32:23PM -0700, Darrick J. Wong wrote:
> > @@ -58,8 +58,7 @@ DECLARE_EVENT_CLASS(iomap_range_class,
> >  		__entry->offset = off;
> >  		__entry->length = len;
> >  	),
> > -	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset %lx "
> > -		  "length %x",
> > +	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx length 0x%llx",
> 
> %#llx is one character shorter than 0x%llx ;-)

But at least for me a little harder to read.
