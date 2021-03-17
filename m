Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7A233F663
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 18:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCQROw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 13:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCQROm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:14:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CD8C06174A;
        Wed, 17 Mar 2021 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yo6Fi9VPbozhR4/XkrldehgVPuWGAklwU7qbAjO38qQ=; b=Ztpw7xml643pqS6iyfntpjWSUP
        XSi+NpT+KK5byJXLPP5aI9TfIlIs470+JZq3+fiEQqeH/nsZ6d+0VW4G3tA1Zs2MWzN8g6bDG4Edh
        Ej9D8VUkAS/U5KNj1cHLYsX5+Ra8VVIln34KFq4as8vjAw3WLHplU+Nt2DBSgWPJKv/5PflBzaJFs
        KrR7w4iSeNYy/11SyHouk+QdY/MJSEB6AapmzCyWRzrSs8UXUgM+BT5GMLUoeKoqF4GhhNECd0k7a
        p3ZxqILzaZ7vz5EiWYFj8jHWE+MojeTiK/lmWv4E7rCVrP7GXweqLdYQNSasdkeGysVIdrg+A2aR7
        U9pd9/Sw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lMZkK-001tiT-NJ; Wed, 17 Mar 2021 17:14:17 +0000
Date:   Wed, 17 Mar 2021 17:14:12 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 01/25] mm: Introduce struct folio
Message-ID: <20210317171412.GA451661@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
 <20210305041901.2396498-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305041901.2396498-2-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 05, 2021 at 04:18:37AM +0000, Matthew Wilcox (Oracle) wrote:
> +/*
> + * A struct folio is either a base (order-0) page or the head page of
> + * a compound page.
> + */

Hmm.  While that comment seems to be true I'm not sure it is the
essence.  Maybe it should be more framed in terms of

"A folio represents a contigously allocated chunk of memory.."

and then extend it with the categories of state and operations performed
on the folio while those get added.  The above statement can still
remain as a low-level explanation, maybe moved to the page member
instead of the type itself.
