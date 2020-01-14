Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9D13B34A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 20:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgANT6h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 14:58:37 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:42779 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgANT6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:58:37 -0500
Received: by mail-il1-f179.google.com with SMTP id t2so12637745ilq.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nr2suBWyH3G+SrgEdmZRyOadvDn7vyAkXtdlcbJy6/4=;
        b=aYomd4wid0gLfURx68KZmThGg8susm1oZebC86DWoGy17aPwwIHZCO/7aXwygnBiCu
         ypdTUjsihgMvxzsNSGl3o1sH1+edhCI2vNNrPmzk0qNsXOsdOOnKqDAleRw9Dwh91O2k
         hygkeIwpwgtMDTjTO7gWpin6jM3kA3kV6X5h8g6LAJVXwi7GEKcbFweoQD8cd5sdbkao
         iYEucLXAhLWFYXGjkPwgmjPugSoMAg3v4gHdRntXFqRqJRd8gsz5JFqCWK791uPdRPwy
         dWPb42NuNnrxGUB5WVEz2yo2BfAyZSLSepWumJBeIWNeRfcUwSSSZCALCaEafMvYHhC5
         9wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nr2suBWyH3G+SrgEdmZRyOadvDn7vyAkXtdlcbJy6/4=;
        b=Gu3g2rNOVqiCPed3GIBGBtasJ47oMfmRLbZcI81nPXeviKBCyyn3Kw1Cg1v9+ds4Sj
         ytXGJbrfHx8BA8M9YNpluGAjHiFYTdeYeP3R4QaManO5XFZTisyhjncZ4wuljiLRNfiB
         mvSPPJo9HK3rdmOsQWVDcSrra8P6GlUENZN7sooe/ZmWtiMwlWMiIP5+kJgxzhiNDxL0
         b3vODUaMI2qG2+v5CHa8/hPcbbAg2Ip11C99tAxxHq3gk4+qH4aZoJvHr+PAcatFbPum
         nyNCPieRPmjX9ZrNog0hwW4LqDQrUM3KGtJGGaIxbjTPzoeipZTDCgGrGFy7MHek0naM
         KZNQ==
X-Gm-Message-State: APjAAAUYHI6FMZuDFsc0cuKsY0e6NjtmTIN3ab7aWBf53wH5oeKaJii5
        v3TZ/TouPg1+4h6zvMpoZVUTy7fmgkD+w8Ix5qIIcA==
X-Google-Smtp-Source: APXvYqzvt7tQjE9nIbRq/GFGA8JfwPqvomO7FDWciY6I0Wm4Eq3osYgBIICZPCmG6GvM4efnYyVFw61IKKpA0yuWOvE=
X-Received: by 2002:a92:d5c3:: with SMTP id d3mr93904ilq.250.1579031916154;
 Tue, 14 Jan 2020 11:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20200114154034.30999-1-amir73il@gmail.com> <20200114162234.GZ8904@ZenIV.linux.org.uk>
 <CAOQ4uxjbRzuAPHbgyW+uGmamc=fZ=eT_p4wCSb0QT7edtUqu8Q@mail.gmail.com> <20200114191907.GC8904@ZenIV.linux.org.uk>
In-Reply-To: <20200114191907.GC8904@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 14 Jan 2020 21:58:25 +0200
Message-ID: <CAOQ4uxh-1cUQtWoNR+JzR0fCo-yEC4UrQGcZvKyj6Pg11G7FRQ@mail.gmail.com>
Subject: Re: dcache: abstract take_name_snapshot() interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 9:19 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jan 14, 2020 at 08:06:56PM +0200, Amir Goldstein wrote:
> > > // NOTE: release_dentry_name_snapshot() will be needed for both copies.
> > > clone_name_snapshot(struct name_snapshot *to, const struct name_snapshot *from)
> > > {
> > >         to->name = from->name;
> > >         if (likely(to->name.name == from->inline_name)) {
> > >                 memcpy(to->inline_name, from->inline_name,
> > >                         to->name.len);
> > >                 to->name.name = to->inline_name;
> > >         } else {
> > >                 struct external_name *p;
> > >                 p = container_of(to->name.name, struct external_name, name[0]);
> > >                 atomic_inc(&p->u.count);
> > >         }
> > > }
> > >
> > > and be done with that.  Avoids any extensions or tree-wide renamings, etc.
> >
> > I started with something like this but than in one of the early
> > revisions I needed
> > to pass some abstract reference around before cloning the name into the event,
> > but with my current patches I can get away with a simple:
> >
> > if (data_type == FANOTIFY_EVENT_NAME)
> >     clone_name_snapshot(&event->name, data);
> > else if (dentry)
> >     take_dentry_name_snapshot(&event->name, dentry);
> >
> > So that simple interface should be good enough for my needs.
>
> I really think it would be safer that way; do you want me to throw that into
> vfs.git (#work.dcache, perhaps)?  I don't have anything going on in the
> vicinity, so it's not likely to cause conflicts either way and nothing I'd
> seen posted on fsdevel seems to be likely to step into it, IIRC, so...
> Up to you.

Sure, that would be great.

Thanks,
Amir.
