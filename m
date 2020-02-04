Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69E68151ED9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 18:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBDRCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 12:02:18 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35345 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgBDRCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:02:18 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so21764102iob.2;
        Tue, 04 Feb 2020 09:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hgrgZa0/qPIZBM7xd/+cQT5nbAgAJPDrB+di6igVMM=;
        b=CLSeYeek5KGnACnmxd9hBeeW3NWeHluT/MTzWH7gzDZFIWrtTUFnfUmZedmR736lM3
         jXVANRsSJ5nEeEmOcGa5PqseOrPcDFnSmWKcR9WWKKWiFfTTW+SY8HLO/b6p+k4aNYep
         Log19NYHXAhaAn0UFGRPrcL3kul6emclRLoDviNvR9a9bwfuZdj8TEZMjHVldTHxHn2B
         N1RsgRCSya2WLd91pet2/oSTKEkBRylMeeucI52Ic7dKC52KwPJt0t/KWZkTP1WAw3zt
         /+2TLt30vik9Km97CE9IUn7VQ3H+afAgpmli9fVG7YoW9pWu2YRCGINdL+/Y1KVfj676
         X7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hgrgZa0/qPIZBM7xd/+cQT5nbAgAJPDrB+di6igVMM=;
        b=TcOAL5aVgQ0tG5GKJ5pTLXFFf+3nxlv/XfS0aOsaAx4YciCvj0EuHStFxSc6aEUENj
         jAVZEBkZXYx1ip4dPka2BQHgMR+7O7WBrj1C3L317/ymFX1dXpq5LIqyf2UlZtuoaCMi
         z+kQwVra82sZhRbsSQSXeJ+sXY0dNqCsMi4WWUgG9DGAKPs4LDOpNulydIgJdzRPhP6t
         4mWhAc/Jwdd9Zq3wDyTbklYqGi2fN8fIvmNldvpFicbAGfKNF/fcyUne73bx1aG9jEPS
         VojI2IdjBRqUN4tqndeIFvKWxfaPHnpb0cDIu7C1SJsIpsb5+d2g8rg8iTNTm/jMKkL/
         jVVg==
X-Gm-Message-State: APjAAAWxsSzFbdq7HD/NCPt5HwZ5Rakl5vEPkpxXCb4GurPQ0H9/isz8
        8BNZI7nd4+8n+IzipAFsEzbVT3wIspQCpTs4OPSL43dM
X-Google-Smtp-Source: APXvYqxgCpIN+gtthDP/i0jdMkcmrP34/2jH4H9TEOMr9I/YIyCpa9Sf7hP9rj9A+3T318kIwEHUBM+yZKZhMO4V1DU=
X-Received: by 2002:a02:c558:: with SMTP id g24mr25003659jaj.81.1580835737864;
 Tue, 04 Feb 2020 09:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
In-Reply-To: <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Feb 2020 19:02:05 +0200
Message-ID: <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > revalidation in that case, just as we already do for lower layers.
> > >
> > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > case.
> >
> > Hi Miklos,
> >
> > I have couple of very basic questions.
> >
> > - So with this change, we will allow NFS to be upper layer also?
>
> I haven't tested, but I think it will fail on the d_type test.

But we do not fail mount on no d_type support...
Besides, I though you were going to add the RENAME_WHITEOUT
test to avert untested network fs as upper.

>
> > - What does revalidation on lower/upper mean? Does that mean that
> >   lower/upper can now change underneath overlayfs and overlayfs will
> >   cope with it.
>
> No, that's a more complicated thing.  Especially with redirected
> layers (i.e. revalidating a redirect actually means revalidating all
> the path components of that redirect).
>
> > If we still expect underlying layers not to change, then
> >   what's the point of calling ->revalidate().
>
> That's a good question; I guess because that's what the filesystem
> expects.  OTOH, it's probably unnecessary in most cases, since the
> path could come from an open file descriptor, in which case the vfs
> will not do any revalidation on that path.
>

Note that ovl_dentry_revalidate() never returns 0 and therefore, vfs
will never actually redo the lookup, but instead return -ESTALE
to userspace. Right? This makes some sense considering that underlying
layers are not expected to change.

The question is, with virtiofs, can we know that the server/host will not
invalidate entries? And if it does, should it cause a permanent error
in overlayfs or a transient error? If we do not want a permanent error,
then ->revalidate() needs to be called to invalidate the overlay dentry. No?

Thanks,
Amir.
