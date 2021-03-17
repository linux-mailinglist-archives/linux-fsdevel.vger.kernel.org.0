Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636A533E89A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 05:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCQE4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 00:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhCQEzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:55:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3DEC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 21:55:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c10so464903ejx.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 21:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R9Su8BT2yWWWTsxwDOrtHcEfB6yWhXQeHaQOaR7lJs0=;
        b=O6sx9FFHvjxesWJe/kyNeeBwWtW52JhZ86uNybfLp1n5nVpFA0IdiS1FOjx1HpoaD3
         v98nvCJdMQQRsZF4Ahu2nvix+wWfSe6qAHxAlqqAICsBrPdWX3GX5tW9Jy52xYO03bG2
         tq7uMOyEKMG4n2m4kmyRyxz9EpkWw4r97rCHXVZFOL8YDM+2i24h4NIe9+6TTy1Ry1tu
         QiRCdpVKVXGNYNe/nBpvBvBRoBPu2da836m6NDtDeN4NNFm6Y84CYIBl6C6eVwoPXJ5A
         9d8jt1DnkFlIM91CFSuKs6O1m+RJp0IKPkWx3F1g46JqMwRFiBaSlwlFy8gmhIBpdAUc
         4ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R9Su8BT2yWWWTsxwDOrtHcEfB6yWhXQeHaQOaR7lJs0=;
        b=pueOZ3oTvNNER7h37XRZ/nCBvAP0dZq6kBOn7I1m/ezTxy5FCHnjWgz+42JrSVrri/
         BXrfgE0LZIyU1bkW/2uuVgEihor4w+RVLAdjGtb1aMQnCr4qiMnoM46qIsN6HlFAMrFX
         28V5TZjrH7Ef9F193G16Cgy4UfyZUKqRi7JNuw+j+uj5EiF6BU6GJw4hwk56QpWTDr3Y
         8L8djaL35Jxsdcca8Cz4UY1BYJdSEmW7ClQEAiquR8PzIFF0uCL0FzM34CtKRhjMnRNg
         bmt1q0or+sTOvqyFM9d+I4SemoqeCo8hVIuS2iNOc2m+rOycmuupcThd5CzlfVjPnwys
         zE0Q==
X-Gm-Message-State: AOAM531B6SQ6Ulp7KG4qC14QgVvjJdzhMb0hIe4GZza66wQ78OvD4PnS
        jNT3W6vFo9vPxz5VKZDCd87ic76W+jPePTltZ8WEEw==
X-Google-Smtp-Source: ABdhPJwIO/ogRUlUiVl0dBLKIRZNfZtAdaRzwMYSyKIDI5BrQSkoOFC21rPTMy4VEFzJeUUvJsOKadQ+mLG8+8a/sbQ=
X-Received: by 2002:a17:906:1386:: with SMTP id f6mr32943546ejc.45.1615956933554;
 Tue, 16 Mar 2021 21:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <CE1E7D7EFA066443B6454A6A5063B50220D0B849@dggeml509-mbs.china.huawei.com>
 <20210311121923.GU3479805@casper.infradead.org> <CAPcyv4jz7-uq+T-sd_U3O_C7SB9nYWVJDnhVsaM0VNR207m8xA@mail.gmail.com>
 <CE1E7D7EFA066443B6454A6A5063B50220D12A8A@dggeml509-mbs.china.huawei.com>
In-Reply-To: <CE1E7D7EFA066443B6454A6A5063B50220D12A8A@dggeml509-mbs.china.huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Mar 2021 21:55:27 -0700
Message-ID: <CAPcyv4i2evDrYVgh4ir_ddRfO7tOgmWPSZf893JTO=+mcG7-XQ@mail.gmail.com>
Subject: Re: [question] Panic in dax_writeback_one
To:     "chenjun (AM)" <chenjun102@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "lizhe (Y)" <lizhe67@huawei.com>, yangerkun <yangerkun@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 8:00 PM chenjun (AM) <chenjun102@huawei.com> wrote:
>
> =E5=9C=A8 2021/3/12 1:25, Dan Williams =E5=86=99=E9=81=93:
> > On Thu, Mar 11, 2021 at 4:20 AM Matthew Wilcox <willy@infradead.org> wr=
ote:
> >>
> >> On Thu, Mar 11, 2021 at 07:48:25AM +0000, chenjun (AM) wrote:
> >>> static int dax_writeback_one(struct xa_state *xas, struct dax_device
> >>> *dax_dev, struct address_space *mapping, void *entry)
> >>> ----dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_S=
IZE);
> >>> The pfn is returned by the driver. In my case, the pfn does not have
> >>> struct page. so pfn_to_page(pfn) return a wrong address.
> >>
> >> I wasn't involved, but I think the right solution here is simply to
> >> replace page_address(pfn_to_page(pfn)) with pfn_to_virt(pfn).  I don't
> >> know why Dan decided to do this in the more complicated way.
> >
> > pfn_to_virt() only works for the direct-map. If pages are not mapped I
> > don't see how pfn_to_virt() is expected to work.
> >
> > The real question Chenjun is why are you writing a new simulator of
> > memory as a block-device vs reusing the pmem driver or brd?
> >
>
> Hi Dan
>
> In my case, I do not want to take memory to create the struct page of
> the memory my driver used.

There are efforts happening to drastically reduce that overhead. You
might want to check out Joao's work [1]. I think that direction holds
more promise than trying to extend FS_DAX_LIMITED.

[1]: http://lore.kernel.org/r/20201208172901.17384-1-joao.m.martins@oracle.=
com

> And, I think this is also a problem for DCSSBLK.

If I understand correctly DAX replaced XIP for S390. There have not
been reports about this problem, and I can only guess because XIP
(eXecute-In-Place) is a read-only use case where dax_writeback_one()
is never triggered, or S390 just isn't using DCSSBLK anymore. The last
time I touched FS_DAX_LIMITED the DCSSBLK maintainers offered to just
delete this driver to get it out of the way.

>
> So I want to go back the older way if CONFIG_FS_DAX_LIMITED
>
> diff --git a/fs/dax.c b/fs/dax.c
> index b3d27fd..6395e84 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -867,6 +867,9 @@ static int dax_writeback_one(struct xa_state *xas,
> struct dax_device *dax_dev,
>   {
>         unsigned long pfn, index, count;
>         long ret =3D 0;
> +       void *kaddr;
> +       pfn_t new_pfn_t;
> +       pgoff_t pgoff;
>
>         /*
>          * A page got tagged dirty in DAX mapping? Something is seriously
> @@ -926,7 +929,25 @@ static int dax_writeback_one(struct xa_state *xas,
> struct dax_device *dax_dev,
>         index =3D xas->xa_index & ~(count - 1);
>
>         dax_entry_mkclean(mapping, index, pfn);
> -       dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_S=
IZE);
> +
> +       if (!IS_ENABLED(CONFIG_FS_DAX_LIMITED) || pfn_valid(pfn))
> +               kaddr =3D page_address(pfn_to_page(pfn));
> +       else {
> +               ret =3D bdev_dax_pgoff(mapping->host->i_sb->s_bdev, pfn <=
<
> PFN_SECTION_SHIFT, count << PAGE_SHIFT, &pgoff);

This is broken:

    mapping->host->i_sb->s_bdev

...there is no guarantee that the superblock associated with the
mapping is hosted on the same block device associated with the passed
in dax_device. See dax_rtdev in xfs_open_devices().
