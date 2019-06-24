Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE3B5195D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfFXROI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 13:14:08 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39927 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfFXROH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 13:14:07 -0400
Received: by mail-qt1-f193.google.com with SMTP id i34so15278485qta.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2019 10:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJ+RAvzPBAa5v9bPGuZoXeQwFc3BtTVsLP1GzK8UUP4=;
        b=NLRB/GC9Umew7FMEUu8JPvaseDV5/gNuyIlAsJTrrAX2wk76pD/3wC/xO2nx6SOnFt
         6QgCwp8+hXZfCt4W4SRuDE4SIX9NJfm1RdY9lCsajqEe/tcJqAKETWZXZzBBuiShraMP
         tFiopWrOpZ76T0hADA/WzVfuaTAnJa/WYt5ChgGqzEwmUpJdDpoHRreQQMZFJK8Una+U
         63W9S90SIFiXdqSSbFgXqSZ+FzQsJo3nrVvWtUD8DtX9PoxOFKlLWJAPTkvAB3g1pYMQ
         aZYxBEyMB8FOD0wLAM6UIo7EtBC52Mna5EOyPdz7U955NsPivwU3kGQNdBPFEtOmUcAU
         LQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJ+RAvzPBAa5v9bPGuZoXeQwFc3BtTVsLP1GzK8UUP4=;
        b=M74Ac5/CQaRoyChvIstxi1ho75GsztHyDfZkTLaNeEDpBBkit/cdlzFuaTiTjSY9L3
         TAHYmpfZMOfABlrp2aY2nz8KI550zZxSCzXXJuX1vFSGuXE3zHE6eA2sTzKFWZrH6KB+
         XIcpUriMp+pBzkkF/NofBa1SuTVkB7jRCxvVFu9N2/JFqHmQgb5RRQFqtEYjVE5ff79h
         r7i+0irT13Sp3S8/9cY8s0t5ysD4VDAJCvduAxHSoIrJgRTDndZWMoIHny/kKvhMZkPQ
         mBnYpAvKUzbWZ6NNx9rDwgAmhvQD0lfWIeF7I41tTuCnIGVMTJgiXUG0vJQSYAsgTkOB
         RGpQ==
X-Gm-Message-State: APjAAAWCpOG9IJVLotZon/gz/pUmyjHIkWOvV1bLpJI2x2wtpxOgSjfF
        voeHqbuDkB+C/YrmFYa/XUAV+pi7YHEhNeYBzpjbAoCS
X-Google-Smtp-Source: APXvYqxp485nYNDW+Op6Gikqr5hCb2I/N/zJwLAWIaqkZ0JejaH2p8x2EBjaEkM9me2CJmO22UOyn7h6+JA2pWJ4e8M=
X-Received: by 2002:a0c:d04a:: with SMTP id d10mr57748940qvh.189.1561396446261;
 Mon, 24 Jun 2019 10:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <CANQeFDCCGED3BR0oTpzQ75gtGpdGCw8FLf+kspBYytw3YteXAw@mail.gmail.com>
 <20190620083628.GH13630@quack2.suse.cz> <CANQeFDB_oSkb_0tBbqoL88UzGf6+FYqjZ3oOo1puSyR7aKtYOA@mail.gmail.com>
 <CAJfpeguGr66Oox27ThPUedDa+rDofehNC1f2gsb_C+eHay1kmg@mail.gmail.com> <20190624104106.GC32376@quack2.suse.cz>
In-Reply-To: <20190624104106.GC32376@quack2.suse.cz>
From:   Liu Bo <obuil.liubo@gmail.com>
Date:   Mon, 24 Jun 2019 10:13:55 -0700
Message-ID: <CANQeFDBYQH5Pxwk17rey6VsCDLV9_g0YX5u=OzcnpoojPveO+w@mail.gmail.com>
Subject: Re: a few questions about pagevc_lookup_entries
To:     Jan Kara <jack@suse.cz>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>, dan.j.williams@intel.com,
        Fengguang Wu <fengguang.wu@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 24, 2019 at 3:41 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 24-06-19 09:25:00, Miklos Szeredi wrote:
> > [cc: vivek, stefan, dgilbert]
> >
> > On Fri, Jun 21, 2019 at 12:04 AM Liu Bo <obuil.liubo@gmail.com> wrote:
> > >
> > > On Thu, Jun 20, 2019 at 1:36 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > [added some relevant lists to CC - this can safe some people debugging by
> > > > being able to google this discussion]
> > > >
> > > > On Wed 19-06-19 15:57:38, Liu Bo wrote:
> > > > > I found a weird dead loop within invalidate_inode_pages2_range, the
> > > > > reason being that  pagevec_lookup_entries(index=1) returns an indices
> > > > > array which has only one entry storing value 0, and this has led
> > > > > invalidate_inode_pages2_range() to a dead loop, something like,
> > > > >
> > > > > invalidate_inode_pages2_range()
> > > > >   -> while (pagevec_lookup_entries(index=1, indices))
> > > > >     ->  for (i = 0; i < pagevec_count(&pvec); i++) {
> > > > >       -> index = indices[0]; // index is set to 0
> > > > >       -> if (radix_tree_exceptional_entry(page)) {
> > > > >           -> if (!invalidate_exceptional_entry2()) //
> > > > >                   ->__dax_invalidate_mapping_entry // return 0
> > > > >                      -> // entry marked as PAGECACHE_TAG_DIRTY/TOWRITE
> > > > >                  ret = -EBUSY;
> > > > >           ->continue;
> > > > >           } // end of if (radix_tree_exceptional_entry(page))
> > > > >     -> index++; // index is set to 1
> > > > >
> > > > > The following debug[1] proved the above analysis,  I was wondering if
> > > > > this was a corner case that  pagevec_lookup_entries() allows or a
> > > > > known bug that has been fixed upstream?
> > > > >
> > > > > ps: the kernel in use is 4.19.30 (LTS).
> > > >
> > > > Hum, the above trace suggests you are using DAX. Are you really? Because the
> > > > stacktrace below shows we are working on fuse inode so that shouldn't
> > > > really be DAX inode...
> > > >
> > >
> > > So I was running tests against virtiofs[1] which adds dax support to
> > > fuse, with dax, fuse provides posix stuff while dax provides data
> > > channel.
> > >
> > > [1]: https://virtio-fs.gitlab.io/
> > > https://gitlab.com/virtio-fs/linux
>
> OK, thanks for the explanation and the pointer. So if I should guess, I'd
> say that there's some problem with multiorder entries (for PMD pages) in
> the radix tree. In particular if you lookup index 1 and there's
> multiorder entry for indices 0-511, radix_tree_next_chunk() is updating
> iter->index like:
>
> iter->index = (index &~ node_maxindex(node)) | (offset << node->shift);
>
> and offset is computed by radix_tree_descend() as:
>
> offset = (index >> parent->shift) & RADIX_TREE_MAP_MASK;
>
> So this all results in iter->index being set to 0 and thus confusing the
> iteration in invalidate_inode_pages2_range(). Current kernel has xarray
> code from Matthew which maintains originally passed index in xas.xa_index
> and thus the problem isn't there.
>
> So to sum up: Seems like a DAX-specific bug with PMD entries in older
> kernels fixed by xarray rewrite.
>

Thank you so much for the information, Jan.

I'll double check if that's the root cause and report back, if yes,
guess then we have to fix 4.19's radix tree in place to do the right
thing instead of porting back xarray rewrite..

thanks,
liubo

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
