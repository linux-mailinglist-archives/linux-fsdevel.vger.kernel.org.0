Return-Path: <linux-fsdevel+bounces-3009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321A17EF11A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 11:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2362281201
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05841A5BB;
	Fri, 17 Nov 2023 10:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xDW+ckKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72265BC
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 02:52:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03ef6fc30so2374666276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 02:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700218331; x=1700823131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVbUiclfv/LBpx5USXusisaeNMmKJ9RM6pmhgHqWsWI=;
        b=xDW+ckKo/ealQSFF3svsoGZ8IZoxfgPDffGGPJPs84pLxj1dK0jbhMRHEQHyPEMqw2
         LncQjbG9qdVx+aGbWgYUWVmc7xwJuY5YnD+HRB9MWZILELkhS2konUlWFl+ZOAaPsWAm
         bDzIyL6J94eK+c8npMno0sWY2SbhmrojVtGG8bvonZfT78ySoqbt1U8syypfSqbzpkmn
         eOPb5j54Y2HhEvr7zyc5R1kAN+gMQF7G4Rv8O9xqEW2gkO4rvHBULBI6hFKprMCXykIG
         2bBySna3khs12PTQwdEG3Fzkqwu9imSEmsG7WpKgivOuFezgnieYVfZB0uL4y/oLYPAj
         M0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218331; x=1700823131;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cVbUiclfv/LBpx5USXusisaeNMmKJ9RM6pmhgHqWsWI=;
        b=pMy8bPmW98lSwSu3WdK/8QvF3B782Ci90P4I6J+PY+YKREX1gsUTHCnoChHZKutaCG
         GNaZNya1K8ZeuMSR9UJheICUyLivu9ygEvgEBfTuEMdUcbOCpOZhq5Djh46EBBqfXtov
         o3rydTJTmXnamHXbQZUwZYWI8DAn2Pmr401qn2XHgpJp5uWHlSj7jMvLnfE6Sn9gqSQ+
         VQqrh1JfACOfsyIQImW0nI3twrnLUgfsHrpk3TjjejSTUdGLiNYI+aYqt1P+9UK/4Rmy
         xMa+U3CKkiLhQS+UO5odep8fAfzlONCZ8HubPHNrg2YAaizl7WQR+mhWW5v3NjCKBIe1
         ESZw==
X-Gm-Message-State: AOJu0YxCCunJjv/sqIlvzY0WIPFzUCMMtHmnbVcg7W5G3bpYrxtPCsiw
	WN5ZsCg4zXp1ZCGnXMtjvMHxnPi/oz0=
X-Google-Smtp-Source: AGHT+IGOMaaGpIhtMNtTmSNCS3V3Cq0J7GN0OkmZS4fkGfl9rHJWZHClHsnqcdWTYfhkwebFYim5TjH1sYc=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a25:9e0e:0:b0:d9a:5b63:a682 with SMTP id
 m14-20020a259e0e000000b00d9a5b63a682mr480664ybq.13.1700218331714; Fri, 17 Nov
 2023 02:52:11 -0800 (PST)
Date: Fri, 17 Nov 2023 11:52:03 +0100
In-Reply-To: <20231103.zoxol9ahthaW@digikod.net>
Message-Id: <ZVdF02XuV3B86UlE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231103155717.78042-7-gnoack@google.com>
 <20231103.zoxol9ahthaW@digikod.net>
Subject: Re: [PATCH v4 6/7] samples/landlock: Add support for LANDLOCK_ACCESS_FS_IOCTL
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks!  (I see you fixed these two on mic-next already.)

On Thu, Nov 16, 2023 at 04:50:03PM -0500, Micka=EF=BF=BDl Sala=EF=BF=BDn wr=
ote:
> On Fri, Nov 03, 2023 at 04:57:16PM +0100, G=EF=BF=BDnther Noack wrote:
> > Add ioctl support to the Landlock sample tool.
> >=20
> > The ioctl right is grouped with the read-write rights in the sample
> > tool, as some ioctl requests provide features that mutate state.
> >=20
> > Signed-off-by: G=EF=BF=BDnther Noack <gnoack@google.com>
> > ---
> >  samples/landlock/sandboxer.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.=
c
> > index 08596c0ef070..a4b2bebaf203 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -81,7 +81,8 @@ static int parse_path(char *env_path, const char ***c=
onst path_list)
> >  	LANDLOCK_ACCESS_FS_EXECUTE | \
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL)
> > =20
> >  /* clang-format on */
> > =20
> > @@ -199,7 +200,8 @@ static int populate_ruleset_net(const char *const e=
nv_var, const int ruleset_fd,
> >  	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> >  	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> >  	LANDLOCK_ACCESS_FS_REFER | \
> > -	LANDLOCK_ACCESS_FS_TRUNCATE)
> > +	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > +	LANDLOCK_ACCESS_FS_IOCTL)
> > =20
> >  /* clang-format on */
> > =20
>=20
> #define LANDLOCK_ABI_LAST 5
>=20
> > @@ -317,6 +319,10 @@ int main(const int argc, char *const argv[], char =
*const *const envp)
> >  		ruleset_attr.handled_access_net &=3D
> >  			~(LANDLOCK_ACCESS_NET_BIND_TCP |
> >  			  LANDLOCK_ACCESS_NET_CONNECT_TCP);
>=20
> __attribute__((fallthrough));
>=20
> > +	case 4:
> > +		/* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
> > +		ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
> > +
> >  		fprintf(stderr,
> >  			"Hint: You should update the running kernel "
> >  			"to leverage Landlock features "
> > --=20
> > 2.42.0.869.gea05f2083d-goog
> >=20

