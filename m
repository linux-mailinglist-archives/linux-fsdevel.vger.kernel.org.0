Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65E21CA805
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 12:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEHKOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgEHKOH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 06:14:07 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98AAC05BD43;
        Fri,  8 May 2020 03:14:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q10so932228ile.0;
        Fri, 08 May 2020 03:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhA1BBa4NsPm3rIlgXZArVumo+yjVGMobhO6ZOoqYRs=;
        b=j1+g9B8h+aRkZjugMpLxA77lzkdbkqgnmjbB326bQLFMbMMd3h/8DNaT/QoBwKLtfh
         KXpX36Yy+zI/n0HpXpFGOWA0k7mrQdoDUKEq69HVNbU3UwDWJ0hS31NrGkc9wMdmB/b7
         pS/6Ujeo1Mm76OIaW9za3ve0FETBb43Cx4wq1Xnh8IXlUt6gVMu80FYn2pl+QT3peryP
         nnWFGNLcYbPYw+43q0rG/P/d0Ui+zNYXhsHr3zjTrnw8EDDxz6DCNLAd4GYDrlDm9O4n
         I2Cs/jhDWfBsWy1PFXrs50xEVXbNx1KP6Kg8De55qosONq/NkdeeFwL3EUcwj4V8I+Vp
         nkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhA1BBa4NsPm3rIlgXZArVumo+yjVGMobhO6ZOoqYRs=;
        b=MM1R5bW35pZvWKAwgqi91nFGrU9ghgGwuOmLUQ72zKI4JuoqDwMkIKL4/j0e148fhl
         feezUmD20709OnHtpKsXVSP/aPNhdq2jd2DWWjwLP/JA1isNxm+wAkhbRqFoyqi5xhqu
         5GmNMrjxWaOpi0Nvpuaqkr9hCpw4PszVx6IxB43bDjT/Sfe6VWLlYEQWTNMoEZTA9WTe
         ta9LZDvjwgf8GIe/nrCg6DtW7Ra65TvS8gFVt/eVCy7r63IdhHeZb3O31FN/9GHipfbb
         1azgoamxQNfyjMmlSPnrQYzNV3TJ0Gb+Sl1dsltEs0w7KJjt1I7sjVIr5kUOhXvazQ4Z
         gPpQ==
X-Gm-Message-State: AGi0PubgcSEeR9YqOIPRQi9xA9VeyuSi+hI0JjDEoprc7fyvUFeUyQGp
        Sd4olGMdTQ8dXjRaNyUmoZEh1fZufE6GvGGVkGdwt2LP
X-Google-Smtp-Source: APiQypIrWPSTx9U/IY+i09/JOejnZGX4BIxq4JUPLFLlBVnEgrKehCVn3ZZpq8559VWoZAjN5PEwfwz56bqv3fQil3M=
X-Received: by 2002:a92:d2c1:: with SMTP id w1mr1787919ilg.96.1588932846340;
 Fri, 08 May 2020 03:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
 <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
 <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com>
 <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com> <CAJfpegvWBHootLiE_zsw35G6Ee387V=Da_wCzaV9NhZQVDKYGg@mail.gmail.com>
In-Reply-To: <CAJfpegvWBHootLiE_zsw35G6Ee387V=Da_wCzaV9NhZQVDKYGg@mail.gmail.com>
From:   Chakra Divi <chakragithub@gmail.com>
Date:   Fri, 8 May 2020 15:43:54 +0530
Message-ID: <CAH7=fosn3fnNBkKzHNBSvoQh+Gjpi2J0mZ3rRENitMmFmpHcUw@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 1:51 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Apr 27, 2020 at 3:46 PM Chakra Divi <chakragithub@gmail.com> wrote:
> >
> > On Tue, Apr 21, 2020 at 4:21 PM Chakra Divi <chakragithub@gmail.com> wrote:
> > >
> > > On Mon, Apr 20, 2020 at 4:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
> > > > >
> > > > > In current code, for exec we are checking mode bits
> > > > > for x bit set even though the fuse_perm_getattr returns
> > > > > success. Changes in this patch avoids mode bit explicit
> > > > > check, leaves the exec checking to fuse file system
> > > > > in uspace.
> > > >
> > > > Why is this needed?
> > >
> > > Thanks for responding Miklos. We have an use case with our remote file
> > > system mounted on fuse , where permissions checks will happen remotely
> > > without the need of mode bits. In case of read, write it worked
> > > without issues. But for executable files, we found that fuse kernel is
> > > explicitly checking 'x' mode bit set on the file. We want this
> > > checking also to be pushed to remote instead of kernel doing it - so
> > > modified the kernel code to send getattr op to usespace in exec case
> > > too.
> >
> > Any help on this Miklos....
>
> I still don't understand what you are requesting.  What your patch
> does is unconditionally allow execution, even without any 'x' bits in
> the mode.  What does that achieve?

Thanks for the help Miklos. We have a network based filesystem that
supports acls.
As our filesystem give granular access, we wipe out the mode bits and
completely rely on ACLs.

Fuse works well for all other ops (with default_permissions disabled )
 as all the checks are done at the filesystems.
But only executables have problems because fuse kernel rejects the
execution by doing access checks on mode bit.
To push this check to filesystem, in the above patch - i'm relying on
return value from fuse_perm_getattr() ignoring the mode bits.

When the fuse module is asked to rely on filesystem for access checks,
why do we need this explicit check for executables?
I found out that it is the same issue with nfs too. Is there a reason
for it ? Should we not push this check to filesystem ?

Thanks,
Chakra
>
> Thanks,
> Miklos
