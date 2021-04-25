Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF6A36A3FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Apr 2021 03:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhDYBwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Apr 2021 21:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhDYBwj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Apr 2021 21:52:39 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEFC061574
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Apr 2021 18:52:00 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id y14-20020a056830208eb02902a1c9fa4c64so12297248otq.9
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Apr 2021 18:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZjHr6wxtjPAcncCZddDDuYn/2t6szRadP1tZCxo6s/Y=;
        b=PhbNlwjW/0mmrNseSVG7rk6af7XrscpDPrCT2fpHtcCLkdcaXEwqvkzYcqvPhTwlYg
         ymb0JaA6v7/NelYvfCTcq4qzdOznGU67DI+5ZAm8DIY0cAFRLIm+CULzO4GnwyJfuUHq
         vCgUbgGhh4AWxF9D9AekJ63722sfZDfIcD7iU3HZnPTIyGyh5EwlzG+Y0FOolfaB5RXQ
         wMZs2eN71IA5CHx4F2/0U/7r2K6aX8Z+O+UmaSL99RFGSgeOiYpYiJ7ML554/g3VjzCx
         GO25GhwG3CpS+4w5W9ERHvAc2rIVh23AS4Egt6N0yqtvDo8qW1GQsaZId3B4EjEUb7bx
         lPug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZjHr6wxtjPAcncCZddDDuYn/2t6szRadP1tZCxo6s/Y=;
        b=tmwyjy67eGPrdopKL2KS0ZkHxeqrT60BjyrqweahA7UxRBEaFIlEWANBhgiQxP6uyf
         gyzoBGqRW9+84o4awgABI+3u8O3+Rh2/itMNj3Zz8AJCKoUyor3ocH74uYPW9FQlAGLr
         Jz5wknBI2GID5t2XrTM19FP15nUF3YM504O+3ittkf0j0Wo59lIf4/bsqhGK5aPPkJaS
         S2RLX17ryKMYbG3Pv2KjBzsWDddZhjAoh32jzgWqcel+6ARyDWTB4hB+4nMnfLrmhyjs
         LnNF+yCxPQNSH+FTcb4x8wbk+c3Q6j4LSZjt6DXQPoEr8zJ1DfWdQk021zhrt+Kc6fM4
         xeAw==
X-Gm-Message-State: AOAM533mHV5Ifqfi8/iWEMoR0+iytyKT38zGBe7lF3Vco0zFN2MLptAS
        MJY5KefOKl18GdyN/I+D5e37BMG7IPlgTcoe2i9DVQ==
X-Google-Smtp-Source: ABdhPJyKVwwOdcYS4VD/q3xCECiG5UN3+bVBRIweb1GzXKRy+fO6IxDiXyax85AgujYaAOk2hrjVTLKcFI4UBorWGpE=
X-Received: by 2002:a9d:479a:: with SMTP id b26mr121686otf.180.1619315519512;
 Sat, 24 Apr 2021 18:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210327135659.GH1719932@casper.infradead.org>
 <CAOg9mSRCdaBfLABFYvikHPe1YH6TkTx2tGU186RDso0S=z-S4A@mail.gmail.com>
 <20210327155630.GJ1719932@casper.infradead.org> <CAOg9mSSxrPEd4XsWseMOnpMGzDAE5Pm0YHcZE7gBdefpsReRzg@mail.gmail.com>
 <CAOg9mSSaDsEEQD7cwbsCi9WA=nSAD78wSJV_5Gu=Kc778z57zA@mail.gmail.com>
 <1720948.1617010659@warthog.procyon.org.uk> <CAOg9mSTEepP-BjV85dOmk6hbhQXYtz2k1y5G1RbN9boN7Mw3wA@mail.gmail.com>
 <CAOg9mSQTRfS1Wyd_ULbN8cS7FstH9ix-um9ZeKLa2O=xLgF+-Q@mail.gmail.com>
 <1268214.1618326494@warthog.procyon.org.uk> <CAOg9mSSxZUwZ0-OdCfb7gLgETkCJOd-9PCrpqWwzqXffwMSejA@mail.gmail.com>
 <20210416151405.GK2531743@casper.infradead.org>
In-Reply-To: <20210416151405.GK2531743@casper.infradead.org>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Sat, 24 Apr 2021 21:51:48 -0400
Message-ID: <CAOg9mST_Q=r2sX5YX-M+BrbmZfQN46BDMmfw-Q4kgbF46V3M5w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>You do?!  Actual readahead implementations, or
>>people still implementing the old ->readpages() method?

No :-) I grabbed that as an example off the top of
my head of the kind of thing I saw while reading
readahead code, but that I didn't try to handle
in my simple implementation of readahead. I'm
guessing that since I have some xfstest regressions
maybe my implementation overlooks one or
more important details...

-Mike

On Fri, Apr 16, 2021 at 11:14 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Apr 16, 2021 at 10:36:52AM -0400, Mike Marshall wrote:
> > So... I think all your stuff is working well from my perspective
> > and that I need to figure out why my orangefs_readahead patch
> > is causing the regressions I listed. My readahead implementation (via your
> > readahead_expand) is really fast, but it is bare-bones... I'm probably
> > leaving out some important stuff... I see other filesystem's
> > readahead implementations doing stuff like avoiding doing readahead
> > on pages that have yet to be written back for example.
>
> You do?!  Actual readahead implementations, or people still implementing
> the old ->readpages() method?  The ->readahead() method is _only_ called
> for pages which are freshly allocated, Locked and !Uptodate.  If you ever
> see a page which is Dirty or Writeback, something has gone very wrong.
> Could you tell me which filesystem you saw that bogosity in?
>
> > The top two commits at https://github.com/hubcapsc/linux/tree/readahead_v3
> > is the current state of my readahead implementation.
> >
> > Please do add
> > Tested-by: Mike Marshall <hubcap@omnibond.com>
> >
> > -Mike
> >
> > On Tue, Apr 13, 2021 at 11:08 AM David Howells <dhowells@redhat.com> wrote:
> > >
> > > Mike Marshall <hubcap@omnibond.com> wrote:
> > >
> > > > Hi David... I've been gone on a motorcycle adventure,
> > > > sorry for the delay... here's my public branch...
> > > >
> > > > https://github.com/hubcapsc/linux/tree/readahead_v3
> > >
> > > That seems to have all of my fscache-iter branch in it.  I thought you'd said
> > > you'd dropped them because they were causing problems.
> > >
> > > Anyway, I've distilled the basic netfs lib patches, including the readahead
> > > expansion patch and ITER_XARRAY patch here:
> > >
> > >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-lib
> > >
> > > if that's of use to you?
> > >
> > > If you're using any of these patches, would it be possible to get a Tested-by
> > > for them that I can add?
> > >
> > > David
> > >
