Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1635EC8D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 18:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiI0QAb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 12:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiI0QA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:00:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC95C7CB73;
        Tue, 27 Sep 2022 09:00:25 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so10500255pjk.2;
        Tue, 27 Sep 2022 09:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=/4Cya9CjV4N5Sr7mOC5bS8nn29gbgT+L6zRPTFmyUBk=;
        b=V9EgwFsB9S7m3ODTCzkW2bhniuFar+JJyRuvMoEF3JRZLYR3H39+Muu35G1GoEUi0/
         dGOKQ4ghBWznXQo93OwWmzDsAC0mIVD6+JY1N70BqQw6OPDcX4HBgaRsoUy0ysejZwys
         eh3aU0vF0vRJ51Qqplm5BeNrVDW5pC/f/HQFApDr5yAdzs7y1Iv3agMg6jDIM8bbkwkm
         BxHRuR/f3hPSqN60OD6P2e0Zwmlwx+X6yhQcchZJGTDLt+xRPxz+rbaX++iwZVMqFjcv
         chEtLoDmMkxyKE+kHfe8c2+HPtXuvGIOTY4VbltEYmtMjVav6hT8tlVb907QppfLto1H
         QkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/4Cya9CjV4N5Sr7mOC5bS8nn29gbgT+L6zRPTFmyUBk=;
        b=C7qDs49B28RrcNRqqEMBVZbSec3Ub8a3DOi0JREVD8/SfnN1trBaMmtwgUXel+Ni2t
         mX4FPPvdwr46rjXyeU4AgvTo6HYSKJsyn8DmsU+pnVAyHBDm2FS1FSNqn0cBiNSA8hdN
         VyjRnqFGj94bZxb8QERkwfy/EsNEO2eojPhPbuL3pucR0QIW0v2U31bNb4/Qa3W2YVmD
         WMXA4LX4mmaF8AElZsY3ILHiUN2GcZHSvBNfAKWpOL6MCWaHhdHl/4QCu3RtGeDHWfiE
         tVQoW1ilHYexCZrvbvIT8UyF0DW4rfkmcM5EDQYnm9e6DPWOn2MocI1P5A+tFceOP+y5
         SsMQ==
X-Gm-Message-State: ACrzQf3VvXXCcj6bW+iZ2x0v3aiEfv00sFCRxw/ceCscYae3bAxq2QiQ
        YRDsw51YFBQPG3UtZTrKLEyukxwiQ2pEdpP40gLSOmB8iURLvw==
X-Google-Smtp-Source: AMsMyM6hcpIN7XxM6Qqe1iqgpXg/gQNwNhKhih7O5Q++zwaFY67XdEVUE6/9V3oSVAIQYiAcZ8NqDgZb9t5pMvejsRo=
X-Received: by 2002:a17:902:cec4:b0:176:be0f:5c79 with SMTP id
 d4-20020a170902cec400b00176be0f5c79mr28456466plg.40.1664294424710; Tue, 27
 Sep 2022 09:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl> <202209270818.5BA5AA62@keescook>
In-Reply-To: <202209270818.5BA5AA62@keescook>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 27 Sep 2022 17:00:13 +0100
Message-ID: <CANeycqqDNjRjcRNW02cDNsZSiA+ixEXAZzpJSJFgLtTrM6k9Ww@mail.gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 27 Sept 2022 at 16:19, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 27, 2022 at 04:11:38PM +0200, Geert Stappers wrote:
> > On Tue, Sep 27, 2022 at 03:14:58PM +0200, Miguel Ojeda wrote:
> > > Miguel, Alex and Wedson will be maintaining the Rust support.
> > >
> > > Boqun, Gary and Bj=C3=B6rn will be reviewers.
> > >
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> > > Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> > > Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> > > Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > ---
> > >  MAINTAINERS | 18 ++++++++++++++++++
> > >  1 file changed, 18 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index f5ca4aefd184..944dc265b64d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17758,6 +17758,24 @@ F: include/rv/
> > >  F: kernel/trace/rv/
> > >  F: tools/verification/
> > >
> > > +RUST
> > > +M: Miguel Ojeda <ojeda@kernel.org>
> > > +M: Alex Gaynor <alex.gaynor@gmail.com>
> > > +M: Wedson Almeida Filho <wedsonaf@google.com>
> > <screenshot from=3D"response of a reply-to-all that I just did">
> >   ** Address not found **
> >
> >   Your message wasn't delivered to wedsonaf@google.com because the
> >   address couldn't be found, or is unable to receive mail.
> >
> >   Learn more here: https://support.google.com/mail/answer/6596
> >
> >   The response was:
> >
> >     The email account that you tried to reach does not exist. Please tr=
y
> >     double-checking the recipient's email address for typos or unnecess=
ary
> >     spaces. Learn more at https://support.google.com/mail/answer/6596
> > </screenshot>
>
> Wedson, can you send (or Ack) the following patch? :)

Acked-by: Wedson Almeida Filho <wedsonaf@gmail.com>

>
> diff --git a/.mailmap b/.mailmap
> index d175777af078..3a7fe4ee56fb 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -433,6 +433,7 @@ Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com=
>
>  Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
>  Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
>  WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
> +Wedson Almeida Filho <wedsonaf@gmail.com> <wedsonaf@google.com>
>  Will Deacon <will@kernel.org> <will.deacon@arm.com>
>  Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
>  Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
>
> --
> Kees Cook
