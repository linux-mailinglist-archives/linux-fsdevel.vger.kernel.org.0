Return-Path: <linux-fsdevel+bounces-5984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB26811A66
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F246B2091F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 17:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD653A8DD;
	Wed, 13 Dec 2023 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuDxgmyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B94EF3;
	Wed, 13 Dec 2023 09:06:04 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f8308616eso163758385a.2;
        Wed, 13 Dec 2023 09:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702487163; x=1703091963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izQi1471NL/cydZbe8/X42uR08bubeTVrkQFcuYiqzs=;
        b=PuDxgmyOLgfAht7UAhnupo6Q3t9Io7QAMqyzTbw6JkfT0hf/KwgODcgwV+uVRSwYgd
         W2pRnfIFFjcqBTIWut0PO4V6wERa8ZAgdxChZvlL9huHp/aE1I5QuzJ9EtIv80igJaQA
         4HfapgSGtUpq69IeOuLtKzPfdxVsIz1DTrgke0SR/Q6JlCl9nHgqHhwqXUY/nkGYgjMI
         BJ/YNhX2hOhWb3FM1PGNnRDmpA4FTeUznxhRHytYF1kst6samGLpx07P/njI9Zudsu30
         24kc1c6ILRUoYj/VGGbhPUpLTNtkm6y/p5jb0IlteFDEYQBJC8vllTj/CrH5BQd/BrvQ
         oL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702487163; x=1703091963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izQi1471NL/cydZbe8/X42uR08bubeTVrkQFcuYiqzs=;
        b=cKLD1homxC7bCG86YPBy3GmQcGYn/pbR+WmN7y7CGyT1OY2COEZ0JxPKqA/iVGtjVF
         LIRxJFOqRtyWnAYdNNe5EugAwjGYYMlGwTXWuQT/4wC+lRYMGdhhbJKNKCF8fHt4yQKk
         LwXrjJEj6WCODilZ/Eqpu99gUa+zl5h1UUk79P8VLK+GE1eS2ZrSfEEsTZyaHvyIGgPb
         sX0Hrcl6euyq87fNss7BUzCYZLQFT3UrOjZ/NORDGj1oMh1GrfKeW9y7YrKyRDX3A69m
         iKjBzQxSUYT1INeu/SPb+/sCKqNGLFvhRCPWccsrHb6smfZsAe8kDaWnC8wjBI/H7Ubd
         Wdwg==
X-Gm-Message-State: AOJu0Ywb9g6jotKgd2HtNJ6Vg/OhZOheGgfJTayU10ee4xgCA2D39Bl3
	weaTPZqdVCcIl9arl9enp6ZwsccDEcLF/DB74aQID2oY
X-Google-Smtp-Source: AGHT+IHFwxt7NaMGwYfCIRV8QcEGmTbFxg9W/HWVNejdiK0MfCoZndI2DuEVIwyJpoIroqNUH2BvNIAFik3pPJY5tas=
X-Received: by 2002:a0c:ee24:0:b0:67a:99cb:e2f with SMTP id
 l4-20020a0cee24000000b0067a99cb0e2fmr6705131qvs.42.1702487163185; Wed, 13 Dec
 2023 09:06:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211193048.580691-1-avagin@google.com> <CAOQ4uxik0=0F-6CLRsuaOheFjwWF-B-Q5iEQ6qJbRszL52HeQQ@mail.gmail.com>
 <CAEWA0a6Ow+BvrPm5O-4-tGRLQYr3+eahj45voF1gdmN3OfadGg@mail.gmail.com>
In-Reply-To: <CAEWA0a6Ow+BvrPm5O-4-tGRLQYr3+eahj45voF1gdmN3OfadGg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 13 Dec 2023 19:05:52 +0200
Message-ID: <CAOQ4uxgzeAgkE73uJB=-Guq7fDtfKU1_1pMTOzBm6ApZuW=hLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/proc: show correct device and inode numbers in /proc/pid/maps
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:08=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
ote:
>
> Hi Amir,
>
> On Mon, Dec 11, 2023 at 9:51=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > +fsdevel, +overlayfs, +brauner, +miklos
> >
> > On Mon, Dec 11, 2023 at 9:30=E2=80=AFPM Andrei Vagin <avagin@google.com=
> wrote:
> > >
> > > Device and inode numbers in /proc/pid/maps have to match numbers retu=
rned by
> > > statx for the same files.
> >
> > That statement may be true for regular files.
> > It is not true for block/char as far as I know.
> >
> > I think that your fix will break that by displaying the ino/dev
> > of the block/char reference inode and not their backing rdev inode.
>
> I think it doesn't break anything here. /proc/pid/maps shows dev of a
> filesystem where the device file resides.
>
> 7f336b6c3000-7f336b6c4000 rw-p 00000000 00:05 7
>   /dev/zero
> $ stat /dev/zero
> Device: 0,5 Inode: 7           Links: 1     Device type: 1,5
>
> I checked that it works with and without my patch. It doesn't matter, loo=
k at
> the following comments.
>
> >
> > >
> > > /proc/pid/maps shows device and inode numbers of vma->vm_file-s. Here=
 is
> > > an issue. If a mapped file is on a stackable file system (e.g.,
> > > overlayfs), vma->vm_file is a backing file whose f_inode is on the
> > > underlying filesystem. To show correct numbers, we need to get a user
> > > file and shows its numbers. The same trick is used to show file paths=
 in
> > > /proc/pid/maps.
> >
> > For the *same* trick, see my patch below.
>
> The patch looks good to me. Thanks! Will you send it?
>

I can send it, if you want.
I wouldn't mind if you send it with my Suggested-by though,
as you are already testing it and posting the selftest.

Thanks,
Amir.

