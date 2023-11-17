Return-Path: <linux-fsdevel+bounces-3010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47377EF11F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 11:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4AF28123D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 10:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7883C1A702;
	Fri, 17 Nov 2023 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCBBUpL5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C2111F
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 02:54:41 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso29587257b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 02:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700218481; x=1700823281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dLg6+mVmC37ssrB4Zlh997BM9umW3Bgu9aiwvUHj+w=;
        b=qCBBUpL5DV1tsTJv7vbDyjTxC4GTMyshkCIH9gJRQEL2jB6/rLE4GSLjp3jB/UzF7q
         go4gkb44lnx2MoLcXvP+B33jOzeIpvGPUJWwRO2VAZlIAiYKj1CPCdGCY/4QNnfFDLAA
         il2h/blqeDBACvsItxonjWdJ/axaAvxlcmQG5v+lIPCFik2Via7hi+bc6QG3caSZvtxL
         nNGNd/gZrZt7DKL0WGOzZsmw+c5dXvCLfyfghBZ7o1ISFBl3E//Y44cyU9VKuZ7woigX
         18gJa1BiST7KNe+JhICPxCIFGME4jtXw4cpzFiRC1oMW1DAypK1CNiDjjeD3Jq/+m4SH
         Nvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700218481; x=1700823281;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5dLg6+mVmC37ssrB4Zlh997BM9umW3Bgu9aiwvUHj+w=;
        b=J0FgmyF7kAcQ8MGqdXLMG+X8S876n54FEKJkG/4EX2+HcC/sbapJxcRdGSoHoF2YVH
         zGGFVuOQKzE2NAnDsBB06Z/WLeWUUDqMzbe/++AI5fXzRSABqx972rzrifvRQKVq9bT/
         fk9bbFevSu4C6hF3lzaUecz+RChG031HDhURO7Zd/CjiwsxB5sCv6fvNXDZRpVUBuheO
         Tgw8jc3ku14rU15TJ1/JsOGlPZkfOVZFGuADDd7K1hAmqiGFha7kmDfbK+FXA8uS36Jt
         cqs46Bn1pmAS75YsH9ollSABvW8RExeA0iXtb0IG3X50nmQuagDkMJQqkZzmh77O/QKo
         X5ow==
X-Gm-Message-State: AOJu0YzS4iNTFsOe9p+A6he8mUqHjFlS+eiK+wLzn/Ogd+z/CdA6kAgu
	biCV+fKSnkl4JgrmhBg/YA8WTBe1Aqg=
X-Google-Smtp-Source: AGHT+IEe+qh9ywWNkcjvpXZE5ZCy9d0SF9AarStWTxoVHohoAA3VMfSn0NnV7FJXSjK2mrVZKB+wUIx8gMU=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:2ae5:2882:889e:d0cf])
 (user=gnoack job=sendgmr) by 2002:a25:8912:0:b0:d9a:fd29:4fe6 with SMTP id
 e18-20020a258912000000b00d9afd294fe6mr495356ybl.3.1700218480830; Fri, 17 Nov
 2023 02:54:40 -0800 (PST)
Date: Fri, 17 Nov 2023 11:54:31 +0100
In-Reply-To: <20231116.iho7Faitawah@digikod.net>
Message-Id: <ZVdGZ4kMY7GnoKKs@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231103155717.78042-1-gnoack@google.com> <20231103155717.78042-2-gnoack@google.com>
 <20231116.iho7Faitawah@digikod.net>
Subject: Re: [PATCH v4 1/7] landlock: Optimize the number of calls to
 get_access_mask slightly
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 04:49:46PM -0500, Micka=EF=BF=BDl Sala=EF=BF=BDn wr=
ote:
> On Fri, Nov 03, 2023 at 04:57:11PM +0100, G=EF=BF=BDnther Noack wrote:
> > This call is now going through a function pointer,
> > and it is not as obvious any more that it will be inlined.
> >=20
> > Signed-off-by: G=EF=BF=BDnther Noack <gnoack@google.com>
> > ---
> >  security/landlock/ruleset.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
> > index ffedc99f2b68..fd348633281c 100644
> > --- a/security/landlock/ruleset.c
> > +++ b/security/landlock/ruleset.c
> > @@ -724,10 +724,11 @@ landlock_init_layer_masks(const struct landlock_r=
uleset *const domain,
> >  	for (layer_level =3D 0; layer_level < domain->num_layers; layer_level=
++) {
> >  		const unsigned long access_req =3D access_request;
> >  		unsigned long access_bit;
> > +		access_mask_t access_mask =3D
>=20
> You can make it const and move it below the other const.

Done.

> > +			get_access_mask(domain, layer_level);
> > =20
> >  		for_each_set_bit(access_bit, &access_req, num_access) {
> > -			if (BIT_ULL(access_bit) &
> > -			    get_access_mask(domain, layer_level)) {
> > +			if (BIT_ULL(access_bit) & access_mask) {
> >  				(*layer_masks)[access_bit] |=3D
> >  					BIT_ULL(layer_level);
> >  				handled_accesses |=3D BIT_ULL(access_bit);
> > --=20
> > 2.42.0.869.gea05f2083d-goog
> >=20

