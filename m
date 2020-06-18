Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D41FF22F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 14:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgFRMqT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 08:46:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729145AbgFRMqS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592484377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
        b=h7Ftdw1WTmPytI2eIit/SWPmSzK6eAJPPK5WnFzNeImRDPOgmU4UbF07fZMqn28Lgn/Isn
        f1tAGW+XUov5PUGD9D5FdA5ppKS3t8F5l4neaqCFjA5VCGCdQbWQcCOi4OdZYxKX9WIuBg
        7IQc4CeH4+El7k8T/bQC/sUyYwm2eN0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-5oLJtShPPparg-ic_huTMw-1; Thu, 18 Jun 2020 08:46:15 -0400
X-MC-Unique: 5oLJtShPPparg-ic_huTMw-1
Received: by mail-oi1-f200.google.com with SMTP id a18so2659395oib.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 05:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
        b=J6ZCEIWn51XTnRy1MfxxtmbdYvM/J9aqcGdk+MvRoMtMDfmdASLd61t27l8jQC95dn
         Wy6WHfg1hfDBcOwm2mI3rO3T8wdt6e489EP2veq2Cytlqbbdb5KKLNT3Q+3RicWxIAwo
         b+qAjk3EWQY+z9v6tYmt5nj5GZq6TP+zFzVxwoTLqZH7doPde0QofpOtQYX78muOfv0F
         7cOd0p25qVxfPTGqc+DEXGbQ0COXarBx+D5GB0zrHX7B5H/CYcTXheyEzrap7t5MJlXh
         GI25CW8UWQCWu3rJqXUWI/ufjyrW8ld1CSvbNx49hNLrrOp3jNb5aqpd4KDrGzfnyZS/
         Pyzw==
X-Gm-Message-State: AOAM533V75vhOWAh1/yWB29m5pXyfIMZuFwXZlQr9a7Qc4YUBhILculT
        OvpDJfLjx0vGsNwfWdc9yCN8BPgvKHEqrdNbUCS1f49DOSU73v/a+kI1tpmXwwz7Qj47ufvEHFq
        zkYAuzwWUVWyi9yuG7bCdPbj73E4asbdJWpt/boJttA==
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr3014455oto.95.1592484374639;
        Thu, 18 Jun 2020 05:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOwYhxZwvrmXCEEJ4lNIcITT1uhrr+sNqXkjoRh5QLgqAWYsSVfGAkiWuBNYfSRh2ekFx49DQ8VN9O2a7lFfU=
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr3014426oto.95.1592484374383;
 Thu, 18 Jun 2020 05:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org> <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org>
In-Reply-To: <20200617022157.GF8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 14:46:03 +0200
Message-ID: <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to mpage_readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel <cluster-devel@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        linux-btrfs@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mi., 17. Juni 2020 um 02:33 Uhr schrieb Matthew Wilcox <willy@infrad=
ead.org>:
> > >
> > > On Wed, Jun 17, 2020 at 12:36:13AM +0200, Andreas Gruenbacher wrote:
> > > > Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@in=
fradead.org>:
> > > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > >
> > > > > Implement the new readahead aop and convert all callers (block_de=
v,
> > > > > exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qn=
x6,
> > > > > reiserfs & udf).  The callers are all trivial except for GFS2 & O=
CFS2.
> > > >
> > > > This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2=
.
> > > >
> > > > Our lock hierarchy is such that the inode cluster lock ("inode gloc=
k")
> > > > for an inode needs to be taken before any page locks in that inode'=
s
> > > > address space.
> > >
> > > How does that work for ...
> > >
> > > writepage:              yes, unlocks (see below)
> > > readpage:               yes, unlocks
> > > invalidatepage:         yes
> > > releasepage:            yes
> > > freepage:               yes
> > > isolate_page:           yes
> > > migratepage:            yes (both)
> > > putback_page:           yes
> > > launder_page:           yes
> > > is_partially_uptodate:  yes
> > > error_remove_page:      yes
> > >
> > > Is there a reason that you don't take the glock in the higher level
> > > ops which are called before readhead gets called?  I'm looking at XFS=
,
> > > and it takes the xfs_ilock SHARED in xfs_file_buffered_aio_read()
> > > (called from xfs_file_read_iter).
> >
> > Right, the approach from the following thread might fix this:
> >
> > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@r=
edhat.com/T/#t
>
> In general, I think this is a sound approach.
>
> Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> will bring in the pages which are in the page cache, so when we get to
> gfs2_fault(), we know there's a reason to acquire the glock.

We'd still be grabbing a glock while holding a dependent page lock.
Another process could be holding the glock and could try to grab the
same page lock (i.e., a concurrent writer), leading to the same kind
of deadlock.

Andreas

