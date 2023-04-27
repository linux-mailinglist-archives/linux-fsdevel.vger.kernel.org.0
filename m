Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE126F08E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243994AbjD0P62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243864AbjD0P61 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:58:27 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C277F9;
        Thu, 27 Apr 2023 08:58:26 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7782debbc94so3126427241.2;
        Thu, 27 Apr 2023 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682611105; x=1685203105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P18Wv2FC8o6U5G8C7PnaZJ5mkZtojpUaPqsXnDkwsNo=;
        b=HhpRnB9nO+jTaU/MWSaEozOH2x6ji7LIGJ92QE0g1y2Eq1CjpBb4E1LqqyZh5K913t
         f1LjlDDjU7R18UTtW3gZQXCeSauihkvi+7JL+CiLQjMI4fODwF7NW5ktnIDCnIr33EEE
         owTfkZtIPOSwfSenrxmaZ/uDQhS/ryjEvQLp95PEZkkxa2+2axqeP5PMNpDuh0Z/5fs5
         fBsE+L5ThYpqb40HP8bmmI0OOKtpmSzTOJqqOZpWfhu52L2vJRL3+IvRdaCbHWfI1Rk+
         H2p2T8tQnZYAoKKWZL6Qm1nRFgTVwa0NVg3df1d5F6S8KoJJ8IW7aab38XwbPg280xP5
         vEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611105; x=1685203105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P18Wv2FC8o6U5G8C7PnaZJ5mkZtojpUaPqsXnDkwsNo=;
        b=eMeqGg0zsqu6tQwDeRO32h2ekgDM+vaEG78Uum1aLnk+5Bz71iHIle42YaRiFJLjIJ
         hoorTdmQesLYVZyAV+JC8+n0LTxuV0+7OF2KLyWSDTRCDSZedLdsRGw5S+JB+6l1BhZG
         jNBSqNnSCLr8YuD1649UaazjWsHp/lTKhiR6bSPR9yOnR1TXEB41bzX2vSqqD4jpiFF4
         dcsc4lfPYRbyb+ROo1cCLin/HC6XY7aYumwCiHDI31l1CrPUvO0SJSaErZuQ0/9FIvWd
         sdWkSx/RxY8NsfxNhfcTiB9s/a3/Vi2iVRcfL/QNKXdraffc37JR6mB+JJHz4C4XsEH9
         EQyQ==
X-Gm-Message-State: AC+VfDwFlqT6+UXIHSvrwqTEFj62/Jy1W+sbjsZaC4gGJxtksFeuTEA5
        LqoT8UM9Uq3FxO5bWs2awrzP1sfv7s4Tyz19FgQ=
X-Google-Smtp-Source: ACHHUZ5pko2MARqLkpMbNCky/0liEvMZxL5XvKyyuvESVkSs5bjRRN55AXeSSYHbI5vXwTtRV51pugDWi1OkBmxAtU0=
X-Received: by 2002:a67:f701:0:b0:42e:4cc3:5b4 with SMTP id
 m1-20020a67f701000000b0042e4cc305b4mr1225181vso.12.1682611105069; Thu, 27 Apr
 2023 08:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegu6xqH3U1icRcY1SeyVh0h-CirXJ-oaCXUsLCZGQgExUQ@mail.gmail.com>
 <CA+PiJmRYG=KOhjw5M+JBKHEEN1XfE2fYQhn+3NDLr_Gw3yBozA@mail.gmail.com>
In-Reply-To: <CA+PiJmRYG=KOhjw5M+JBKHEEN1XfE2fYQhn+3NDLr_Gw3yBozA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 27 Apr 2023 18:58:14 +0300
Message-ID: <CAOQ4uxgaPkGPppTqL0TEcrY-8h61D+1RcLbSbSnxY8XChghQaw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] fuse passthrough solutions and status
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Paul Lawrence <paullawrence@google.com>,
        bpf <bpf@vger.kernel.org>, lsf-pc@lists.linux-foundation.org,
        Alessio Balsini <balsini@android.com>,
        Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 25, 2023 at 2:59=E2=80=AFAM Daniel Rosenberg via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
> On Fri, Feb 10, 2023 at 7:52 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > Several fuse based filesystems pass file data from an underlying
> > filesystem without modification.  The added value can come from
> > changed directory structure, changed metadata or the ability to
> > intercept I/O only in special cases.  This pattern is very common, so
> > optimizing it could be very worthwhile.
> >
> > I'd like to discuss proposed solutions to enabling data passthrough.
> > There are several prototypes:
> >
> >  - fuse2[1] (myself, very old)
> >  - fuse-passthrough[2] (Alessio Balsini, more recent)
> >  - fuse-bpf[3] (Daniel Rosenberg, new)
> >
> > The scope of fuse-bpf is much wider, but it does offer conditional
> > passthrough behavior as well.
> >
> > One of the questions is how to reference underlying files.  Passing
> > open file descriptors directly in the fuse messages could be
> > dangerous[4].  Setting up the mapping from an open file descriptor to
> > the kernel using an ioctl() instead should be safe.
> >
> > Other open issues:
> >
> >  - what shall be the lifetime of the mapping?
> >
> >  - does the mapped open file need to be visible to userspace?
> > Remember, this is a kernel module, so there's no process involved
> > where you could look at /proc/PID/fd.  Adding a kernel thread for each
> > fuse instance that installs these mapped fds as actual file descriptor
> > might be the solution.
> >
> > Thanks,
> > Miklos
> >
> >
> > [1] https://lore.kernel.org/all/CAJfpegtjEoE7H8tayLaQHG9fRSBiVuaspnmPr2=
oQiOZXVB1+7g@mail.gmail.com/
> >
> > [2] https://lore.kernel.org/all/20210125153057.3623715-1-balsini@androi=
d.com/
> >
> > [3] https://lore.kernel.org/all/20221122021536.1629178-1-drosen@google.=
com/
> >
> > [4] https://lore.kernel.org/all/CAG48ez17uXtjCTa7xpa=3DJWz3iBbNDQTKO2hv=
n6PAZtfW3kXgcA@mail.gmail.com/
>
> I'd be very interested to discuss fuse-bpf, and how it aligns with the
> other efforts. I recall there being some io uring effort as well,
> though I haven't looked into that too much yet.
>

For the record, I scheduled a (30 min) session for this with you and Miklos
co-leads.

Bernd's session on FUSE uring will follow right after.

Thanks,
Amir.
