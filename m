Return-Path: <linux-fsdevel+bounces-14009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9C8768BC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293EA287E24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B81CAAB;
	Fri,  8 Mar 2024 16:45:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75851171A4;
	Fri,  8 Mar 2024 16:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916329; cv=none; b=qjGRiCMVkMGzdQaG2NzPKJTtFaZxcFeq9yXm/Ss//Uoo9EIFNwUrx522xW4CUN3W2PLEG/wFfKkn9vy7lsltkLmxXP0oGrnnaGATJgAsfOycgNgd2ygFm6f2Kfv8sWcHAkCn0MEpbQYdET01X6lz8zXNqUJM7NqCVFCVZ5X4G8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916329; c=relaxed/simple;
	bh=8U5qdKB0DMpmg3gUpkvAO98Vy1vsWobCQuZf+O8qEEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rocen+Bf6yvmbzgNoiqhe17E//vdpGaW+ld8uhbTCIOzBtkLT2xn714fSkj7vGGQXFKe2i8ztdFLtPm+phVLQUf6mZW31m6kodPtPSMfEa4YNc31nA3TNnWKEXUKrlq4eoBf0/PnnA+9gBfDUxfcCWbRl4mA7hRcXzlyEdmb7rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4467d570cdso126409266b.3;
        Fri, 08 Mar 2024 08:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709916326; x=1710521126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhkgjgkXj1OWZTfq9UV7UD5/nprSvz13YTx6ty0+ulw=;
        b=xAno1HEMi+gjucxFEAjZdCU4oWDLxg1Q2mrSKS0Y6KKdTKVW7yIOL6Z0MFW54XZxTH
         WpwVra4emztjltpwYtFDqi2ULYafFl6WpGKOcpF74t6tXy3r2ZoFgy9Ubk8tjwrKpyzf
         r4Oge/kxApiXWHQKQ7oVP7CnFWaEIxIPuYkIJduvOCmxTSafh1I+V1u54XUxeB9mzvJ5
         BEPQnjRcZSvdiisX9UhPK8SCL98jSNb9XXqSvWhr8N/9+H+w55XzOkjLyzQOojc0yGir
         Pynre9cezwunVMy33TOm5N03E+IrN+B0DbbFE4FpbbppE5VJfFD5NO2n4slLZb55YLRB
         CB5g==
X-Forwarded-Encrypted: i=1; AJvYcCXCuQyCPdURjfzvUmDr66lWs9P+bQnv6mgEBQVy6ke1SdS8hInYu9WCzzjWvFhGSQauiIN/dOwTX+0jWZxKRKL8nM91e3dO+cc5Nh6w0AI3zp9PAwmlF8gLDScw7ooql4nDOas5Q+/21yM2a2auodl3j9DOePyEAGkPzThNxECD2mBlNlNVs5MIhw==
X-Gm-Message-State: AOJu0YzMf8i5Vrog/OQaGuM2DD9f7uCnjlVz3LN0h30wh03JPGjbitII
	3rjJL0DIbzpO7SLjgblyEmJW7OVa33HfwluOGCFCB6OwrS4FsY0xXJsRs/NSx3o5Lw==
X-Google-Smtp-Source: AGHT+IHC9EI2cqzk5Ho0bywx2cZfLMGRgh8ZLqN+WqW56+lV7Y+zxgsbVz82D2FxojiEklqKe09+Tw==
X-Received: by 2002:a17:906:c348:b0:a45:b631:1045 with SMTP id ci8-20020a170906c34800b00a45b6311045mr6159284ejb.21.1709916325392;
        Fri, 08 Mar 2024 08:45:25 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id fw11-20020a170906c94b00b00a45a8c4edb4sm4020089ejb.48.2024.03.08.08.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 08:45:25 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4429c556efso142414366b.0;
        Fri, 08 Mar 2024 08:45:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWaZqd3o8IESgHTAB2g1KrJq91h4JlmdYJRO13JQ6VisoA7MdePLMFBWhw4OBNWufRNUOBtXNT9hLrLGWGq+D3GYEKz6Etwx9VF45Yob8URFA+caEzNGzjHbTBqaAut8sxDdOlgMUV9w8vbiHb0lkVeg/z7pWRJ4EZM/nvK56Pw4MWswyJZdxqPJQ==
X-Received: by 2002:a17:906:cf88:b0:a45:373:cff with SMTP id
 um8-20020a170906cf8800b00a4503730cffmr12031257ejb.68.1709916325086; Fri, 08
 Mar 2024 08:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <CAEg-Je96OKs_LOXorNVj1a1=e+1f=-gw34v4VWNOmfKXc6PLSQ@mail.gmail.com> <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
In-Reply-To: <i2oeask3rxxd5w4k7ikky6zddnr2qgflrmu52i7ah6n4e7va26@2qmghvmb732p>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 8 Mar 2024 11:44:48 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
Message-ID: <CAEg-Je_URgYd6VJL5Pd=YDGQM=0T5tspfnTvgVTMG-Ec1fTt6g@mail.gmail.com>
Subject: Re: [PATCH v2] statx: stx_subvol
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <mszeredi@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 11:34=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Fri, Mar 08, 2024 at 06:42:27AM -0500, Neal Gompa wrote:
> > On Thu, Mar 7, 2024 at 9:29=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > Add a new statx field for (sub)volume identifiers, as implemented by
> > > btrfs and bcachefs.
> > >
> > > This includes bcachefs support; we'll definitely want btrfs support a=
s
> > > well.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/2uvhm6gweyl7iyyp2xpfryvcu=
2g3padagaeqcbiavjyiis6prl@yjm725bizncq/
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > Cc: Josef Bacik <josef@toxicpanda.com>
> > > Cc: Miklos Szeredi <mszeredi@redhat.com>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > > ---
> > >  fs/bcachefs/fs.c          | 3 +++
> > >  fs/stat.c                 | 1 +
> > >  include/linux/stat.h      | 1 +
> > >  include/uapi/linux/stat.h | 4 +++-
> > >  4 files changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
> > > index 3f073845bbd7..6a542ed43e2c 100644
> > > --- a/fs/bcachefs/fs.c
> > > +++ b/fs/bcachefs/fs.c
> > > @@ -840,6 +840,9 @@ static int bch2_getattr(struct mnt_idmap *idmap,
> > >         stat->blksize   =3D block_bytes(c);
> > >         stat->blocks    =3D inode->v.i_blocks;
> > >
> > > +       stat->subvol    =3D inode->ei_subvol;
> > > +       stat->result_mask |=3D STATX_SUBVOL;
> > > +
> > >         if (request_mask & STATX_BTIME) {
> > >                 stat->result_mask |=3D STATX_BTIME;
> > >                 stat->btime =3D bch2_time_to_timespec(c, inode->ei_in=
ode.bi_otime);
> > > diff --git a/fs/stat.c b/fs/stat.c
> > > index 77cdc69eb422..70bd3e888cfa 100644
> > > --- a/fs/stat.c
> > > +++ b/fs/stat.c
> > > @@ -658,6 +658,7 @@ cp_statx(const struct kstat *stat, struct statx _=
_user *buffer)
> > >         tmp.stx_mnt_id =3D stat->mnt_id;
> > >         tmp.stx_dio_mem_align =3D stat->dio_mem_align;
> > >         tmp.stx_dio_offset_align =3D stat->dio_offset_align;
> > > +       tmp.stx_subvol =3D stat->subvol;
> > >
> > >         return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
> > >  }
> > > diff --git a/include/linux/stat.h b/include/linux/stat.h
> > > index 52150570d37a..bf92441dbad2 100644
> > > --- a/include/linux/stat.h
> > > +++ b/include/linux/stat.h
> > > @@ -53,6 +53,7 @@ struct kstat {
> > >         u32             dio_mem_align;
> > >         u32             dio_offset_align;
> > >         u64             change_cookie;
> > > +       u64             subvol;
> > >  };
> > >
> > >  /* These definitions are internal to the kernel for now. Mainly used=
 by nfsd. */
> > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > index 2f2ee82d5517..67626d535316 100644
> > > --- a/include/uapi/linux/stat.h
> > > +++ b/include/uapi/linux/stat.h
> > > @@ -126,8 +126,9 @@ struct statx {
> > >         __u64   stx_mnt_id;
> > >         __u32   stx_dio_mem_align;      /* Memory buffer alignment fo=
r direct I/O */
> > >         __u32   stx_dio_offset_align;   /* File offset alignment for =
direct I/O */
> > > +       __u64   stx_subvol;     /* Subvolume identifier */
> > >         /* 0xa0 */
> > > -       __u64   __spare3[12];   /* Spare space for future expansion *=
/
> > > +       __u64   __spare3[11];   /* Spare space for future expansion *=
/
> > >         /* 0x100 */
> > >  };
> > >
> > > @@ -155,6 +156,7 @@ struct statx {
> > >  #define STATX_MNT_ID           0x00001000U     /* Got stx_mnt_id */
> > >  #define STATX_DIOALIGN         0x00002000U     /* Want/got direct I/=
O alignment info */
> > >  #define STATX_MNT_ID_UNIQUE    0x00004000U     /* Want/got extended =
stx_mount_id */
> > > +#define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvo=
l */
> > >
> > >  #define STATX__RESERVED                0x80000000U     /* Reserved f=
or future struct statx expansion */
> > >
> > > --
> > > 2.43.0
> > >
> > >
> >
> > I think it's generally expected that patches that touch different
> > layers are split up. That is, we should have a patch that adds the
> > capability and a separate patch that enables it in bcachefs. This also
> > helps make it clearer to others how a new feature should be plumbed
> > into a filesystem.
> >
> > I would prefer it to be split up in this manner for this reason.
>
> I'll do it that way if the patch is big enough that it ought to be
> split up. For something this small, seeing how it's used is relevant
> context for both reviewers and people looking at it afterwards.
>

It needs to also be split up because fs/ and fs/bcachefs are
maintained differently. And while right now bcachefs is the only
consumer of the API, btrfs will add it right after it's committed, and
for people who are cherry-picking/backporting accordingly, having to
chop out part of a patch would be unpleasant.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

