Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D38305D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313544AbhAZWgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388338AbhAZTMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611688267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dhSDWdgO45oMOw4U14ZD4IpWy4LqGlGQzgyJ+NX3F9s=;
        b=RV5i8IOr+AD8PVlARWPcj/V3Aef7XJUDwmYp5eA/FXlu1pwjmupvJxXEwK1Uo16ilnfxLn
        GcXdeVs+2L8BuReRVm+aybpV5CZvGOjSQTbXA2ASq2Q3e+CksGM9aM+gQU8WNiOL0okA5w
        A4+2vLSlAQ2GZaVbrhEu56Ntl3ONE1M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-0FpfIJZsODOUscNHd-2Xww-1; Tue, 26 Jan 2021 14:11:04 -0500
X-MC-Unique: 0FpfIJZsODOUscNHd-2Xww-1
Received: by mail-ej1-f71.google.com with SMTP id hd8so3831613ejc.22
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 11:11:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhSDWdgO45oMOw4U14ZD4IpWy4LqGlGQzgyJ+NX3F9s=;
        b=LqW2LslwQl5rXYzBMvwoU8sc+KTILPfN1Wdo/IQaO1NTByxwCh+odC4UHMhJAuCYF4
         pbk+Vk0Agx2N1Vi/IHOuzM3u5/0Sq4GGXzRLU204UMC5MNnrDzQTgpF4ZMnfceNRuSz+
         fU3DxULxahfjRb8SRlGn9bIhe4vrOmAsZi4OhMaZqfqOV9MYH+Vr47f0XUKn340kndlX
         7ozKQmBr46P84XEP7wg9kHp3FgVNjwsgfadNz9mOrNQqZyInpJ5STVhwiconKQ6XfyyI
         mtpR9H3B8YPdLgkC3/O96mVvrAeBO85KNurWe+LVRNN1UN8dtVantqu5Rxd4r8bqAwue
         xUoA==
X-Gm-Message-State: AOAM532WaHKqUf0ZHQpd2/uzxhv3RC0JoSHtf8ikZ9JRKwzsf4QxlBcE
        GcxfTsLVTDWzf2z1/JfA0APSMAwkWpQd3Lw95zzqL6NB4M7RXG5gkQVt0kfTajNAYCW/NSNzL/j
        k9WaPVuytRyl8pjk3+5E9iRVfXBPiE854BM8BxqLToA==
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr5760852edv.211.1611688263259;
        Tue, 26 Jan 2021 11:11:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9khL2OyLeDGiHbXxhgFxEoiQEWhWSGq0ZEPFvGyzCXtwZceNpjSLzAw970dmzg8NCnH9M4SKeWZSU2be3AaE=
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr5760842edv.211.1611688263103;
 Tue, 26 Jan 2021 11:11:03 -0800 (PST)
MIME-Version: 1.0
References: <161161025063.2537118.2009249444682241405.stgit@warthog.procyon.org.uk>
 <161161064956.2537118.3354798147866150631.stgit@warthog.procyon.org.uk>
 <20210126013611.GI308988@casper.infradead.org> <D6C85B77-17CA-4BA6-9C2C-C63A8AF613AB@oracle.com>
In-Reply-To: <D6C85B77-17CA-4BA6-9C2C-C63A8AF613AB@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 26 Jan 2021 14:10:26 -0500
Message-ID: <CALF+zOm++OzAebR4wu+Hdf8Aa8GpXZu8Am9eVajVUiDMBJE63w@mail.gmail.com>
Subject: Re: [PATCH 32/32] NFS: Convert readpage to readahead and use
 netfs_readahead for fscache
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs <linux-cachefs@redhat.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:25 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Jan 25, 2021, at 8:36 PM, Matthew Wilcox <willy@infradead.org> wrote:
> >
> >
> > For Subject: s/readpage/readpages/
> >
> > On Mon, Jan 25, 2021 at 09:37:29PM +0000, David Howells wrote:
> >> +int __nfs_readahead_from_fscache(struct nfs_readdesc *desc,
> >> +                             struct readahead_control *rac)
> >
> > I thought you wanted it called ractl instead of rac?  That's what I've
> > been using in new code.
> >
> >> -    dfprintk(FSCACHE, "NFS: nfs_getpages_from_fscache (0x%p/%u/0x%p)\n",
> >> -             nfs_i_fscache(inode), npages, inode);
> >> +    dfprintk(FSCACHE, "NFS: nfs_readahead_from_fscache (0x%p/0x%p)\n",
> >> +             nfs_i_fscache(inode), inode);
> >
> > We do have readahead_count() if this is useful information to be logging.
>
> As a sidebar, the Linux NFS community is transitioning to tracepoints.
> It would be helpful (but not completely necessary) to use tracepoints
> in new code instead of printk.
>

The netfs API has a lot of good tracepoints and to be honest I think we can
get rid of fscache's rpcdebug, but let me take a closer look to be
sure.  I didn't use rpcdebug much, if at all, in the latest rounds of debugging.



>
> >> +static inline int nfs_readahead_from_fscache(struct nfs_readdesc *desc,
> >> +                                         struct readahead_control *rac)
> >> {
> >> -    if (NFS_I(inode)->fscache)
> >> -            return __nfs_readpages_from_fscache(ctx, inode, mapping, pages,
> >> -                                                nr_pages);
> >> +    if (NFS_I(rac->mapping->host)->fscache)
> >> +            return __nfs_readahead_from_fscache(desc, rac);
> >>      return -ENOBUFS;
> >> }
> >
> > Not entirely sure that it's worth having the two functions separated any more.
> >
> >>      /* attempt to read as many of the pages as possible from the cache
> >>       * - this returns -ENOBUFS immediately if the cookie is negative
> >>       */
> >> -    ret = nfs_readpages_from_fscache(desc.ctx, inode, mapping,
> >> -                                     pages, &nr_pages);
> >> +    ret = nfs_readahead_from_fscache(&desc, rac);
> >>      if (ret == 0)
> >>              goto read_complete; /* all pages were read */
> >>
> >>      nfs_pageio_init_read(&desc.pgio, inode, false,
> >>                           &nfs_async_read_completion_ops);
> >>
> >> -    ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
> >> +    while ((page = readahead_page(rac))) {
> >> +            ret = readpage_async_filler(&desc, page);
> >> +            put_page(page);
> >> +    }
> >
> > I thought with the new API we didn't need to do this kind of thing
> > any more?  ie no matter whether fscache is configured in or not, it'll
> > submit the I/Os.
>
> --
> Chuck Lever
>
>
>

