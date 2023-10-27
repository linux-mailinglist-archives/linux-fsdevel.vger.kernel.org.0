Return-Path: <linux-fsdevel+bounces-1308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FEF7D8EC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C6A1C20FB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A728F5C;
	Fri, 27 Oct 2023 06:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwjKnCN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97B8F5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:33:34 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62401B4;
	Thu, 26 Oct 2023 23:33:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-66d264e67d8so12146516d6.1;
        Thu, 26 Oct 2023 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698388412; x=1698993212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKm/bHf1FXcxdqhrkNq5axpKtIbuO3rNEWsSQhKd1vg=;
        b=cwjKnCN/LTFrM0Ho0VfDGhXH0NRibQDf0VfzIGZI0NIcMNxLUZHtdTVit8ndUBlk+v
         K5oFBJAUdiHmIEowo1Tbqe0WNb6PpwyS0bvzAkWpW0wAZdf80hq0QeGlj1WkihA1T+jG
         4qt0cu/bV3mGYP92IMkq6aPgtWXcgJaO6DS95P1jLTLOeUiAOE3Jb9qXURNLqHrc16Vc
         N8/0uY/R1sLKZCbpgxa49Sj1sykF4YDEtu+ou/UaBEM+zMeHsk1RQ07KOVnWgg5bQfO6
         D1pnxVxLaQJFVfWnqkSpGxHPGRlDx5+5864fn3IHvdB4KmZODqBpvNJPJdDkqIseflMR
         NHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698388412; x=1698993212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKm/bHf1FXcxdqhrkNq5axpKtIbuO3rNEWsSQhKd1vg=;
        b=NHeCCKzd7B9uueHSJpIaFkk+h4YhmZZf327A3WjZ1eaMFiPNG8LMLksEDaQ7zvvFDt
         FR/2/AGEeduTXCHQtmtoKmQsS1TWmOgwtmF8l9MG4TavZ/wsl2xnKvw7G302POBQZQfU
         HC58Yr7kV83AQ5Qctr1ki4HBCuiaJLaieT7yzUmGTrku6VvQWNnoK32iXP/O7QGxR/37
         Adx6uQcKtgpRlt6PRodSPtUA9yEYFkrUVlXeUHJhsX13Ym2xTjn36hbtyoDMAUy705w9
         M/lNVPAnE1DhErgamHjpyNMNl+Eqh0/01TF6Gy/pvzqBydHJ12EOa15gdFR6hajoFFde
         ZBJQ==
X-Gm-Message-State: AOJu0YzcSNjwDurTAxPbSPw/gxqfiQ/e1gIj+KwyMj4JFx4YO02iSuLa
	IP3Ek9QzIU8ZZKlilwj3Ty5ppNtsKu1YOfPJZwc=
X-Google-Smtp-Source: AGHT+IG2wCno7VWYDvpeyacgdm1i5GVCBgDpmJRe2SWhPcZXuuFNLegJ3fc+NTZfe3Atl/1G8vL9r0A7Tk03ywzuws0=
X-Received: by 2002:a05:6214:e48:b0:66d:66bd:e60a with SMTP id
 o8-20020a0562140e4800b0066d66bde60amr1662115qvc.64.1698388411825; Thu, 26 Oct
 2023 23:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026155224.129326-1-amir73il@gmail.com> <ZTtOz8mr1ENl0i9q@infradead.org>
 <CAOQ4uxjbXhXZmCLTJcXopQikYZg+XxSDa0Of90MBRgRbW5Bhxg@mail.gmail.com> <ZTtTy0wITtw2W2vU@infradead.org>
In-Reply-To: <ZTtTy0wITtw2W2vU@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Oct 2023 09:33:19 +0300
Message-ID: <CAOQ4uxigdYYCWopKjonxww-be9Rxv9H3_KfcMe3SktXAKoXq4g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fanotify support for btrfs sub-volumes
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 9:08=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Oct 27, 2023 at 09:03:43AM +0300, Amir Goldstein wrote:
> > With all due respect, your NACK is uncalled for.
>
> It abosolute is not.  We must not spread the broken btrfs behavior.
>
> > The "details" that fanotify reports and has reported since circa v5.1
> > are the same details available to any unprivileged user via calls
> > to statfs(2) and name_to_handle_at(2).
>
> Yes, and that's very broken.  btrfs sneaked this in and we need to
> fix it.
>
> Again:
>
> Extra-hard-Nacked-by: Christoph Hellwig <hch@lst.de>
>
> and I'm a little sad that you're even arguing for sneaking such broken
> thing in.

OK. You are blaming me for attempting to sneak in a broken feature
and I have blamed you for trying take my patches hostage to
promote your agenda.
I hope that we are both wrong.

Suppose that we follow up on your plan to fix btrfs, that it is
all done and everyone is happy.

You said it yourself, that we cannot risk regressions by changing
the existing st_dev/f_fsid without an opt-in mount/mkfs option.
Is that correct?

If that is the case, fanotify will need to continue reporting the fsid's
exactly as the user observes them on the legacy btrfs filesystems.
The v2 patches I posted are required to make that possible.

However, I think we can reach a compromise here.
My main goal with the recent f_fsid series is to allow fanotify
to be used as (unprivileged) inotify drop-in replacement.

To do that, there is no need to allow btrfs sb/mount watch
on sub-volumes, so I don't mind keeping the ban on sb/mount
watches on btrfs sub-volume and relaxing only inode watch
inside btrfs sub-volume.

IOW, on legacy btrfs sub-volumes, users could use fanotify
to watch changes/access to a file and get events with the same
fsid that the user observed with statfs(2) on that file.

Migrating to new btrfs sub-volumes (i.e. with unique sb/vfsmount)
would enable the feature of fanotify sb/mount watch, so there is
one more incentive for the community to fix btrfs fsid's and for
users to actually make this migration.

Will that address your concerns?

Thanks,
Amir.

