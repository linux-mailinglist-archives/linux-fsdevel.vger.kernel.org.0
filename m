Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3165D79CC70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Sep 2023 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjILJwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Sep 2023 05:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjILJwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:52:33 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C812E5F
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 02:52:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so86116991fa.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Sep 2023 02:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694512348; x=1695117148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTzHMfb2PMnB/WCXfRvRMCtM+zTQXX2oSM6n6ez9S90=;
        b=AKflX3JEXrpjhrpkXU3lEV+Wd1VX5WjOdtjwRPuxcrc9zx0Sdcj7FOKvU7bNKv+csA
         pJEwky/iYjh8zgpEJ/YvApP9hCknaBQnexmQ1cOIr1/gZG33cPkCbQ0MHBHeDWcfGvpe
         Dc7B05lj/qDh4W2S/ii9aWjL4A9JODwRzbrH9HBlhwTbGeXsTAczN0G1oZ3COPtsfoby
         9LZkpNnwEkZwKrsuRMRbe/TlJq0dSM2EQtRE5zDy/UJHZT/5492yJBSFG9Xt9s38IR5P
         Rm2SuYDgIVqlzxIbY3bt8U4636nJxoeDKCosJZ4J/fcFwel2l26kaMm2fqrlgJQo4nfX
         iMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694512348; x=1695117148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTzHMfb2PMnB/WCXfRvRMCtM+zTQXX2oSM6n6ez9S90=;
        b=GTu/OWjeUTgYFTYbgk+KX9fym8ZdOcPKx4xxtbnE6avptekFrhrXE2TGAxufBHZCRV
         75Gkh4PKvZoX9TieKBmpGKCMoMzCFc7NOeXc5qLtmfbeIUjUnXrfgcjqG48MA4Dr/Kbf
         n6prkGgssohbzJgOMG/nKtbqNb2DFFfm0trDN8wKzHK+9EHZ9Ug/F89pQyRuO1hBvCbk
         tVXAjRtxVNNo7gGZw74Zjm5yNbHXfM10Q6qnEFx3nRDM+GTckUPpypI0wO86PYRsqPKn
         abIaAtFPGjHOswqNQG3HJFo/4zAVriQFmlAJNnt3Aolzzqk2mXBmuUm2M7F5JxCrg4Nb
         jXkQ==
X-Gm-Message-State: AOJu0YxZHP/hzymjT5NbIk6uTMhXvEYAXwFSnp7hazZg+IhpQmqwQUpB
        J+jfJK5XZqhr9TxGvIIMIknlno+QYqJkl1BL2zA=
X-Google-Smtp-Source: AGHT+IHBnuM5cZEpJAoHuof7kfZvuMORzseShHCbegClIE/2GKz8q41K15Yj6S+g62o5jnsWxDG/cJnQ8ZWePMLgiNY=
X-Received: by 2002:a2e:8194:0:b0:2b7:117:e54 with SMTP id e20-20020a2e8194000000b002b701170e54mr9901648ljg.4.1694512347465;
 Tue, 12 Sep 2023 02:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home>
 <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain> <20230907110409.GH19790@gate.crashing.org>
 <bd1fb81a-6bb7-4ab4-9f8c-55307f3e9590@kadam.mountain> <20230907123016.GJ19790@gate.crashing.org>
In-Reply-To: <20230907123016.GJ19790@gate.crashing.org>
From:   Richard Biener <richard.guenther@gmail.com>
Date:   Tue, 12 Sep 2023 11:50:26 +0200
Message-ID: <CAFiYyc3mqzH+K+woJpLMtQ4oOWkfq9KFb35pdNhKHOwQQvjJPw@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 7, 2023 at 2:32=E2=80=AFPM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Sep 07, 2023 at 02:23:00PM +0300, Dan Carpenter wrote:
> > On Thu, Sep 07, 2023 at 06:04:09AM -0500, Segher Boessenkool wrote:
> > > On Thu, Sep 07, 2023 at 12:48:25PM +0300, Dan Carpenter via Gcc-patch=
es wrote:
> > > > I started to hunt
> > > > down all the Makefile which add a -Werror but there are a lot and
> > > > eventually I got bored and gave up.
> > >
> > > I have a patch stack for that, since 2014 or so.  I build Linux with
> > > unreleased GCC versions all the time, so pretty much any new warning =
is
> > > fatal if you unwisely use -Werror.
> > >
> > > > Someone should patch GCC so there it checks an environment variable=
 to
> > > > ignore -Werror.  Somethine like this?
> > >
> > > No.  You should patch your program, instead.
> >
> > There are 2930 Makefiles in the kernel source.
>
> Yes.  And you need patches to about thirty.  Or a bit more, if you want
> to do it more cleanly.  This isn't a guess.
>
> > > One easy way is to add a
> > > -Wno-error at the end of your command lines.  Or even just -w if you
> > > want or need a bigger hammer.
> >
> > I tried that.  Some of the Makefiles check an environemnt variable as
> > well if you want to turn off -Werror.  It's not a complete solution at
> > all.  I have no idea what a complete solution looks like because I gave
> > up.
>
> A solution can not involve changing the compiler.  That is just saying
> the kernel doesn't know how to fix its own problems, so let's give the
> compiler some more unnecessary problems.

You can change the compiler by replacing it with a script that appends
-Wno-error
for example.

> > > Or nicer, put it all in Kconfig, like powerpc already has for example=
.
> > > There is a CONFIG_WERROR as well, so maybe use that in all places?
> >
> > That's a good idea but I'm trying to compile old kernels and not the
> > current kernel.
>
> You can patch older kernels, too, you know :-)
>
> If you need to not make any changes to your source code for some crazy
> reason (political perhaps?), just use a shell script or shell function
> instead of invoking the compiler driver directly?
>
>
> Segher
>
> Segher
