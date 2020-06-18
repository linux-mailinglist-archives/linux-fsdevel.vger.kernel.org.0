Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D31FF969
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgFRQkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 12:40:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731965AbgFRQkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592498429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
        b=e31t8BkS6xSRALcGqv57e+ji295zDcSzyzbjhbqCPIya2fUZ79TtfL8Q09svKgs5aFv63r
        w2G2eCWwvlV+m3QmvX9nS4hIZ67OOvmncXeTlp+hdk0c7J0f5qhYsbJ5KdB3cSRoyHzcHK
        WEeRU0hMzJ37Biryh2RpuzvyJNnvKg0=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-kO0orYNXNvKIFqth0HmIgQ-1; Thu, 18 Jun 2020 12:40:28 -0400
X-MC-Unique: kO0orYNXNvKIFqth0HmIgQ-1
Received: by mail-ot1-f69.google.com with SMTP id w21so2877242oti.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2020 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
        b=Z3VYkQ+B3F8XuWHryla1+jB9Ja8LLrAdTAQ7/ClYJP3+fRQzTg87RNHeuuVlT231bG
         8kc278O/jLe89rXq80VVncLe4r+oN/nxcqMq6sk5Bvk0abm/OrUgyNvFocVFOdC7j6GH
         VUkr2H5210usWNONZWRa1Ly2+LXanH//++JeD1VLWqXOQs99wQdP8Ret8XSshaLhJ76u
         m31RRkXw9AK3ZZkxpDS/pumXnMkcJoOJIMIwCM6ux0Sn1L49lE5/2zGmgNEiB51PTXVv
         ZpccaWN5lQTRiFbM+SBwpGp4y/AEqjEJ+0QtjBXLYNm2fnXt4+OKBSmPbT33mYtj6Dhr
         C1cg==
X-Gm-Message-State: AOAM532NdkAtIe5BLEiYtZHwl5vYZZMK0CvTb4Gl+ilaWkLcD21ieKwl
        IXMCXSTnYJzO75VPPR1iJUFPOpsV74NssUypbcpAmDGfAP+mMFQliw1SS90YrhGP4rkqcO740tz
        0GZD9BLQZOglk0SAnYtpXpsJjxoYKtOc3CNrs03Myfw==
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr4000192oto.95.1592498427404;
        Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE8nhb2Q0d4GxQpaInRB14NGapvcWpYnTg96Ky3B2ltZU9DxgAABVkj/Ptn9PHhgl8mMoH1G9lpq5ufccfhow=
X-Received: by 2002:a05:6830:10c8:: with SMTP id z8mr4000168oto.95.1592498427103;
 Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org> <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org> <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
 <20200618150309.GP8681@bombadil.infradead.org>
In-Reply-To: <20200618150309.GP8681@bombadil.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu, 18 Jun 2020 18:40:15 +0200
Message-ID: <CAHc6FU6TYTiQ0a0GkN1dhh3VeQKVKrL+eALvuYzZ8nq5jvNHjg@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 18, 2020 at 02:46:03PM +0200, Andreas Gruenbacher wrote:
> > On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wr=
ote:
> > > On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=83=C2=BCnbach=
er wrote:
> > > > Right, the approach from the following thread might fix this:
> > > >
> > > > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruen=
ba@redhat.com/T/#t
> > >
> > > In general, I think this is a sound approach.
> > >
> > > Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> > > will bring in the pages which are in the page cache, so when we get t=
o
> > > gfs2_fault(), we know there's a reason to acquire the glock.
> >
> > We'd still be grabbing a glock while holding a dependent page lock.
> > Another process could be holding the glock and could try to grab the
> > same page lock (i.e., a concurrent writer), leading to the same kind
> > of deadlock.
>
> What I'm saying is that gfs2_fault should just be:
>
> +static vm_fault_t gfs2_fault(struct vm_fault *vmf)
> +{
> +       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> +       struct gfs2_inode *ip =3D GFS2_I(inode);
> +       struct gfs2_holder gh;
> +       vm_fault_t ret;
> +       int err;
> +
> +       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> +       err =3D gfs2_glock_nq(&gh);
> +       if (err) {
> +               ret =3D block_page_mkwrite_return(err);
> +               goto out_uninit;
> +       }
> +       ret =3D filemap_fault(vmf);
> +       gfs2_glock_dq(&gh);
> +out_uninit:
> +       gfs2_holder_uninit(&gh);
> +       return ret;
> +}
>
> because by the time gfs2_fault() is called, map_pages() has already been
> called and has failed to insert the necessary page, so we should just
> acquire the glock now instead of trying again to look for the page in
> the page cache.

Okay, that's great.

Thanks,
Andreas

