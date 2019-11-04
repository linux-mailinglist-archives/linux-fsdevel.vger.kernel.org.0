Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C6AEEADF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 22:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfKDVP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 16:15:28 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40344 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbfKDVP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:15:27 -0500
Received: by mail-qt1-f193.google.com with SMTP id o49so26130819qta.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2019 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pyXNiCRfNtBczIIqZ12Au+Ud6Z68623cr8kr//yYcys=;
        b=cdIurt3FoLPTZlK0pRWkw6/vK5VskqT2SbrzmEIJH+tJ6Ws9V4Lsgf9USo2+e2ozUc
         YRC+b39mpReZt55//saai5UbNMBA3eXwOqYLQtfunIkTwkfTlIfn1eXp2VeIe1/orkPr
         PDVNDgKxGvEW8/cTzBHwWhOs6aaLwvdAp8wwJznhpYiyIH9szefozZKp8Gp400JqPNGU
         fTr/7Xjau32owsZ9g3acr0XI1ZTN6RVvcZ58S7ZMFunV92cxFdu7JBWTybRQM5KPfcgD
         VnxEWZzKOSsxfKO36w3EM6M1OhrZPi8fZFAK54K+pX7TtJSCqY3tKZTOVsHNgsvdV+dl
         4NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pyXNiCRfNtBczIIqZ12Au+Ud6Z68623cr8kr//yYcys=;
        b=hFOh16Auj6zHXWqL4AVkeWLEmJVFv6PyTGaZE/piUEcFGg8HOt7zDs2RihTtqBnoSC
         /ZxEtc/cghWypzm0JhmqdObS/s71XVcrUrbI781bwaLQISaJTqef5sMXGOYo9FnsMvpM
         K0rOb9IfLTK3Jj/4N8zhbZ+TrULMWQRjo4fOR7gs2lvl9QoF7HBkaqYgku4rourUMGIy
         idJDhdB5/+fLMEbhgVfHfqNpItC9VVhjMN3YN5foIViGPA7qmKn0g7RN6S0IEm/mmykr
         02KZfuypuv/bd1NzUQnizWqyHIHVqwtYiM+qL4I4GAcaIBnJtAJMfOLrGzhz/aA3fisg
         /UaA==
X-Gm-Message-State: APjAAAWr87s+aDq6CZJueYMqePesl9VU4gF1R2VeYa6aZkmy2bCxu1p/
        NIJHmWTN+DRcM/AmTojtEIEG/A==
X-Google-Smtp-Source: APXvYqzMR4jCE1PYixsxB/Gjs6m+eeNvSRexU+WyF4DsIRWaOdmeothP674vqn/aB1paP5wRwlCCGw==
X-Received: by 2002:ac8:3a21:: with SMTP id w30mr14733201qte.299.1572902126035;
        Mon, 04 Nov 2019 13:15:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q1sm6459892qti.46.2019.11.04.13.15.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Nov 2019 13:15:25 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iRjh7-0000mG-3H; Mon, 04 Nov 2019 17:15:25 -0400
Date:   Mon, 4 Nov 2019 17:15:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alex Williamson <alex.williamson@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Chinner <david@fromorbit.com>,
        David Airlie <airlied@linux.ie>,
        "David S . Miller" <davem@davemloft.net>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, bpf@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rdma@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/18] mm/gup: introduce pin_user_pages*() and FOLL_PIN
Message-ID: <20191104211525.GJ30938@ziepe.ca>
References: <20191103211813.213227-6-jhubbard@nvidia.com>
 <20191104173325.GD5134@redhat.com>
 <be9de35c-57e9-75c3-2e86-eae50904bbdf@nvidia.com>
 <20191104191811.GI5134@redhat.com>
 <e9656d47-b4a1-da8a-e8cc-ebcfb8cc06d6@nvidia.com>
 <20191104195248.GA7731@redhat.com>
 <25ec4bc0-caaa-2a01-2ae7-2d79663a40e1@nvidia.com>
 <20191104203153.GB7731@redhat.com>
 <20191104203702.GG30938@ziepe.ca>
 <d0890a8b-c349-0515-2570-10e83979836b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0890a8b-c349-0515-2570-10e83979836b@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 12:57:59PM -0800, John Hubbard wrote:
> On 11/4/19 12:37 PM, Jason Gunthorpe wrote:
> > On Mon, Nov 04, 2019 at 03:31:53PM -0500, Jerome Glisse wrote:
> >>> Note for Jason: the (a) or (b) items are talking about the vfio case, which is
> >>> one of the two call sites that now use pin_longterm_pages_remote(), and the
> >>> other one is infiniband:
> >>>
> >>> drivers/infiniband/core/umem_odp.c:646:         npages = pin_longterm_pages_remote(owning_process, owning_mm,
> >>> drivers/vfio/vfio_iommu_type1.c:353:            ret = pin_longterm_pages_remote(NULL, mm, vaddr, 1,
> >>
> >> vfio should be reverted until it can be properly implemented.
> >> The issue is that when you fix the implementation you might
> >> break vfio existing user and thus regress the kernel from user
> >> point of view. So i rather have the change to vfio reverted,
> >> i believe it was not well understood when it got upstream,
> >> between in my 5.4 tree it is still gup_remote not longterm.
> > 
> > It is clearly a bug, vfio must use LONGTERM, and does right above this
> > remote call:
> > 
> >         if (mm == current->mm) {
> >                 ret = get_user_pages(vaddr, 1, flags | FOLL_LONGTERM, page,
> >                                      vmas);
> >         } else {
> >                 ret = get_user_pages_remote(NULL, mm, vaddr, 1, flags, page,
> >                                             vmas, NULL);
> > 
> > 
> > I'm not even sure that it really makes any sense to build a 'if' like
> > that, surely just always call remote??
> > 
> 
> 
> Right, and I thought about this when converting, and realized that the above 
> code is working around the current gup.c limitations, which are "cannot support
> gup remote with FOLL_LONGTERM".

But AFAICT it doesn't have a problem, the protection test is just too
strict, and I guess the control flow needs a bit of fixing..

The issue is this:

static __always_inline long __get_user_pages_locked():
{
        if (locked) {
                /* if VM_FAULT_RETRY can be returned, vmas become invalid */
                BUG_ON(vmas);
                /* check caller initialized locked */
                BUG_ON(*locked != 1);
        }


so remote could be written as:

if (gup_flags & FOLL_LONGTERM) {
   if (WARN_ON_ONCE(locked))
        return -EINVAL;
   return __gup_longterm_locked(...)
}

return __get_user_pages_locked(...)

??

Jason
