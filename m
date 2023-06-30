Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF10743C5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjF3NFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3NFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:05:49 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6E535AF;
        Fri, 30 Jun 2023 06:05:48 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5634db21a58so1224545eaf.0;
        Fri, 30 Jun 2023 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688130347; x=1690722347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2+8E7VuNWe1l9mNYwfvfSAKevjWtL1Yf1fmko9VETk=;
        b=L5x2OjQt6fEmqJ2imvQYfYWiIvlrVy6HyQYNtl3IOUoJmQO0Qiol1/tHgm82d9MmZv
         aOKRJz6Mx/KIWMVW6ZKLR0hJnA0nlPSERZyYjxA/N+CX1Nw3bkniCPbZb5hF7zo3bDvu
         YXHe7VJuTs6/qy2QwDifJ8WBGPj52ZgbFMQ/ihviJ4zDmH45XCI1PzfCvqVktPBlqcOD
         tp6ODwBheFDKOfpfDIXwHf80LZT7Ge8vJTN061bDOdc6VASuus/omaVSo8LduBIX/kzB
         fHJviKM7CHFlDpQEiBQVM67QZjngoZNu+LMHRhKJY/8ejLjQJKsFWAvgb06Hz/qP2fJf
         embA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688130347; x=1690722347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2+8E7VuNWe1l9mNYwfvfSAKevjWtL1Yf1fmko9VETk=;
        b=GflsbiRRWpd7yJLrhTDqugSqkSf/KPwBv1X/XVe8293/5lvk9av5HJ1XsFgnJh/A8p
         IXbEwTP/7uWCp4RIdIRljqisPSUPwHp8RuIk4IY+k7ffV9WMv6IY93iVc8tUbFE0yNU0
         tWZFuqNKfuI1xqaaM8D69Fo+IAD9inC07/RcoYhDyDG/GzCVdsu/mtIw3siCNHattDjb
         8TsVUPUvgAjlvUO4cJMpJHK4taCSsoSUhslG+TtqlxeLz8FV8O6MGMeTIRFYFWZk7+9G
         riO4u9Nmn2BDBuc3w2ekpXcpJ2o69tb48a7yuIImHrwKTzmtzboSyBjDndeHUeg6L9Ex
         Zvpg==
X-Gm-Message-State: ABy/qLa8FVBmfx6P6R0YwlJiiAb0RI28YqDI0kve+dmI1XY5bFzMsln9
        /I6VPDdHXTwlmUbEFva+3k2w52PMYnkcFKdsOfc=
X-Google-Smtp-Source: APBJJlHGMv5+prMCX0VtQqlu61CGL+n8D24VeyPgkllazLXihHbNH+OVyl6DY1gyWArJUkkP7eL/k1QRsxqRZriA+OQ=
X-Received: by 2002:a05:6359:d0f:b0:134:e4c4:ebff with SMTP id
 gp15-20020a0563590d0f00b00134e4c4ebffmr2319969rwb.11.1688130347147; Fri, 30
 Jun 2023 06:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org> <20230629181408.GM11467@frogsfrogsfrogs>
 <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
 <CAOQ4uxiD6a9GmKwagRpUWBPRWCczB52Tsu5m6_igDzTQSLcs0w@mail.gmail.com> <CALrw=nHH2u=+utzy8NfP6+fM6kOgtW0hdUHwK9-BWdYq+t-UoA@mail.gmail.com>
In-Reply-To: <CALrw=nHH2u=+utzy8NfP6+fM6kOgtW0hdUHwK9-BWdYq+t-UoA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 30 Jun 2023 16:05:36 +0300
Message-ID: <CAOQ4uxju10zrQhVDA5WS+vTSbuW17vOD6EGBBJUmZg8c95vsrA@mail.gmail.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to stale
 cached iomap
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Leah Rumancik <lrumancik@google.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
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

On Fri, Jun 30, 2023 at 3:30=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> On Fri, Jun 30, 2023 at 11:39=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > On Thu, Jun 29, 2023 at 10:31=E2=80=AFPM Ignat Korchagin <ignat@cloudfl=
are.com> wrote:
> > >
> > > On Thu, Jun 29, 2023 at 7:14=E2=80=AFPM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >
> > > > [add the xfs lts maintainers]
> > > >
> > > > On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> > > > > On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > > > > > Hi Dave and Derrick,
> > > > > >
> > > > > > We are tracking down some corruptions on xfs for our rocksdb wo=
rkload,
> > > > > > running on kernel 6.1.25. The corruptions were
> > > > > > detected by rocksdb block checksum. The workload seems to share=
 some
> > > > > > similarities
> > > > > > with the multi-threaded write workload described in
> > > > > > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@=
dread.disaster.area/
> > > > > >
> > > > > > Can we backport the patch series to stable since it seemed to f=
ix data
> > > > > > corruptions ?
> > > > >
> > > > > For clarity, are you asking for permission or advice about doing =
this
> > > > > yourself, or are you asking somebody else to do the backport for =
you?
> > > >
> > > > Nobody's officially committed to backporting and testing patches fo=
r
> > > > 6.1; are you (Cloudflare) volunteering?
> > >
> > > Yes, we have applied them on top of 6.1.36, will be gradually
> > > releasing to our servers and will report back if we see the issues go
> > > away
> > >
> >
> > Getting feedback back from Cloudflare production servers is awesome
> > but it's not enough.
> >
> > The standard for getting xfs LTS backports approved is:
> > 1. Test the backports against regressions with several rounds of fstest=
s
> >     check -g auto on selected xfs configurations [1]
> > 2. Post the backport series to xfs list and get an ACK from upstream
> >     xfs maintainers
> >
> > We have volunteers doing this work for 5.4.y, 5.10.y and 5.15.y.
> > We do not yet have a volunteer to do that work for 6.1.y.
> >
> > The question is whether you (or your team) are volunteering to
> > do that work for 6.1.y xfs backports to help share the load?
>
> We are not a big team and apart from other internal project work our
> efforts are focused on fixing this issue in production, because it
> affects many teams and workloads. If we confirm that these patches fix
> the issue in production, we will definitely consider dedicating some
> work to ensure they are officially backported. But if not - we would
> be required to search for a fix first before we can commit to any
> work.
>
> So, IOW - can we come back to you a bit later on this after we get the
> feedback from production?
>

Of course.
The volunteering question for 6.1.y is independent.

When you decide that you have a series of backports
that proves to fix a real bug in production,
a way to test the series will be worked out.

Thanks,
Amir.
