Return-Path: <linux-fsdevel+bounces-3008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7D7EF0FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 11:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5938B20B10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA01A5AD;
	Fri, 17 Nov 2023 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oi73KVh0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EB6D4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 02:49:22 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9e5e190458dso225372066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700218161; x=1700822961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SumEA8udEUkk7snFjJnXByDyaoFqxp7+fNZO1CvUAJE=;
        b=Oi73KVh0w91Q/+GBVqV0O+Vva36TQobbYaMuDWcUqtxepL4bdC5tRBsrZKlXASqOMj
         rr2mOY8KZqG5fiJEn7jgJC/Wt9VOsr0hM5dRKoujA+JwnZrlY5B6xludBpESKPd/m/YA
         KkqigJN5BeLkJBKjJM10mp4/H5q4nHTc6l1sTt/8lCzcQzle6pQYeFvYPsmJ/qRAh/ob
         ornLw15hPzH75kMVay6c3cmviMO2H+KzDTMT1SSkt/Iw4aVqU4ppY879lQbENQoAwBT4
         SMxaw826iyHLNU8fySqt6fQ+GeK8/xuzJQGjY3Rmw/9pMdjo5OPTVkeorC4+Z2rKE7w+
         2z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218161; x=1700822961;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SumEA8udEUkk7snFjJnXByDyaoFqxp7+fNZO1CvUAJE=;
        b=MqcoEwnPB7YhoXPPwCcAPj8FqhvYylPma5x15IlSWnWkbBv+T+9RJBPPOUKbpP/tPo
         cv1iYPSa7XRT0x0xjegvDteI7pO29Eu9xRcl+zHAryUR0G+YPjzJS2SxkKMucTsf587n
         CVUTUYPbM4bloaSIdbasmXytdTTmv19Fpy2dZfutQemTNH+j4bnHaR5MeoMo1L2BQHiS
         2WzMTFN3zwAfmJ/xs8x6XLaZfGGmP9AslTWlG7VLIosCIVXzzOz3/ce5DGbYAMf/uqaT
         QYogRBK7Xk1ohChKf4FD6tvmwonePXKn7aWSoS1QX+/aJ79j3YOKYFwuf+TGMw7dsDVN
         FG3w==
X-Gm-Message-State: AOJu0YwXNW5RD58qs4s1QPFvU7vcqupzl9W19pU6ex3/bzWznRFE7jw8
	jw6ACRK9+qR1W9+ozRvlUGmfMDJlJ1s=
X-Google-Smtp-Source: AGHT+IGTActtzNDTf0GzdafwVASi5fTJMH9kqsbYlXBzufLooixdniNvf7203wbuSXGKPTIT87WRRjKLsu8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a17:906:359b:b0:9b7:32d0:f903 with SMTP id
 o27-20020a170906359b00b009b732d0f903mr44794ejb.2.1700218160722; Fri, 17 Nov
 2023 02:49:20 -0800 (PST)
Date: Fri, 17 Nov 2023 11:49:12 +0100
In-Reply-To: <20231115.eej5lueRahwo@digikod.net>
Message-Id: <ZVdFARx1LcVF2-ca@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231103155717.78042-3-gnoack@google.com>
 <20231115.eej5lueRahwo@digikod.net>
Subject: Re: [PATCH v4 2/7] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu, Nov 16, 2023 at 04:50:56PM -0500, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 03, 2023 at 04:57:12PM +0100, G=C3=BCnther Noack wrote:
> > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landloc=
k.h
> > index 25c8d7677539..6d41c059e910 100644
> > --- a/include/uapi/linux/landlock.h
> > +++ b/include/uapi/linux/landlock.h
> > @@ -198,13 +199,26 @@ struct landlock_net_port_attr {
> >   *   If multiple requirements are not met, the ``EACCES`` error code t=
akes
> >   *   precedence over ``EXDEV``.
> >   *
> > + * The following access right applies both to files and directories:
> > + *
> > + * - %LANDLOCK_ACCESS_FS_IOCTL: Invoke :manpage:`ioctl(2)` commands on=
 an opened
> > + *   file or directory.
> > + *
> > + *   This access right applies to all :manpage:`ioctl(2)` commands, ex=
cept of
> > + *   ``FIOCLEX``, ``FIONCLEX``, ``FIONBIO``, ``FIOASYNC`` and ``FIONRE=
AD``.
> > + *   These commands continue to be invokable independent of the
> > + *   %LANDLOCK_ACCESS_FS_IOCTL access right.
> > + *
> > + *   This access right is available since the fourth version of the La=
ndlock
>=20
> It is now the fifth version. Same for the documentation.

Thanks!

I've accidentally put the last update to this docstring into the "Documenta=
tion"
commit.  I'll rebase that so that it becomes part of the commit that touche=
s the
implementation and the header.  The version is fixed there.


> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index bc7c126deea2..aa54970c235f 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -1123,7 +1130,9 @@ static int hook_file_open(struct file *const file=
)
> >  {
> >  	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_FS] =3D {};
> >  	access_mask_t open_access_request, full_access_request, allowed_acces=
s;
> > -	const access_mask_t optional_access =3D LANDLOCK_ACCESS_FS_TRUNCATE;
> > +	const access_mask_t optional_access =3D
> > +		LANDLOCK_ACCESS_FS_TRUNCATE | LANDLOCK_ACCESS_FS_IOCTL |
> > +		IOCTL_CMD_G1 | IOCTL_CMD_G2 | IOCTL_CMD_G3 | IOCTL_CMD_G4;
>=20
> I think it would be more future-proof to declare a new global const and
> use it here for optional_access:
>=20
> static const access_mask_t ioctl_groups =3D
> 	IOCTL_CMD_G1 |
> 	IOCTL_CMD_G2 |
> 	IOCTL_CMD_G3 |
> 	IOCTL_CMD_G4;

Done.


> > +static access_mask_t required_ioctl_access(unsigned int cmd)
> > +{
> > +	switch (cmd) {
> > +	case FIOQSIZE:
> > +		return IOCTL_CMD_G1;
> > +	case FS_IOC_FIEMAP:
> > +	case FIBMAP:
> > +	case FIGETBSZ:
> > +		return IOCTL_CMD_G2;
> > +	case FIONREAD:
> > +	case FIDEDUPERANGE:
> > +		return IOCTL_CMD_G3;
> > +	case FICLONE:
> > +	case FICLONERANGE:
> > +	case FS_IOC_RESVSP:
> > +	case FS_IOC_RESVSP64:
> > +	case FS_IOC_UNRESVSP:
> > +	case FS_IOC_UNRESVSP64:
> > +	case FS_IOC_ZERO_RANGE:
> > +		return IOCTL_CMD_G4;
> > +	case FIOCLEX:
> > +	case FIONCLEX:
> > +	case FIONBIO:
> > +	case FIOASYNC:
> > +		/*
> > +		 * FIOCLEX, FIONCLEX, FIONBIO and FIOASYNC manipulate the FD's
> > +		 * close-on-exec and the file's buffered-IO and async flags.
> > +		 * These operations are also available through fcntl(2),
> > +		 * and are unconditionally permitted in Landlock.
> > +		 */
> > +		return 0;
>=20
> You can move this block at the top.

Done.


> > +	default:
> > +		/*
> > +		 * Other commands are guarded by the catch-all access right.
> > +		 */
> > +		return LANDLOCK_ACCESS_FS_IOCTL;
> > +	}
> > +}
> > +
> > +static int hook_file_ioctl(struct file *file, unsigned int cmd,
> > +			   unsigned long arg)
> > +{
> > +	access_mask_t required_access =3D required_ioctl_access(cmd);
> > +	access_mask_t allowed_access =3D landlock_file(file)->allowed_access;
>=20
> You can use const for these variables.

Done.


> > +
> > +	/*
> > +	 * It is the access rights at the time of opening the file which
> > +	 * determine whether ioctl can be used on the opened file later.
> > +	 *
> > +	 * The access right is attached to the opened file in hook_file_open(=
).
> > +	 */
> > +	if ((allowed_access & required_access) =3D=3D required_access)
> > +		return 0;
>=20
> Please add a new line.

Done.


> > +	return -EACCES;
> > +}
> > +
> >  static struct security_hook_list landlock_hooks[] __ro_after_init =3D =
{
> >  	LSM_HOOK_INIT(inode_free_security, hook_inode_free_security),
> > =20
> > @@ -1218,6 +1283,7 @@ static struct security_hook_list landlock_hooks[]=
 __ro_after_init =3D {
> >  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
> >  	LSM_HOOK_INIT(file_open, hook_file_open),
> >  	LSM_HOOK_INIT(file_truncate, hook_file_truncate),
> > +	LSM_HOOK_INIT(file_ioctl, hook_file_ioctl),
> >  };
> > =20
> >  __init void landlock_add_fs_hooks(void)
> > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > index 93c9c6f91556..d0a95169ba3f 100644
> > --- a/security/landlock/limits.h
> > +++ b/security/landlock/limits.h
> > @@ -18,7 +18,15 @@
> >  #define LANDLOCK_MAX_NUM_LAYERS		16
> >  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
> > =20
> > -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
> > +#define LANDLOCK_LAST_PUBLIC_ACCESS_FS	LANDLOCK_ACCESS_FS_IOCTL
> > +#define LANDLOCK_MASK_PUBLIC_ACCESS_FS	((LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 1) - 1)
> > +
>=20
> Please add a comment to explain that the semantic of these synthetic
> access rights is defined by the required_ioctl_access() helper.

Done.


> > +#define IOCTL_CMD_G1			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 1)
> > +#define IOCTL_CMD_G2			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 2)
> > +#define IOCTL_CMD_G3			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 3)
> > +#define IOCTL_CMD_G4			(LANDLOCK_LAST_PUBLIC_ACCESS_FS << 4)
> > +
> > +#define LANDLOCK_LAST_ACCESS_FS		IOCTL_CMD_G4
> >  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
> >  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS=
_FS)
> >  #define LANDLOCK_SHIFT_ACCESS_FS	0
> > diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
> > index c7f1526784fd..58d96aff3980 100644
> > --- a/security/landlock/ruleset.h
> > +++ b/security/landlock/ruleset.h
> > @@ -30,7 +30,7 @@
> >  	LANDLOCK_ACCESS_FS_REFER)
> >  /* clang-format on */
> > =20
> > -typedef u16 access_mask_t;
> > +typedef u32 access_mask_t;
> >  /* Makes sure all filesystem access rights can be stored. */
> >  static_assert(BITS_PER_TYPE(access_mask_t) >=3D LANDLOCK_NUM_ACCESS_FS=
);
> >  /* Makes sure all network access rights can be stored. */
> > @@ -256,6 +256,54 @@ static inline void landlock_get_ruleset(struct lan=
dlock_ruleset *const ruleset)
> >  		refcount_inc(&ruleset->usage);
> >  }
> > =20
> > +/**
> > + * expand_ioctl - return the dst flags from either the src flag or the
>=20
> Return...

Done.


> > + * LANDLOCK_ACCESS_FS_IOCTL flag, depending on whether the
> > + * LANDLOCK_ACCESS_FS_IOCTL and src access rights are handled or not.
> > + *
> > + * @handled: Handled access rights
> > + * @access:  The access mask to copy values from
> > + * @src:     A single access right to copy from in @access.
> > + * @dst:     One or more access rights to copy to
>=20
> Please don't add extra spaces, that would avoid to shift all the lines
> if we get another name which is longer.

Done.


> > + *
> > + * Returns:
> > + * @dst, or 0
> > + */
> > +static inline access_mask_t expand_ioctl(access_mask_t handled,
> > +					 access_mask_t access,
> > +					 access_mask_t src, access_mask_t dst)
> > +{
> > +	if (!(handled & LANDLOCK_ACCESS_FS_IOCTL))
> > +		return 0;
> > +
> > +	access_mask_t copy_from =3D (handled & src) ? src :
> > +						    LANDLOCK_ACCESS_FS_IOCTL;
> > +	if (access & copy_from)
> > +		return dst;
>=20
> Please add a newline after return.

Done.


> > +	return 0;
> > +}
> > +
> > +/**
> > + * Returns @access with the synthetic IOCTL group flags enabled if nec=
essary.
>=20
> I think htmldocs will print a warning with this format.

You are absolutely right, I got a warning about that. %-)  Fixed.


=E2=80=94G=C3=BCnther

