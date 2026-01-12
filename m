Return-Path: <linux-fsdevel+bounces-73224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F7D1297E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75F730B9639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 12:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A626357A37;
	Mon, 12 Jan 2026 12:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W1jiVqnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139F3563FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222012; cv=none; b=Rv8az26PO4aZosr31PVo4ND+pmvaFwfsvAJey97Z/iXa7mOmzP7EQ/TSHmbNdntAAKiKovWPxCHt5nhvuShP/uuCEVFD++dCExT1mW4cIUv66me8KEJkNUnHU8FfN1WP1qplpYLCCZfyeD23LISWU5mTHAVKkpUlmcj8pDL7o/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222012; c=relaxed/simple;
	bh=9m4Fl2k9KQWJbcfOAq3Cu2yoH//35FVnMui0yhZmKPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4+N9s1HaMshi92q+abMfvyZRl0PlcjSFwbKhr/HwQlvlHlr2/WywEVhT9VXbOuBTHgssFzh6i/ibPJR1lzikoE2vpUyzbiOBe+WGt/thA5Aa71Rdt7SaO2tlQkG29ZIAh01huIiiHwBTUkLuQRIXakSOJzgX9QJOZYJHARg+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W1jiVqnT; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432da746749so1471000f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 04:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768222006; x=1768826806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJfksYBMf04F9YsRSch9TVJyappZDo9nWWGjONWbc7U=;
        b=W1jiVqnTbR7wDRKcPi/d1jMqxjvrB3YosQXvfqGJ/ntEQJYvFZqJsU7fg+dZor2GCf
         RAWlUgoUrpx2mjxImo+iHy3v3M/QrDu4VwdwUfMKTVzxdRGsPvEya1D1XQ1qr/Hbj5e7
         rQ3koygonJvpIjQpUrWythrJTKuwmoRtWr4+XSiOltAL6vxD6J4nI8Oxrf2Fdq/GNRbl
         MNZBVWS/5pwiRCCHginaG4L/PUhCaS/tGskTON2cizbV2xoukAx7ZYmW7z3AE2ONf2oU
         iEahRnmarEXX70jm13InrUtPAqyLxJYCRkIkoQrNS57JPiVaHfki6Cp7XVdcHVqAvmZc
         CWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222006; x=1768826806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJfksYBMf04F9YsRSch9TVJyappZDo9nWWGjONWbc7U=;
        b=muOyZXSQnR2TDXV7jAHXt+wYcTTFpu1gFW0UcXBbw2DadQgECEnkZ+Qoy9+uPco70Z
         pDQ80yIMLeFSEF4nWC+Ty2pm0hXvCyPLHGWqtHcmjNEuM0nK8ih1E7XIbHkWZ2Fr5nN/
         6gMZb0VYC+efAuK9fVwG732GGOEhIhAxPkayGiPV4wXj8LmSGCqNhhBwjUkJJHdPRnsy
         Dc+E5mItg9/UHoDl6P5MYfSwWRana1T1TIcWo2eCFax63zL5PjtpCELsCjtytFvMSOgx
         ovaitkvWqg5sv8+Hk+u0apoEl4JaO6dGQXfg2w6YJo6poZaH6xb4HSyz3X3g5c2tdw3l
         p/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV717ng3SpYHMNK3u3Iu9G6+m7EbOce88/gYODlmEBZsVODyOsVoOWyHo1R07MwDEv/8wabUeCzEFCnugHF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/DpXfpykK19bHa2o3Z7UIeliqaUpaDZIb7K5sZsREwQDF7joZ
	RpjcG5LHuqaobABzwENGY1qg4mtcaWPTIfA7Emq/Vjv//Tgc9kQnILqCmOTcML3QmbK4ic2aWHA
	Rl6hY
X-Gm-Gg: AY/fxX5RHpxLKVLDucH+qVGb4DZDhQ7KX7fJPKNY3bVYRBYMxZrQVo6uhlpqfUn5LM/
	XgjKm4JCXpNjg0BDJdT5zJwbpNqhhJ2ArDYRnWFoh51aP61GTJjRJiRnWKfZEYAZiNZVLsdv3w+
	ui+xavceNtubUz8Bfusx79M/DGB8B0w29HGIiXulOl/1ZDgHZCwwLqbvUOvZweze/QmE5cwDebM
	NcsSNqUa1Fwug3Zl5W6DQpqt8aW02VrBw1g8Jhn42hVzkRjOsCzJO5Erj3rDHm/9sZ1xkBnJgte
	uZiQ6ze4GqrrL+mhOPsFTMidSaev0xiMK/Dq1lyzqUBmX8KKf+9z8MANezQWWeDrKHqOjmZviy5
	RHPxEdcVjiOCiqB/xkDJYQm2rv4R6fI8iJmjhPCtbA0V2NDwtEF2j6Tm90ENe8xoY0rmo3PFWrF
	XZyOZ0f5QS/FSPlI1JcbPpZcAYSyDyGGc=
X-Google-Smtp-Source: AGHT+IH2IebLAKFKxY8Uvt4jUIFFT+Ij8Y6D7r7fSKRO8YCnnaSQ8GLFJdjyy1UaUIlKGcgUiTElog==
X-Received: by 2002:a05:6000:26c4:b0:430:96bd:411b with SMTP id ffacd0b85a97d-432c3775a8cmr21299946f8f.58.1768222006097;
        Mon, 12 Jan 2026 04:46:46 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm37877453f8f.4.2026.01.12.04.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:46:45 -0800 (PST)
Date: Mon, 12 Jan 2026 13:46:44 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 2/3] exec: inherit HWCAPs from the parent process
Message-ID: <wfl47fj3l4xhffrwuqfn5pgtrrn3s64lxxodnz5forx7d4x443@spsi3sx33lnf>
References: <20260108050748.520792-1-avagin@google.com>
 <20260108050748.520792-3-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o7rqwh4s3kscjtie"
Content-Disposition: inline
In-Reply-To: <20260108050748.520792-3-avagin@google.com>


--o7rqwh4s3kscjtie
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] exec: inherit HWCAPs from the parent process
MIME-Version: 1.0

On Thu, Jan 08, 2026 at 05:07:47AM +0000, Andrei Vagin <avagin@google.com> =
wrote:
> @@ -1780,6 +1791,50 @@ static int bprm_execve(struct linux_binprm *bprm)
>  	return retval;
>  }
> =20
> +static void inherit_hwcap(struct linux_binprm *bprm)
> +{
> +	int i, n;
> +
> +#ifdef ELF_HWCAP4
> +	n =3D 4;
> +#elif defined(ELF_HWCAP3)
> +	n =3D 3;
> +#elif defined(ELF_HWCAP2)
> +	n =3D 2;
> +#else
> +	n =3D 1;
> +#endif

Is it guaranteed that HWCAP n+1 exists only when n does?
(To make this work.)

> +
> +	for (i =3D 0; n && i < AT_VECTOR_SIZE; i +=3D 2) {
> +		long val =3D current->mm->saved_auxv[i + 1];
> +
> +		switch (current->mm->saved_auxv[i]) {
> +		case AT_HWCAP:
> +			bprm->hwcap =3D val & ELF_HWCAP;
> +			break;
> +#ifdef ELF_HWCAP2
> +		case AT_HWCAP2:
> +			bprm->hwcap2 =3D val & ELF_HWCAP2;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP3
> +		case AT_HWCAP3:
> +			bprm->hwcap3 =3D val & ELF_HWCAP3;
> +			break;
> +#endif
> +#ifdef ELF_HWCAP4
> +		case AT_HWCAP4:
> +			bprm->hwcap4 =3D val & ELF_HWCAP4;
> +			break;
> +#endif
> +		default:
> +			continue;
> +		}
> +		n--;
> +	}
> +	mm_flags_set(MMF_USER_HWCAP, bprm->mm);

Will this work when mm->saved_auxv isn't set by the prctl (it is
zeroes?)?

Thanks,
Michal

--o7rqwh4s3kscjtie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWTtMRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AisSAEA3jOw1q2q7fyDcfOoeTcd
ydeYIa3MJ59Bw5P1NbVJP0YA/0e1/9IiJ/h7y8JbPASpknLbuJY7oLSlA/zl9MUy
MJQF
=Iqi6
-----END PGP SIGNATURE-----

--o7rqwh4s3kscjtie--

