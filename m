Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686AE36B9D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbhDZTQZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235389AbhDZTQZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619464543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjlPen1encdZDkGM0wilUuVPtH5U8CDDV8DYPkgdQBU=;
        b=V3ODUlNMD2lfBmzDOB7nzOK9iJjEJfnuf5HhyYS+nfLmpNGwhyHtt8xq4hyg880BTqneue
        1IUR9siRZ5F3O4SOrVKAPZDzT3sTpU67CSH+JY3OHnkfTWWNSGIG1Q/E6udOZBfuuS5u/K
        zP4pk0PPrCNpVsPmu4/X4SSQeC2/KxA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Wp5K4gphOo6UthY-7xoAMA-1; Mon, 26 Apr 2021 15:15:41 -0400
X-MC-Unique: Wp5K4gphOo6UthY-7xoAMA-1
Received: by mail-qk1-f197.google.com with SMTP id p17-20020a05620a1131b02902e45c6e4d33so5154376qkk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NjlPen1encdZDkGM0wilUuVPtH5U8CDDV8DYPkgdQBU=;
        b=sfpPC3Xf19U/RzSmvR9KPjYEsgmgE4n0M4EJrysYnSEWl3CdwIrWmBsuFq/J2MQK3p
         7KhAcd9iqc8dei6tWEdIzNM2U72zRf4071vh1SB+FgjJxZchgpst0clf5vE3oyMLOEm/
         LVmd3sEwbQ2GGPVIit7JMWpVFcxblldwuG6SsNGQJbL/MNFWnhgbOeqNdrhsblscHWyX
         QuedktV68Zl7coVUc7tzTT+qr5WbbNOhcbKvFTTQtvqbdASJ3y7NBZvDbMR4WUA4zrdD
         bs1JANa0LmBaziALNVDe7EcifBwQFDk1gtE5g1tx0qp/sVypNZ++cWQp+RSC1Mt4czsy
         f5pg==
X-Gm-Message-State: AOAM5329KA44+A0WN5/qVfYAgwzz72QdcNzuIJel/OYf0WU5kiotNSLL
        7S9dFvaIBvu4zHdJQFwPai/9CeTzqCof1/FBti+3GpWgw32H1YXKnuv8wZ+NySy7WoKNJyTTzpf
        6f4f+oNQShwNw9ps/XzXv/Q5pPw==
X-Received: by 2002:a37:de14:: with SMTP id h20mr18965532qkj.34.1619464540670;
        Mon, 26 Apr 2021 12:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZYRAHl+eWnQtgdg3ck30c64eIGwlxsQ5wJdm+wrQWh9LXuumEJb2NQlXbEra5jinaPsZTlQ==
X-Received: by 2002:a37:de14:: with SMTP id h20mr18965510qkj.34.1619464540455;
        Mon, 26 Apr 2021 12:15:40 -0700 (PDT)
Received: from [192.168.1.180] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id c15sm12638215qtg.31.2021.04.26.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:15:40 -0700 (PDT)
Message-ID: <8114b7a1151edf52e3a20cf30d2673cd177191bf.camel@redhat.com>
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
From:   Jeff Layton <jlayton@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Apr 2021 15:15:39 -0400
In-Reply-To: <YIcMVCkp4xswHolw@zeniv-ca.linux.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
         <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
         <YIcMVCkp4xswHolw@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-04-26 at 18:54 +0000, Al Viro wrote:
> On Fri, Apr 23, 2021 at 02:28:01PM +0100, David Howells wrote:
> > -#define iterate_all_kinds(i, n, v, I, B, K) {			\
> > +#define iterate_xarray(i, n, __v, skip, STEP) {		\
> > +	struct page *head = NULL;				\
> > +	size_t wanted = n, seg, offset;				\
> > +	loff_t start = i->xarray_start + skip;			\
> > +	pgoff_t index = start >> PAGE_SHIFT;			\
> > +	int j;							\
> > +								\
> > +	XA_STATE(xas, i->xarray, index);			\
> > +								\
> > +	rcu_read_lock();						\
> > +	xas_for_each(&xas, head, ULONG_MAX) {				\
> > +		if (xas_retry(&xas, head))				\
> > +			continue;					\
> 
> OK, now I'm really confused; what's to guarantee that restart will not have
> you hit the same entry more than once?  STEP might be e.g.
> 
> 		memcpy_to_page(v.bv_page, v.bv_offset,
> 			       (from += v.bv_len) - v.bv_len, v.bv_len)
> 
> which is clearly not idempotent - from gets incremented, after all.
> What am I missing here?
> 

Not sure I understand the issue you see. If xas_retry returns true,
we'll restart, but we won't have called STEP yet for that entry. I
don't see how we'd retry there and have an issue with idempotency.

> > +		if (WARN_ON(xa_is_value(head)))				\
> > +			break;						\
> > +		if (WARN_ON(PageHuge(head)))				\
> > +			break;						\
> > +		for (j = (head->index < index) ? index - head->index : 0; \
> > +		     j < thp_nr_pages(head); j++) {			\
> > +			__v.bv_page = head + j;				\
> > +			offset = (i->xarray_start + skip) & ~PAGE_MASK;	\
> > +			seg = PAGE_SIZE - offset;			\
> > +			__v.bv_offset = offset;				\
> > +			__v.bv_len = min(n, seg);			\
> > +			(void)(STEP);					\
> > +			n -= __v.bv_len;				\
> > +			skip += __v.bv_len;				\
> > +			if (n == 0)					\
> > +				break;					\
> > +		}							\
> > +		if (n == 0)						\
> > +			break;						\
> > +	}							\
> > +	rcu_read_unlock();					\
> > +	n = wanted - n;						\
> > +}


