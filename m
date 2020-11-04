Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C0F2A6FB3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 22:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgKDVeD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 16:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgKDVeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 16:34:03 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F031C0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2020 13:34:03 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so103095qtu.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2020 13:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iHZD2JCK/HDwhsMu1vVM7AOnv1j/wL3L6uGfwT70qHM=;
        b=RiGKLvkM2fI0f2pGevdBjuq9lVHh/vlXQ7+9n8MQUEi1onyiCrP0EKjXY2h75Z80xO
         wV3f//kC2Tn2LreECFmnDJ+oHMuc2plxlFVGJ3tpgy4hcPZwwfs7ou39g9v9um14BTtz
         76IcG6Oezj4e+gauSRVps1jR9Qz14KhTsQwfrGnXPkVwSOQqTi6R3I09C+fXIvjccroX
         /ExJUrTbv9xs6mOwbqERUNoPKt+aejJEnpN07U6GpHQszPfC3cyN058H52mVmMMH6EEM
         97I51UuGImTa1vpOvm/+hqiuXTrlm5rKWQQL/y+jpIzNCsR5q4nTWiJQaxYv2J9NqMBh
         kt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHZD2JCK/HDwhsMu1vVM7AOnv1j/wL3L6uGfwT70qHM=;
        b=KjH+Bbjas1xVA2CIpL9YBjLKk+fVgtuUPV/I/zYwG5kRa00OsGgIGFj26H0h2sMP3/
         dMlibtUMOSFa+71XSDN//pg1RqpHwBVHa5cyTrkENEA+kF8b39gRumn/pWGlAfxb72Kx
         7qw1NLrrK+xD4HitmBUJRiPOcL1+4aG6hCnjLURPZyIa7r4065r9MQOdmmDGZ4RsqOK/
         LNEzVeMFil0qO/08xm590M2OXXUooFsDRF+fp0gDBFsxZQ/pFUNETlNDAQMwCHw9LX4+
         o8taq9cu9T9epXkPQl2GBwUdnSytJxHFqyClG0qUMMmZ8IzqA2C46VLkGC8g7XXemJF0
         /ZgQ==
X-Gm-Message-State: AOAM532YlCJE9Tyf0hLcf87cD+5WMNlx2+3RLiij86XZ5S9lEotbrJPq
        feT+NifKfPbjBHBA6zepgqsoiQ==
X-Google-Smtp-Source: ABdhPJz1lZC0hQdq+/Z+Gg9PunT4MgTgJeE8do4JSq8mGR99B6PprmXnUqIAQZ2hfu2RtSa36rAYWg==
X-Received: by 2002:ac8:5307:: with SMTP id t7mr52090qtn.273.1604525642181;
        Wed, 04 Nov 2020 13:34:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l30sm1193806qta.73.2020.11.04.13.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 13:34:01 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kaQPo-00Giar-AC; Wed, 04 Nov 2020 17:34:00 -0400
Date:   Wed, 4 Nov 2020 17:34:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "xiaofeng.yan" <xiaofeng.yan2012@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, oulijun@huawei.com, yanxiaofeng7@jd.com
Subject: Re: [PATCH 2/2] infiniband: Modify the reference to xa_store_irq()
 because the parameter of this function  has changed
Message-ID: <20201104213400.GX36674@ziepe.ca>
References: <20201104023213.760-1-xiaofeng.yan2012@gmail.com>
 <20201104023213.760-2-xiaofeng.yan2012@gmail.com>
 <20201104185843.GV36674@ziepe.ca>
 <20201104193036.GD17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104193036.GD17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 04, 2020 at 07:30:36PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 04, 2020 at 02:58:43PM -0400, Jason Gunthorpe wrote:
> > >  static void cm_finalize_id(struct cm_id_private *cm_id_priv)
> > >  {
> > >  	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
> > > -		     cm_id_priv, GFP_KERNEL);
> > > +		     cm_id_priv);
> > >  }
> > 
> > This one is almost a bug, the entry is preallocated with NULL though:
> > 
> > 	ret = xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
> > 				  &cm.local_id_next, GFP_KERNEL);
> > 
> > so it should never allocate here:
> > 
> > static int cm_req_handler(struct cm_work *work)
> > {
> > 	spin_lock_irq(&cm_id_priv->lock);
> > 	cm_finalize_id(cm_id_priv);
> 
> Uhm.  I think you want a different debugging check from this.  The actual
> bug here is that you'll get back from calling cm_finalize_id() with
> interrupts enabled. 

Ooh, that is just no fun too :\

Again surprised some lockdep didn't catch wrongly nesting irq locks

> Can you switch to xa_store(), or do we need an
> xa_store_irqsave()?

Yes, it looks like there is no reason for this, all users of the
xarray are from sleeping contexts, so it shouldn't need the IRQ
version.. I made a patch for this thanks

The cm_id_priv->lock is probably also not needing to be irq either,
but that is much harder to tell for sure

> > Still, woops.
> > 
> > Matt, maybe a might_sleep is deserved in here someplace?
> >
> > @@ -1534,6 +1534,8 @@ void *__xa_store(struct xarray *xa, unsigned long index, void *entry, gfp_t gfp)
> >         XA_STATE(xas, xa, index);
> >         void *curr;
> >  
> > +       might_sleep_if(gfpflags_allow_blocking(gfp));
> > +
> >         if (WARN_ON_ONCE(xa_is_advanced(entry)))
> >                 return XA_ERROR(-EINVAL);
> >         if (xa_track_free(xa) && !entry)
> > 
> > And similar in the other places that conditionally call __xas_nomem()
> > ?

But this debugging would still catch the wrong nesting of a GFP_KERNEL
inside a spinlock, you don't like it?

> > I also still wish there was a proper 'xa store in already allocated
> > but null' idiom - I remember you thought about using gfp flags == 0 at
> > one point.
> 
> An xa_replace(), perhaps?

Make sense.. But I've also done this with cmpxchg. A magic GFP flag,
as you tried to do with 0, is appealing in many ways

Jason
