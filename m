Return-Path: <linux-fsdevel+bounces-334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FD47C8B81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F9CB20C58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4311721A18;
	Fri, 13 Oct 2023 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q90R7Tdr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6033219E5
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 16:38:37 +0000 (UTC)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DDBF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:38:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d9ac9573274so2128284276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697215114; x=1697819914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85tz8MZnQIy0CUyHXD4OwO6hFEU+0OOkrrzLhDAPynw=;
        b=Q90R7Tdrw7oRx2g7QAuiOQfZ0moqLRi0ko1qyZhnLu68DdroxUEZIZKnYfrcTlEKHZ
         F2o9IHgWzk8aHLHfIF14T7v2rkjG2OaTJntJhFE020tmKlxjtdvweSw81h/GmEDVdT9A
         obdHXgUydPNnob+3r8KdEv1ojDVBnCdthXzgdmq56O3rNndoRI6ecYVSF13Q5/GpIJAG
         1PGe5u0iFbpoIMhdrS5/6EYJOBP4xVIj6gT6rMzbL535Bqnu3JiRuURSrChrMOZkF1HY
         J7lJIBRJCJsY8ji8W3H64++Bt/h22HUxEe9ijrUNRiqs5KdQxqiKKlyVD4AUGDpkk5T7
         c1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697215114; x=1697819914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85tz8MZnQIy0CUyHXD4OwO6hFEU+0OOkrrzLhDAPynw=;
        b=w6ig389Bo0v71w32kfvHyDdh0uc+MyHDNm0nLJc5lGS04soNkl+6qcC4haqN9LpL4z
         1jS0IwGVtzrvWiAO5V5VvygQwgTr0u+wKKNfpwnn5NamhGvaLWNFdp1dBuGoITfeh994
         VHfog3P2rc4LxoceB3Tnrg99T+DxPdpL756+JJkGR6pcBPuXzFyLgT25XWPu6i+2ZF5h
         4swz/l7XJ32Q7sljyCaoNDcR8ODR+NR7EbNO9bvUw9uMh5eaztIoW9AwrzdBJhlxNj77
         e+3vB01uQ4ZjtxyUIrNK0pJhCihOLOXsVvzlGpwNGgTKyca0ZkC8h0Xh7Tbk42IYreeO
         u/wA==
X-Gm-Message-State: AOJu0YwqApdGkWEEk8oh/rue2CV3mwnFSEa0fFIpwOliVnUotQvlMV8O
	N3szj6u0fFLPXb1wwoAfK6NPpyYY8mV83r3bsIx2
X-Google-Smtp-Source: AGHT+IEIaSBfASZ5Mn1dNgyH878ixt7Ja/xhQg8a+sIaxL+NLRUpQv75KfQ3z3OfydJhIWt+cgU+2xUOjDRn5uIOySM=
X-Received: by 2002:a25:8f8c:0:b0:d89:f292:6e80 with SMTP id
 u12-20020a258f8c000000b00d89f2926e80mr26964031ybl.35.1697215114724; Fri, 13
 Oct 2023 09:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner> <CAHC9VhTQFyyE59A3WG3Z0xkP6m31h1M0bvS=yihE7ukpUiDMug@mail.gmail.com>
 <20231013-hakte-sitzt-853957a5d8da@brauner>
In-Reply-To: <20231013-hakte-sitzt-853957a5d8da@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Oct 2023 12:38:24 -0400
Message-ID: <CAHC9VhQ2hX8QvQagt+J7V2OBtiSXctufVcVj0fi1bQEsduWD4Q@mail.gmail.com>
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
To: Christian Brauner <brauner@kernel.org>
Cc: Dan Clash <daclash@linux.microsoft.com>, linux-kernel@vger.kernel.org, 
	axboe@kernel.dk, linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com, 
	audit@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 12:22=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Fri, Oct 13, 2023 at 11:56:08AM -0400, Paul Moore wrote:
> > On Fri, Oct 13, 2023 at 11:44=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
> > > > An io_uring openat operation can update an audit reference count
> > > > from multiple threads resulting in the call trace below.
> > > >
> > > > A call to io_uring_submit() with a single openat op with a flag of
> > > > IOSQE_ASYNC results in the following reference count updates.
> > > >
> > > > These first part of the system call performs two increments that do=
 not race.
> > > >
> > > > [...]
> > >
> > > Picking this up as is. Let me know if this needs another tree.
> >
> > Whoa.  A couple of things:
> >
> > * Please don't merge patches into an upstream tree if all of the
> > affected subsystems haven't ACK'd the patch.  I know you've got your
> > boilerplate below about ACKs *after* the merge, which is fine, but I
> > find it breaks decorum a bit to merge patches without an explicit ACK
> > or even just a "looks good to me" from all of the relevant subsystems.
>
> I simply read your mail:
>
> X-Date: Fri, 13 Oct 2023 17:43:54 +0200
> X-URI: https://lore.kernel.org/lkml/CAHC9VhQcSY9q=3DwVT7hOz9y=3Do3a67BVUn=
VGNotgAvE6vK7WAkBw@mail.gmail.com
>
> "I'm not too concerned, either approach works for me, the important bit
>  is moving to an atomic_t/refcount_t so we can protect ourselves
>  against the race.  The patch looks good to me and I'd like to get this
>  fix merged."
>
> including that "The patch looks good to me [...]" part before I sent out
> the application message:

Some of this is likely due to email races, or far faster than normal
responses.  When I was writing the email you reference above ("This
patch looks good to me...") the last email I had from you was asking
for changes to the patch; since you were suggesting a change I made
the assumption (which arguably one shouldn't assume things) that you
were not planning to merge the patch.

> X-Date: Fri, 13 Oct 2023 17:44:36 +0200
> X-URI: https://lore.kernel.org/lkml/20231013-karierte-mehrzahl-6a93803560=
9e@brauner
>
> > Regardless, as I mentioned in my last email (I think our last emails
> > raced a bit), I'm okay with this change, please add my ACK.
>
> It's before the weekend and we're about to release -rc6. This thing
> needs to be in -next, you said it looks good to you in a prior mail. I'm
> not sure why I'm receiving this mail apart from the justified
> clarification about -stable although that was made explicit in your
> prior mail as well.

I hope I explained the intent in my last email a bit more clearly with
the explanation above.  Regardless, I think the lessons to be learned
is that I won't assume that your suggestion of changes and merging a
patch are mutually exclusive, and just to be on the safe side I would
ask that you not merge audit, LSM, or SELinux related patches without
an explicit ACK from those subsystems.  Hopefully that should prevent
things like this from happening again.

--=20
paul-moore.com

