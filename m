Return-Path: <linux-fsdevel+bounces-4855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F8804CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 09:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E348EB20B75
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 08:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A133D96E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMvt80vE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACE3D7;
	Mon,  4 Dec 2023 23:50:20 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso2089372e87.0;
        Mon, 04 Dec 2023 23:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701762618; x=1702367418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24XpIXBTmRJo0XbocsA3yQjileor73SUcUHM5/C26TQ=;
        b=LMvt80vETvkacPZpLVC8B/CFLqrMs/nFdy1ycSF3D1tjb9ERUeBDP2xmLdQzft8XGh
         phPgHNOE9RMkhZrM+CfeFMKJgdokJ/Qqtm3yhn8s4Ff9cMIENivTXi0RlZV+Qmccou8q
         DSpbssVfw+m1GpIf6uTmtHX/F6Xj7n6jKzczaUFfkQnJHjmmHgSe7JMZNt3Sc6v+rckG
         o/n2icprv2BWRnw6/fnx2mGc2/Jjx0U7TJ+VQ66aW7oLzlcWqB24hnZuQrxXn8M6QWeU
         e0axnXCQwt8I3P6dskdI1q8ROjP0Ensi7SJi9/Ilq23U3vu41dLcrRgc4NY9VRx81R89
         Qgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762618; x=1702367418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=24XpIXBTmRJo0XbocsA3yQjileor73SUcUHM5/C26TQ=;
        b=oGnaXStJApyFLAm7ainSZ63FRngtrTkk7OT1I5e/rElk9w7gC9Klpzv2f/n98hidCp
         Kx4m4MuBAKsuXkqG7nnbVaajJgWGzGdd2fwPLdJiYAOExvTAtXJT9+Md6nAqPMbX32G3
         m5DPlr6KFMncW+tBr2RFuOX/i04Gm8dmoV6UqeJXco8VDKwexkuzeCbDdy7rsXAMXTUK
         cpNVyU3+O8VyIVIActBL5Q5UtVsV30LbV9IMLOz7qtT/mNYGubdDk8DpuBTlHJeNPSty
         h5ax5hcsENii5+pTsQPGJKtH7YmjfzfvFeff9l67Qmwua3jvCH7iTSWMk8UlN0inLrUo
         XEIA==
X-Gm-Message-State: AOJu0Yx4/8v7XKusT0D/7X+uMa402NQnWQF2ZkGJzUueMTmxRKdKd71p
	M0+ZhoqiAdtxvHMmn3bUVSdggaOx8EEODaBRivVNmfHeT5pvtA==
X-Google-Smtp-Source: AGHT+IFYk/BFJ+hBLuLjG6lRmBPi4W3t9JXRIbLGhARD7zbHnPkUPaeoLgCB5r5Ol5CeNFsJAhBYmEmVVYH4xqXABrw=
X-Received: by 2002:a05:6512:b96:b0:50b:e7b0:193c with SMTP id
 b22-20020a0565120b9600b0050be7b0193cmr2843173lfv.88.1701762618250; Mon, 04
 Dec 2023 23:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ8C1XPdyVKuq=cL4CqOi2+ag-=tEbaC=0a3Zro9ZZU5Xw1cjw@mail.gmail.com>
 <ZVxUXZrlIaRJKghT@archie.me> <CAKYAXd_WFKXt1GqzFyfrJo6KHf6iaDwp-n3Qb1Hu63wokNhO9g@mail.gmail.com>
 <CAJ8C1XOzdscAUGCBh9Mbu9cm-oAqRA4mBoGjSFCxydJSCkzkUw@mail.gmail.com>
In-Reply-To: <CAJ8C1XOzdscAUGCBh9Mbu9cm-oAqRA4mBoGjSFCxydJSCkzkUw@mail.gmail.com>
From: Seamus de Mora <seamusdemora@gmail.com>
Date: Tue, 5 Dec 2023 01:49:42 -0600
Message-ID: <CAJ8C1XNThwLi-kxwkLfmecc0FETNNMdHKqWkBDYw4uSZdheuRA@mail.gmail.com>
Subject: Re: Add sub-topic on 'exFAT' in man mount
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linux Manual Pages <linux-man@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Alejandro Colomar <alx@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 4:43=E2=80=AFPM Seamus de Mora <seamusdemora@gmail.=
com> wrote:
>
> On Sun, Nov 26, 2023 at 5:59=E2=80=AFPM Namjae Jeon <linkinjeon@kernel.or=
g> wrote:
> >
> > 2023-11-21 15:55 GMT+09:00, Bagas Sanjaya <bagasdotme@gmail.com>:
> > > On Mon, Nov 20, 2023 at 04:55:18PM -0600, Seamus de Mora wrote:
> > >> I'd like to volunteer to add some information to the mount manual.
> > >>
> > >> I'm told that exFAT was added to the kernel about 4 years ago, but
> > >> last I checked, there was nothing about it in man mount.  I feel thi=
s
> > >> could be addressed best by adding a sub-topic on exFAT under the top=
ic
> > >> `FILESYSTEM-SPECIFIC MOUNT OPTIONS`.
> > >>
> > >> If my application is of interest, please let me know what steps I ne=
ed
> > >> to take - or how to approach this task.
> > >>
> > >
> > > I'm adding from Alejandro's reply.
> > >
> > > You can start reading the source in fs/exfat in linux.git tree [1].
> > > Then you can write the documentation for exfat in Documentation/exfat=
.rst
> > > (currently doesn't exist yet), at the same time of your manpage
> > > contribution.
> > >
> > > Cc'ing exfat maintainers for better treatment.
> > Thanks Bagas for forwarding this to us!
> >
> > Hi Seamus,
> >
> > Some of mount options are same with fatfs's ones. You can refer the
> > descriptions of fatfs
> > documentation(Documentation/filesystems/vfat.rst).
> > If you have any questions about other options or documentation for
> > exfat, please give an email me.
> >
> > Thanks!
> > >
> > > Thanks.
> > >
> > > [1]:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/fs/exfat
>
> Thanks for the offer Namjae; I'm sure I'll take you up on that when I
> get ready to actually produce something. For now, I am reading and
> trying to get myself up to speed to tackle this. So far, the going has
> been a bit slow as I have a couple of commitments I need to finish.

I've read a bit about the mechanics & markup for creating/editing man
pages. Now all I need is something useful to say :)

In that regard, I **guess** the best place to look for the details I
need is in the source code. Without access to the author or
maintainers, I don't see how else to get at the details needed for a
decent piece of documentation. I think that is what Bagas (?)
suggested, but how/where do I find "fs/exfat in linux.git tree" ??

Thanks,
~S

