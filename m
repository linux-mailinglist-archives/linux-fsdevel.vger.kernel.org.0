Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7597113D973
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 13:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAPL77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 06:59:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgAPL76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579175997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVlll+9epLEfpQSpTpRDRqetzl16SU3ouLx+y4VzUXw=;
        b=Y8zuL16rB2nXKsOJ/egBexWLsL4NG9OifUmFJytIbRK1W9r9d8X8aWajVkb5eHGjQQvYji
        N9rjEKdD/+Dv7mIolCLmBo90G5XOZrHqnPZoqo5VPrHWDh+x4swSmG4IQ140Viceo/OIgv
        zn98kz46HHnpRo/1lMbd6lXBunUXJiw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-GFIy9PHAMtinqpOhvavwEg-1; Thu, 16 Jan 2020 06:59:56 -0500
X-MC-Unique: GFIy9PHAMtinqpOhvavwEg-1
Received: by mail-qt1-f198.google.com with SMTP id l5so13480158qte.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2020 03:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NVlll+9epLEfpQSpTpRDRqetzl16SU3ouLx+y4VzUXw=;
        b=fKPRJYJgOI/6US6GNgJVzkq4EOKT0UJF7fp0ZMqeRn6ryAoIn7ukFrGC33KPsSt5P5
         Khj6CNWRASFIb5wIphv58Dn6PHL7NtirkCGUST9U1HPLE5iVVIf2uu6bnG2tOAfDmTBq
         JKoksTTuFyhXCsP8RCoNL2jqU6+5gXjl9REt8zWxr/MdHwqQR9jKU2ObJkLmIJRkjy0E
         8J4dIWNBmv6ZvACBCdASpkA52NVpPJd9yKXVvmHiA/Cdds5ES9vpVefzdS/d0A83+DeM
         VK62cQwEu8K1SokkD2vmW/nqPViDHNvkrXhjysN2LHNj7MJqSj+RrgMj9QO2gXmPiX1L
         hdYg==
X-Gm-Message-State: APjAAAV26VoWrg4f/tQlVk457oga2jz5BJ/xYkoLVD6h8qx1/H8LkjKl
        FkL9Cyq+LlVkR0tMXrPEbfnbBp0CpNii73hMFOOmAgc7IboOLFl0MwO6nfndmMIZYXTYXv0chPr
        gJ0mREmJ0YjE2jaLc/eRmCvu0j8NxIIjRyy1utPdcig==
X-Received: by 2002:a37:a042:: with SMTP id j63mr31675080qke.156.1579175995804;
        Thu, 16 Jan 2020 03:59:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqx8ceW1MVVch1WnxF39TcDvpv6YYcrXJ8tg2vLbV56dFam9hlkEuzYKy5pZiU0uzIkAr9ClmvDq0du+bFXBPi8=
X-Received: by 2002:a37:a042:: with SMTP id j63mr31675067qke.156.1579175995549;
 Thu, 16 Jan 2020 03:59:55 -0800 (PST)
MIME-Version: 1.0
References: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
 <CAJfpegsECDNeL0FmaB=BsYdYrmZSLpG5etvwhW5uQWGJJjODeg@mail.gmail.com>
 <CA+wuGHBV=YH5-bnNZvZSMzB+Tt0VyuEKFUZV8d_Htptxp3=_eQ@mail.gmail.com> <20200116101545.GA28605@miu.piliscsaba.redhat.com>
In-Reply-To: <20200116101545.GA28605@miu.piliscsaba.redhat.com>
From:   Ondrej Holy <oholy@redhat.com>
Date:   Thu, 16 Jan 2020 12:59:19 +0100
Message-ID: <CA+wuGHAVySJykzr4_qMSiZ0JYrjUrnn2ASrFaCoj3pk969papg@mail.gmail.com>
Subject: Re: Weird fuse_operations.read calls with Linux 5.4
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=C4=8Dt 16. 1. 2020 v 11:16 odes=C3=ADlatel Miklos Szeredi <miklos@szeredi.=
hu> napsal:
>
> On Wed, Jan 15, 2020 at 01:24:52PM +0100, Ondrej Holy wrote:
> > st 15. 1. 2020 v 12:41 odes=C3=ADlatel Miklos Szeredi <miklos@szeredi.h=
u> napsal:
> > >
> > > On Wed, Jan 15, 2020 at 9:28 AM Ondrej Holy <oholy@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I have been directed here from https://github.com/libfuse/libfuse/i=
ssues/488.
> > > >
> > > > My issue is that with Linux Kernel 5.4, one read kernel call (e.g.
> > > > made by cat tool) triggers two fuse_operations.read executions and =
in
> > > > both cases with 0 offset even though that first read successfully
> > > > returned some bytes.
> > > >
> > > > For gvfs, it leads to redundant I/O operations, or to "Operation no=
t
> > > > supported" errors if seeking is not supported. This doesn't happen
> > > > with Linux 5.3. Any idea what is wrong here?
> > > >
> > > > $ strace cat /run/user/1000/gvfs/ftp\:host\=3Dserver\,user\=3Duser/=
foo
> > > > ...
> > > > openat(AT_FDCWD, "/run/user/1000/gvfs/ftp:host=3Dserver,user=3Duser=
/foo",
> > >
> > > Hi, I'm trying to reproduce this on fedora30, but even failing to get
> > > that "cat" to work.  I've  replaced "server" with a public ftp server=
,
> > > but it's not even getting to the ftp backend.  Is there a trick to
> > > enable the ftp backend?  Haven't found the answer by googling...
> >
> > Hi Miklos,
> >
> > you need gvfs and gvfs-fuse packages installed. Then it should be
> > enough to mount some share, e.g. over Nautilus, or using just "gio
> > mount ftp://user@server/". Once some share is mounted, then you should
> > see it in /run/user/$UID/gvfs. I can reproduce on Fedora 31 with
> > kernel-5.4.10-200.fc31.x86_64, whereas kernel-5.3.16-300.fc31.x86_64
> > works without any issues.
>
> Thanks, I was missing the "gio mount ..." command.
>
> Here's a patch that should fix it.  Will go into 5.5-rc7 and will be back=
ported
> to 5.4.x stable series.

That sounds great!

Thanks a lot

Ondrej

