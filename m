Return-Path: <linux-fsdevel+bounces-3681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C77F77EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70D11C20F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D82FC21;
	Fri, 24 Nov 2023 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNr9RKGR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D711992
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:39:19 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-548eadba14dso1238350a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700840358; x=1701445158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MdY+CEN7lfJq7E8LmxU/yKl+DLnEKriP7xWtMKyRLI=;
        b=HNr9RKGRXJwapoKyJR+qMqL/0whUhS20vQf6uKw9t+utB0G5kgaa5l47Scy4qh/PHH
         yBS7QhGgV1oY4JTEDtc9gFktzBn0wVVne+CsT4i+eIR4Jg5FB+pSYGimy8Liatp1V3gB
         ciYhMYE1smCvV7jNgan/PiJEbMwRij818KjLwGdn5BJWBiflTEyh0U4Oqz9+j4Pd/jo6
         X3TPEbylCYcSM867ICph6PbYA+bvuT3LUHgcR+t+1nYx5vMg1hc8ZN7XT8sau08OLO0t
         Q0GJLqLF2ETAyj2V//JJ7MJtkvwR5W0VmEZ1oYsm0RUPpP4ZW1IbT2tQ9A/RaMoBzOFm
         gTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840358; x=1701445158;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+MdY+CEN7lfJq7E8LmxU/yKl+DLnEKriP7xWtMKyRLI=;
        b=HetP7nVzl/bFZWG71XrPCmbNi/dAXh8B1t0CILcLlANH1aJ5meNC6z2U775RPxUVnb
         huloNj2SEJcdyRJW1XN56vx0FUjdebbrNo5BCM/vhkgvyW5+QXNdAjpPSJUmrYsr52H5
         t2lJ8OQ8IH0bfGIbRD9FtBq+rJQdMByX0hJlCst9XEwM4AR5lkb1IKMJ+JgNkRxTpmKM
         TfWpXSt1v+tA/1haUGCQNdKB6whxWlShWoXp+Sgb4tntijefYJ0JGiV3WQU00zfBBhl4
         B+9ajK4ECOHxmySo1RZKlGbRmGqyp/IwdTkdqJeXk+ng2gvc7dGijf4P0flaffTRwpmm
         uokw==
X-Gm-Message-State: AOJu0YyBB/NU+zK/BfeJ/P3JavpwZkEKvbBcwAzeyas7zkzBXsxq9tLv
	tzmqCBK+Ka99O1JO2y+oKW30I6iH/FU=
X-Google-Smtp-Source: AGHT+IHnNoF6BgJwUOugkI+xgyGHb4W13m56l8pHQe9JmK/keKOh4nXrtdmg1SmVuxwcdqwLJoPICe66tEw=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4402:b0:54a:e7a4:e56 with SMTP id
 y2-20020a056402440200b0054ae7a40e56mr46013eda.2.1700840357610; Fri, 24 Nov
 2023 07:39:17 -0800 (PST)
Date: Fri, 24 Nov 2023 16:39:02 +0100
In-Reply-To: <20231120.fau2Oi6queij@digikod.net>
Message-Id: <ZWDDlvXCdShpFIZ5@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231117154920.1706371-1-gnoack@google.com> <20231117154920.1706371-3-gnoack@google.com>
 <20231120.fau2Oi6queij@digikod.net>
Subject: Re: [PATCH v5 2/7] landlock: Add IOCTL access right
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 08:43:30PM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Nov 17, 2023 at 04:49:15PM +0100, G=C3=BCnther Noack wrote:
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP1	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 1)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP2	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 2)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP3	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 3)
> > +#define LANDLOCK_ACCESS_FS_IOCTL_GROUP4	(LANDLOCK_LAST_PUBLIC_ACCESS_F=
S << 4)
>=20
> Please move this LANDLOCK_ACCESS_FS_IOCTL_* block to fs.h
>=20
> We can still create the public and private masks in limits.h but add a
> static_assert() to make sure there is no overlap.

Done.


> >  	/* Checks content (and 32-bits cast). */
> > -	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_ACCESS_FS) !=3D
> > -	    LANDLOCK_MASK_ACCESS_FS)
> > +	if ((ruleset_attr.handled_access_fs | LANDLOCK_MASK_PUBLIC_ACCESS_FS)=
 !=3D
> > +	    LANDLOCK_MASK_PUBLIC_ACCESS_FS)
>=20
> It would now be possible to add LANDLOCK_ACCESS_FS_IOCTL_GROUP* to a
> rule, which is not part of the API/ABI. I've sent a patch with new tests
> to make sure this is covered:
> https://lore.kernel.org/r/20231120193914.441117-2-mic@digikod.net
>=20
> I'll push it in my -next branch if everything is OK before pushing your
> next series. Please review it.

Thanks, good catch!

Looking at add_rule_path_beneath(), it indeed does not look like I have cov=
ered
that case in my patch.  I'll put an explicit check for it, like this:

  /*
   * Checks that allowed_access matches the @ruleset constraints and only
   * consists of publicly visible access rights (as opposed to synthetic
   * ones).
   */
  mask =3D landlock_get_raw_fs_access_mask(ruleset, 0) &
         LANDLOCK_MASK_PUBLIC_ACCESS_FS;
  if ((path_beneath_attr.allowed_access | mask) !=3D mask)
          return -EINVAL;

I assume that the tests that you added were failing?  Or was there an obscu=
re
code path that caught it anyway?

Thanks,
=E2=80=94G=C3=BCnther

