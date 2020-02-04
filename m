Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1971520CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 20:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgBDTLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 14:11:53 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38182 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgBDTLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:11:53 -0500
Received: by mail-io1-f66.google.com with SMTP id s24so22211103iog.5;
        Tue, 04 Feb 2020 11:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgG8Aq1eztnn8MeKd1kOrjhva+lvRx+uFNlRHL5Qu5I=;
        b=uZInOuNauUYF1jvM/tnRGgkRGL0wfuh8xNLYFI8v3njC90tE3jdcOonalGltGzeQ2n
         Gdc0dS8IpDhm4wyBUtVUZghCp/AGi+F4bOG4h7If6sPAZaip1IvRl/8mG3LRB4P49zIi
         uCVYqkbgM/+JGcV/VBosz1zxU7He1HMaAJ7g7ERVlWBzW44TF79aZZZ4T9DLSPwaGfLZ
         atkfP/ET5xWHjbYTV3cSFONdxu2pa46Vraqu04ZU2w4oa+6qNAdBIhe9cTiR8alStb5W
         cl4kzkfbeg4rYfUO1eqgOqTpwZGNTUP9u5LX+n7oc+pFfasZG2e0u6rAGUizSOzr8Xvv
         nveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgG8Aq1eztnn8MeKd1kOrjhva+lvRx+uFNlRHL5Qu5I=;
        b=kdRW6Pcfv3idHr/HUvGexwD0OzCyCAsvZUo+s1WGBNqyGIGiGfEbxJu6/5+z2UKvSi
         xtTRcWrLXO80P98GpraXQHGKefA2gsqeDEts09EmyRsokVvEp1oVQ7kYSugyqFgAZ7Rh
         p8F7z/n7SLXlRrU1/S7QgPa+1G7MEt8l/2UjAuvV6zgn8Se9AJe95V9cpNYdoGO5vXc0
         Bc/t9Ba8mYejHF6iam/HgqVEE3OfJwbcjDVf9J0asTry7L+DDLabsmjfgE/eQRXrs1Yt
         Js7SH2s4EYn78Zk/DkrMSXw3+afRauMZHAzUdemGD1Q46xtonLwNKbrbYzXQdMw8qWh5
         kosA==
X-Gm-Message-State: APjAAAV1TjK5/P/KvYPyqTJTke7IByIXaBieiwpa0oRB1SBBnPH17v0b
        FJ+Rzs6U3bZsDFTxa+EMy3E29uzWObHiJMvwBS8=
X-Google-Smtp-Source: APXvYqx2o6LrUei5DNhzbK+xbt8F9aQdjZPLZXRv4TpQJjenwJlWW5kuprX/zqiFsKW5XAmo4f1j68K/B7tEYyurnSA=
X-Received: by 2002:a5d:9c8c:: with SMTP id p12mr25031745iop.72.1580843512760;
 Tue, 04 Feb 2020 11:11:52 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <20200204145951.GC11631@redhat.com> <CAJfpegtq4A-m9vOPwUftiotC_Xv6w-dnhCi9=E0t-b1ZPJXPGw@mail.gmail.com>
 <CAOQ4uxj_pVp9-EN2Gmq9j6G3xozzpK_zQiRO-brx6PZ9VpgD0Q@mail.gmail.com> <20200204184221.GA24566@redhat.com>
In-Reply-To: <20200204184221.GA24566@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 4 Feb 2020 21:11:41 +0200
Message-ID: <CAOQ4uxhfV++XvO17ywftnhLoryYsynF=Y-pHCwmPdymc6naOFg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 4, 2020 at 8:42 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Feb 04, 2020 at 07:02:05PM +0200, Amir Goldstein wrote:
> > On Tue, Feb 4, 2020 at 6:17 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Tue, Feb 4, 2020 at 3:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > >
> > > > On Fri, Jan 31, 2020 at 12:50:04PM +0100, Miklos Szeredi wrote:
> > > > > No reason to prevent upper layer being a remote filesystem.  Do the
> > > > > revalidation in that case, just as we already do for lower layers.
> > > > >
> > > > > This lets virtiofs be used as upper layer, which appears to be a real use
> > > > > case.
> > > >
> > > > Hi Miklos,
> > > >
> > > > I have couple of very basic questions.
> > > >
> > > > - So with this change, we will allow NFS to be upper layer also?
> > >
> > > I haven't tested, but I think it will fail on the d_type test.
> >
> > But we do not fail mount on no d_type support...
> > Besides, I though you were going to add the RENAME_WHITEOUT
> > test to avert untested network fs as upper.
> >
> > >
> > > > - What does revalidation on lower/upper mean? Does that mean that
> > > >   lower/upper can now change underneath overlayfs and overlayfs will
> > > >   cope with it.
> > >
> > > No, that's a more complicated thing.  Especially with redirected
> > > layers (i.e. revalidating a redirect actually means revalidating all
> > > the path components of that redirect).
> > >
> > > > If we still expect underlying layers not to change, then
> > > >   what's the point of calling ->revalidate().
> > >
> > > That's a good question; I guess because that's what the filesystem
> > > expects.  OTOH, it's probably unnecessary in most cases, since the
> > > path could come from an open file descriptor, in which case the vfs
> > > will not do any revalidation on that path.
> > >
> >
> > Note that ovl_dentry_revalidate() never returns 0 and therefore, vfs
> > will never actually redo the lookup, but instead return -ESTALE
> > to userspace. Right? This makes some sense considering that underlying
> > layers are not expected to change.
> >
> > The question is, with virtiofs, can we know that the server/host will not
> > invalidate entries?
>
> I don't think virtiofs will ensure that server/host will not invalidate
> entries. It will be more of a configuration thing where we will expect
> users to configure things in such a way that shared directory does not
> change.
>
> So that means, if user does not configure it properly and things change
> unexpectedly, then overlayfs should be able to detect it and flag error
> to user space?
>
> > And if it does, should it cause a permanent error
> > in overlayfs or a transient error? If we do not want a permanent error,
> > then ->revalidate() needs to be called to invalidate the overlay dentry. No?
>
> So as of now user space will get -ESTALE and that will get cleared when
> user space retries after corresponding ovl dentry has been dropped from
> cache (either dentry is evicted, cache is cleared forcibly or overlayfs
> is remounted)? If yes, that kind of makes sense. Overlay does not expect
> underlying layers to change and if a change it detected it is flagged
> to user space (and overlayfs does not try to fix it)?
>

I looks like it. I don't really understand why overlayfs shouldn't drop
the dentry on failure to revalidate. Maybe I am missing something.

Thanks,
Amir.
