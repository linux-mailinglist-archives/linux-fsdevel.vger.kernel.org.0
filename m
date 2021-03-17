Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52533F784
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCQRv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbhCQRvY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:51:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A18C06174A;
        Wed, 17 Mar 2021 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rGJfEo0c4N/BIwZMUyXKTYj49Ef/YOPV1DuFMT6A41I=; b=W3xmbSdfZ5iXeZvED39lrk7GjL
        yCn8/s5ctILZyLudlyB8ZVNXAhGbX8JXuE4x4eNKUHXkIWhEKGHKyTb91mQHhuDZcq6m13PQE7s/L
        ri09yPI1Csu67NLuhgaeUBRITOKSQboppcf/86L4C0Y33BUVyPtkOP42+tExCLbBjNDlwJyOVUCWl
        +ASZGqoF6Rzi22GWrGZoTi2/XeucJWvG2B9UaNlrPQyQFYNsNmzLavWUp0vphXeo2xVDFzbwQgr2E
        tGyokdiR2zFHkEbT5n9MjuEEShb4b4iEKRSvz8X85kZmWzJeUQvwBOihw8jnZeavKLOcnNMeTgFli
        aXYC7GkA==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaJq-001wL1-Od; Wed, 17 Mar 2021 17:50:58 +0000
Date:   Wed, 17 Mar 2021 18:48:44 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-ID: <YFJA/ExliTBVfj/8@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
 <alpine.LSU.2.11.2103131842590.14125@eggly.anvils>
 <20210315115501.7rmzaan2hxsqowgq@box>
 <YE9VLGl50hLIJHci@dhcp22.suse.cz>
 <20210315190904.GB150808@infradead.org>
 <20210315194014.GZ2577561@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315194014.GZ2577561@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 07:40:14PM +0000, Matthew Wilcox wrote:
> The reason I didn't go with 'head' is that traditionally 'head' implies
> that there are tail pages.  It would be weird to ask 'if (HeadHead(head))'
> That's currently spelled 'if (FolioMulti(folio))'.  But it can be changed
> if there's a really better alternative.  It'll make me more grumpy if
> somebody comes up with a really good alternative in six months.

The folio name keeps growing on me.  Still not perfect, but I do like
that it is:

 a) short

and

 b) very different from page
