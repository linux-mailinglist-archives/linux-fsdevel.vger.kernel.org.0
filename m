Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E64221BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 07:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgGPFRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 01:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:17:48 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC96C061755
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 22:17:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so5203167ejb.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhKdkyhzBCrHDBJwUUcPf+KwT6tO1Wi+tMUkn7td2RQ=;
        b=b1LEFcnRYx1nTMkOSj0eTB/2U15B9GIWDLABwl6F+4oXlXbNreUFFzUVlzRmtbZH/W
         zEWxLPDgqjA61HLvxaZ9e4ueIt3ocMzY1cHVlZXTlS5SDYZuedDggNjvXdr/fBmtRWPy
         IDSyjQDt6/FnzYzq7AU4G/iOD6Z2hM4bUWXUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhKdkyhzBCrHDBJwUUcPf+KwT6tO1Wi+tMUkn7td2RQ=;
        b=k4dYw61ikE83z7x9UE+OVE43xE9AFN92Dxt6h23Shb4Mdgv7dLW01KMqfhBgVpAjmF
         aJKFiQqcuKinVmpRx60dxxYL4JQ5C85F4ssNdkH05YA4gnMO3wqgzQ3mvTUU58fkPmx5
         cQeDzDi0m4f+sUphp3Itm6Jbe4vjjkRivZPAJtwORnQx9P7JWXwFA+zP+bFqmu9VRO1Z
         NZVvQxlPjRGjo2eEV69LmaDa6aUKXsNCjhEB38nglIPCAbUPVFRDCDtbdGyFFE22DQO6
         /ovATHsGTwedkVCP3Ixp2SatgTSjI10Os+4+yJWBcAvqcpD5scdl4LcvpBktWh8iH0A1
         OkRw==
X-Gm-Message-State: AOAM532gVY95tptik1RjKCGGdQw3DnwdJytbOuAMKXAHkv61KPZ807f3
        IjH3iqPljekA4Cad9UK5uuRPU42mHAMxJg2g/amKzg==
X-Google-Smtp-Source: ABdhPJwR08O0tTC70WK+dzUYKsRlUldZiUJ9by9ozP6Qb0JMiLS/i4upeHK3NPcl15T56c1fTQWRZ8W5qEvKKyNMrcI=
X-Received: by 2002:a17:906:3c42:: with SMTP id i2mr2339121ejg.14.1594876666485;
 Wed, 15 Jul 2020 22:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200714102639.662048-1-chirantan@chromium.org>
 <CAJfpegvd3nHWLtxjeC8BfW8JTHKRmX5iNgdWYYFj+MEK-ogiFw@mail.gmail.com> <CA+icZUWDtOHpgTCEhPatYfR+zJAbOBK2ihtf7G=zzCKAxiVmsQ@mail.gmail.com>
In-Reply-To: <CA+icZUWDtOHpgTCEhPatYfR+zJAbOBK2ihtf7G=zzCKAxiVmsQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 16 Jul 2020 07:17:35 +0200
Message-ID: <CAJfpegvG+xMNaL4r1UATGu6tjZqjapp50=Z4rsq6sumaBzwFMQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix parameter for FS_IOC_{GET,SET}FLAGS
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Chirantan Ekbote <chirantan@chromium.org>,
        linux-fsdevel@vger.kernel.org, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 1:06 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jul 15, 2020 at 5:05 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > On Tue, Jul 14, 2020 at 12:26 PM Chirantan Ekbote
> > <chirantan@chromium.org> wrote:
> > >
> > > The ioctl encoding for this parameter is a long but the documentation
> > > says it should be an int and the kernel drivers expect it to be an int.
> > > If the fuse driver treats this as a long it might end up scribbling over
> > > the stack of a userspace process that only allocated enough space for an
> > > int.
> > >
> > > This was previously discussed in [1] and a patch for fuse was proposed
> > > in [2].  From what I can tell the patch in [2] was nacked in favor of
> > > adding new, "fixed" ioctls and using those from userspace.  However
> > > there is still no "fixed" version of these ioctls and the fact is that
> > > it's sometimes infeasible to change all userspace to use the new one.
> >
> > Okay, applied.
> >
>
> ...and pushed? I do not see in in fuse.git.

Pushed now.

Thanks,
Miklos
