Return-Path: <linux-fsdevel+bounces-897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B57D2996
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 07:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA523B20E13
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 05:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0605240;
	Mon, 23 Oct 2023 05:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="REJoacNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B384C92
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 05:19:16 +0000 (UTC)
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE129E9
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:19:14 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457bac7c3f5so1166564137.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Oct 2023 22:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gwmail.gwu.edu; s=google; t=1698038354; x=1698643154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPKNsYw47vEU08LvLMgxXuyAW0YiYMmyg4gd050CiD0=;
        b=REJoacNJJCD37L8IrikoySgOmq0HKaAdufNFEnfL7A/8Y/jsZwbmi9mALQ6eFHT3s4
         CjTN4hUnKxiwo6aKD+W6CNYAkg1fUKtMtuQiEnEnKCrE8dhGInrRLvp2kTwga+AIqCM9
         qBa6Gy55g9miiUG24DzdyMYpa2dm30+MqfQTy5fQJqXzschjVEZ/Zv8g20WXfPnt3wVJ
         TeStnX5ezRInQVVPHtyL5wMRzDq7alAA0rpZbKEVLOUmSaqxJtI7cZEsZDNtJJ4aYKCm
         Wq2uPf1yMLpPx8nYYIikkM1hyBKy6mcQnYCCMq3bizPwaLAnmRfDx2VFlWSihL+bQ1XH
         MorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698038354; x=1698643154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPKNsYw47vEU08LvLMgxXuyAW0YiYMmyg4gd050CiD0=;
        b=YPYQSBc5zaHMJqdSSafmho8m+ik7coOK4zZ1zYeOBV1/RUUMyZKprolKETBfQjMDYv
         1YrqJ6BtLj0MjMWhH4gFc6F+ednWGJKTkaIM+P8JJGPh5RAe5ow3TbHPl1xpDCdC7myU
         kJ9NA8ClhcJsm4lVNy7hc53pGChP3ukIUnOKVIOiEAObqgpifkvDi3IBnwS/3Y99WuIh
         075MbItAF0aQ62YyI5RsPyLEmTz1+4a5b8nfhJcCqBuUI/BQIcNk96M1/qkM3D5fC6zq
         eKLOMonEC7U6BLtYXNj6YEez51VKmEMDdsdK0ejXhdMgJ4sexs8OEmg8qRkIYkpMGn36
         Q+mg==
X-Gm-Message-State: AOJu0YzFD13ULmpr4YtKt2iFTulDQZMUNI9Ad8xX+KiZqy6VpTTmdahB
	+R5xINaEYaSarv7yPoGtlU5GLpAFW9jD9bS5jpmQQQ8SyNp2vRHltuY=
X-Google-Smtp-Source: AGHT+IEh6O5HX3O6bl7YbAamdDTtMciz3awzt2ARYdDjbYU12YPU+XbGQCu2nw5h2MHEdeM5mI/xBn2w4BcOndf5v3Q=
X-Received: by 2002:a67:c003:0:b0:457:e2cf:2a6 with SMTP id
 v3-20020a67c003000000b00457e2cf02a6mr8088241vsi.8.1698038354028; Sun, 22 Oct
 2023 22:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZO9NK0FchtYjOuIH@infradead.org> <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area> <20230906215327.18a45c89@gandalf.local.home>
 <4af7c904-ac36-44c9-83c4-2cb30c732672@kadam.mountain> <20230907110409.GH19790@gate.crashing.org>
 <bd1fb81a-6bb7-4ab4-9f8c-55307f3e9590@kadam.mountain> <20230907123016.GJ19790@gate.crashing.org>
 <CAFiYyc3mqzH+K+woJpLMtQ4oOWkfq9KFb35pdNhKHOwQQvjJPw@mail.gmail.com>
In-Reply-To: <CAFiYyc3mqzH+K+woJpLMtQ4oOWkfq9KFb35pdNhKHOwQQvjJPw@mail.gmail.com>
From: Eric Gallager <egall@gwmail.gwu.edu>
Date: Mon, 23 Oct 2023 01:19:02 -0400
Message-ID: <CAMfHzOs3B9wqh5YmOm61B7inknDMR39+LWTYeovybPp=3PE_9g@mail.gmail.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
To: Richard Biener <richard.guenther@gmail.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Dave Chinner <david@fromorbit.com>, 
	Guenter Roeck <linux@roeck-us.net>, Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, gcc-patches@gcc.gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2023 at 5:53=E2=80=AFAM Richard Biener via Gcc-patches
<gcc-patches@gcc.gnu.org> wrote:
>
> On Thu, Sep 7, 2023 at 2:32=E2=80=AFPM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Thu, Sep 07, 2023 at 02:23:00PM +0300, Dan Carpenter wrote:
> > > On Thu, Sep 07, 2023 at 06:04:09AM -0500, Segher Boessenkool wrote:
> > > > On Thu, Sep 07, 2023 at 12:48:25PM +0300, Dan Carpenter via Gcc-pat=
ches wrote:
> > > > > I started to hunt
> > > > > down all the Makefile which add a -Werror but there are a lot and
> > > > > eventually I got bored and gave up.
> > > >
> > > > I have a patch stack for that, since 2014 or so.  I build Linux wit=
h
> > > > unreleased GCC versions all the time, so pretty much any new warnin=
g is
> > > > fatal if you unwisely use -Werror.
> > > >
> > > > > Someone should patch GCC so there it checks an environment variab=
le to
> > > > > ignore -Werror.  Somethine like this?
> > > >
> > > > No.  You should patch your program, instead.
> > >
> > > There are 2930 Makefiles in the kernel source.
> >
> > Yes.  And you need patches to about thirty.  Or a bit more, if you want
> > to do it more cleanly.  This isn't a guess.
> >
> > > > One easy way is to add a
> > > > -Wno-error at the end of your command lines.  Or even just -w if yo=
u
> > > > want or need a bigger hammer.
> > >
> > > I tried that.  Some of the Makefiles check an environemnt variable as
> > > well if you want to turn off -Werror.  It's not a complete solution a=
t
> > > all.  I have no idea what a complete solution looks like because I ga=
ve
> > > up.
> >
> > A solution can not involve changing the compiler.  That is just saying
> > the kernel doesn't know how to fix its own problems, so let's give the
> > compiler some more unnecessary problems.
>
> You can change the compiler by replacing it with a script that appends
> -Wno-error
> for example.

I personally would find the original proposal of an IGNORE_WERROR
environment variable much simpler than any of the alternative proposed
solutions, especially for complicated build systems where I can't tell
where the "-Werror" is getting inserted from. Often times I'm not
actually the developer of the package I'm trying to compile, so saying
"fix your code" in such a case doesn't make sense, since it's not
actually my code to fix in the first place. It would be much easier
for end-users in such a situation to just set an environment variable,
rather than asking them to try to become developers themselves, which
is what some of these alternative proposals (such as "write your own
script!") seem to be asking.

>
> > > > Or nicer, put it all in Kconfig, like powerpc already has for examp=
le.
> > > > There is a CONFIG_WERROR as well, so maybe use that in all places?
> > >
> > > That's a good idea but I'm trying to compile old kernels and not the
> > > current kernel.
> >
> > You can patch older kernels, too, you know :-)
> >
> > If you need to not make any changes to your source code for some crazy
> > reason (political perhaps?), just use a shell script or shell function
> > instead of invoking the compiler driver directly?
> >
> >
> > Segher
> >
> > Segher

