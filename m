Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF16E7BA191
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Oct 2023 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjJEOpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237013AbjJEOnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:43:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8C919DA;
        Thu,  5 Oct 2023 07:19:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68249C43397;
        Thu,  5 Oct 2023 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696515594;
        bh=ioyqBCfpdobqYs4clL9FnA6RQauvcrnCtnIY+oIl3ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GIsqUURLhZOqQrT8yqDukkzp/1YgQY1ROgEwjUz57ZEPdfgKZjPe426e4Fvn9zz7V
         5W2kN9i08ucNfL5N+zAMlaSyp35xM/kwIaIbVQL6N/mlLN7VZ4IGjV/aT+Wwn0aTdG
         ThFUH4f6FgDmOrP/QtlK0dKAxs3L1IeEdUVP8pg8tbdFOGa+aAAHvdkLNE/nULGPtR
         fNeN/434onptlavHdk5MRITgZEDtzW8ndfWhgGhqrybKCp5PRj2ouvdOD/kVIpQNYX
         t6XUrQ61pLOADBtGOxtpZXguSf4mEm4rZYxkKAxyrAbLF4J01ZbUavemlx5xZqX5VV
         LvMj+j5h0/0UQ==
Date:   Thu, 5 Oct 2023 15:19:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, nd@arm.com,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        maz@kernel.org, oliver.upton@linux.dev, shuah@kernel.org,
        will@kernel.org, kvmarm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 07/20] arm64: enable the Permission Overlay Extension
 for EL0
Message-ID: <e857348d-2726-45cb-b088-0f6368b44514@sirena.org.uk>
References: <20230927140123.5283-1-joey.gouly@arm.com>
 <20230927140123.5283-8-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8+AeTyjR3Dtj+J8t"
Content-Disposition: inline
In-Reply-To: <20230927140123.5283-8-joey.gouly@arm.com>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--8+AeTyjR3Dtj+J8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 03:01:10PM +0100, Joey Gouly wrote:

> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -400,6 +400,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[]=
 =3D {
>  };
> =20
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr3[] =3D {
> +	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3=
_EL1_S1POE_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_=
EL1_S1PIE_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR3_=
EL1_TCRX_SHIFT, 4, 0),
>  	ARM64_FTR_END,
> @@ -2220,6 +2221,12 @@ static void cpu_enable_mops(const struct arm64_cpu=
_capabilities *__unused)
>  	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_MSCEn);
>  }
> =20
> +static void cpu_enable_poe(const struct arm64_cpu_capabilities *__unused)
> +{
> +	sysreg_clear_set(REG_TCR2_EL1, 0, TCR2_EL1x_E0POE);
> +	sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_E0POE);
> +}
> +
>  /* Internal helper functions to match cpu capability type */
>  static bool
>  cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
> @@ -2724,6 +2731,7 @@ static const struct arm64_cpu_capabilities arm64_fe=
atures[] =3D {
>  		.capability =3D ARM64_HAS_S1POE,
>  		.type =3D ARM64_CPUCAP_BOOT_CPU_FEATURE,
>  		.matches =3D has_cpuid_feature,
> +		.cpu_enable =3D cpu_enable_poe,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
>  	},
>  	{},
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c

I'd also expect to see an update to arm64_elf_hwcaps[]?

--8+AeTyjR3Dtj+J8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUexgMACgkQJNaLcl1U
h9DdPQf+MoPCKizqQ2zaY8Y1D5V8WlIwkYZFtGS3u88oO01OvQ1NPnw0FIt5QylA
Av4l9yfYPeZEMD7/ccIalJdq7OZxyZe6w2AZi9vmY/FQvckPiy8my6ylpWo/E5Sb
zy9JRySG9T492QO1sMtK7SQFtqB8fVStFx1epxfYkC6Qk2HvvY8vtRgugfbjr07d
JaAUguuI3036XzLPLPtCjN7pVts/CJzbRWss8plygg6ayJ9Unum/Fledih0ST4FK
tZlXrfrYID19A0I1VckKNazmKaJBUXn4flaOOkUn0dmTxS67krjSK1sVxMyW7cUG
N7vWOPNUlOm8odz/vH7c+5G0YiihgA==
=Uz9V
-----END PGP SIGNATURE-----

--8+AeTyjR3Dtj+J8t--
