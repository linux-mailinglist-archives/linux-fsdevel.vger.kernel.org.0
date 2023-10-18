Return-Path: <linux-fsdevel+bounces-696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796D7CE731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 20:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D03281E0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825B93FB17;
	Wed, 18 Oct 2023 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki.org header.i=@mbuki-mvuki.org header.b="Cb19xTcC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF18237148
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 18:49:57 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5399C118
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:49:55 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-79f9acc857cso259124239f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 11:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki.org; s=google; t=1697654994; x=1698259794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/XxvuFdO2ZdwNK/XNDg8OlspT0DUauJ6LGtfa4Ho6I=;
        b=Cb19xTcCcayNTx35VLJzoEvdrhzmcv92YMeoZ1VdOwKVcQBWclqKDbjzBsfXJxzDSk
         9yMipQL9wCVgXVDwYanrj1vZxGbDOiYbnJHkw9FcSo28Ws+7+YodrEbgRnjWM84BtZpU
         lcHGbVaxpcJJo0c808D+Zl11nuUw5l49cze8eSm102dxiSAYaAtN5LdXgcZzXAYLPxzl
         xLlvifl/oEO1alDVsRfw8Ja/e3VXkzi+VookbWIGgh31PhtkSfclJP1eMuUxBWKvArLm
         9z4sy+TVu1bW43OFUrYpqjQiYk6oNtX7T3AZprNK/AwDLkRrjlF7pIoux0GZYlwd4QrW
         vF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654994; x=1698259794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/XxvuFdO2ZdwNK/XNDg8OlspT0DUauJ6LGtfa4Ho6I=;
        b=aGrl2ZerQ0qpuowOzw0Id5GDIj2LZB6gUSV79Ue81KSJ8teE7YodDSptoby/so+JeH
         Glz1Nsv1ZRgBQnhcPb9XQVsvb3La4bjMmDYVCx8gMPRKz3j75mcuMwDpDVhuWjoFyd09
         72YdS8Yf/2L8x1jNPtedAnNWia3Zy8T0huM8eMMEYBKrS8dN6e9oNbqr47pKrz9SOl1T
         SQRRnCpJr8RreIiNDWtPLvIkRR8lphKSpWyuSnXn8RqmFA8uTifZPdFrioXfLuovoKjP
         STtjDDxy+JYNXlwF++4k8Nv4G/3VZHfK+3KG6tYKLz7O74RlqV4KwcBBdqFwf4VUheYw
         Dclw==
X-Gm-Message-State: AOJu0YyHcu6t05efRUwvBOGG/24AeHrjWLbpe0gvWRCqqNhnINtR4h8k
	8oJIZmXlIa0H35++JNYeCRmP2raXng2N3BEP7mUaCg==
X-Google-Smtp-Source: AGHT+IGzFwJjge2BOF6o2vMxFLEbgbFf3Xisus20yfGBAsejgI5s1KB++SUapF6eHqICDhunmvZ9ZzdwzHYALJRn/mY=
X-Received: by 2002:a05:6e02:b4b:b0:357:4535:c93 with SMTP id
 f11-20020a056e020b4b00b0035745350c93mr362020ilu.0.1697654994722; Wed, 18 Oct
 2023 11:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANSNSoUYMdPPLuZhofOW6DaKzCF47WhZ+T9BnL8sA37M7b4F+g@mail.gmail.com>
 <2023101819-satisfied-drool-49bb@gregkh>
In-Reply-To: <2023101819-satisfied-drool-49bb@gregkh>
From: Jesse Hathaway <jesse@mbuki-mvuki.org>
Date: Wed, 18 Oct 2023 13:49:44 -0500
Message-ID: <CANSNSoV6encjhH2u-Ua8wmjy==emvpi+76HTZasxbfzobMQ_Vw@mail.gmail.com>
Subject: Re: [PATCH] attr: block mode changes of symlinks
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Florian Weimer <fweimer@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 1:40=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> > Unfortunately, this has not held up in LTSes without causing
> > regressions, specifically in crun:
> >
> > Crun issue and patch
> >  1. https://github.com/containers/crun/issues/1308
> >  2. https://github.com/containers/crun/pull/1309
>
> So thre's a fix already for this, they agree that symlinks shouldn't
> have modes, so what's the issue?

The problem is that it breaks crun in Debian stable. They have fixed the
issue in crun, but that patch may not be backported to Debian's stable
version. In other words the patch seems to break existing software in
the wild.

> It needs to reverted in Linus's tree first, otherwise you will hit the
> same problem when moving to a new kernel.

Okay, I'll raise the issue on the linux kernel mailing list.

> > P.S. apologies for not having the correct threading headers. I am not o=
n
> > the list.
>
> You can always grab the mail on lore.kernel.org and respond to it there,
> you are trying to dig up a months old email and we don't really have any
> context at all (I had to go to lore to figure it out...)

Thanks, I'll do that next time.

