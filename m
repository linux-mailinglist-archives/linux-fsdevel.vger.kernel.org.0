Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D402C69A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Nov 2020 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgK0Qlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 11:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgK0Qlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:41:55 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33216C0613D1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 08:41:55 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t143so6439339oif.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2020 08:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvWvhtMw4/htNL9ufrpeeiTrNh5C8K1xoJuv3kml8OU=;
        b=mWijLgZ5NSU7tK5Er9vqbGC4jbfS0Bqq/aYyMsemdaGkzC26693YU2vfClXz6l5bFX
         8V9Tmh1URUsBmfAtzpfJBSsWjrAMMRM9/VMPWONetAV5szTP8VaMKJt+DpMU0x3qRxB/
         4YoNhkXtcge1clOF9lx0p8oXJqD3ybi1HvdmslWxLE5axdlugRoidPml/hLfeIITAWtl
         yTKrJi82eFqDSzCwL+Yzgm5kKBDeaBT1VyKWR1CG4OsbzW+rx4h73WYKIcI9FPIy9+GM
         iu3pcLOuzKUDAHJ3BQiAIDZYWXTxv9STtLSAcRtxi6amYyeKf3Y7xbbxGpa2Uz/KoAYg
         /0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvWvhtMw4/htNL9ufrpeeiTrNh5C8K1xoJuv3kml8OU=;
        b=H+6HYDMhDi88IKXwiP79ZQf4wlyNk6av7Gqe6svAO6mwHEY/2pxPHS99OQgBCDur01
         4fPaCiHcbOviYqJDCnajvg79P1AH9LneHkHHImrq+4j1GBsjBtV+tIwV9bGmMEN/CO9f
         /UlHUsLymZQ8q1qWQ/ws8T5cQckp3a0FT6DjCrxTI2ZIQeK1nqAnFgmKl7sNDWZxmiHo
         QmCQMWDXdJFXR5vo6BDbjWEraDCgpB4/uaaASdz4iKPKeGs/SK/OEI3oqZVj12c4k8vD
         BEi2xSKwFnl9UURhdcDUsi4rdHBWvdJHkrKfgPekxTrueRsrXRNwRsy146VoDwmN8tc2
         hNiQ==
X-Gm-Message-State: AOAM533uoZs3WsRY1zrSqXS5fo89d7ykvaM2OS7WO8CybHT/zbzz20v2
        CvYOAYP9F1tBm+qMV0tQaFzWeWkazhOLHgllNh0=
X-Google-Smtp-Source: ABdhPJwRKRxB7y76hqIzaFmgJaVpdK47Nv9ZPEeXr/XzuKloFjYjcqgPameihf+YTWPob14ioae9JMvesl5/ldmcCDA=
X-Received: by 2002:a05:6808:3b1:: with SMTP id n17mr6121939oie.139.1606495314568;
 Fri, 27 Nov 2020 08:41:54 -0800 (PST)
MIME-Version: 1.0
References: <CAE1WUT6O6uP12YMU1NaU-4CR-AaxRUhhWHY=zUtNXpHUfxrF=A@mail.gmail.com>
 <20201109013322.GA9685@magnolia> <20201109015001.GX17076@casper.infradead.org>
 <CAE1WUT7LBAKYoZ=-UxEdt1OdoirwcKMU_A=6TAKPo7HxwnS+zw@mail.gmail.com> <20201109033559.GY17076@casper.infradead.org>
In-Reply-To: <20201109033559.GY17076@casper.infradead.org>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Fri, 27 Nov 2020 08:41:43 -0800
Message-ID: <CAE1WUT4-jc-R-Hi2X8QpnNBCNMv3Bb4jWivnVzB1Lu=VCxupcA@mail.gmail.com>
Subject: Re: Best solution for shifting DAX_ZERO_PAGE to XA_ZERO_ENTRY
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sorry for the long reply time - personal issues came up.

On Sun, Nov 8, 2020 at 7:36 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Nov 08, 2020 at 05:54:14PM -0800, Amy Parker wrote:
> > On Sun, Nov 8, 2020 at 5:50 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Sun, Nov 08, 2020 at 05:33:22PM -0800, Darrick J. Wong wrote:
> > > > On Sun, Nov 08, 2020 at 05:15:55PM -0800, Amy Parker wrote:
> > > > > XA_ZERO_ENTRY
> > > > > is defined in include/linux/xarray.h, where it's defined using
> > > > > xa_mk_internal(257). This function returns a void pointer, which
> > > > > is incompatible with the bitwise arithmetic it is performed on with.
> > >
> > > We don't really perform bitwise arithmetic on it, outside of:
> > >
> > > static int dax_is_zero_entry(void *entry)
> > > {
> > >         return xa_to_value(entry) & DAX_ZERO_PAGE;
> > > }
> >
> > We also have:
> >
> > if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
> >        unsigned long index = xas->xa_index;
> >        /* we are replacing a zero page with block mapping */
> >        if (dax_is_pmd_entry(entry))
> >               unmap_mapping_pages(mapping, index & ~PG_PMD_COLOUR,
> >                             PG_PMD_NR, false);
> >        else /* pte entry */
> >               unmap_mapping_pages(mapping, index, 1, false);
> > }
> >
> > and:
> >
> > *entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
> >               DAX_PMD | DAX_ZERO_PAGE, false);
>
> Right.  We need to be able to distinguish whether an entry represents
> a PMD size.  So maybe we need XA_ZERO_PMD_ENTRY ... ?  Or we could use
> the recently-added xa_get_order().

I could add an additional dependent patch for this. Where would we
want XA_ZERO_PMD_ENTRY declared? Considering we're dependent
on DAX_PMD, I'd say in fs/dax.c, but if there's a better solution I'm missing...

> >
> > That'd probably be a better idea - so what should we do about the type
> > issue? Not typecasting it causes it not to compile.
>
> I don't think you'll need to do any casting once the bit operations go
> away ...

True, but what're we going to do about dax_is_zero_entry? We haven't
figured out what to do about that yet... a typecast back to void* of
xa_to_value locally could work, as it itself is just shifting an entry right
by 1 bit and then typecasting it to unsigned long. Thoughts?

Best regards,
Amy Parker
(she/her)
