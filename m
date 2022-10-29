Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40C611F96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 05:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJ2DJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 23:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJ2DJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 23:09:37 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015ACD47;
        Fri, 28 Oct 2022 20:09:27 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j7so2517562pjn.5;
        Fri, 28 Oct 2022 20:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7850AVZhPg0xwR5TufU8/GvZ+aF2CAvoh9xDDNZMbU=;
        b=PpSYmXOpR1ZNbvyAjC0uMbN1lliC/gSNxANTwbAOzgh23ZskLxkTdnGm5n/1NJ1iua
         VXVFC5DhLav2jPZb8KuvaCMAGXP2WVHrFlqnpCweTGNrHx/Pz+SCUB1c+kgFgpYHihmJ
         4oEpC92ZnylfW54KMh5IjD+c40x+jnV+gvCJs/4NFlHwx6tvRKpoRXUdUSFU8BJ/EICV
         ukK0+2skhSKHK9f0P71GblVfM0MZvGc9PciK2vj8oZM3nKvi17MxG/1qjkoDdj4n/iQA
         rCRVuQ/oWKNWGg/DWNZ88U9KTJXI2ECcUrd7Zxfrga19oZD8JgwKxAWe+VqkD1j9qYEy
         Xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7850AVZhPg0xwR5TufU8/GvZ+aF2CAvoh9xDDNZMbU=;
        b=zdtMuFiJ3VN0yXJkYa1X/WHPHJnL9++ufS6S2Wl5EGKp7fF1WXxAjPy/B8verV7A70
         iSDlhAuyK74DGfnwPiBUASD4GhjTM1RRCyJMHt9dax6NkgYqCrhAyK8Q0svx7FJJjPwa
         IvujTJBhG6r2wAvwH6XlUTR3/LjD4K+a7DjMbhE5zljuZDeZbGwZl9VmL/0cYIQqQlGS
         ID8TjLtF1+vp8itZ6gR0VJJV+caRg8HJshdtQ8xlhHoVZcqg4VWPrhMibkaM/fUd8o6o
         f7sv4cJ8Sh4qeFavJgaCMwNmHbNQqZRZv5uXns7JQha3xFWnm6HOgThGGcRWjBdrwNC1
         OYaw==
X-Gm-Message-State: ACrzQf2Htco9SghEHga53yPxmlHO90LbkGHszNymzP0RdJeDSBe303QW
        KzoEVPRpH8QUGkBHamn6sdE=
X-Google-Smtp-Source: AMsMyM5fzjnOBYEoO8OQ6nkktG5SYyopQO1J/9ewhlREWvJCqR161JXTWL5Lk8xDLzg1tuXFssfhVQ==
X-Received: by 2002:a17:90b:1212:b0:213:a3a4:4d97 with SMTP id gl18-20020a17090b121200b00213a3a44d97mr2878378pjb.225.1667012966422;
        Fri, 28 Oct 2022 20:09:26 -0700 (PDT)
Received: from localhost ([58.84.24.234])
        by smtp.gmail.com with ESMTPSA id x17-20020aa78f11000000b0053e4baecc14sm177955pfr.108.2022.10.28.20.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 20:09:25 -0700 (PDT)
Date:   Sat, 29 Oct 2022 08:39:22 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 1/2] iomap: Change uptodate variable name to state
Message-ID: <20221029030922.57srdnkj3wfnjuy4@riteshh-domain>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <82faf435c4e5748e8c6554308f13cac5bc4a8546.1666928993.git.ritesh.list@gmail.com>
 <Y1wD4BykwDgJ1mXC@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1wD4BykwDgJ1mXC@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/10/28 09:31AM, Darrick J. Wong wrote:
> On Fri, Oct 28, 2022 at 10:00:32AM +0530, Ritesh Harjani (IBM) wrote:
> > This patch just changes the struct iomap_page uptodate & uptodate_lock
> > member names to state and state_lock to better reflect their purpose for
> > the upcoming patch.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index ca5c62901541..255f9f92668c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -25,13 +25,13 @@
> >  
> >  /*
> >   * Structure allocated for each folio when block size < folio size
> > - * to track sub-folio uptodate status and I/O completions.
> > + * to track sub-folio uptodate state and I/O completions.
> >   */
> >  struct iomap_page {
> >  	atomic_t		read_bytes_pending;
> >  	atomic_t		write_bytes_pending;
> > -	spinlock_t		uptodate_lock;
> > -	unsigned long		uptodate[];
> > +	spinlock_t		state_lock;
> > +	unsigned long		state[];
> >  };
> >  
> >  static inline struct iomap_page *to_iomap_page(struct folio *folio)
> > @@ -58,12 +58,12 @@ iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> >  	else
> >  		gfp = GFP_NOFS | __GFP_NOFAIL;
> >  
> > -	iop = kzalloc(struct_size(iop, uptodate, BITS_TO_LONGS(nr_blocks)),
> > +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> >  		      gfp);
> >  	if (iop) {
> > -		spin_lock_init(&iop->uptodate_lock);
> > +		spin_lock_init(&iop->state_lock);
> >  		if (folio_test_uptodate(folio))
> > -			bitmap_fill(iop->uptodate, nr_blocks);
> > +			bitmap_fill(iop->state, nr_blocks);
> >  		folio_attach_private(folio, iop);
> >  	}
> >  	return iop;
> > @@ -79,7 +79,7 @@ static void iomap_page_release(struct folio *folio)
> >  		return;
> >  	WARN_ON_ONCE(atomic_read(&iop->read_bytes_pending));
> >  	WARN_ON_ONCE(atomic_read(&iop->write_bytes_pending));
> > -	WARN_ON_ONCE(bitmap_full(iop->uptodate, nr_blocks) !=
> > +	WARN_ON_ONCE(bitmap_full(iop->state, nr_blocks) !=
> >  			folio_test_uptodate(folio));
> >  	kfree(iop);
> >  }
> > @@ -110,7 +110,7 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
> >  
> >  		/* move forward for each leading block marked uptodate */
> >  		for (i = first; i <= last; i++) {
> > -			if (!test_bit(i, iop->uptodate))
> > +			if (!test_bit(i, iop->state))
> 
> Hmm... time to add a new predicate helper clarifying that this is
> uptodate state that we're checking here.

Yup. Willy suggested something like iop_block_**. But to keep it short we can 
keep it like iop_test_uptodate().

-ritesh
