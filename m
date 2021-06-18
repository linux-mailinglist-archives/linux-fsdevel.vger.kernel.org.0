Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7543ACB55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 14:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhFRMvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 08:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230217AbhFRMva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624020560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=stvSk3gDnwydLdmv2kGkmelsFDUu+AMaT99wKTXZOB8=;
        b=i7hkyrGUerIjKt2oqy+GNSo7m8TIelQX6u26U6xhSm7e8qJ3x41cdTQJ09TSCN+5KeS3mY
        vGsHaJEe19V7JhkXYBWHfgSNX6WKVgefPBOLA6j2ttu8pZSol16lt8o1qtD2zA4AwZRqrV
        pW0mFl/oRDvUDXgDYdz9SDFJFSoTcR0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-LhsThL7aMIWg8SqvPJKNAQ-1; Fri, 18 Jun 2021 08:49:19 -0400
X-MC-Unique: LhsThL7aMIWg8SqvPJKNAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A81E2802B7E;
        Fri, 18 Jun 2021 12:49:16 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-2.rdu2.redhat.com [10.10.114.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0CD819D61;
        Fri, 18 Jun 2021 12:49:15 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7F47422054F; Fri, 18 Jun 2021 08:49:15 -0400 (EDT)
Date:   Fri, 18 Jun 2021 08:49:15 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] fs/fuse: Remove unneeded kaddr parameter
Message-ID: <20210618124915.GA1234055@redhat.com>
References: <20210525172428.3634316-1-ira.weiny@intel.com>
 <20210525172428.3634316-2-ira.weiny@intel.com>
 <20210611172301.GA1600546@iweiny-DESK2.sc.intel.com>
 <CAJfpegv3iZ2pj8Cn0cvhZB0pVa4SC8LSZ9OYx3Qr-BwWmvtGag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv3iZ2pj8Cn0cvhZB0pVa4SC8LSZ9OYx3Qr-BwWmvtGag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 09:01:39AM +0200, Miklos Szeredi wrote:
> On Fri, 11 Jun 2021 at 19:23, Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Tue, May 25, 2021 at 10:24:26AM -0700, 'Ira Weiny' wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > fuse_dax_mem_range_init() does not need the address or the pfn of the
> > > memory requested in dax_direct_access().  It is only calling direct
> > > access to get the number of pages.
> >
> > In looking for feedback on this small series I realize that I failed to email
> > Miklos for the fs/fuse patch.
> >
> > I'm adding Miklos to the To line...
> 
> LGTM, but this is Vivek's code, so adding Cc.
> 

Looks good to me as well. We are not using pfn and kaddr in
fuse_dax_mem_range_init().

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

> Thanks,
> Miklos
> 
> 
> >
> > For the rest of the series is there any feedback?
> >
> > Ira
> >
> > >
> > > Remove the unused variables and stop requesting the kaddr and pfn from
> > > dax_direct_access().
> > >
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  fs/fuse/dax.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
> > > index ff99ab2a3c43..34f8a5635c7f 100644
> > > --- a/fs/fuse/dax.c
> > > +++ b/fs/fuse/dax.c
> > > @@ -1234,8 +1234,6 @@ void fuse_dax_conn_free(struct fuse_conn *fc)
> > >  static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
> > >  {
> > >       long nr_pages, nr_ranges;
> > > -     void *kaddr;
> > > -     pfn_t pfn;
> > >       struct fuse_dax_mapping *range;
> > >       int ret, id;
> > >       size_t dax_size = -1;
> > > @@ -1247,8 +1245,8 @@ static int fuse_dax_mem_range_init(struct fuse_conn_dax *fcd)
> > >       INIT_DELAYED_WORK(&fcd->free_work, fuse_dax_free_mem_worker);
> > >
> > >       id = dax_read_lock();
> > > -     nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), &kaddr,
> > > -                                  &pfn);
> > > +     nr_pages = dax_direct_access(fcd->dev, 0, PHYS_PFN(dax_size), NULL,
> > > +                                  NULL);
> > >       dax_read_unlock(id);
> > >       if (nr_pages < 0) {
> > >               pr_debug("dax_direct_access() returned %ld\n", nr_pages);
> > > --
> > > 2.28.0.rc0.12.gb6a658bd00c9
> > >
> 

