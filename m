Return-Path: <linux-fsdevel+bounces-53112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7CAEA4F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 20:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA5517AC067
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801202ED862;
	Thu, 26 Jun 2025 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BaKoARYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C052EBDFF;
	Thu, 26 Jun 2025 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961505; cv=none; b=H3uaQp4ATu/hFPbsE4gPVLLKEPcL0T3KcBJ1PI0nxNxpncwouSTQ7mAvFKSWfXG/JfhEL9SD5yW3LH1satWkXJzzeZyETD/3eCRCwJE/ivCzp+WDmW6Gh2DK0GoRi9andvTsdHLpHccFIXqkDvSM1vz9Wxk4IwNWIOJ84H+99q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961505; c=relaxed/simple;
	bh=/vTqsWsQnnD6PxS8RqEp3lyYDah0D1sXXjxJyrumqZI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ec7J+ni/qAGXvVECmbHv2sjzZ21ThBMVMkw9GPUdFi5KhtQUz1Y1PJjr/GCZUeSx9cmLU911P1HFc64/b104/I7UCTQlTlQ1KmQwrHK+j/60AdKnT/gWW8i7SPU7LmgNlQPOdL4mnP0Ax1AQaaHp30L1HGTUxMKp9Xy29CVizec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BaKoARYI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LjE007gYCBpNBo6Eo9JKv1OoWp0a2hHAJM79jEQpxYM=;
	t=1750961504; x=1752171104; b=BaKoARYIsnp2GemovybvRVesCARYXGR+IxR4WQ23I33x54b
	txL/HgjWJCb3Az/E66dzyqMvF4y9R6jKAAPdeV1Ypbak2jy6qvR7GvQg2Rvyud1Luibd6zYnSGxye
	O7METzP8/y88iCv3cTTPbsl9Eoc91/YH/SsypUVgrs+PKO+MKE7H94pfsilIvVoZVm7fqxkFrlebf
	N6R77B69gqwzJIkyB73bLIp4gEy1i9rc6LAtSxa5w6yrRRIIXkITwwrvu9fNPq1FBQgIxp+KeSLA+
	gnqr0/mJIb3mANZ4wEKRJ4w4YSUekfqQEfDfKgnBepTutTtaQ5JsiEN+rAJWWyTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uUr4B-0000000BuZ7-2DCz;
	Thu, 26 Jun 2025 20:11:19 +0200
Message-ID: <66deaafe1974c989e949975bafe3ab0b2ae3f5ff.camel@sipsolutions.net>
Subject: Re: [PATCH v4 12/15] kunit: Introduce UAPI testing framework
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Andrew Morton	 <akpm@linux-foundation.org>, Willy
 Tarreau <w@1wt.eu>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=	
 <linux@weissschuh.net>, Brendan Higgins <brendan.higgins@linux.dev>, David
 Gow	 <davidgow@google.com>, Rae Moar <rmoar@google.com>, Shuah Khan
 <shuah@kernel.org>,  Jonathan Corbet	 <corbet@lwn.net>, Nicolas Schier
 <nicolas.schier@linux.dev>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org, Kees Cook
 <kees@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 	linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Date: Thu, 26 Jun 2025 20:11:17 +0200
In-Reply-To: <20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de> (sfid-20250626_081057_904093_DFB49A53)
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
	 <20250626-kunit-kselftests-v4-12-48760534fef5@linutronix.de>
	 (sfid-20250626_081057_904093_DFB49A53)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Thomas,

I ran into two minor issues trying out the patches, see inline.

On Thu, 2025-06-26 at 08:10 +0200, Thomas Wei=C3=9Fschuh wrote:
> Enable running UAPI tests as part of kunit.
> The selftests are embedded into the kernel image and their output is
> forwarded to kunit for unified reporting.
>=20
> The implementation reuses parts of usermode drivers and usermode
> helpers. However these frameworks are not used directly as they make it
> impossible to retrieve a thread's exit code.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>=20
> [SNIP]
> +/**
> + * KUNIT_UAPI_EMBED_BLOB() - Embed another build artifact into the kerne=
l
> + * @_name: The name of symbol under which the artifact is embedded.
> + * @_path: Path to the artifact on disk.
> + *
> + * Embeds a build artifact like a userspace executable into the kernel o=
r current module.
> + * The build artifact is read from disk and needs to be already built.
> + */
> +#define KUNIT_UAPI_EMBED_BLOB(_name, _path)					\
> +	asm (									\
> +	"	.pushsection .rodata, \"a\"				\n"	\
> +	"	.global " __stringify(CONCATENATE(_name, _data)) "	\n"	\
> +	__stringify(CONCATENATE(_name, _data)) ":			\n"	\
> +	"	.incbin " __stringify(_path) "				\n"	\
> +	"	.size " __stringify(CONCATENATE(_name, _data)) ", "		\
> +			". - " __stringify(CONCATENATE(_name, _data)) "	\n"	\
> +	"	.global " __stringify(CONCATENATE(_name, _end)) "	\n"	\
> +	__stringify(CONCATENATE(_name, _end)) ":			\n"	\
> +	"	.popsection						\n"	\
> +	);									\
> +										\
> +	extern const char CONCATENATE(_name, _data)[];				\
> +	extern const char CONCATENATE(_name, _end)[];				\
> +										\
> +	static const struct kunit_uapi_blob _name =3D {				\
> +		.path	=3D _path,						\
> +		.data	=3D CONCATENATE(_name, _data),				\
> +		.end	=3D CONCATENATE(_name, _end),				\
> +	}									\

For me, the compiler could not find the files for the ".incbin" unless
I added an include path. i.e. adding
  ccflags-y :=3D -I$(obj)
to lib/kunit/Makefile fixed the problem for me.

> [SNIP]
> +static int kunit_uapi_run_executable_in_mount(struct kunit *test, const =
char *executable,
> +						=C2=A0=C2=A0 struct vfsmount *mnt)
> +{
> +	struct kunit_uapi_user_mode_thread_ctx ctx =3D {
> +		.setup_done	=3D COMPLETION_INITIALIZER_ONSTACK(ctx.setup_done),
> +		.executable	=3D executable,
> +		.pwd		=3D {
> +			.mnt	=3D mnt,
> +			.dentry	=3D mnt->mnt_root,
> +		},
> +	};
> +	int forward_err, wait_err, ret;

ret needs to be initialized to zero here as the kernel_wait function
will only set "ret" if wo.wo_stat is non-zero.

Benjamin

> [SNIP]


