Return-Path: <linux-fsdevel+bounces-42186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24FAA3E595
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 21:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5A4174118
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 20:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E22638A0;
	Thu, 20 Feb 2025 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVlPP9GE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29870214218
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082007; cv=none; b=VeTB5dhwVr/LQWep5sRkljkoIGBdeWjNbfZRhVYX4aATN5nrc/dYsvYI2T9Mn9Cu+83eIOry199shPwQqJB5Swg6QMQzzJw/cV4v4QqWCPqQmj/fR+w5f5n8NfnsNKfHCE7aXTGUybNTMmjtUqjk16+Tflxg8QnOsbvusg8Q1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082007; c=relaxed/simple;
	bh=cKugbOpgswlis1Z5dV3I5Hd+22d512BRQuZU+Ew9wL4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PNmybNSnI2bUa2lxuY8U7zQuqyOivGETJ3OAbmnqngwWTJjw3mWbo+Qge/4VPeRV7dxq9ZrPR7Ske2Qw/MUmwG0Dhb7wBTe/9Ps0Sfw3S7IFdxF15oRIg3gmnYFVaV6siHDoDDpo7EfE13OVlgNNIzfvsEB2YD3Z/gFB463V9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVlPP9GE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B7FC4CED1;
	Thu, 20 Feb 2025 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740082006;
	bh=cKugbOpgswlis1Z5dV3I5Hd+22d512BRQuZU+Ew9wL4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XVlPP9GErFAsL0C9DPp1Hppwo6E9lK3eb7Wj6aSglno69yNVqmMDOMUwzDts8Fmj9
	 Xjo3P3r4z0GPfAo40ybfsWn/lhVjp3gf1U0WHzShxdKjIy4BIfvKxcDK9qKSJcWIsr
	 PcAHtwDrn4ynomVdp/KrZ3TKIDw74UavoaZkN/u58qkH/uWBw+ZDQn5BV2iLiJSYIA
	 Sp9SAhbTO8CKVide5x/9EyitNNiMTz7m478saMZj+XO16tbDI+ifqsVLS9ic//qHm3
	 XKeaBINIPPER0lJxmW/S+wDhW/A/qKDQGXC/KIjxLt6ma7KClDC82gwHnJkrtCbyAa
	 aqrCY33jQZjfw==
Message-ID: <16f621e592978794737f4b547ee23b7d41201cbe.camel@kernel.org>
Subject: Re: [PATCH] sysv: Remove the filesystem
From: Jeff Layton <jlayton@kernel.org>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Date: Thu, 20 Feb 2025 15:06:44 -0500
In-Reply-To: <20250220163940.10155-2-jack@suse.cz>
References: <20250220163940.10155-2-jack@suse.cz>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCVKZWZmIExheXRvbiA8amxheXRvbkBwb29jaGllcmVkcy5uZXQ+iQI7BB
 MBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCTpXWPAIZAQAKCRAADmhBGVaCFc65D/4
 gBLNMHopQYgG/9RIM3kgFCCQV0pLv0hcg1cjr+bPI5f1PzJoOVi9s0wBDHwp8+vtHgYhM54yt43uI
 7Htij0RHFL5eFqoVT4TSfAg2qlvNemJEOY0e4daljjmZM7UtmpGs9NN0r9r50W82eb5Kw5bc/r0km
 R/arUS2st+ecRsCnwAOj6HiURwIgfDMHGPtSkoPpu3DDp/cjcYUg3HaOJuTjtGHFH963B+f+hyQ2B
 rQZBBE76ErgTDJ2Db9Ey0kw7VEZ4I2nnVUY9B5dE2pJFVO5HJBMp30fUGKvwaKqYCU2iAKxdmJXRI
 ONb7dSde8LqZahuunPDMZyMA5+mkQl7kpIpR6kVDIiqmxzRuPeiMP7O2FCUlS2DnJnRVrHmCljLkZ
 Wf7ZUA22wJpepBligemtSRSbqCyZ3B48zJ8g5B8xLEntPo/NknSJaYRvfEQqGxgk5kkNWMIMDkfQO
 lDSXZvoxqU9wFH/9jTv1/6p8dHeGM0BsbBLMqQaqnWiVt5mG92E1zkOW69LnoozE6Le+12DsNW7Rj
 iR5K+27MObjXEYIW7FIvNN/TQ6U1EOsdxwB8o//Yfc3p2QqPr5uS93SDDan5ehH59BnHpguTc27Xi
 QQZ9EGiieCUx6Zh2ze3X2UW9YNzE15uKwkkuEIj60NvQRmEDfweYfOfPVOueC+iFifbQgSmVmZiBM
 YXl0b24gPGpsYXl0b25AcmVkaGF0LmNvbT6JAjgEEwECACIFAk6V0q0CGwMGCwkIBwMCBhUIAgkKC
 wQWAgMBAh4BAheAAAoJEAAOaEEZVoIViKUQALpvsacTMWWOd7SlPFzIYy2/fjvKlfB/Xs4YdNcf9q
 LqF+lk2RBUHdR/dGwZpvw/OLmnZ8TryDo2zXVJNWEEUFNc7wQpl3i78r6UU/GUY/RQmOgPhs3epQC
 3PMJj4xFx+VuVcf/MXgDDdBUHaCTT793hyBeDbQuciARDJAW24Q1RCmjcwWIV/pgrlFa4lAXsmhoa
 c8UPc82Ijrs6ivlTweFf16VBc4nSLX5FB3ls7S5noRhm5/Zsd4PGPgIHgCZcPgkAnU1S/A/rSqf3F
 LpU+CbVBDvlVAnOq9gfNF+QiTlOHdZVIe4gEYAU3CUjbleywQqV02BKxPVM0C5/oVjMVx3bri75n1
 TkBYGmqAXy9usCkHIsG5CBHmphv9MHmqMZQVsxvCzfnI5IO1+7MoloeeW/lxuyd0pU88dZsV/riHw
 87i2GJUJtVlMl5IGBNFpqoNUoqmvRfEMeXhy/kUX4Xc03I1coZIgmwLmCSXwx9MaCPFzV/dOOrju2
 xjO+2sYyB5BNtxRqUEyXglpujFZqJxxau7E0eXoYgoY9gtFGsspzFkVNntamVXEWVVgzJJr/EWW0y
 +jNd54MfPRqH+eCGuqlnNLktSAVz1MvVRY1dxUltSlDZT7P2bUoMorIPu8p7ZCg9dyX1+9T6Muc5d
 Hxf/BBP/ir+3e8JTFQBFOiLNdFtB9KZWZmIExheXRvbiA8amxheXRvbkBzYW1iYS5vcmc+iQI4BBM
 BAgAiBQJOldK9AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRAADmhBGVaCFWgWD/0ZRi4h
 N9FK2BdQs9RwNnFZUr7JidAWfCrs37XrA/56olQl3ojn0fQtrP4DbTmCuh0SfMijB24psy1GnkPep
 naQ6VRf7Dxg/Y8muZELSOtsv2CKt3/02J1BBitrkkqmHyni5fLLYYg6fub0T/8Kwo1qGPdu1hx2BQ
 RERYtQ/S5d/T0cACdlzi6w8rs5f09hU9Tu4qV1JLKmBTgUWKN969HPRkxiojLQziHVyM/weR5Reu6
 FZVNuVBGqBD+sfk/c98VJHjsQhYJijcsmgMb1NohAzwrBKcSGKOWJToGEO/1RkIN8tqGnYNp2G+aR
 685D0chgTl1WzPRM6mFG1+n2b2RR95DxumKVpwBwdLPoCkI24JkeDJ7lXSe3uFWISstFGt0HL8Eew
 P8RuGC8s5h7Ct91HMNQTbjgA+Vi1foWUVXpEintAKgoywaIDlJfTZIl6Ew8ETN/7DLy8bXYgq0Xzh
 aKg3CnOUuGQV5/nl4OAX/3jocT5Cz/OtAiNYj5mLPeL5z2ZszjoCAH6caqsF2oLyAnLqRgDgR+wTQ
 T6gMhr2IRsl+cp8gPHBwQ4uZMb+X00c/Amm9VfviT+BI7B66cnC7Zv6Gvmtu2rEjWDGWPqUgccB7h
 dMKnKDthkA227/82tYoFiFMb/NwtgGrn5n2vwJyKN6SEoygGrNt0SI84y6hEVbQlSmVmZiBMYXl0b
 24gPGpsYXl0b25AcHJpbWFyeWRhdGEuY29tPokCOQQTAQIAIwUCU4xmKQIbAwcLCQgHAwIBBhUIAg
 kKCwQWAgMBAh4BAheAAAoJEAAOaEEZVoIV1H0P/j4OUTwFd7BBbpoSp695qb6HqCzWMuExsp8nZjr
 uymMaeZbGr3OWMNEXRI1FWNHMtcMHWLP/RaDqCJil28proO+PQ/yPhsr2QqJcW4nr91tBrv/MqItu
 AXLYlsgXqp4BxLP67bzRJ1Bd2x0bWXurpEXY//VBOLnODqThGEcL7jouwjmnRh9FTKZfBDpFRaEfD
 FOXIfAkMKBa/c9TQwRpx2DPsl3eFWVCNuNGKeGsirLqCxUg5kWTxEorROppz9oU4HPicL6rRH22Ce
 6nOAON2vHvhkUuO3GbffhrcsPD4DaYup4ic+DxWm+DaSSRJ+e1yJvwi6NmQ9P9UAuLG93S2MdNNbo
 sZ9P8k2mTOVKMc+GooI9Ve/vH8unwitwo7ORMVXhJeU6Q0X7zf3SjwDq2lBhn1DSuTsn2DbsNTiDv
 qrAaCvbsTsw+SZRwF85eG67eAwouYk+dnKmp1q57LDKMyzysij2oDKbcBlwB/TeX16p8+LxECv51a
 sjS9TInnipssssUDrHIvoTTXWcz7Y5wIngxDFwT8rPY3EggzLGfK5Zx2Q5S/N0FfmADmKknG/D8qG
 IcJE574D956tiUDKN4I+/g125ORR1v7bP+OIaayAvq17RP+qcAqkxc0x8iCYVCYDouDyNvWPGRhbL
 UO7mlBpjW9jK9e2fvZY9iw3QzIPGKtClKZWZmIExheXRvbiA8amVmZi5sYXl0b25AcHJpbWFyeWRh
 dGEuY29tPokCOQQTAQIAIwUCU4xmUAIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEAAOa
 EEZVoIVzJoQALFCS6n/FHQS+hIzHIb56JbokhK0AFqoLVzLKzrnaeXhE5isWcVg0eoV2oTScIwUSU
 apy94if69tnUo4Q7YNt8/6yFM6hwZAxFjOXR0ciGE3Q+Z1zi49Ox51yjGMQGxlakV9ep4sV/d5a50
 M+LFTmYSAFp6HY23JN9PkjVJC4PUv5DYRbOZ6Y1+TfXKBAewMVqtwT1Y+LPlfmI8dbbbuUX/kKZ5d
 dhV2736fgyfpslvJKYl0YifUOVy4D1G/oSycyHkJG78OvX4JKcf2kKzVvg7/Rnv+AueCfFQ6nGwPn
 0P91I7TEOC4XfZ6a1K3uTp4fPPs1Wn75X7K8lzJP/p8lme40uqwAyBjk+IA5VGd+CVRiyJTpGZwA0
 jwSYLyXboX+Dqm9pSYzmC9+/AE7lIgpWj+3iNisp1SWtHc4pdtQ5EU2SEz8yKvDbD0lNDbv4ljI7e
 flPsvN6vOrxz24mCliEco5DwhpaaSnzWnbAPXhQDWb/lUgs/JNk8dtwmvWnqCwRqElMLVisAbJmC0
 BhZ/Ab4sph3EaiZfdXKhiQqSGdK4La3OTJOJYZphPdGgnkvDV9Pl1QZ0ijXQrVIy3zd6VCNaKYq7B
 AKidn5g/2Q8oio9Tf4XfdZ9dtwcB+bwDJFgvvDYaZ5bI3ln4V3EyW5i2NfXazz/GA/I/ZtbsigCFc
 8ftCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQg
 HAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD
 2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozz
 uxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+9eiVUNpxF4SiU4i9J
 DfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRD
 CHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1g
 Yy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVV
 AaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJO
 aEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhp
 f8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+m
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 17:39 +0100, Jan Kara wrote:
> Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> rwlock") the sysv filesystem was doing IO under a rwlock in its
> get_block() function (yes, a non-sleepable lock hold over a function
> used to read inode metadata for all reads and writes).  Nobody noticed
> until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> Just drop it.
>=20
> [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/index.rst         |   1 -
>  Documentation/filesystems/sysv-fs.rst       | 264 ---------
>  MAINTAINERS                                 |   6 -
>  arch/loongarch/configs/loongson3_defconfig  |   1 -
>  arch/m68k/configs/amiga_defconfig           |   1 -
>  arch/m68k/configs/apollo_defconfig          |   1 -
>  arch/m68k/configs/atari_defconfig           |   1 -
>  arch/m68k/configs/bvme6000_defconfig        |   1 -
>  arch/m68k/configs/hp300_defconfig           |   1 -
>  arch/m68k/configs/mac_defconfig             |   1 -
>  arch/m68k/configs/multi_defconfig           |   1 -
>  arch/m68k/configs/mvme147_defconfig         |   1 -
>  arch/m68k/configs/mvme16x_defconfig         |   1 -
>  arch/m68k/configs/q40_defconfig             |   1 -
>  arch/m68k/configs/sun3_defconfig            |   1 -
>  arch/m68k/configs/sun3x_defconfig           |   1 -
>  arch/mips/configs/malta_defconfig           |   1 -
>  arch/mips/configs/malta_kvm_defconfig       |   1 -
>  arch/mips/configs/maltaup_xpa_defconfig     |   1 -
>  arch/mips/configs/rm200_defconfig           |   1 -
>  arch/parisc/configs/generic-64bit_defconfig |   1 -
>  arch/powerpc/configs/fsl-emb-nonhw.config   |   1 -
>  arch/powerpc/configs/ppc6xx_defconfig       |   1 -
>  fs/Kconfig                                  |   1 -
>  fs/Makefile                                 |   1 -
>  fs/sysv/Kconfig                             |  38 --
>  fs/sysv/Makefile                            |   9 -
>  fs/sysv/balloc.c                            | 240 --------
>  fs/sysv/dir.c                               | 378 ------------
>  fs/sysv/file.c                              |  59 --
>  fs/sysv/ialloc.c                            | 235 --------
>  fs/sysv/inode.c                             | 354 -----------
>  fs/sysv/itree.c                             | 511 ----------------
>  fs/sysv/namei.c                             | 280 ---------
>  fs/sysv/super.c                             | 616 --------------------
>  fs/sysv/sysv.h                              | 245 --------
>  include/linux/sysv_fs.h                     | 214 -------
>  37 files changed, 3472 deletions(-)
>  delete mode 100644 Documentation/filesystems/sysv-fs.rst
>  delete mode 100644 fs/sysv/Kconfig
>  delete mode 100644 fs/sysv/Makefile
>  delete mode 100644 fs/sysv/balloc.c
>  delete mode 100644 fs/sysv/dir.c
>  delete mode 100644 fs/sysv/file.c
>  delete mode 100644 fs/sysv/ialloc.c
>  delete mode 100644 fs/sysv/inode.c
>  delete mode 100644 fs/sysv/itree.c
>  delete mode 100644 fs/sysv/namei.c
>  delete mode 100644 fs/sysv/super.c
>  delete mode 100644 fs/sysv/sysv.h
>  delete mode 100644 include/linux/sysv_fs.h
>=20
> Hello Christian!
>=20
> Here is sysv removal patch rebased on top of your vfs.all branch. Can you=
 pull
> it into your tree? Or I could carry it in my tree but I guess there's no =
point.
> Thanks!
>=20
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesyst=
ems/index.rst
> index 2636f2a41bd3..a9cf8e950b15 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -118,7 +118,6 @@ Documentation for filesystem implementations.
>     spufs/index
>     squashfs
>     sysfs
> -   sysv-fs
>     tmpfs
>     ubifs
>     ubifs-authentication
> diff --git a/Documentation/filesystems/sysv-fs.rst b/Documentation/filesy=
stems/sysv-fs.rst
> deleted file mode 100644
> index 89e40911ad7c..000000000000
> --- a/Documentation/filesystems/sysv-fs.rst
> +++ /dev/null
> @@ -1,264 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0
> -
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -SystemV Filesystem
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -It implements all of
> -  - Xenix FS,
> -  - SystemV/386 FS,
> -  - Coherent FS.
> -
> -To install:
> -
> -* Answer the 'System V and Coherent filesystem support' question with 'y=
'
> -  when configuring the kernel.
> -* To mount a disk or a partition, use::
> -
> -    mount [-r] -t sysv device mountpoint
> -
> -  The file system type names::
> -
> -               -t sysv
> -               -t xenix
> -               -t coherent
> -
> -  may be used interchangeably, but the last two will eventually disappea=
r.
> -
> -Bugs in the present implementation:
> -
> -- Coherent FS:
> -
> -  - The "free list interleave" n:m is currently ignored.
> -  - Only file systems with no filesystem name and no pack name are recog=
nized.
> -    (See Coherent "man mkfs" for a description of these features.)
> -
> -- SystemV Release 2 FS:
> -
> -  The superblock is only searched in the blocks 9, 15, 18, which
> -  corresponds to the beginning of track 1 on floppy disks. No support
> -  for this FS on hard disk yet.
> -
> -
> -These filesystems are rather similar. Here is a comparison with Minix FS=
:
> -
> -* Linux fdisk reports on partitions
> -
> -  - Minix FS     0x81 Linux/Minix
> -  - Xenix FS     ??
> -  - SystemV FS   ??
> -  - Coherent FS  0x08 AIX bootable
> -
> -* Size of a block or zone (data allocation unit on disk)
> -
> -  - Minix FS     1024
> -  - Xenix FS     1024 (also 512 ??)
> -  - SystemV FS   1024 (also 512 and 2048)
> -  - Coherent FS   512
> -
> -* General layout: all have one boot block, one super block and
> -  separate areas for inodes and for directories/data.
> -  On SystemV Release 2 FS (e.g. Microport) the first track is reserved a=
nd
> -  all the block numbers (including the super block) are offset by one tr=
ack.
> -
> -* Byte ordering of "short" (16 bit entities) on disk:
> -
> -  - Minix FS     little endian  0 1
> -  - Xenix FS     little endian  0 1
> -  - SystemV FS   little endian  0 1
> -  - Coherent FS  little endian  0 1
> -
> -  Of course, this affects only the file system, not the data of files on=
 it!
> -
> -* Byte ordering of "long" (32 bit entities) on disk:
> -
> -  - Minix FS     little endian  0 1 2 3
> -  - Xenix FS     little endian  0 1 2 3
> -  - SystemV FS   little endian  0 1 2 3
> -  - Coherent FS  PDP-11         2 3 0 1
> -
> -  Of course, this affects only the file system, not the data of files on=
 it!
> -
> -* Inode on disk: "short", 0 means non-existent, the root dir ino is:
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D
> -  Minix FS                            1
> -  Xenix FS, SystemV FS, Coherent FS   2
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D
> -
> -* Maximum number of hard links to a file:
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  Minix FS     250
> -  Xenix FS     ??
> -  SystemV FS   ??
> -  Coherent FS  >=3D10000
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -* Free inode management:
> -
> -  - Minix FS
> -      a bitmap
> -  - Xenix FS, SystemV FS, Coherent FS
> -      There is a cache of a certain number of free inodes in the super-b=
lock.
> -      When it is exhausted, new free inodes are found using a linear sea=
rch.
> -
> -* Free block management:
> -
> -  - Minix FS
> -      a bitmap
> -  - Xenix FS, SystemV FS, Coherent FS
> -      Free blocks are organized in a "free list". Maybe a misleading ter=
m,
> -      since it is not true that every free block contains a pointer to
> -      the next free block. Rather, the free blocks are organized in chun=
ks
> -      of limited size, and every now and then a free block contains poin=
ters
> -      to the free blocks pertaining to the next chunk; the first of thes=
e
> -      contains pointers and so on. The list terminates with a "block num=
ber"
> -      0 on Xenix FS and SystemV FS, with a block zeroed out on Coherent =
FS.
> -
> -* Super-block location:
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  Minix FS     block 1 =3D bytes 1024..2047
> -  Xenix FS     block 1 =3D bytes 1024..2047
> -  SystemV FS   bytes 512..1023
> -  Coherent FS  block 1 =3D bytes 512..1023
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -* Super-block layout:
> -
> -  - Minix FS::
> -
> -                    unsigned short s_ninodes;
> -                    unsigned short s_nzones;
> -                    unsigned short s_imap_blocks;
> -                    unsigned short s_zmap_blocks;
> -                    unsigned short s_firstdatazone;
> -                    unsigned short s_log_zone_size;
> -                    unsigned long s_max_size;
> -                    unsigned short s_magic;
> -
> -  - Xenix FS, SystemV FS, Coherent FS::
> -
> -                    unsigned short s_firstdatazone;
> -                    unsigned long  s_nzones;
> -                    unsigned short s_fzone_count;
> -                    unsigned long  s_fzones[NICFREE];
> -                    unsigned short s_finode_count;
> -                    unsigned short s_finodes[NICINOD];
> -                    char           s_flock;
> -                    char           s_ilock;
> -                    char           s_modified;
> -                    char           s_rdonly;
> -                    unsigned long  s_time;
> -                    short          s_dinfo[4]; -- SystemV FS only
> -                    unsigned long  s_free_zones;
> -                    unsigned short s_free_inodes;
> -                    short          s_dinfo[4]; -- Xenix FS only
> -                    unsigned short s_interleave_m,s_interleave_n; -- Coh=
erent FS only
> -                    char           s_fname[6];
> -                    char           s_fpack[6];
> -
> -    then they differ considerably:
> -
> -        Xenix FS::
> -
> -                    char           s_clean;
> -                    char           s_fill[371];
> -                    long           s_magic;
> -                    long           s_type;
> -
> -        SystemV FS::
> -
> -                    long           s_fill[12 or 14];
> -                    long           s_state;
> -                    long           s_magic;
> -                    long           s_type;
> -
> -        Coherent FS::
> -
> -                    unsigned long  s_unique;
> -
> -    Note that Coherent FS has no magic.
> -
> -* Inode layout:
> -
> -  - Minix FS::
> -
> -                    unsigned short i_mode;
> -                    unsigned short i_uid;
> -                    unsigned long  i_size;
> -                    unsigned long  i_time;
> -                    unsigned char  i_gid;
> -                    unsigned char  i_nlinks;
> -                    unsigned short i_zone[7+1+1];
> -
> -  - Xenix FS, SystemV FS, Coherent FS::
> -
> -                    unsigned short i_mode;
> -                    unsigned short i_nlink;
> -                    unsigned short i_uid;
> -                    unsigned short i_gid;
> -                    unsigned long  i_size;
> -                    unsigned char  i_zone[3*(10+1+1+1)];
> -                    unsigned long  i_atime;
> -                    unsigned long  i_mtime;
> -                    unsigned long  i_ctime;
> -
> -
> -* Regular file data blocks are organized as
> -
> -  - Minix FS:
> -
> -             - 7 direct blocks
> -	     - 1 indirect block (pointers to blocks)
> -             - 1 double-indirect block (pointer to pointers to blocks)
> -
> -  - Xenix FS, SystemV FS, Coherent FS:
> -
> -             - 10 direct blocks
> -             -  1 indirect block (pointers to blocks)
> -             -  1 double-indirect block (pointer to pointers to blocks)
> -             -  1 triple-indirect block (pointer to pointers to pointers=
 to blocks)
> -
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -               Inode size   inodes per block
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -  Minix FS        32        32
> -  Xenix FS        64        16
> -  SystemV FS      64        16
> -  Coherent FS     64        8
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -* Directory entry on disk
> -
> -  - Minix FS::
> -
> -                    unsigned short inode;
> -                    char name[14/30];
> -
> -  - Xenix FS, SystemV FS, Coherent FS::
> -
> -                    unsigned short inode;
> -                    char name[14];
> -
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -                 Dir entry size    dir entries per block
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -  Minix FS       16/32             64/32
> -  Xenix FS       16                64
> -  SystemV FS     16                64
> -  Coherent FS    16                32
> -  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> -
> -* How to implement symbolic links such that the host fsck doesn't scream=
:
> -
> -  - Minix FS     normal
> -  - Xenix FS     kludge: as regular files with  chmod 1000
> -  - SystemV FS   ??
> -  - Coherent FS  kludge: as regular files with  chmod 1000
> -
> -
> -Notation: We often speak of a "block" but mean a zone (the allocation un=
it)
> -and not the disk driver's notion of "block".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4e17764cb6ed..58534bc39b2d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23075,12 +23075,6 @@ L:	platform-driver-x86@vger.kernel.org
>  S:	Maintained
>  F:	drivers/platform/x86/system76_acpi.c
> =20
> -SYSV FILESYSTEM
> -S:	Orphan
> -F:	Documentation/filesystems/sysv-fs.rst
> -F:	fs/sysv/
> -F:	include/linux/sysv_fs.h
> -
>  TASKSTATS STATISTICS INTERFACE
>  M:	Balbir Singh <bsingharora@gmail.com>
>  S:	Maintained
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/=
configs/loongson3_defconfig
> index 73c77500ac46..3c240afe5aed 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -981,7 +981,6 @@ CONFIG_MINIX_FS=3Dm
>  CONFIG_ROMFS_FS=3Dm
>  CONFIG_PSTORE=3Dm
>  CONFIG_PSTORE_COMPRESS=3Dy
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_EROFS_FS_ZIP_LZMA=3Dy
> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_=
defconfig
> index dbf2ea561c85..68a2e299ea71 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -486,7 +486,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apoll=
o_defconfig
> index b0fd199cc0a4..3696d0c19579 100644
> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig
> @@ -443,7 +443,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_=
defconfig
> index bb5b2d3b6c10..dbd4b58b724c 100644
> --- a/arch/m68k/configs/atari_defconfig
> +++ b/arch/m68k/configs/atari_defconfig
> @@ -463,7 +463,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvm=
e6000_defconfig
> index 8315a13bab73..95178e66703f 100644
> --- a/arch/m68k/configs/bvme6000_defconfig
> +++ b/arch/m68k/configs/bvme6000_defconfig
> @@ -435,7 +435,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_=
defconfig
> index 350370657e5f..68372a0b05ac 100644
> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig
> @@ -445,7 +445,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defc=
onfig
> index f942b4755702..a9beb4ec8a15 100644
> --- a/arch/m68k/configs/mac_defconfig
> +++ b/arch/m68k/configs/mac_defconfig
> @@ -462,7 +462,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_=
defconfig
> index b1eaad02efab..45a898e9c1d1 100644
> --- a/arch/m68k/configs/multi_defconfig
> +++ b/arch/m68k/configs/multi_defconfig
> @@ -549,7 +549,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme=
147_defconfig
> index 6309a4442bb3..350dc6d08461 100644
> --- a/arch/m68k/configs/mvme147_defconfig
> +++ b/arch/m68k/configs/mvme147_defconfig
> @@ -435,7 +435,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme=
16x_defconfig
> index 3feb0731f814..7ea283ba86b7 100644
> --- a/arch/m68k/configs/mvme16x_defconfig
> +++ b/arch/m68k/configs/mvme16x_defconfig
> @@ -436,7 +436,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defc=
onfig
> index ea04b1b0da7d..eb0de405e6a9 100644
> --- a/arch/m68k/configs/q40_defconfig
> +++ b/arch/m68k/configs/q40_defconfig
> @@ -452,7 +452,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_de=
fconfig
> index f52d9af92153..7026a139ccf8 100644
> --- a/arch/m68k/configs/sun3_defconfig
> +++ b/arch/m68k/configs/sun3_defconfig
> @@ -433,7 +433,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_=
defconfig
> index f348447824da..c91abb80b081 100644
> --- a/arch/m68k/configs/sun3x_defconfig
> +++ b/arch/m68k/configs/sun3x_defconfig
> @@ -433,7 +433,6 @@ CONFIG_OMFS_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_QNX6FS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_EROFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
> diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_=
defconfig
> index 4390d30206d9..e308b82c094a 100644
> --- a/arch/mips/configs/malta_defconfig
> +++ b/arch/mips/configs/malta_defconfig
> @@ -347,7 +347,6 @@ CONFIG_CRAMFS=3Dm
>  CONFIG_VXFS_FS=3Dm
>  CONFIG_MINIX_FS=3Dm
>  CONFIG_ROMFS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
>  CONFIG_ROOT_NFS=3Dy
> diff --git a/arch/mips/configs/malta_kvm_defconfig b/arch/mips/configs/ma=
lta_kvm_defconfig
> index d63d8be8cb50..fa5b04063ddb 100644
> --- a/arch/mips/configs/malta_kvm_defconfig
> +++ b/arch/mips/configs/malta_kvm_defconfig
> @@ -354,7 +354,6 @@ CONFIG_CRAMFS=3Dm
>  CONFIG_VXFS_FS=3Dm
>  CONFIG_MINIX_FS=3Dm
>  CONFIG_ROMFS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
>  CONFIG_ROOT_NFS=3Dy
> diff --git a/arch/mips/configs/maltaup_xpa_defconfig b/arch/mips/configs/=
maltaup_xpa_defconfig
> index 338bb6544a93..40283171af68 100644
> --- a/arch/mips/configs/maltaup_xpa_defconfig
> +++ b/arch/mips/configs/maltaup_xpa_defconfig
> @@ -353,7 +353,6 @@ CONFIG_CRAMFS=3Dm
>  CONFIG_VXFS_FS=3Dm
>  CONFIG_MINIX_FS=3Dm
>  CONFIG_ROMFS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_NFS_FS=3Dy
>  CONFIG_ROOT_NFS=3Dy
> diff --git a/arch/mips/configs/rm200_defconfig b/arch/mips/configs/rm200_=
defconfig
> index 08e1c1f2f4de..3a6d0384b774 100644
> --- a/arch/mips/configs/rm200_defconfig
> +++ b/arch/mips/configs/rm200_defconfig
> @@ -336,7 +336,6 @@ CONFIG_MINIX_FS=3Dm
>  CONFIG_HPFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_ROMFS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_NFS_FS=3Dm
>  CONFIG_NFSD=3Dm
> diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/co=
nfigs/generic-64bit_defconfig
> index 19a804860ed5..ea623f910748 100644
> --- a/arch/parisc/configs/generic-64bit_defconfig
> +++ b/arch/parisc/configs/generic-64bit_defconfig
> @@ -268,7 +268,6 @@ CONFIG_PROC_KCORE=3Dy
>  CONFIG_TMPFS=3Dy
>  CONFIG_TMPFS_XATTR=3Dy
>  CONFIG_CONFIGFS_FS=3Dy
> -CONFIG_SYSV_FS=3Dy
>  CONFIG_NFS_FS=3Dm
>  CONFIG_NFS_V4=3Dm
>  CONFIG_NFS_V4_1=3Dy
> diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/con=
figs/fsl-emb-nonhw.config
> index 3009b0efaf34..d6d2a458847b 100644
> --- a/arch/powerpc/configs/fsl-emb-nonhw.config
> +++ b/arch/powerpc/configs/fsl-emb-nonhw.config
> @@ -112,7 +112,6 @@ CONFIG_QNX4FS_FS=3Dm
>  CONFIG_RCU_TRACE=3Dy
>  CONFIG_RESET_CONTROLLER=3Dy
>  CONFIG_ROOT_NFS=3Dy
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_SYSVIPC=3Dy
>  CONFIG_TMPFS=3Dy
>  CONFIG_UBIFS_FS=3Dy
> diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs=
/ppc6xx_defconfig
> index ca0c90e95837..364d1a78bc12 100644
> --- a/arch/powerpc/configs/ppc6xx_defconfig
> +++ b/arch/powerpc/configs/ppc6xx_defconfig
> @@ -986,7 +986,6 @@ CONFIG_MINIX_FS=3Dm
>  CONFIG_OMFS_FS=3Dm
>  CONFIG_QNX4FS_FS=3Dm
>  CONFIG_ROMFS_FS=3Dm
> -CONFIG_SYSV_FS=3Dm
>  CONFIG_UFS_FS=3Dm
>  CONFIG_NFS_FS=3Dm
>  CONFIG_NFS_V3_ACL=3Dy
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 64d420e3c475..afe21866d6b4 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -336,7 +336,6 @@ source "fs/qnx4/Kconfig"
>  source "fs/qnx6/Kconfig"
>  source "fs/romfs/Kconfig"
>  source "fs/pstore/Kconfig"
> -source "fs/sysv/Kconfig"
>  source "fs/ufs/Kconfig"
>  source "fs/erofs/Kconfig"
>  source "fs/vboxsf/Kconfig"
> diff --git a/fs/Makefile b/fs/Makefile
> index 15df0a923d3a..77fd7f7b5d02 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -87,7 +87,6 @@ obj-$(CONFIG_NFSD)		+=3D nfsd/
>  obj-$(CONFIG_LOCKD)		+=3D lockd/
>  obj-$(CONFIG_NLS)		+=3D nls/
>  obj-y				+=3D unicode/
> -obj-$(CONFIG_SYSV_FS)		+=3D sysv/
>  obj-$(CONFIG_SMBFS)		+=3D smb/
>  obj-$(CONFIG_HPFS_FS)		+=3D hpfs/
>  obj-$(CONFIG_NTFS3_FS)		+=3D ntfs3/
> diff --git a/fs/sysv/Kconfig b/fs/sysv/Kconfig
> deleted file mode 100644
> index 67b3f90afbfd..000000000000
> --- a/fs/sysv/Kconfig
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -config SYSV_FS
> -	tristate "System V/Xenix/V7/Coherent file system support"
> -	depends on BLOCK
> -	select BUFFER_HEAD
> -	help
> -	  SCO, Xenix and Coherent are commercial Unix systems for Intel
> -	  machines, and Version 7 was used on the DEC PDP-11. Saying Y
> -	  here would allow you to read from their floppies and hard disk
> -	  partitions.
> -
> -	  If you have floppies or hard disk partitions like that, it is likely
> -	  that they contain binaries from those other Unix systems; in order
> -	  to run these binaries, you will want to install linux-abi which is
> -	  a set of kernel modules that lets you run SCO, Xenix, Wyse,
> -	  UnixWare, Dell Unix and System V programs under Linux.  It is
> -	  available via FTP (user: ftp) from
> -	  <ftp://ftp.openlinux.org/pub/people/hch/linux-abi/>).
> -	  NOTE: that will work only for binaries from Intel-based systems;
> -	  PDP ones will have to wait until somebody ports Linux to -11 ;-)
> -
> -	  If you only intend to mount files from some other Unix over the
> -	  network using NFS, you don't need the System V file system support
> -	  (but you need NFS file system support obviously).
> -
> -	  Note that this option is generally not needed for floppies, since a
> -	  good portable way to transport files and directories between unixes
> -	  (and even other operating systems) is given by the tar program ("man
> -	  tar" or preferably "info tar").  Note also that this option has
> -	  nothing whatsoever to do with the option "System V IPC". Read about
> -	  the System V file system in
> -	  <file:Documentation/filesystems/sysv-fs.rst>.
> -	  Saying Y here will enlarge your kernel by about 27 KB.
> -
> -	  To compile this as a module, choose M here: the module will be called
> -	  sysv.
> -
> -	  If you haven't heard about all of this before, it's safe to say N.
> diff --git a/fs/sysv/Makefile b/fs/sysv/Makefile
> deleted file mode 100644
> index 17d12ba04b18..000000000000
> --- a/fs/sysv/Makefile
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Makefile for the Linux SystemV/Coherent filesystem routines.
> -#
> -
> -obj-$(CONFIG_SYSV_FS) +=3D sysv.o
> -
> -sysv-objs :=3D ialloc.o balloc.o inode.o itree.o file.o dir.o \
> -	     namei.o super.o
> diff --git a/fs/sysv/balloc.c b/fs/sysv/balloc.c
> deleted file mode 100644
> index 0e69dbdf7277..000000000000
> --- a/fs/sysv/balloc.c
> +++ /dev/null
> @@ -1,240 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/balloc.c
> - *
> - *  minix/bitmap.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  ext/freelists.c
> - *  Copyright (C) 1992  Remy Card (card@masi.ibp.fr)
> - *
> - *  xenix/alloc.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/alloc.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/balloc.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  This file contains code for allocating/freeing blocks.
> - */
> -
> -#include <linux/buffer_head.h>
> -#include <linux/string.h>
> -#include "sysv.h"
> -
> -/* We don't trust the value of
> -   sb->sv_sbd2->s_tfree =3D *sb->sv_free_blocks
> -   but we nevertheless keep it up to date. */
> -
> -static inline sysv_zone_t *get_chunk(struct super_block *sb, struct buff=
er_head *bh)
> -{
> -	char *bh_data =3D bh->b_data;
> -
> -	if (SYSV_SB(sb)->s_type =3D=3D FSTYPE_SYSV4)
> -		return (sysv_zone_t*)(bh_data+4);
> -	else
> -		return (sysv_zone_t*)(bh_data+2);
> -}
> -
> -/* NOTE NOTE NOTE: nr is a block number _as_ _stored_ _on_ _disk_ */
> -
> -void sysv_free_block(struct super_block * sb, sysv_zone_t nr)
> -{
> -	struct sysv_sb_info * sbi =3D SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	sysv_zone_t *blocks =3D sbi->s_bcache;
> -	unsigned count;
> -	unsigned block =3D fs32_to_cpu(sbi, nr);
> -
> -	/*
> -	 * This code does not work at all for AFS (it has a bitmap
> -	 * free list).  As AFS is supposed to be read-only no one
> -	 * should call this for an AFS filesystem anyway...
> -	 */
> -	if (sbi->s_type =3D=3D FSTYPE_AFS)
> -		return;
> -
> -	if (block < sbi->s_firstdatazone || block >=3D sbi->s_nzones) {
> -		printk("sysv_free_block: trying to free block not in datazone\n");
> -		return;
> -	}
> -
> -	mutex_lock(&sbi->s_lock);
> -	count =3D fs16_to_cpu(sbi, *sbi->s_bcache_count);
> -
> -	if (count > sbi->s_flc_size) {
> -		printk("sysv_free_block: flc_count > flc_size\n");
> -		mutex_unlock(&sbi->s_lock);
> -		return;
> -	}
> -	/* If the free list head in super-block is full, it is copied
> -	 * into this block being freed, ditto if it's completely empty
> -	 * (applies only on Coherent).
> -	 */
> -	if (count =3D=3D sbi->s_flc_size || count =3D=3D 0) {
> -		block +=3D sbi->s_block_base;
> -		bh =3D sb_getblk(sb, block);
> -		if (!bh) {
> -			printk("sysv_free_block: getblk() failed\n");
> -			mutex_unlock(&sbi->s_lock);
> -			return;
> -		}
> -		memset(bh->b_data, 0, sb->s_blocksize);
> -		*(__fs16*)bh->b_data =3D cpu_to_fs16(sbi, count);
> -		memcpy(get_chunk(sb,bh), blocks, count * sizeof(sysv_zone_t));
> -		mark_buffer_dirty(bh);
> -		set_buffer_uptodate(bh);
> -		brelse(bh);
> -		count =3D 0;
> -	}
> -	sbi->s_bcache[count++] =3D nr;
> -
> -	*sbi->s_bcache_count =3D cpu_to_fs16(sbi, count);
> -	fs32_add(sbi, sbi->s_free_blocks, 1);
> -	dirty_sb(sb);
> -	mutex_unlock(&sbi->s_lock);
> -}
> -
> -sysv_zone_t sysv_new_block(struct super_block * sb)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	unsigned int block;
> -	sysv_zone_t nr;
> -	struct buffer_head * bh;
> -	unsigned count;
> -
> -	mutex_lock(&sbi->s_lock);
> -	count =3D fs16_to_cpu(sbi, *sbi->s_bcache_count);
> -
> -	if (count =3D=3D 0) /* Applies only to Coherent FS */
> -		goto Enospc;
> -	nr =3D sbi->s_bcache[--count];
> -	if (nr =3D=3D 0)  /* Applies only to Xenix FS, SystemV FS */
> -		goto Enospc;
> -
> -	block =3D fs32_to_cpu(sbi, nr);
> -
> -	*sbi->s_bcache_count =3D cpu_to_fs16(sbi, count);
> -
> -	if (block < sbi->s_firstdatazone || block >=3D sbi->s_nzones) {
> -		printk("sysv_new_block: new block %d is not in data zone\n",
> -			block);
> -		goto Enospc;
> -	}
> -
> -	if (count =3D=3D 0) { /* the last block continues the free list */
> -		unsigned count;
> -
> -		block +=3D sbi->s_block_base;
> -		if (!(bh =3D sb_bread(sb, block))) {
> -			printk("sysv_new_block: cannot read free-list block\n");
> -			/* retry this same block next time */
> -			*sbi->s_bcache_count =3D cpu_to_fs16(sbi, 1);
> -			goto Enospc;
> -		}
> -		count =3D fs16_to_cpu(sbi, *(__fs16*)bh->b_data);
> -		if (count > sbi->s_flc_size) {
> -			printk("sysv_new_block: free-list block with >flc_size entries\n");
> -			brelse(bh);
> -			goto Enospc;
> -		}
> -		*sbi->s_bcache_count =3D cpu_to_fs16(sbi, count);
> -		memcpy(sbi->s_bcache, get_chunk(sb, bh),
> -				count * sizeof(sysv_zone_t));
> -		brelse(bh);
> -	}
> -	/* Now the free list head in the superblock is valid again. */
> -	fs32_add(sbi, sbi->s_free_blocks, -1);
> -	dirty_sb(sb);
> -	mutex_unlock(&sbi->s_lock);
> -	return nr;
> -
> -Enospc:
> -	mutex_unlock(&sbi->s_lock);
> -	return 0;
> -}
> -
> -unsigned long sysv_count_free_blocks(struct super_block * sb)
> -{
> -	struct sysv_sb_info * sbi =3D SYSV_SB(sb);
> -	int sb_count;
> -	int count;
> -	struct buffer_head * bh =3D NULL;
> -	sysv_zone_t *blocks;
> -	unsigned block;
> -	int n;
> -
> -	/*
> -	 * This code does not work at all for AFS (it has a bitmap
> -	 * free list).  As AFS is supposed to be read-only we just
> -	 * lie and say it has no free block at all.
> -	 */
> -	if (sbi->s_type =3D=3D FSTYPE_AFS)
> -		return 0;
> -
> -	mutex_lock(&sbi->s_lock);
> -	sb_count =3D fs32_to_cpu(sbi, *sbi->s_free_blocks);
> -
> -	if (0)
> -		goto trust_sb;
> -
> -	/* this causes a lot of disk traffic ... */
> -	count =3D 0;
> -	n =3D fs16_to_cpu(sbi, *sbi->s_bcache_count);
> -	blocks =3D sbi->s_bcache;
> -	while (1) {
> -		sysv_zone_t zone;
> -		if (n > sbi->s_flc_size)
> -			goto E2big;
> -		zone =3D 0;
> -		while (n && (zone =3D blocks[--n]) !=3D 0)
> -			count++;
> -		if (zone =3D=3D 0)
> -			break;
> -
> -		block =3D fs32_to_cpu(sbi, zone);
> -		if (bh)
> -			brelse(bh);
> -
> -		if (block < sbi->s_firstdatazone || block >=3D sbi->s_nzones)
> -			goto Einval;
> -		block +=3D sbi->s_block_base;
> -		bh =3D sb_bread(sb, block);
> -		if (!bh)
> -			goto Eio;
> -		n =3D fs16_to_cpu(sbi, *(__fs16*)bh->b_data);
> -		blocks =3D get_chunk(sb, bh);
> -	}
> -	if (bh)
> -		brelse(bh);
> -	if (count !=3D sb_count)
> -		goto Ecount;
> -done:
> -	mutex_unlock(&sbi->s_lock);
> -	return count;
> -
> -Einval:
> -	printk("sysv_count_free_blocks: new block %d is not in data zone\n",
> -		block);
> -	goto trust_sb;
> -Eio:
> -	printk("sysv_count_free_blocks: cannot read free-list block\n");
> -	goto trust_sb;
> -E2big:
> -	printk("sysv_count_free_blocks: >flc_size entries in free-list block\n"=
);
> -	if (bh)
> -		brelse(bh);
> -trust_sb:
> -	count =3D sb_count;
> -	goto done;
> -Ecount:
> -	printk("sysv_count_free_blocks: free block count was %d, "
> -		"correcting to %d\n", sb_count, count);
> -	if (!sb_rdonly(sb)) {
> -		*sbi->s_free_blocks =3D cpu_to_fs32(sbi, count);
> -		dirty_sb(sb);
> -	}
> -	goto done;
> -}
> diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
> deleted file mode 100644
> index 639307e2ff8c..000000000000
> --- a/fs/sysv/dir.c
> +++ /dev/null
> @@ -1,378 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/dir.c
> - *
> - *  minix/dir.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  coh/dir.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/dir.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  SystemV/Coherent directory handling functions
> - */
> -
> -#include <linux/pagemap.h>
> -#include <linux/highmem.h>
> -#include <linux/swap.h>
> -#include "sysv.h"
> -
> -static int sysv_readdir(struct file *, struct dir_context *);
> -
> -const struct file_operations sysv_dir_operations =3D {
> -	.llseek		=3D generic_file_llseek,
> -	.read		=3D generic_read_dir,
> -	.iterate_shared	=3D sysv_readdir,
> -	.fsync		=3D generic_file_fsync,
> -};
> -
> -static void dir_commit_chunk(struct folio *folio, loff_t pos, unsigned l=
en)
> -{
> -	struct address_space *mapping =3D folio->mapping;
> -	struct inode *dir =3D mapping->host;
> -
> -	block_write_end(NULL, mapping, pos, len, len, folio, NULL);
> -	if (pos+len > dir->i_size) {
> -		i_size_write(dir, pos+len);
> -		mark_inode_dirty(dir);
> -	}
> -	folio_unlock(folio);
> -}
> -
> -static int sysv_handle_dirsync(struct inode *dir)
> -{
> -	int err;
> -
> -	err =3D filemap_write_and_wait(dir->i_mapping);
> -	if (!err)
> -		err =3D sync_inode_metadata(dir, 1);
> -	return err;
> -}
> -
> -/*
> - * Calls to dir_get_folio()/folio_release_kmap() must be nested accordin=
g to the
> - * rules documented in mm/highmem.rst.
> - *
> - * NOTE: sysv_find_entry() and sysv_dotdot() act as calls to dir_get_fol=
io()
> - * and must be treated accordingly for nesting purposes.
> - */
> -static void *dir_get_folio(struct inode *dir, unsigned long n,
> -		struct folio **foliop)
> -{
> -	struct folio *folio =3D read_mapping_folio(dir->i_mapping, n, NULL);
> -
> -	if (IS_ERR(folio))
> -		return ERR_CAST(folio);
> -	*foliop =3D folio;
> -	return kmap_local_folio(folio, 0);
> -}
> -
> -static int sysv_readdir(struct file *file, struct dir_context *ctx)
> -{
> -	unsigned long pos =3D ctx->pos;
> -	struct inode *inode =3D file_inode(file);
> -	struct super_block *sb =3D inode->i_sb;
> -	unsigned long npages =3D dir_pages(inode);
> -	unsigned offset;
> -	unsigned long n;
> -
> -	ctx->pos =3D pos =3D (pos + SYSV_DIRSIZE-1) & ~(SYSV_DIRSIZE-1);
> -	if (pos >=3D inode->i_size)
> -		return 0;
> -
> -	offset =3D pos & ~PAGE_MASK;
> -	n =3D pos >> PAGE_SHIFT;
> -
> -	for ( ; n < npages; n++, offset =3D 0) {
> -		char *kaddr, *limit;
> -		struct sysv_dir_entry *de;
> -		struct folio *folio;
> -
> -		kaddr =3D dir_get_folio(inode, n, &folio);
> -		if (IS_ERR(kaddr))
> -			continue;
> -		de =3D (struct sysv_dir_entry *)(kaddr+offset);
> -		limit =3D kaddr + PAGE_SIZE - SYSV_DIRSIZE;
> -		for ( ;(char*)de <=3D limit; de++, ctx->pos +=3D sizeof(*de)) {
> -			char *name =3D de->name;
> -
> -			if (!de->inode)
> -				continue;
> -
> -			if (!dir_emit(ctx, name, strnlen(name,SYSV_NAMELEN),
> -					fs16_to_cpu(SYSV_SB(sb), de->inode),
> -					DT_UNKNOWN)) {
> -				folio_release_kmap(folio, kaddr);
> -				return 0;
> -			}
> -		}
> -		folio_release_kmap(folio, kaddr);
> -	}
> -	return 0;
> -}
> -
> -/* compare strings: name[0..len-1] (not zero-terminated) and
> - * buffer[0..] (filled with zeroes up to buffer[0..maxlen-1])
> - */
> -static inline int namecompare(int len, int maxlen,
> -	const char * name, const char * buffer)
> -{
> -	if (len < maxlen && buffer[len])
> -		return 0;
> -	return !memcmp(name, buffer, len);
> -}
> -
> -/*
> - *	sysv_find_entry()
> - *
> - * finds an entry in the specified directory with the wanted name.
> - * It does NOT read the inode of the
> - * entry - you'll have to do that yourself if you want to.
> - *
> - * On Success folio_release_kmap() should be called on *foliop.
> - *
> - * sysv_find_entry() acts as a call to dir_get_folio() and must be treat=
ed
> - * accordingly for nesting purposes.
> - */
> -struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct fol=
io **foliop)
> -{
> -	const char * name =3D dentry->d_name.name;
> -	int namelen =3D dentry->d_name.len;
> -	struct inode * dir =3D d_inode(dentry->d_parent);
> -	unsigned long start, n;
> -	unsigned long npages =3D dir_pages(dir);
> -	struct sysv_dir_entry *de;
> -
> -	start =3D SYSV_I(dir)->i_dir_start_lookup;
> -	if (start >=3D npages)
> -		start =3D 0;
> -	n =3D start;
> -
> -	do {
> -		char *kaddr =3D dir_get_folio(dir, n, foliop);
> -
> -		if (!IS_ERR(kaddr)) {
> -			de =3D (struct sysv_dir_entry *)kaddr;
> -			kaddr +=3D folio_size(*foliop) - SYSV_DIRSIZE;
> -			for ( ; (char *) de <=3D kaddr ; de++) {
> -				if (!de->inode)
> -					continue;
> -				if (namecompare(namelen, SYSV_NAMELEN,
> -							name, de->name))
> -					goto found;
> -			}
> -			folio_release_kmap(*foliop, kaddr);
> -		}
> -
> -		if (++n >=3D npages)
> -			n =3D 0;
> -	} while (n !=3D start);
> -
> -	return NULL;
> -
> -found:
> -	SYSV_I(dir)->i_dir_start_lookup =3D n;
> -	return de;
> -}
> -
> -int sysv_add_link(struct dentry *dentry, struct inode *inode)
> -{
> -	struct inode *dir =3D d_inode(dentry->d_parent);
> -	const char * name =3D dentry->d_name.name;
> -	int namelen =3D dentry->d_name.len;
> -	struct folio *folio =3D NULL;
> -	struct sysv_dir_entry * de;
> -	unsigned long npages =3D dir_pages(dir);
> -	unsigned long n;
> -	char *kaddr;
> -	loff_t pos;
> -	int err;
> -
> -	/* We take care of directory expansion in the same loop */
> -	for (n =3D 0; n <=3D npages; n++) {
> -		kaddr =3D dir_get_folio(dir, n, &folio);
> -		if (IS_ERR(kaddr))
> -			return PTR_ERR(kaddr);
> -		de =3D (struct sysv_dir_entry *)kaddr;
> -		kaddr +=3D PAGE_SIZE - SYSV_DIRSIZE;
> -		while ((char *)de <=3D kaddr) {
> -			if (!de->inode)
> -				goto got_it;
> -			err =3D -EEXIST;
> -			if (namecompare(namelen, SYSV_NAMELEN, name, de->name))=20
> -				goto out_folio;
> -			de++;
> -		}
> -		folio_release_kmap(folio, kaddr);
> -	}
> -	BUG();
> -	return -EINVAL;
> -
> -got_it:
> -	pos =3D folio_pos(folio) + offset_in_folio(folio, de);
> -	folio_lock(folio);
> -	err =3D sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
> -	if (err)
> -		goto out_unlock;
> -	memcpy (de->name, name, namelen);
> -	memset (de->name + namelen, 0, SYSV_DIRSIZE - namelen - 2);
> -	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
> -	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
> -	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> -	mark_inode_dirty(dir);
> -	err =3D sysv_handle_dirsync(dir);
> -out_folio:
> -	folio_release_kmap(folio, kaddr);
> -	return err;
> -out_unlock:
> -	folio_unlock(folio);
> -	goto out_folio;
> -}
> -
> -int sysv_delete_entry(struct sysv_dir_entry *de, struct folio *folio)
> -{
> -	struct inode *inode =3D folio->mapping->host;
> -	loff_t pos =3D folio_pos(folio) + offset_in_folio(folio, de);
> -	int err;
> -
> -	folio_lock(folio);
> -	err =3D sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
> -	if (err) {
> -		folio_unlock(folio);
> -		return err;
> -	}
> -	de->inode =3D 0;
> -	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> -	mark_inode_dirty(inode);
> -	return sysv_handle_dirsync(inode);
> -}
> -
> -int sysv_make_empty(struct inode *inode, struct inode *dir)
> -{
> -	struct folio *folio =3D filemap_grab_folio(inode->i_mapping, 0);
> -	struct sysv_dir_entry * de;
> -	char *kaddr;
> -	int err;
> -
> -	if (IS_ERR(folio))
> -		return PTR_ERR(folio);
> -	err =3D sysv_prepare_chunk(folio, 0, 2 * SYSV_DIRSIZE);
> -	if (err) {
> -		folio_unlock(folio);
> -		goto fail;
> -	}
> -	kaddr =3D kmap_local_folio(folio, 0);
> -	memset(kaddr, 0, folio_size(folio));
> -
> -	de =3D (struct sysv_dir_entry *)kaddr;
> -	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
> -	strcpy(de->name,".");
> -	de++;
> -	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), dir->i_ino);
> -	strcpy(de->name,"..");
> -
> -	kunmap_local(kaddr);
> -	dir_commit_chunk(folio, 0, 2 * SYSV_DIRSIZE);
> -	err =3D sysv_handle_dirsync(inode);
> -fail:
> -	folio_put(folio);
> -	return err;
> -}
> -
> -/*
> - * routine to check that the specified directory is empty (for rmdir)
> - */
> -int sysv_empty_dir(struct inode * inode)
> -{
> -	struct super_block *sb =3D inode->i_sb;
> -	struct folio *folio =3D NULL;
> -	unsigned long i, npages =3D dir_pages(inode);
> -	char *kaddr;
> -
> -	for (i =3D 0; i < npages; i++) {
> -		struct sysv_dir_entry *de;
> -
> -		kaddr =3D dir_get_folio(inode, i, &folio);
> -		if (IS_ERR(kaddr))
> -			continue;
> -
> -		de =3D (struct sysv_dir_entry *)kaddr;
> -		kaddr +=3D folio_size(folio) - SYSV_DIRSIZE;
> -
> -		for ( ;(char *)de <=3D kaddr; de++) {
> -			if (!de->inode)
> -				continue;
> -			/* check for . and .. */
> -			if (de->name[0] !=3D '.')
> -				goto not_empty;
> -			if (!de->name[1]) {
> -				if (de->inode =3D=3D cpu_to_fs16(SYSV_SB(sb),
> -							inode->i_ino))
> -					continue;
> -				goto not_empty;
> -			}
> -			if (de->name[1] !=3D '.' || de->name[2])
> -				goto not_empty;
> -		}
> -		folio_release_kmap(folio, kaddr);
> -	}
> -	return 1;
> -
> -not_empty:
> -	folio_release_kmap(folio, kaddr);
> -	return 0;
> -}
> -
> -/* Releases the page */
> -int sysv_set_link(struct sysv_dir_entry *de, struct folio *folio,
> -		struct inode *inode)
> -{
> -	struct inode *dir =3D folio->mapping->host;
> -	loff_t pos =3D folio_pos(folio) + offset_in_folio(folio, de);
> -	int err;
> -
> -	folio_lock(folio);
> -	err =3D sysv_prepare_chunk(folio, pos, SYSV_DIRSIZE);
> -	if (err) {
> -		folio_unlock(folio);
> -		return err;
> -	}
> -	de->inode =3D cpu_to_fs16(SYSV_SB(inode->i_sb), inode->i_ino);
> -	dir_commit_chunk(folio, pos, SYSV_DIRSIZE);
> -	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> -	mark_inode_dirty(dir);
> -	return sysv_handle_dirsync(inode);
> -}
> -
> -/*
> - * Calls to dir_get_folio()/folio_release_kmap() must be nested accordin=
g to the
> - * rules documented in mm/highmem.rst.
> - *
> - * sysv_dotdot() acts as a call to dir_get_folio() and must be treated
> - * accordingly for nesting purposes.
> - */
> -struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct folio **fol=
iop)
> -{
> -	struct sysv_dir_entry *de =3D dir_get_folio(dir, 0, foliop);
> -
> -	if (IS_ERR(de))
> -		return NULL;
> -	/* ".." is the second directory entry */
> -	return de + 1;
> -}
> -
> -ino_t sysv_inode_by_name(struct dentry *dentry)
> -{
> -	struct folio *folio;
> -	struct sysv_dir_entry *de =3D sysv_find_entry (dentry, &folio);
> -	ino_t res =3D 0;
> -=09
> -	if (de) {
> -		res =3D fs16_to_cpu(SYSV_SB(dentry->d_sb), de->inode);
> -		folio_release_kmap(folio, de);
> -	}
> -	return res;
> -}
> diff --git a/fs/sysv/file.c b/fs/sysv/file.c
> deleted file mode 100644
> index c645f60bdb7f..000000000000
> --- a/fs/sysv/file.c
> +++ /dev/null
> @@ -1,59 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/file.c
> - *
> - *  minix/file.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  coh/file.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/file.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  SystemV/Coherent regular file handling primitives
> - */
> -
> -#include "sysv.h"
> -
> -/*
> - * We have mostly NULLs here: the current defaults are OK for
> - * the coh filesystem.
> - */
> -const struct file_operations sysv_file_operations =3D {
> -	.llseek		=3D generic_file_llseek,
> -	.read_iter	=3D generic_file_read_iter,
> -	.write_iter	=3D generic_file_write_iter,
> -	.mmap		=3D generic_file_mmap,
> -	.fsync		=3D generic_file_fsync,
> -	.splice_read	=3D filemap_splice_read,
> -};
> -
> -static int sysv_setattr(struct mnt_idmap *idmap,
> -			struct dentry *dentry, struct iattr *attr)
> -{
> -	struct inode *inode =3D d_inode(dentry);
> -	int error;
> -
> -	error =3D setattr_prepare(&nop_mnt_idmap, dentry, attr);
> -	if (error)
> -		return error;
> -
> -	if ((attr->ia_valid & ATTR_SIZE) &&
> -	    attr->ia_size !=3D i_size_read(inode)) {
> -		error =3D inode_newsize_ok(inode, attr->ia_size);
> -		if (error)
> -			return error;
> -		truncate_setsize(inode, attr->ia_size);
> -		sysv_truncate(inode);
> -	}
> -
> -	setattr_copy(&nop_mnt_idmap, inode, attr);
> -	mark_inode_dirty(inode);
> -	return 0;
> -}
> -
> -const struct inode_operations sysv_file_inode_operations =3D {
> -	.setattr	=3D sysv_setattr,
> -	.getattr	=3D sysv_getattr,
> -};
> diff --git a/fs/sysv/ialloc.c b/fs/sysv/ialloc.c
> deleted file mode 100644
> index 269df6d49815..000000000000
> --- a/fs/sysv/ialloc.c
> +++ /dev/null
> @@ -1,235 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/ialloc.c
> - *
> - *  minix/bitmap.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  ext/freelists.c
> - *  Copyright (C) 1992  Remy Card (card@masi.ibp.fr)
> - *
> - *  xenix/alloc.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/alloc.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/ialloc.c
> - *  Copyright (C) 1993  Bruno Haible
> - *
> - *  This file contains code for allocating/freeing inodes.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/stddef.h>
> -#include <linux/sched.h>
> -#include <linux/stat.h>
> -#include <linux/string.h>
> -#include <linux/buffer_head.h>
> -#include <linux/writeback.h>
> -#include "sysv.h"
> -
> -/* We don't trust the value of
> -   sb->sv_sbd2->s_tinode =3D *sb->sv_sb_total_free_inodes
> -   but we nevertheless keep it up to date. */
> -
> -/* An inode on disk is considered free if both i_mode =3D=3D 0 and i_nli=
nk =3D=3D 0. */
> -
> -/* return &sb->sv_sb_fic_inodes[i] =3D &sbd->s_inode[i]; */
> -static inline sysv_ino_t *
> -sv_sb_fic_inode(struct super_block * sb, unsigned int i)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -
> -	if (sbi->s_bh1 =3D=3D sbi->s_bh2)
> -		return &sbi->s_sb_fic_inodes[i];
> -	else {
> -		/* 512 byte Xenix FS */
> -		unsigned int offset =3D offsetof(struct xenix_super_block, s_inode[i])=
;
> -		if (offset < 512)
> -			return (sysv_ino_t*)(sbi->s_sbd1 + offset);
> -		else
> -			return (sysv_ino_t*)(sbi->s_sbd2 + offset);
> -	}
> -}
> -
> -struct sysv_inode *
> -sysv_raw_inode(struct super_block *sb, unsigned ino, struct buffer_head =
**bh)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	struct sysv_inode *res;
> -	int block =3D sbi->s_firstinodezone + sbi->s_block_base;
> -
> -	block +=3D (ino-1) >> sbi->s_inodes_per_block_bits;
> -	*bh =3D sb_bread(sb, block);
> -	if (!*bh)
> -		return NULL;
> -	res =3D (struct sysv_inode *)(*bh)->b_data;
> -	return res + ((ino-1) & sbi->s_inodes_per_block_1);
> -}
> -
> -static int refill_free_cache(struct super_block *sb)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	int i =3D 0, ino;
> -
> -	ino =3D SYSV_ROOT_INO+1;
> -	raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode)
> -		goto out;
> -	while (ino <=3D sbi->s_ninodes) {
> -		if (raw_inode->i_mode =3D=3D 0 && raw_inode->i_nlink =3D=3D 0) {
> -			*sv_sb_fic_inode(sb,i++) =3D cpu_to_fs16(SYSV_SB(sb), ino);
> -			if (i =3D=3D sbi->s_fic_size)
> -				break;
> -		}
> -		if ((ino++ & sbi->s_inodes_per_block_1) =3D=3D 0) {
> -			brelse(bh);
> -			raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -			if (!raw_inode)
> -				goto out;
> -		} else
> -			raw_inode++;
> -	}
> -	brelse(bh);
> -out:
> -	return i;
> -}
> -
> -void sysv_free_inode(struct inode * inode)
> -{
> -	struct super_block *sb =3D inode->i_sb;
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	unsigned int ino;
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	unsigned count;
> -
> -	sb =3D inode->i_sb;
> -	ino =3D inode->i_ino;
> -	if (ino <=3D SYSV_ROOT_INO || ino > sbi->s_ninodes) {
> -		printk("sysv_free_inode: inode 0,1,2 or nonexistent inode\n");
> -		return;
> -	}
> -	raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode) {
> -		printk("sysv_free_inode: unable to read inode block on device "
> -		       "%s\n", inode->i_sb->s_id);
> -		return;
> -	}
> -	mutex_lock(&sbi->s_lock);
> -	count =3D fs16_to_cpu(sbi, *sbi->s_sb_fic_count);
> -	if (count < sbi->s_fic_size) {
> -		*sv_sb_fic_inode(sb,count++) =3D cpu_to_fs16(sbi, ino);
> -		*sbi->s_sb_fic_count =3D cpu_to_fs16(sbi, count);
> -	}
> -	fs16_add(sbi, sbi->s_sb_total_free_inodes, 1);
> -	dirty_sb(sb);
> -	memset(raw_inode, 0, sizeof(struct sysv_inode));
> -	mark_buffer_dirty(bh);
> -	mutex_unlock(&sbi->s_lock);
> -	brelse(bh);
> -}
> -
> -struct inode * sysv_new_inode(const struct inode * dir, umode_t mode)
> -{
> -	struct super_block *sb =3D dir->i_sb;
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	struct inode *inode;
> -	sysv_ino_t ino;
> -	unsigned count;
> -	struct writeback_control wbc =3D {
> -		.sync_mode =3D WB_SYNC_NONE
> -	};
> -
> -	inode =3D new_inode(sb);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> -
> -	mutex_lock(&sbi->s_lock);
> -	count =3D fs16_to_cpu(sbi, *sbi->s_sb_fic_count);
> -	if (count =3D=3D 0 || (*sv_sb_fic_inode(sb,count-1) =3D=3D 0)) {
> -		count =3D refill_free_cache(sb);
> -		if (count =3D=3D 0) {
> -			iput(inode);
> -			mutex_unlock(&sbi->s_lock);
> -			return ERR_PTR(-ENOSPC);
> -		}
> -	}
> -	/* Now count > 0. */
> -	ino =3D *sv_sb_fic_inode(sb,--count);
> -	*sbi->s_sb_fic_count =3D cpu_to_fs16(sbi, count);
> -	fs16_add(sbi, sbi->s_sb_total_free_inodes, -1);
> -	dirty_sb(sb);
> -	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> -	inode->i_ino =3D fs16_to_cpu(sbi, ino);
> -	simple_inode_init_ts(inode);
> -	inode->i_blocks =3D 0;
> -	memset(SYSV_I(inode)->i_data, 0, sizeof(SYSV_I(inode)->i_data));
> -	SYSV_I(inode)->i_dir_start_lookup =3D 0;
> -	insert_inode_hash(inode);
> -	mark_inode_dirty(inode);
> -
> -	sysv_write_inode(inode, &wbc);	/* ensure inode not allocated again */
> -	mark_inode_dirty(inode);	/* cleared by sysv_write_inode() */
> -	/* That's it. */
> -	mutex_unlock(&sbi->s_lock);
> -	return inode;
> -}
> -
> -unsigned long sysv_count_free_inodes(struct super_block * sb)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	int ino, count, sb_count;
> -
> -	mutex_lock(&sbi->s_lock);
> -
> -	sb_count =3D fs16_to_cpu(sbi, *sbi->s_sb_total_free_inodes);
> -
> -	if (0)
> -		goto trust_sb;
> -
> -	/* this causes a lot of disk traffic ... */
> -	count =3D 0;
> -	ino =3D SYSV_ROOT_INO+1;
> -	raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode)
> -		goto Eio;
> -	while (ino <=3D sbi->s_ninodes) {
> -		if (raw_inode->i_mode =3D=3D 0 && raw_inode->i_nlink =3D=3D 0)
> -			count++;
> -		if ((ino++ & sbi->s_inodes_per_block_1) =3D=3D 0) {
> -			brelse(bh);
> -			raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -			if (!raw_inode)
> -				goto Eio;
> -		} else
> -			raw_inode++;
> -	}
> -	brelse(bh);
> -	if (count !=3D sb_count)
> -		goto Einval;
> -out:
> -	mutex_unlock(&sbi->s_lock);
> -	return count;
> -
> -Einval:
> -	printk("sysv_count_free_inodes: "
> -		"free inode count was %d, correcting to %d\n",
> -		sb_count, count);
> -	if (!sb_rdonly(sb)) {
> -		*sbi->s_sb_total_free_inodes =3D cpu_to_fs16(SYSV_SB(sb), count);
> -		dirty_sb(sb);
> -	}
> -	goto out;
> -
> -Eio:
> -	printk("sysv_count_free_inodes: unable to read inode table\n");
> -trust_sb:
> -	count =3D sb_count;
> -	goto out;
> -}
> diff --git a/fs/sysv/inode.c b/fs/sysv/inode.c
> deleted file mode 100644
> index 76bc2d5e75a9..000000000000
> --- a/fs/sysv/inode.c
> +++ /dev/null
> @@ -1,354 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/inode.c
> - *
> - *  minix/inode.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  xenix/inode.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/inode.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Paul B. Monday
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Bruno Haible
> - *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
> - *
> - *  This file contains code for allocating/freeing inodes and for read/w=
riting
> - *  the superblock.
> - */
> -
> -#include <linux/highuid.h>
> -#include <linux/slab.h>
> -#include <linux/init.h>
> -#include <linux/buffer_head.h>
> -#include <linux/vfs.h>
> -#include <linux/writeback.h>
> -#include <linux/namei.h>
> -#include <asm/byteorder.h>
> -#include "sysv.h"
> -
> -static int sysv_sync_fs(struct super_block *sb, int wait)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	u32 time =3D (u32)ktime_get_real_seconds(), old_time;
> -
> -	mutex_lock(&sbi->s_lock);
> -
> -	/*
> -	 * If we are going to write out the super block,
> -	 * then attach current time stamp.
> -	 * But if the filesystem was marked clean, keep it clean.
> -	 */
> -	old_time =3D fs32_to_cpu(sbi, *sbi->s_sb_time);
> -	if (sbi->s_type =3D=3D FSTYPE_SYSV4) {
> -		if (*sbi->s_sb_state =3D=3D cpu_to_fs32(sbi, 0x7c269d38u - old_time))
> -			*sbi->s_sb_state =3D cpu_to_fs32(sbi, 0x7c269d38u - time);
> -		*sbi->s_sb_time =3D cpu_to_fs32(sbi, time);
> -		mark_buffer_dirty(sbi->s_bh2);
> -	}
> -
> -	mutex_unlock(&sbi->s_lock);
> -
> -	return 0;
> -}
> -
> -static int sysv_remount(struct super_block *sb, int *flags, char *data)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -
> -	sync_filesystem(sb);
> -	if (sbi->s_forced_ro)
> -		*flags |=3D SB_RDONLY;
> -	return 0;
> -}
> -
> -static void sysv_put_super(struct super_block *sb)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -
> -	if (!sb_rdonly(sb)) {
> -		/* XXX ext2 also updates the state here */
> -		mark_buffer_dirty(sbi->s_bh1);
> -		if (sbi->s_bh1 !=3D sbi->s_bh2)
> -			mark_buffer_dirty(sbi->s_bh2);
> -	}
> -
> -	brelse(sbi->s_bh1);
> -	if (sbi->s_bh1 !=3D sbi->s_bh2)
> -		brelse(sbi->s_bh2);
> -
> -	kfree(sbi);
> -}
> -
> -static int sysv_statfs(struct dentry *dentry, struct kstatfs *buf)
> -{
> -	struct super_block *sb =3D dentry->d_sb;
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	u64 id =3D huge_encode_dev(sb->s_bdev->bd_dev);
> -
> -	buf->f_type =3D sb->s_magic;
> -	buf->f_bsize =3D sb->s_blocksize;
> -	buf->f_blocks =3D sbi->s_ndatazones;
> -	buf->f_bavail =3D buf->f_bfree =3D sysv_count_free_blocks(sb);
> -	buf->f_files =3D sbi->s_ninodes;
> -	buf->f_ffree =3D sysv_count_free_inodes(sb);
> -	buf->f_namelen =3D SYSV_NAMELEN;
> -	buf->f_fsid =3D u64_to_fsid(id);
> -	return 0;
> -}
> -
> -/*=20
> - * NXI <-> N0XI for PDP, XIN <-> XIN0 for le32, NIX <-> 0NIX for be32
> - */
> -static inline void read3byte(struct sysv_sb_info *sbi,
> -	unsigned char * from, unsigned char * to)
> -{
> -	if (sbi->s_bytesex =3D=3D BYTESEX_PDP) {
> -		to[0] =3D from[0];
> -		to[1] =3D 0;
> -		to[2] =3D from[1];
> -		to[3] =3D from[2];
> -	} else if (sbi->s_bytesex =3D=3D BYTESEX_LE) {
> -		to[0] =3D from[0];
> -		to[1] =3D from[1];
> -		to[2] =3D from[2];
> -		to[3] =3D 0;
> -	} else {
> -		to[0] =3D 0;
> -		to[1] =3D from[0];
> -		to[2] =3D from[1];
> -		to[3] =3D from[2];
> -	}
> -}
> -
> -static inline void write3byte(struct sysv_sb_info *sbi,
> -	unsigned char * from, unsigned char * to)
> -{
> -	if (sbi->s_bytesex =3D=3D BYTESEX_PDP) {
> -		to[0] =3D from[0];
> -		to[1] =3D from[2];
> -		to[2] =3D from[3];
> -	} else if (sbi->s_bytesex =3D=3D BYTESEX_LE) {
> -		to[0] =3D from[0];
> -		to[1] =3D from[1];
> -		to[2] =3D from[2];
> -	} else {
> -		to[0] =3D from[1];
> -		to[1] =3D from[2];
> -		to[2] =3D from[3];
> -	}
> -}
> -
> -static const struct inode_operations sysv_symlink_inode_operations =3D {
> -	.get_link	=3D page_get_link,
> -	.getattr	=3D sysv_getattr,
> -};
> -
> -void sysv_set_inode(struct inode *inode, dev_t rdev)
> -{
> -	if (S_ISREG(inode->i_mode)) {
> -		inode->i_op =3D &sysv_file_inode_operations;
> -		inode->i_fop =3D &sysv_file_operations;
> -		inode->i_mapping->a_ops =3D &sysv_aops;
> -	} else if (S_ISDIR(inode->i_mode)) {
> -		inode->i_op =3D &sysv_dir_inode_operations;
> -		inode->i_fop =3D &sysv_dir_operations;
> -		inode->i_mapping->a_ops =3D &sysv_aops;
> -	} else if (S_ISLNK(inode->i_mode)) {
> -		inode->i_op =3D &sysv_symlink_inode_operations;
> -		inode_nohighmem(inode);
> -		inode->i_mapping->a_ops =3D &sysv_aops;
> -	} else
> -		init_special_inode(inode, inode->i_mode, rdev);
> -}
> -
> -struct inode *sysv_iget(struct super_block *sb, unsigned int ino)
> -{
> -	struct sysv_sb_info * sbi =3D SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	struct sysv_inode_info * si;
> -	struct inode *inode;
> -	unsigned int block;
> -
> -	if (!ino || ino > sbi->s_ninodes) {
> -		printk("Bad inode number on dev %s: %d is out of range\n",
> -		       sb->s_id, ino);
> -		return ERR_PTR(-EIO);
> -	}
> -
> -	inode =3D iget_locked(sb, ino);
> -	if (!inode)
> -		return ERR_PTR(-ENOMEM);
> -	if (!(inode->i_state & I_NEW))
> -		return inode;
> -
> -	raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode) {
> -		printk("Major problem: unable to read inode from dev %s\n",
> -		       inode->i_sb->s_id);
> -		goto bad_inode;
> -	}
> -	/* SystemV FS: kludge permissions if ino=3D=3DSYSV_ROOT_INO ?? */
> -	inode->i_mode =3D fs16_to_cpu(sbi, raw_inode->i_mode);
> -	i_uid_write(inode, (uid_t)fs16_to_cpu(sbi, raw_inode->i_uid));
> -	i_gid_write(inode, (gid_t)fs16_to_cpu(sbi, raw_inode->i_gid));
> -	set_nlink(inode, fs16_to_cpu(sbi, raw_inode->i_nlink));
> -	inode->i_size =3D fs32_to_cpu(sbi, raw_inode->i_size);
> -	inode_set_atime(inode, fs32_to_cpu(sbi, raw_inode->i_atime), 0);
> -	inode_set_mtime(inode, fs32_to_cpu(sbi, raw_inode->i_mtime), 0);
> -	inode_set_ctime(inode, fs32_to_cpu(sbi, raw_inode->i_ctime), 0);
> -	inode->i_blocks =3D 0;
> -
> -	si =3D SYSV_I(inode);
> -	for (block =3D 0; block < 10+1+1+1; block++)
> -		read3byte(sbi, &raw_inode->i_data[3*block],
> -				(u8 *)&si->i_data[block]);
> -	brelse(bh);
> -	si->i_dir_start_lookup =3D 0;
> -	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> -		sysv_set_inode(inode,
> -			       old_decode_dev(fs32_to_cpu(sbi, si->i_data[0])));
> -	else
> -		sysv_set_inode(inode, 0);
> -	unlock_new_inode(inode);
> -	return inode;
> -
> -bad_inode:
> -	iget_failed(inode);
> -	return ERR_PTR(-EIO);
> -}
> -
> -static int __sysv_write_inode(struct inode *inode, int wait)
> -{
> -	struct super_block * sb =3D inode->i_sb;
> -	struct sysv_sb_info * sbi =3D SYSV_SB(sb);
> -	struct buffer_head * bh;
> -	struct sysv_inode * raw_inode;
> -	struct sysv_inode_info * si;
> -	unsigned int ino, block;
> -	int err =3D 0;
> -
> -	ino =3D inode->i_ino;
> -	if (!ino || ino > sbi->s_ninodes) {
> -		printk("Bad inode number on dev %s: %d is out of range\n",
> -		       inode->i_sb->s_id, ino);
> -		return -EIO;
> -	}
> -	raw_inode =3D sysv_raw_inode(sb, ino, &bh);
> -	if (!raw_inode) {
> -		printk("unable to read i-node block\n");
> -		return -EIO;
> -	}
> -
> -	raw_inode->i_mode =3D cpu_to_fs16(sbi, inode->i_mode);
> -	raw_inode->i_uid =3D cpu_to_fs16(sbi, fs_high2lowuid(i_uid_read(inode))=
);
> -	raw_inode->i_gid =3D cpu_to_fs16(sbi, fs_high2lowgid(i_gid_read(inode))=
);
> -	raw_inode->i_nlink =3D cpu_to_fs16(sbi, inode->i_nlink);
> -	raw_inode->i_size =3D cpu_to_fs32(sbi, inode->i_size);
> -	raw_inode->i_atime =3D cpu_to_fs32(sbi, inode_get_atime_sec(inode));
> -	raw_inode->i_mtime =3D cpu_to_fs32(sbi, inode_get_mtime_sec(inode));
> -	raw_inode->i_ctime =3D cpu_to_fs32(sbi, inode_get_ctime_sec(inode));
> -
> -	si =3D SYSV_I(inode);
> -	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
> -		si->i_data[0] =3D cpu_to_fs32(sbi, old_encode_dev(inode->i_rdev));
> -	for (block =3D 0; block < 10+1+1+1; block++)
> -		write3byte(sbi, (u8 *)&si->i_data[block],
> -			&raw_inode->i_data[3*block]);
> -	mark_buffer_dirty(bh);
> -	if (wait) {
> -                sync_dirty_buffer(bh);
> -                if (buffer_req(bh) && !buffer_uptodate(bh)) {
> -                        printk ("IO error syncing sysv inode [%s:%08x]\n=
",
> -                                sb->s_id, ino);
> -                        err =3D -EIO;
> -                }
> -        }
> -	brelse(bh);
> -	return err;
> -}
> -
> -int sysv_write_inode(struct inode *inode, struct writeback_control *wbc)
> -{
> -	return __sysv_write_inode(inode, wbc->sync_mode =3D=3D WB_SYNC_ALL);
> -}
> -
> -int sysv_sync_inode(struct inode *inode)
> -{
> -	return __sysv_write_inode(inode, 1);
> -}
> -
> -static void sysv_evict_inode(struct inode *inode)
> -{
> -	truncate_inode_pages_final(&inode->i_data);
> -	if (!inode->i_nlink) {
> -		inode->i_size =3D 0;
> -		sysv_truncate(inode);
> -	}
> -	invalidate_inode_buffers(inode);
> -	clear_inode(inode);
> -	if (!inode->i_nlink)
> -		sysv_free_inode(inode);
> -}
> -
> -static struct kmem_cache *sysv_inode_cachep;
> -
> -static struct inode *sysv_alloc_inode(struct super_block *sb)
> -{
> -	struct sysv_inode_info *si;
> -
> -	si =3D alloc_inode_sb(sb, sysv_inode_cachep, GFP_KERNEL);
> -	if (!si)
> -		return NULL;
> -	return &si->vfs_inode;
> -}
> -
> -static void sysv_free_in_core_inode(struct inode *inode)
> -{
> -	kmem_cache_free(sysv_inode_cachep, SYSV_I(inode));
> -}
> -
> -static void init_once(void *p)
> -{
> -	struct sysv_inode_info *si =3D (struct sysv_inode_info *)p;
> -
> -	inode_init_once(&si->vfs_inode);
> -}
> -
> -const struct super_operations sysv_sops =3D {
> -	.alloc_inode	=3D sysv_alloc_inode,
> -	.free_inode	=3D sysv_free_in_core_inode,
> -	.write_inode	=3D sysv_write_inode,
> -	.evict_inode	=3D sysv_evict_inode,
> -	.put_super	=3D sysv_put_super,
> -	.sync_fs	=3D sysv_sync_fs,
> -	.remount_fs	=3D sysv_remount,
> -	.statfs		=3D sysv_statfs,
> -};
> -
> -int __init sysv_init_icache(void)
> -{
> -	sysv_inode_cachep =3D kmem_cache_create("sysv_inode_cache",
> -			sizeof(struct sysv_inode_info), 0,
> -			SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
> -			init_once);
> -	if (!sysv_inode_cachep)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -void sysv_destroy_icache(void)
> -{
> -	/*
> -	 * Make sure all delayed rcu free inodes are flushed before we
> -	 * destroy cache.
> -	 */
> -	rcu_barrier();
> -	kmem_cache_destroy(sysv_inode_cachep);
> -}
> diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
> deleted file mode 100644
> index 451e95f474fa..000000000000
> --- a/fs/sysv/itree.c
> +++ /dev/null
> @@ -1,511 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/itree.c
> - *
> - *  Handling of indirect blocks' trees.
> - *  AV, Sep--Dec 2000
> - */
> -
> -#include <linux/buffer_head.h>
> -#include <linux/mount.h>
> -#include <linux/mpage.h>
> -#include <linux/string.h>
> -#include "sysv.h"
> -
> -enum {DIRECT =3D 10, DEPTH =3D 4};	/* Have triple indirect */
> -
> -static inline void dirty_indirect(struct buffer_head *bh, struct inode *=
inode)
> -{
> -	mark_buffer_dirty_inode(bh, inode);
> -	if (IS_SYNC(inode))
> -		sync_dirty_buffer(bh);
> -}
> -
> -static int block_to_path(struct inode *inode, long block, int offsets[DE=
PTH])
> -{
> -	struct super_block *sb =3D inode->i_sb;
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	int ptrs_bits =3D sbi->s_ind_per_block_bits;
> -	unsigned long	indirect_blocks =3D sbi->s_ind_per_block,
> -			double_blocks =3D sbi->s_ind_per_block_2;
> -	int n =3D 0;
> -
> -	if (block < 0) {
> -		printk("sysv_block_map: block < 0\n");
> -	} else if (block < DIRECT) {
> -		offsets[n++] =3D block;
> -	} else if ( (block -=3D DIRECT) < indirect_blocks) {
> -		offsets[n++] =3D DIRECT;
> -		offsets[n++] =3D block;
> -	} else if ((block -=3D indirect_blocks) < double_blocks) {
> -		offsets[n++] =3D DIRECT+1;
> -		offsets[n++] =3D block >> ptrs_bits;
> -		offsets[n++] =3D block & (indirect_blocks - 1);
> -	} else if (((block -=3D double_blocks) >> (ptrs_bits * 2)) < indirect_b=
locks) {
> -		offsets[n++] =3D DIRECT+2;
> -		offsets[n++] =3D block >> (ptrs_bits * 2);
> -		offsets[n++] =3D (block >> ptrs_bits) & (indirect_blocks - 1);
> -		offsets[n++] =3D block & (indirect_blocks - 1);
> -	} else {
> -		/* nothing */;
> -	}
> -	return n;
> -}
> -
> -static inline int block_to_cpu(struct sysv_sb_info *sbi, sysv_zone_t nr)
> -{
> -	return sbi->s_block_base + fs32_to_cpu(sbi, nr);
> -}
> -
> -typedef struct {
> -	sysv_zone_t     *p;
> -	sysv_zone_t     key;
> -	struct buffer_head *bh;
> -} Indirect;
> -
> -static DEFINE_RWLOCK(pointers_lock);
> -
> -static inline void add_chain(Indirect *p, struct buffer_head *bh, sysv_z=
one_t *v)
> -{
> -	p->key =3D *(p->p =3D v);
> -	p->bh =3D bh;
> -}
> -
> -static inline int verify_chain(Indirect *from, Indirect *to)
> -{
> -	while (from <=3D to && from->key =3D=3D *from->p)
> -		from++;
> -	return (from > to);
> -}
> -
> -static inline sysv_zone_t *block_end(struct buffer_head *bh)
> -{
> -	return (sysv_zone_t*)((char*)bh->b_data + bh->b_size);
> -}
> -
> -static Indirect *get_branch(struct inode *inode,
> -			    int depth,
> -			    int offsets[],
> -			    Indirect chain[],
> -			    int *err)
> -{
> -	struct super_block *sb =3D inode->i_sb;
> -	Indirect *p =3D chain;
> -	struct buffer_head *bh;
> -
> -	*err =3D 0;
> -	add_chain(chain, NULL, SYSV_I(inode)->i_data + *offsets);
> -	if (!p->key)
> -		goto no_block;
> -	while (--depth) {
> -		int block =3D block_to_cpu(SYSV_SB(sb), p->key);
> -		bh =3D sb_bread(sb, block);
> -		if (!bh)
> -			goto failure;
> -		read_lock(&pointers_lock);
> -		if (!verify_chain(chain, p))
> -			goto changed;
> -		add_chain(++p, bh, (sysv_zone_t*)bh->b_data + *++offsets);
> -		read_unlock(&pointers_lock);
> -		if (!p->key)
> -			goto no_block;
> -	}
> -	return NULL;
> -
> -changed:
> -	read_unlock(&pointers_lock);
> -	brelse(bh);
> -	*err =3D -EAGAIN;
> -	goto no_block;
> -failure:
> -	*err =3D -EIO;
> -no_block:
> -	return p;
> -}
> -
> -static int alloc_branch(struct inode *inode,
> -			int num,
> -			int *offsets,
> -			Indirect *branch)
> -{
> -	int blocksize =3D inode->i_sb->s_blocksize;
> -	int n =3D 0;
> -	int i;
> -
> -	branch[0].key =3D sysv_new_block(inode->i_sb);
> -	if (branch[0].key) for (n =3D 1; n < num; n++) {
> -		struct buffer_head *bh;
> -		int parent;
> -		/* Allocate the next block */
> -		branch[n].key =3D sysv_new_block(inode->i_sb);
> -		if (!branch[n].key)
> -			break;
> -		/*
> -		 * Get buffer_head for parent block, zero it out and set=20
> -		 * the pointer to new one, then send parent to disk.
> -		 */
> -		parent =3D block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
> -		bh =3D sb_getblk(inode->i_sb, parent);
> -		if (!bh) {
> -			sysv_free_block(inode->i_sb, branch[n].key);
> -			break;
> -		}
> -		lock_buffer(bh);
> -		memset(bh->b_data, 0, blocksize);
> -		branch[n].bh =3D bh;
> -		branch[n].p =3D (sysv_zone_t*) bh->b_data + offsets[n];
> -		*branch[n].p =3D branch[n].key;
> -		set_buffer_uptodate(bh);
> -		unlock_buffer(bh);
> -		dirty_indirect(bh, inode);
> -	}
> -	if (n =3D=3D num)
> -		return 0;
> -
> -	/* Allocation failed, free what we already allocated */
> -	for (i =3D 1; i < n; i++)
> -		bforget(branch[i].bh);
> -	for (i =3D 0; i < n; i++)
> -		sysv_free_block(inode->i_sb, branch[i].key);
> -	return -ENOSPC;
> -}
> -
> -static inline int splice_branch(struct inode *inode,
> -				Indirect chain[],
> -				Indirect *where,
> -				int num)
> -{
> -	int i;
> -
> -	/* Verify that place we are splicing to is still there and vacant */
> -	write_lock(&pointers_lock);
> -	if (!verify_chain(chain, where-1) || *where->p)
> -		goto changed;
> -	*where->p =3D where->key;
> -	write_unlock(&pointers_lock);
> -
> -	inode_set_ctime_current(inode);
> -
> -	/* had we spliced it onto indirect block? */
> -	if (where->bh)
> -		dirty_indirect(where->bh, inode);
> -
> -	if (IS_SYNC(inode))
> -		sysv_sync_inode(inode);
> -	else
> -		mark_inode_dirty(inode);
> -	return 0;
> -
> -changed:
> -	write_unlock(&pointers_lock);
> -	for (i =3D 1; i < num; i++)
> -		bforget(where[i].bh);
> -	for (i =3D 0; i < num; i++)
> -		sysv_free_block(inode->i_sb, where[i].key);
> -	return -EAGAIN;
> -}
> -
> -static int get_block(struct inode *inode, sector_t iblock, struct buffer=
_head *bh_result, int create)
> -{
> -	int err =3D -EIO;
> -	int offsets[DEPTH];
> -	Indirect chain[DEPTH];
> -	struct super_block *sb =3D inode->i_sb;
> -	Indirect *partial;
> -	int left;
> -	int depth =3D block_to_path(inode, iblock, offsets);
> -
> -	if (depth =3D=3D 0)
> -		goto out;
> -
> -reread:
> -	partial =3D get_branch(inode, depth, offsets, chain, &err);
> -
> -	/* Simplest case - block found, no allocation needed */
> -	if (!partial) {
> -got_it:
> -		map_bh(bh_result, sb, block_to_cpu(SYSV_SB(sb),
> -					chain[depth-1].key));
> -		/* Clean up and exit */
> -		partial =3D chain+depth-1; /* the whole chain */
> -		goto cleanup;
> -	}
> -
> -	/* Next simple case - plain lookup or failed read of indirect block */
> -	if (!create || err =3D=3D -EIO) {
> -cleanup:
> -		while (partial > chain) {
> -			brelse(partial->bh);
> -			partial--;
> -		}
> -out:
> -		return err;
> -	}
> -
> -	/*
> -	 * Indirect block might be removed by truncate while we were
> -	 * reading it. Handling of that case (forget what we've got and
> -	 * reread) is taken out of the main path.
> -	 */
> -	if (err =3D=3D -EAGAIN)
> -		goto changed;
> -
> -	left =3D (chain + depth) - partial;
> -	err =3D alloc_branch(inode, left, offsets+(partial-chain), partial);
> -	if (err)
> -		goto cleanup;
> -
> -	if (splice_branch(inode, chain, partial, left) < 0)
> -		goto changed;
> -
> -	set_buffer_new(bh_result);
> -	goto got_it;
> -
> -changed:
> -	while (partial > chain) {
> -		brelse(partial->bh);
> -		partial--;
> -	}
> -	goto reread;
> -}
> -
> -static inline int all_zeroes(sysv_zone_t *p, sysv_zone_t *q)
> -{
> -	while (p < q)
> -		if (*p++)
> -			return 0;
> -	return 1;
> -}
> -
> -static Indirect *find_shared(struct inode *inode,
> -				int depth,
> -				int offsets[],
> -				Indirect chain[],
> -				sysv_zone_t *top)
> -{
> -	Indirect *partial, *p;
> -	int k, err;
> -
> -	*top =3D 0;
> -	for (k =3D depth; k > 1 && !offsets[k-1]; k--)
> -		;
> -	partial =3D get_branch(inode, k, offsets, chain, &err);
> -
> -	write_lock(&pointers_lock);
> -	if (!partial)
> -		partial =3D chain + k-1;
> -	/*
> -	 * If the branch acquired continuation since we've looked at it -
> -	 * fine, it should all survive and (new) top doesn't belong to us.
> -	 */
> -	if (!partial->key && *partial->p) {
> -		write_unlock(&pointers_lock);
> -		goto no_top;
> -	}
> -	for (p=3Dpartial; p>chain && all_zeroes((sysv_zone_t*)p->bh->b_data,p->=
p); p--)
> -		;
> -	/*
> -	 * OK, we've found the last block that must survive. The rest of our
> -	 * branch should be detached before unlocking. However, if that rest
> -	 * of branch is all ours and does not grow immediately from the inode
> -	 * it's easier to cheat and just decrement partial->p.
> -	 */
> -	if (p =3D=3D chain + k - 1 && p > chain) {
> -		p->p--;
> -	} else {
> -		*top =3D *p->p;
> -		*p->p =3D 0;
> -	}
> -	write_unlock(&pointers_lock);
> -
> -	while (partial > p) {
> -		brelse(partial->bh);
> -		partial--;
> -	}
> -no_top:
> -	return partial;
> -}
> -
> -static inline void free_data(struct inode *inode, sysv_zone_t *p, sysv_z=
one_t *q)
> -{
> -	for ( ; p < q ; p++) {
> -		sysv_zone_t nr =3D *p;
> -		if (nr) {
> -			*p =3D 0;
> -			sysv_free_block(inode->i_sb, nr);
> -			mark_inode_dirty(inode);
> -		}
> -	}
> -}
> -
> -static void free_branches(struct inode *inode, sysv_zone_t *p, sysv_zone=
_t *q, int depth)
> -{
> -	struct buffer_head * bh;
> -	struct super_block *sb =3D inode->i_sb;
> -
> -	if (depth--) {
> -		for ( ; p < q ; p++) {
> -			int block;
> -			sysv_zone_t nr =3D *p;
> -			if (!nr)
> -				continue;
> -			*p =3D 0;
> -			block =3D block_to_cpu(SYSV_SB(sb), nr);
> -			bh =3D sb_bread(sb, block);
> -			if (!bh)
> -				continue;
> -			free_branches(inode, (sysv_zone_t*)bh->b_data,
> -					block_end(bh), depth);
> -			bforget(bh);
> -			sysv_free_block(sb, nr);
> -			mark_inode_dirty(inode);
> -		}
> -	} else
> -		free_data(inode, p, q);
> -}
> -
> -void sysv_truncate (struct inode * inode)
> -{
> -	sysv_zone_t *i_data =3D SYSV_I(inode)->i_data;
> -	int offsets[DEPTH];
> -	Indirect chain[DEPTH];
> -	Indirect *partial;
> -	sysv_zone_t nr =3D 0;
> -	int n;
> -	long iblock;
> -	unsigned blocksize;
> -
> -	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
> -	    S_ISLNK(inode->i_mode)))
> -		return;
> -
> -	blocksize =3D inode->i_sb->s_blocksize;
> -	iblock =3D (inode->i_size + blocksize-1)
> -					>> inode->i_sb->s_blocksize_bits;
> -
> -	block_truncate_page(inode->i_mapping, inode->i_size, get_block);
> -
> -	n =3D block_to_path(inode, iblock, offsets);
> -	if (n =3D=3D 0)
> -		return;
> -
> -	if (n =3D=3D 1) {
> -		free_data(inode, i_data+offsets[0], i_data + DIRECT);
> -		goto do_indirects;
> -	}
> -
> -	partial =3D find_shared(inode, n, offsets, chain, &nr);
> -	/* Kill the top of shared branch (already detached) */
> -	if (nr) {
> -		if (partial =3D=3D chain)
> -			mark_inode_dirty(inode);
> -		else
> -			dirty_indirect(partial->bh, inode);
> -		free_branches(inode, &nr, &nr+1, (chain+n-1) - partial);
> -	}
> -	/* Clear the ends of indirect blocks on the shared branch */
> -	while (partial > chain) {
> -		free_branches(inode, partial->p + 1, block_end(partial->bh),
> -				(chain+n-1) - partial);
> -		dirty_indirect(partial->bh, inode);
> -		brelse (partial->bh);
> -		partial--;
> -	}
> -do_indirects:
> -	/* Kill the remaining (whole) subtrees (=3D=3D subtrees deeper than...)=
 */
> -	while (n < DEPTH) {
> -		nr =3D i_data[DIRECT + n - 1];
> -		if (nr) {
> -			i_data[DIRECT + n - 1] =3D 0;
> -			mark_inode_dirty(inode);
> -			free_branches(inode, &nr, &nr+1, n);
> -		}
> -		n++;
> -	}
> -	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
> -	if (IS_SYNC(inode))
> -		sysv_sync_inode (inode);
> -	else
> -		mark_inode_dirty(inode);
> -}
> -
> -static unsigned sysv_nblocks(struct super_block *s, loff_t size)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(s);
> -	int ptrs_bits =3D sbi->s_ind_per_block_bits;
> -	unsigned blocks, res, direct =3D DIRECT, i =3D DEPTH;
> -	blocks =3D (size + s->s_blocksize - 1) >> s->s_blocksize_bits;
> -	res =3D blocks;
> -	while (--i && blocks > direct) {
> -		blocks =3D ((blocks - direct - 1) >> ptrs_bits) + 1;
> -		res +=3D blocks;
> -		direct =3D 1;
> -	}
> -	return res;
> -}
> -
> -int sysv_getattr(struct mnt_idmap *idmap, const struct path *path,
> -		 struct kstat *stat, u32 request_mask, unsigned int flags)
> -{
> -	struct super_block *s =3D path->dentry->d_sb;
> -	generic_fillattr(&nop_mnt_idmap, request_mask, d_inode(path->dentry),
> -			 stat);
> -	stat->blocks =3D (s->s_blocksize / 512) * sysv_nblocks(s, stat->size);
> -	stat->blksize =3D s->s_blocksize;
> -	return 0;
> -}
> -
> -static int sysv_writepages(struct address_space *mapping,
> -		struct writeback_control *wbc)
> -{
> -	return mpage_writepages(mapping, wbc, get_block);
> -}
> -
> -static int sysv_read_folio(struct file *file, struct folio *folio)
> -{
> -	return block_read_full_folio(folio, get_block);
> -}
> -
> -int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len)
> -{
> -	return __block_write_begin(folio, pos, len, get_block);
> -}
> -
> -static void sysv_write_failed(struct address_space *mapping, loff_t to)
> -{
> -	struct inode *inode =3D mapping->host;
> -
> -	if (to > inode->i_size) {
> -		truncate_pagecache(inode, inode->i_size);
> -		sysv_truncate(inode);
> -	}
> -}
> -
> -static int sysv_write_begin(struct file *file, struct address_space *map=
ping,
> -			loff_t pos, unsigned len,
> -			struct folio **foliop, void **fsdata)
> -{
> -	int ret;
> -
> -	ret =3D block_write_begin(mapping, pos, len, foliop, get_block);
> -	if (unlikely(ret))
> -		sysv_write_failed(mapping, pos + len);
> -
> -	return ret;
> -}
> -
> -static sector_t sysv_bmap(struct address_space *mapping, sector_t block)
> -{
> -	return generic_block_bmap(mapping,block,get_block);
> -}
> -
> -const struct address_space_operations sysv_aops =3D {
> -	.dirty_folio =3D block_dirty_folio,
> -	.invalidate_folio =3D block_invalidate_folio,
> -	.read_folio =3D sysv_read_folio,
> -	.writepages =3D sysv_writepages,
> -	.write_begin =3D sysv_write_begin,
> -	.write_end =3D generic_write_end,
> -	.migrate_folio =3D buffer_migrate_folio,
> -	.bmap =3D sysv_bmap
> -};
> diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
> deleted file mode 100644
> index fb8bd8437872..000000000000
> --- a/fs/sysv/namei.c
> +++ /dev/null
> @@ -1,280 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - *  linux/fs/sysv/namei.c
> - *
> - *  minix/namei.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  coh/namei.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/namei.c
> - *  Copyright (C) 1993  Bruno Haible
> - *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
> - */
> -
> -#include <linux/pagemap.h>
> -#include "sysv.h"
> -
> -static int add_nondir(struct dentry *dentry, struct inode *inode)
> -{
> -	int err =3D sysv_add_link(dentry, inode);
> -	if (!err) {
> -		d_instantiate(dentry, inode);
> -		return 0;
> -	}
> -	inode_dec_link_count(inode);
> -	iput(inode);
> -	return err;
> -}
> -
> -static struct dentry *sysv_lookup(struct inode * dir, struct dentry * de=
ntry, unsigned int flags)
> -{
> -	struct inode * inode =3D NULL;
> -	ino_t ino;
> -
> -	if (dentry->d_name.len > SYSV_NAMELEN)
> -		return ERR_PTR(-ENAMETOOLONG);
> -	ino =3D sysv_inode_by_name(dentry);
> -	if (ino)
> -		inode =3D sysv_iget(dir->i_sb, ino);
> -	return d_splice_alias(inode, dentry);
> -}
> -
> -static int sysv_mknod(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode, dev_t rdev)
> -{
> -	struct inode * inode;
> -	int err;
> -
> -	if (!old_valid_dev(rdev))
> -		return -EINVAL;
> -
> -	inode =3D sysv_new_inode(dir, mode);
> -	err =3D PTR_ERR(inode);
> -
> -	if (!IS_ERR(inode)) {
> -		sysv_set_inode(inode, rdev);
> -		mark_inode_dirty(inode);
> -		err =3D add_nondir(dentry, inode);
> -	}
> -	return err;
> -}
> -
> -static int sysv_create(struct mnt_idmap *idmap, struct inode *dir,
> -		       struct dentry *dentry, umode_t mode, bool excl)
> -{
> -	return sysv_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
> -}
> -
> -static int sysv_symlink(struct mnt_idmap *idmap, struct inode *dir,
> -			struct dentry *dentry, const char *symname)
> -{
> -	int err =3D -ENAMETOOLONG;
> -	int l =3D strlen(symname)+1;
> -	struct inode * inode;
> -
> -	if (l > dir->i_sb->s_blocksize)
> -		goto out;
> -
> -	inode =3D sysv_new_inode(dir, S_IFLNK|0777);
> -	err =3D PTR_ERR(inode);
> -	if (IS_ERR(inode))
> -		goto out;
> -=09
> -	sysv_set_inode(inode, 0);
> -	err =3D page_symlink(inode, symname, l);
> -	if (err)
> -		goto out_fail;
> -
> -	mark_inode_dirty(inode);
> -	err =3D add_nondir(dentry, inode);
> -out:
> -	return err;
> -
> -out_fail:
> -	inode_dec_link_count(inode);
> -	iput(inode);
> -	goto out;
> -}
> -
> -static int sysv_link(struct dentry * old_dentry, struct inode * dir,=20
> -	struct dentry * dentry)
> -{
> -	struct inode *inode =3D d_inode(old_dentry);
> -
> -	inode_set_ctime_current(inode);
> -	inode_inc_link_count(inode);
> -	ihold(inode);
> -
> -	return add_nondir(dentry, inode);
> -}
> -
> -static int sysv_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> -		      struct dentry *dentry, umode_t mode)
> -{
> -	struct inode * inode;
> -	int err;
> -
> -	inode_inc_link_count(dir);
> -
> -	inode =3D sysv_new_inode(dir, S_IFDIR|mode);
> -	err =3D PTR_ERR(inode);
> -	if (IS_ERR(inode))
> -		goto out_dir;
> -
> -	sysv_set_inode(inode, 0);
> -
> -	inode_inc_link_count(inode);
> -
> -	err =3D sysv_make_empty(inode, dir);
> -	if (err)
> -		goto out_fail;
> -
> -	err =3D sysv_add_link(dentry, inode);
> -	if (err)
> -		goto out_fail;
> -
> -        d_instantiate(dentry, inode);
> -out:
> -	return err;
> -
> -out_fail:
> -	inode_dec_link_count(inode);
> -	inode_dec_link_count(inode);
> -	iput(inode);
> -out_dir:
> -	inode_dec_link_count(dir);
> -	goto out;
> -}
> -
> -static int sysv_unlink(struct inode * dir, struct dentry * dentry)
> -{
> -	struct inode * inode =3D d_inode(dentry);
> -	struct folio *folio;
> -	struct sysv_dir_entry * de;
> -	int err;
> -
> -	de =3D sysv_find_entry(dentry, &folio);
> -	if (!de)
> -		return -ENOENT;
> -
> -	err =3D sysv_delete_entry(de, folio);
> -	if (!err) {
> -		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
> -		inode_dec_link_count(inode);
> -	}
> -	folio_release_kmap(folio, de);
> -	return err;
> -}
> -
> -static int sysv_rmdir(struct inode * dir, struct dentry * dentry)
> -{
> -	struct inode *inode =3D d_inode(dentry);
> -	int err =3D -ENOTEMPTY;
> -
> -	if (sysv_empty_dir(inode)) {
> -		err =3D sysv_unlink(dir, dentry);
> -		if (!err) {
> -			inode->i_size =3D 0;
> -			inode_dec_link_count(inode);
> -			inode_dec_link_count(dir);
> -		}
> -	}
> -	return err;
> -}
> -
> -/*
> - * Anybody can rename anything with this: the permission checks are left=
 to the
> - * higher-level routines.
> - */
> -static int sysv_rename(struct mnt_idmap *idmap, struct inode *old_dir,
> -		       struct dentry *old_dentry, struct inode *new_dir,
> -		       struct dentry *new_dentry, unsigned int flags)
> -{
> -	struct inode * old_inode =3D d_inode(old_dentry);
> -	struct inode * new_inode =3D d_inode(new_dentry);
> -	struct folio *dir_folio;
> -	struct sysv_dir_entry * dir_de =3D NULL;
> -	struct folio *old_folio;
> -	struct sysv_dir_entry * old_de;
> -	int err =3D -ENOENT;
> -
> -	if (flags & ~RENAME_NOREPLACE)
> -		return -EINVAL;
> -
> -	old_de =3D sysv_find_entry(old_dentry, &old_folio);
> -	if (!old_de)
> -		goto out;
> -
> -	if (S_ISDIR(old_inode->i_mode)) {
> -		err =3D -EIO;
> -		dir_de =3D sysv_dotdot(old_inode, &dir_folio);
> -		if (!dir_de)
> -			goto out_old;
> -	}
> -
> -	if (new_inode) {
> -		struct folio *new_folio;
> -		struct sysv_dir_entry * new_de;
> -
> -		err =3D -ENOTEMPTY;
> -		if (dir_de && !sysv_empty_dir(new_inode))
> -			goto out_dir;
> -
> -		err =3D -ENOENT;
> -		new_de =3D sysv_find_entry(new_dentry, &new_folio);
> -		if (!new_de)
> -			goto out_dir;
> -		err =3D sysv_set_link(new_de, new_folio, old_inode);
> -		folio_release_kmap(new_folio, new_de);
> -		if (err)
> -			goto out_dir;
> -		inode_set_ctime_current(new_inode);
> -		if (dir_de)
> -			drop_nlink(new_inode);
> -		inode_dec_link_count(new_inode);
> -	} else {
> -		err =3D sysv_add_link(new_dentry, old_inode);
> -		if (err)
> -			goto out_dir;
> -		if (dir_de)
> -			inode_inc_link_count(new_dir);
> -	}
> -
> -	err =3D sysv_delete_entry(old_de, old_folio);
> -	if (err)
> -		goto out_dir;
> -
> -	mark_inode_dirty(old_inode);
> -
> -	if (dir_de) {
> -		err =3D sysv_set_link(dir_de, dir_folio, new_dir);
> -		if (!err)
> -			inode_dec_link_count(old_dir);
> -	}
> -
> -out_dir:
> -	if (dir_de)
> -		folio_release_kmap(dir_folio, dir_de);
> -out_old:
> -	folio_release_kmap(old_folio, old_de);
> -out:
> -	return err;
> -}
> -
> -/*
> - * directories can handle most operations...
> - */
> -const struct inode_operations sysv_dir_inode_operations =3D {
> -	.create		=3D sysv_create,
> -	.lookup		=3D sysv_lookup,
> -	.link		=3D sysv_link,
> -	.unlink		=3D sysv_unlink,
> -	.symlink	=3D sysv_symlink,
> -	.mkdir		=3D sysv_mkdir,
> -	.rmdir		=3D sysv_rmdir,
> -	.mknod		=3D sysv_mknod,
> -	.rename		=3D sysv_rename,
> -	.getattr	=3D sysv_getattr,
> -};
> diff --git a/fs/sysv/super.c b/fs/sysv/super.c
> deleted file mode 100644
> index 03be9f1b7802..000000000000
> --- a/fs/sysv/super.c
> +++ /dev/null
> @@ -1,616 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - *  linux/fs/sysv/inode.c
> - *
> - *  minix/inode.c
> - *  Copyright (C) 1991, 1992  Linus Torvalds
> - *
> - *  xenix/inode.c
> - *  Copyright (C) 1992  Doug Evans
> - *
> - *  coh/inode.c
> - *  Copyright (C) 1993  Pascal Haible, Bruno Haible
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Paul B. Monday
> - *
> - *  sysv/inode.c
> - *  Copyright (C) 1993  Bruno Haible
> - *  Copyright (C) 1997, 1998  Krzysztof G. Baranowski
> - *
> - *  This file contains code for read/parsing the superblock.
> - */
> -
> -#include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/slab.h>
> -#include <linux/buffer_head.h>
> -#include <linux/fs_context.h>
> -#include "sysv.h"
> -
> -/*
> - * The following functions try to recognize specific filesystems.
> - *
> - * We recognize:
> - * - Xenix FS by its magic number.
> - * - SystemV FS by its magic number.
> - * - Coherent FS by its funny fname/fpack field.
> - * - SCO AFS by s_nfree =3D=3D 0xffff
> - * - V7 FS has no distinguishing features.
> - *
> - * We discriminate among SystemV4 and SystemV2 FS by the assumption that
> - * the time stamp is not < 01-01-1980.
> - */
> -
> -enum {
> -	JAN_1_1980 =3D (10*365 + 2) * 24 * 60 * 60
> -};
> -
> -static void detected_xenix(struct sysv_sb_info *sbi, unsigned *max_links=
)
> -{
> -	struct buffer_head *bh1 =3D sbi->s_bh1;
> -	struct buffer_head *bh2 =3D sbi->s_bh2;
> -	struct xenix_super_block * sbd1;
> -	struct xenix_super_block * sbd2;
> -
> -	if (bh1 !=3D bh2)
> -		sbd1 =3D sbd2 =3D (struct xenix_super_block *) bh1->b_data;
> -	else {
> -		/* block size =3D 512, so bh1 !=3D bh2 */
> -		sbd1 =3D (struct xenix_super_block *) bh1->b_data;
> -		sbd2 =3D (struct xenix_super_block *) (bh2->b_data - 512);
> -	}
> -
> -	*max_links =3D XENIX_LINK_MAX;
> -	sbi->s_fic_size =3D XENIX_NICINOD;
> -	sbi->s_flc_size =3D XENIX_NICFREE;
> -	sbi->s_sbd1 =3D (char *)sbd1;
> -	sbi->s_sbd2 =3D (char *)sbd2;
> -	sbi->s_sb_fic_count =3D &sbd1->s_ninode;
> -	sbi->s_sb_fic_inodes =3D &sbd1->s_inode[0];
> -	sbi->s_sb_total_free_inodes =3D &sbd2->s_tinode;
> -	sbi->s_bcache_count =3D &sbd1->s_nfree;
> -	sbi->s_bcache =3D &sbd1->s_free[0];
> -	sbi->s_free_blocks =3D &sbd2->s_tfree;
> -	sbi->s_sb_time =3D &sbd2->s_time;
> -	sbi->s_firstdatazone =3D fs16_to_cpu(sbi, sbd1->s_isize);
> -	sbi->s_nzones =3D fs32_to_cpu(sbi, sbd1->s_fsize);
> -}
> -
> -static void detected_sysv4(struct sysv_sb_info *sbi, unsigned *max_links=
)
> -{
> -	struct sysv4_super_block * sbd;
> -	struct buffer_head *bh1 =3D sbi->s_bh1;
> -	struct buffer_head *bh2 =3D sbi->s_bh2;
> -
> -	if (bh1 =3D=3D bh2)
> -		sbd =3D (struct sysv4_super_block *) (bh1->b_data + BLOCK_SIZE/2);
> -	else
> -		sbd =3D (struct sysv4_super_block *) bh2->b_data;
> -
> -	*max_links =3D SYSV_LINK_MAX;
> -	sbi->s_fic_size =3D SYSV_NICINOD;
> -	sbi->s_flc_size =3D SYSV_NICFREE;
> -	sbi->s_sbd1 =3D (char *)sbd;
> -	sbi->s_sbd2 =3D (char *)sbd;
> -	sbi->s_sb_fic_count =3D &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes =3D &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes =3D &sbd->s_tinode;
> -	sbi->s_bcache_count =3D &sbd->s_nfree;
> -	sbi->s_bcache =3D &sbd->s_free[0];
> -	sbi->s_free_blocks =3D &sbd->s_tfree;
> -	sbi->s_sb_time =3D &sbd->s_time;
> -	sbi->s_sb_state =3D &sbd->s_state;
> -	sbi->s_firstdatazone =3D fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones =3D fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static void detected_sysv2(struct sysv_sb_info *sbi, unsigned *max_links=
)
> -{
> -	struct sysv2_super_block *sbd;
> -	struct buffer_head *bh1 =3D sbi->s_bh1;
> -	struct buffer_head *bh2 =3D sbi->s_bh2;
> -
> -	if (bh1 =3D=3D bh2)
> -		sbd =3D (struct sysv2_super_block *) (bh1->b_data + BLOCK_SIZE/2);
> -	else
> -		sbd =3D (struct sysv2_super_block *) bh2->b_data;
> -
> -	*max_links =3D SYSV_LINK_MAX;
> -	sbi->s_fic_size =3D SYSV_NICINOD;
> -	sbi->s_flc_size =3D SYSV_NICFREE;
> -	sbi->s_sbd1 =3D (char *)sbd;
> -	sbi->s_sbd2 =3D (char *)sbd;
> -	sbi->s_sb_fic_count =3D &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes =3D &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes =3D &sbd->s_tinode;
> -	sbi->s_bcache_count =3D &sbd->s_nfree;
> -	sbi->s_bcache =3D &sbd->s_free[0];
> -	sbi->s_free_blocks =3D &sbd->s_tfree;
> -	sbi->s_sb_time =3D &sbd->s_time;
> -	sbi->s_sb_state =3D &sbd->s_state;
> -	sbi->s_firstdatazone =3D fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones =3D fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static void detected_coherent(struct sysv_sb_info *sbi, unsigned *max_li=
nks)
> -{
> -	struct coh_super_block * sbd;
> -	struct buffer_head *bh1 =3D sbi->s_bh1;
> -
> -	sbd =3D (struct coh_super_block *) bh1->b_data;
> -
> -	*max_links =3D COH_LINK_MAX;
> -	sbi->s_fic_size =3D COH_NICINOD;
> -	sbi->s_flc_size =3D COH_NICFREE;
> -	sbi->s_sbd1 =3D (char *)sbd;
> -	sbi->s_sbd2 =3D (char *)sbd;
> -	sbi->s_sb_fic_count =3D &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes =3D &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes =3D &sbd->s_tinode;
> -	sbi->s_bcache_count =3D &sbd->s_nfree;
> -	sbi->s_bcache =3D &sbd->s_free[0];
> -	sbi->s_free_blocks =3D &sbd->s_tfree;
> -	sbi->s_sb_time =3D &sbd->s_time;
> -	sbi->s_firstdatazone =3D fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones =3D fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static void detected_v7(struct sysv_sb_info *sbi, unsigned *max_links)
> -{
> -	struct buffer_head *bh2 =3D sbi->s_bh2;
> -	struct v7_super_block *sbd =3D (struct v7_super_block *)bh2->b_data;
> -
> -	*max_links =3D V7_LINK_MAX;
> -	sbi->s_fic_size =3D V7_NICINOD;
> -	sbi->s_flc_size =3D V7_NICFREE;
> -	sbi->s_sbd1 =3D (char *)sbd;
> -	sbi->s_sbd2 =3D (char *)sbd;
> -	sbi->s_sb_fic_count =3D &sbd->s_ninode;
> -	sbi->s_sb_fic_inodes =3D &sbd->s_inode[0];
> -	sbi->s_sb_total_free_inodes =3D &sbd->s_tinode;
> -	sbi->s_bcache_count =3D &sbd->s_nfree;
> -	sbi->s_bcache =3D &sbd->s_free[0];
> -	sbi->s_free_blocks =3D &sbd->s_tfree;
> -	sbi->s_sb_time =3D &sbd->s_time;
> -	sbi->s_firstdatazone =3D fs16_to_cpu(sbi, sbd->s_isize);
> -	sbi->s_nzones =3D fs32_to_cpu(sbi, sbd->s_fsize);
> -}
> -
> -static int detect_xenix(struct sysv_sb_info *sbi, struct buffer_head *bh=
)
> -{
> -	struct xenix_super_block *sbd =3D (struct xenix_super_block *)bh->b_dat=
a;
> -	if (*(__le32 *)&sbd->s_magic =3D=3D cpu_to_le32(0x2b5544))
> -		sbi->s_bytesex =3D BYTESEX_LE;
> -	else if (*(__be32 *)&sbd->s_magic =3D=3D cpu_to_be32(0x2b5544))
> -		sbi->s_bytesex =3D BYTESEX_BE;
> -	else
> -		return 0;
> -	switch (fs32_to_cpu(sbi, sbd->s_type)) {
> -	case 1:
> -		sbi->s_type =3D FSTYPE_XENIX;
> -		return 1;
> -	case 2:
> -		sbi->s_type =3D FSTYPE_XENIX;
> -		return 2;
> -	default:
> -		return 0;
> -	}
> -}
> -
> -static int detect_sysv(struct sysv_sb_info *sbi, struct buffer_head *bh)
> -{
> -	struct super_block *sb =3D sbi->s_sb;
> -	/* All relevant fields are at the same offsets in R2 and R4 */
> -	struct sysv4_super_block * sbd;
> -	u32 type;
> -
> -	sbd =3D (struct sysv4_super_block *) (bh->b_data + BLOCK_SIZE/2);
> -	if (*(__le32 *)&sbd->s_magic =3D=3D cpu_to_le32(0xfd187e20))
> -		sbi->s_bytesex =3D BYTESEX_LE;
> -	else if (*(__be32 *)&sbd->s_magic =3D=3D cpu_to_be32(0xfd187e20))
> -		sbi->s_bytesex =3D BYTESEX_BE;
> -	else
> -		return 0;
> -
> -	type =3D fs32_to_cpu(sbi, sbd->s_type);
> -=20
> - 	if (fs16_to_cpu(sbi, sbd->s_nfree) =3D=3D 0xffff) {
> - 		sbi->s_type =3D FSTYPE_AFS;
> -		sbi->s_forced_ro =3D 1;
> - 		if (!sb_rdonly(sb)) {
> - 			printk("SysV FS: SCO EAFS on %s detected, "=20
> - 				"forcing read-only mode.\n",=20
> - 				sb->s_id);
> - 		}
> - 		return type;
> - 	}
> -=20
> -	if (fs32_to_cpu(sbi, sbd->s_time) < JAN_1_1980) {
> -		/* this is likely to happen on SystemV2 FS */
> -		if (type > 3 || type < 1)
> -			return 0;
> -		sbi->s_type =3D FSTYPE_SYSV2;
> -		return type;
> -	}
> -	if ((type > 3 || type < 1) && (type > 0x30 || type < 0x10))
> -		return 0;
> -
> -	/* On Interactive Unix (ISC) Version 4.0/3.x s_type field =3D 0x10,
> -	   0x20 or 0x30 indicates that symbolic links and the 14-character
> -	   filename limit is gone. Due to lack of information about this
> -           feature read-only mode seems to be a reasonable approach... -=
KGB */
> -
> -	if (type >=3D 0x10) {
> -		printk("SysV FS: can't handle long file names on %s, "
> -		       "forcing read-only mode.\n", sb->s_id);
> -		sbi->s_forced_ro =3D 1;
> -	}
> -
> -	sbi->s_type =3D FSTYPE_SYSV4;
> -	return type >=3D 0x10 ? type >> 4 : type;
> -}
> -
> -static int detect_coherent(struct sysv_sb_info *sbi, struct buffer_head =
*bh)
> -{
> -	struct coh_super_block * sbd;
> -
> -	sbd =3D (struct coh_super_block *) (bh->b_data + BLOCK_SIZE/2);
> -	if ((memcmp(sbd->s_fname,"noname",6) && memcmp(sbd->s_fname,"xxxxx ",6)=
)
> -	    || (memcmp(sbd->s_fpack,"nopack",6) && memcmp(sbd->s_fpack,"xxxxx\n=
",6)))
> -		return 0;
> -	sbi->s_bytesex =3D BYTESEX_PDP;
> -	sbi->s_type =3D FSTYPE_COH;
> -	return 1;
> -}
> -
> -static int detect_sysv_odd(struct sysv_sb_info *sbi, struct buffer_head =
*bh)
> -{
> -	int size =3D detect_sysv(sbi, bh);
> -
> -	return size>2 ? 0 : size;
> -}
> -
> -static struct {
> -	int block;
> -	int (*test)(struct sysv_sb_info *, struct buffer_head *);
> -} flavours[] =3D {
> -	{1, detect_xenix},
> -	{0, detect_sysv},
> -	{0, detect_coherent},
> -	{9, detect_sysv_odd},
> -	{15,detect_sysv_odd},
> -	{18,detect_sysv},
> -};
> -
> -static char *flavour_names[] =3D {
> -	[FSTYPE_XENIX]	=3D "Xenix",
> -	[FSTYPE_SYSV4]	=3D "SystemV",
> -	[FSTYPE_SYSV2]	=3D "SystemV Release 2",
> -	[FSTYPE_COH]	=3D "Coherent",
> -	[FSTYPE_V7]	=3D "V7",
> -	[FSTYPE_AFS]	=3D "AFS",
> -};
> -
> -static void (*flavour_setup[])(struct sysv_sb_info *, unsigned *) =3D {
> -	[FSTYPE_XENIX]	=3D detected_xenix,
> -	[FSTYPE_SYSV4]	=3D detected_sysv4,
> -	[FSTYPE_SYSV2]	=3D detected_sysv2,
> -	[FSTYPE_COH]	=3D detected_coherent,
> -	[FSTYPE_V7]	=3D detected_v7,
> -	[FSTYPE_AFS]	=3D detected_sysv4,
> -};
> -
> -static int complete_read_super(struct super_block *sb, int silent, int s=
ize)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -	struct inode *root_inode;
> -	char *found =3D flavour_names[sbi->s_type];
> -	u_char n_bits =3D size+8;
> -	int bsize =3D 1 << n_bits;
> -	int bsize_4 =3D bsize >> 2;
> -
> -	sbi->s_firstinodezone =3D 2;
> -
> -	flavour_setup[sbi->s_type](sbi, &sb->s_max_links);
> -	if (sbi->s_firstdatazone < sbi->s_firstinodezone)
> -		return 0;
> -
> -	sbi->s_ndatazones =3D sbi->s_nzones - sbi->s_firstdatazone;
> -	sbi->s_inodes_per_block =3D bsize >> 6;
> -	sbi->s_inodes_per_block_1 =3D (bsize >> 6)-1;
> -	sbi->s_inodes_per_block_bits =3D n_bits-6;
> -	sbi->s_ind_per_block =3D bsize_4;
> -	sbi->s_ind_per_block_2 =3D bsize_4*bsize_4;
> -	sbi->s_toobig_block =3D 10 + bsize_4 * (1 + bsize_4 * (1 + bsize_4));
> -	sbi->s_ind_per_block_bits =3D n_bits-2;
> -
> -	sbi->s_ninodes =3D (sbi->s_firstdatazone - sbi->s_firstinodezone)
> -		<< sbi->s_inodes_per_block_bits;
> -
> -	if (!silent)
> -		printk("VFS: Found a %s FS (block size =3D %ld) on device %s\n",
> -		       found, sb->s_blocksize, sb->s_id);
> -
> -	sb->s_magic =3D SYSV_MAGIC_BASE + sbi->s_type;
> -	/* set up enough so that it can read an inode */
> -	sb->s_op =3D &sysv_sops;
> -	if (sbi->s_forced_ro)
> -		sb->s_flags |=3D SB_RDONLY;
> -	root_inode =3D sysv_iget(sb, SYSV_ROOT_INO);
> -	if (IS_ERR(root_inode)) {
> -		printk("SysV FS: get root inode failed\n");
> -		return 0;
> -	}
> -	sb->s_root =3D d_make_root(root_inode);
> -	if (!sb->s_root) {
> -		printk("SysV FS: get root dentry failed\n");
> -		return 0;
> -	}
> -	return 1;
> -}
> -
> -static int sysv_fill_super(struct super_block *sb, struct fs_context *fc=
)
> -{
> -	struct buffer_head *bh1, *bh =3D NULL;
> -	struct sysv_sb_info *sbi;
> -	unsigned long blocknr;
> -	int size =3D 0, i;
> -	int silent =3D fc->sb_flags & SB_SILENT;
> -=09
> -	BUILD_BUG_ON(1024 !=3D sizeof (struct xenix_super_block));
> -	BUILD_BUG_ON(512 !=3D sizeof (struct sysv4_super_block));
> -	BUILD_BUG_ON(512 !=3D sizeof (struct sysv2_super_block));
> -	BUILD_BUG_ON(500 !=3D sizeof (struct coh_super_block));
> -	BUILD_BUG_ON(64 !=3D sizeof (struct sysv_inode));
> -
> -	sbi =3D kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sbi->s_sb =3D sb;
> -	sbi->s_block_base =3D 0;
> -	mutex_init(&sbi->s_lock);
> -	sb->s_fs_info =3D sbi;
> -	sb->s_time_min =3D 0;
> -	sb->s_time_max =3D U32_MAX;
> -	sb_set_blocksize(sb, BLOCK_SIZE);
> -
> -	for (i =3D 0; i < ARRAY_SIZE(flavours) && !size; i++) {
> -		brelse(bh);
> -		bh =3D sb_bread(sb, flavours[i].block);
> -		if (!bh)
> -			continue;
> -		size =3D flavours[i].test(SYSV_SB(sb), bh);
> -	}
> -
> -	if (!size)
> -		goto Eunknown;
> -
> -	switch (size) {
> -		case 1:
> -			blocknr =3D bh->b_blocknr << 1;
> -			brelse(bh);
> -			sb_set_blocksize(sb, 512);
> -			bh1 =3D sb_bread(sb, blocknr);
> -			bh =3D sb_bread(sb, blocknr + 1);
> -			break;
> -		case 2:
> -			bh1 =3D bh;
> -			break;
> -		case 3:
> -			blocknr =3D bh->b_blocknr >> 1;
> -			brelse(bh);
> -			sb_set_blocksize(sb, 2048);
> -			bh1 =3D bh =3D sb_bread(sb, blocknr);
> -			break;
> -		default:
> -			goto Ebadsize;
> -	}
> -
> -	if (bh && bh1) {
> -		sbi->s_bh1 =3D bh1;
> -		sbi->s_bh2 =3D bh;
> -		if (complete_read_super(sb, silent, size))
> -			return 0;
> -	}
> -
> -	brelse(bh1);
> -	brelse(bh);
> -	sb_set_blocksize(sb, BLOCK_SIZE);
> -	printk("oldfs: cannot read superblock\n");
> -failed:
> -	kfree(sbi);
> -	return -EINVAL;
> -
> -Eunknown:
> -	brelse(bh);
> -	if (!silent)
> -		printk("VFS: unable to find oldfs superblock on device %s\n",
> -			sb->s_id);
> -	goto failed;
> -Ebadsize:
> -	brelse(bh);
> -	if (!silent)
> -		printk("VFS: oldfs: unsupported block size (%dKb)\n",
> -			1<<(size-2));
> -	goto failed;
> -}
> -
> -static int v7_sanity_check(struct super_block *sb, struct buffer_head *b=
h)
> -{
> -	struct v7_super_block *v7sb;
> -	struct sysv_inode *v7i;
> -	struct buffer_head *bh2;
> -	struct sysv_sb_info *sbi;
> -
> -	sbi =3D sb->s_fs_info;
> -
> -	/* plausibility check on superblock */
> -	v7sb =3D (struct v7_super_block *) bh->b_data;
> -	if (fs16_to_cpu(sbi, v7sb->s_nfree) > V7_NICFREE ||
> -	    fs16_to_cpu(sbi, v7sb->s_ninode) > V7_NICINOD ||
> -	    fs32_to_cpu(sbi, v7sb->s_fsize) > V7_MAXSIZE)
> -		return 0;
> -
> -	/* plausibility check on root inode: it is a directory,
> -	   with a nonzero size that is a multiple of 16 */
> -	bh2 =3D sb_bread(sb, 2);
> -	if (bh2 =3D=3D NULL)
> -		return 0;
> -
> -	v7i =3D (struct sysv_inode *)(bh2->b_data + 64);
> -	if ((fs16_to_cpu(sbi, v7i->i_mode) & ~0777) !=3D S_IFDIR ||
> -	    (fs32_to_cpu(sbi, v7i->i_size) =3D=3D 0) ||
> -	    (fs32_to_cpu(sbi, v7i->i_size) & 017) ||
> -	    (fs32_to_cpu(sbi, v7i->i_size) > V7_NFILES *
> -	     sizeof(struct sysv_dir_entry))) {
> -		brelse(bh2);
> -		return 0;
> -	}
> -
> -	brelse(bh2);
> -	return 1;
> -}
> -
> -static int v7_fill_super(struct super_block *sb, struct fs_context *fc)
> -{
> -	struct sysv_sb_info *sbi;
> -	struct buffer_head *bh;
> -	int silent =3D fc->sb_flags & SB_SILENT;
> -
> -	BUILD_BUG_ON(sizeof(struct v7_super_block) !=3D 440);
> -	BUILD_BUG_ON(sizeof(struct sysv_inode) !=3D 64);
> -
> -	sbi =3D kzalloc(sizeof(struct sysv_sb_info), GFP_KERNEL);
> -	if (!sbi)
> -		return -ENOMEM;
> -
> -	sbi->s_sb =3D sb;
> -	sbi->s_block_base =3D 0;
> -	sbi->s_type =3D FSTYPE_V7;
> -	mutex_init(&sbi->s_lock);
> -	sb->s_fs_info =3D sbi;
> -	sb->s_time_min =3D 0;
> -	sb->s_time_max =3D U32_MAX;
> -=09
> -	sb_set_blocksize(sb, 512);
> -
> -	if ((bh =3D sb_bread(sb, 1)) =3D=3D NULL) {
> -		if (!silent)
> -			printk("VFS: unable to read V7 FS superblock on "
> -			       "device %s.\n", sb->s_id);
> -		goto failed;
> -	}
> -
> -	/* Try PDP-11 UNIX */
> -	sbi->s_bytesex =3D BYTESEX_PDP;
> -	if (v7_sanity_check(sb, bh))
> -		goto detected;
> -
> -	/* Try PC/IX, v7/x86 */
> -	sbi->s_bytesex =3D BYTESEX_LE;
> -	if (v7_sanity_check(sb, bh))
> -		goto detected;
> -
> -	goto failed;
> -
> -detected:
> -	sbi->s_bh1 =3D bh;
> -	sbi->s_bh2 =3D bh;
> -	if (complete_read_super(sb, silent, 1))
> -		return 0;
> -
> -failed:
> -	printk(KERN_ERR "VFS: could not find a valid V7 on %s.\n",
> -		sb->s_id);
> -	brelse(bh);
> -	kfree(sbi);
> -	return -EINVAL;
> -}
> -
> -/* Every kernel module contains stuff like this. */
> -
> -static int sysv_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_bdev(fc, sysv_fill_super);
> -}
> -
> -static int v7_get_tree(struct fs_context *fc)
> -{
> -	return get_tree_bdev(fc, v7_fill_super);
> -}
> -
> -static const struct fs_context_operations sysv_context_ops =3D {
> -	.get_tree	=3D sysv_get_tree,
> -};
> -
> -static const struct fs_context_operations v7_context_ops =3D {
> -	.get_tree	=3D v7_get_tree,
> -};
> -
> -static int sysv_init_fs_context(struct fs_context *fc)
> -{
> -	fc->ops =3D &sysv_context_ops;
> -	return 0;
> -}
> -
> -static int v7_init_fs_context(struct fs_context *fc)
> -{
> -	fc->ops =3D &v7_context_ops;
> -	return 0;
> -}
> -
> -static struct file_system_type sysv_fs_type =3D {
> -	.owner			=3D THIS_MODULE,
> -	.name			=3D "sysv",
> -	.kill_sb		=3D kill_block_super,
> -	.fs_flags		=3D FS_REQUIRES_DEV,
> -	.init_fs_context	=3D sysv_init_fs_context,
> -};
> -MODULE_ALIAS_FS("sysv");
> -
> -static struct file_system_type v7_fs_type =3D {
> -	.owner			=3D THIS_MODULE,
> -	.name			=3D "v7",
> -	.kill_sb		=3D kill_block_super,
> -	.fs_flags		=3D FS_REQUIRES_DEV,
> -	.init_fs_context	=3D v7_init_fs_context,
> -};
> -MODULE_ALIAS_FS("v7");
> -MODULE_ALIAS("v7");
> -
> -static int __init init_sysv_fs(void)
> -{
> -	int error;
> -
> -	error =3D sysv_init_icache();
> -	if (error)
> -		goto out;
> -	error =3D register_filesystem(&sysv_fs_type);
> -	if (error)
> -		goto destroy_icache;
> -	error =3D register_filesystem(&v7_fs_type);
> -	if (error)
> -		goto unregister;
> -	return 0;
> -
> -unregister:
> -	unregister_filesystem(&sysv_fs_type);
> -destroy_icache:
> -	sysv_destroy_icache();
> -out:
> -	return error;
> -}
> -
> -static void __exit exit_sysv_fs(void)
> -{
> -	unregister_filesystem(&sysv_fs_type);
> -	unregister_filesystem(&v7_fs_type);
> -	sysv_destroy_icache();
> -}
> -
> -module_init(init_sysv_fs)
> -module_exit(exit_sysv_fs)
> -MODULE_DESCRIPTION("SystemV Filesystem");
> -MODULE_LICENSE("GPL");
> diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
> deleted file mode 100644
> index 0a48b2e7edb1..000000000000
> --- a/fs/sysv/sysv.h
> +++ /dev/null
> @@ -1,245 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _SYSV_H
> -#define _SYSV_H
> -
> -#include <linux/buffer_head.h>
> -
> -typedef __u16 __bitwise __fs16;
> -typedef __u32 __bitwise __fs32;
> -
> -#include <linux/sysv_fs.h>
> -
> -/*
> - * SystemV/V7/Coherent super-block data in memory
> - *
> - * The SystemV/V7/Coherent superblock contains dynamic data (it gets mod=
ified
> - * while the system is running). This is in contrast to the Minix and Be=
rkeley
> - * filesystems (where the superblock is never modified). This affects th=
e
> - * sync() operation: we must keep the superblock in a disk buffer and us=
e this
> - * one as our "working copy".
> - */
> -
> -struct sysv_sb_info {
> -	struct super_block *s_sb;	/* VFS superblock */
> -	int	       s_type;		/* file system type: FSTYPE_{XENIX|SYSV|COH} */
> -	char	       s_bytesex;	/* bytesex (le/be/pdp) */
> -	unsigned int   s_inodes_per_block;	/* number of inodes per block */
> -	unsigned int   s_inodes_per_block_1;	/* inodes_per_block - 1 */
> -	unsigned int   s_inodes_per_block_bits;	/* log2(inodes_per_block) */
> -	unsigned int   s_ind_per_block;		/* number of indirections per block */
> -	unsigned int   s_ind_per_block_bits;	/* log2(ind_per_block) */
> -	unsigned int   s_ind_per_block_2;	/* ind_per_block ^ 2 */
> -	unsigned int   s_toobig_block;		/* 10 + ipb + ipb^2 + ipb^3 */
> -	unsigned int   s_block_base;	/* physical block number of block 0 */
> -	unsigned short s_fic_size;	/* free inode cache size, NICINOD */
> -	unsigned short s_flc_size;	/* free block list chunk size, NICFREE */
> -	/* The superblock is kept in one or two disk buffers: */
> -	struct buffer_head *s_bh1;
> -	struct buffer_head *s_bh2;
> -	/* These are pointers into the disk buffer, to compensate for
> -	   different superblock layout. */
> -	char *         s_sbd1;		/* entire superblock data, for part 1 */
> -	char *         s_sbd2;		/* entire superblock data, for part 2 */
> -	__fs16         *s_sb_fic_count;	/* pointer to s_sbd->s_ninode */
> -        sysv_ino_t     *s_sb_fic_inodes; /* pointer to s_sbd->s_inode */
> -	__fs16         *s_sb_total_free_inodes; /* pointer to s_sbd->s_tinode *=
/
> -	__fs16         *s_bcache_count;	/* pointer to s_sbd->s_nfree */
> -	sysv_zone_t    *s_bcache;	/* pointer to s_sbd->s_free */
> -	__fs32         *s_free_blocks;	/* pointer to s_sbd->s_tfree */
> -	__fs32         *s_sb_time;	/* pointer to s_sbd->s_time */
> -	__fs32         *s_sb_state;	/* pointer to s_sbd->s_state, only FSTYPE_S=
YSV */
> -	/* We keep those superblock entities that don't change here;
> -	   this saves us an indirection and perhaps a conversion. */
> -	u32            s_firstinodezone; /* index of first inode zone */
> -	u32            s_firstdatazone;	/* same as s_sbd->s_isize */
> -	u32            s_ninodes;	/* total number of inodes */
> -	u32            s_ndatazones;	/* total number of data zones */
> -	u32            s_nzones;	/* same as s_sbd->s_fsize */
> -	u16	       s_namelen;       /* max length of dir entry */
> -	int	       s_forced_ro;
> -	struct mutex s_lock;
> -};
> -
> -/*
> - * SystemV/V7/Coherent FS inode data in memory
> - */
> -struct sysv_inode_info {
> -	__fs32		i_data[13];
> -	u32		i_dir_start_lookup;
> -	struct inode	vfs_inode;
> -};
> -
> -
> -static inline struct sysv_inode_info *SYSV_I(struct inode *inode)
> -{
> -	return container_of(inode, struct sysv_inode_info, vfs_inode);
> -}
> -
> -static inline struct sysv_sb_info *SYSV_SB(struct super_block *sb)
> -{
> -	return sb->s_fs_info;
> -}
> -
> -
> -/* identify the FS in memory */
> -enum {
> -	FSTYPE_NONE =3D 0,
> -	FSTYPE_XENIX,
> -	FSTYPE_SYSV4,
> -	FSTYPE_SYSV2,
> -	FSTYPE_COH,
> -	FSTYPE_V7,
> -	FSTYPE_AFS,
> -	FSTYPE_END,
> -};
> -
> -#define SYSV_MAGIC_BASE		0x012FF7B3
> -
> -#define XENIX_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_XENIX)
> -#define SYSV4_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV4)
> -#define SYSV2_SUPER_MAGIC	(SYSV_MAGIC_BASE+FSTYPE_SYSV2)
> -#define COH_SUPER_MAGIC		(SYSV_MAGIC_BASE+FSTYPE_COH)
> -
> -
> -/* Admissible values for i_nlink: 0.._LINK_MAX */
> -enum {
> -	XENIX_LINK_MAX	=3D	126,	/* ?? */
> -	SYSV_LINK_MAX	=3D	126,	/* 127? 251? */
> -	V7_LINK_MAX     =3D	126,	/* ?? */
> -	COH_LINK_MAX	=3D	10000,
> -};
> -
> -
> -static inline void dirty_sb(struct super_block *sb)
> -{
> -	struct sysv_sb_info *sbi =3D SYSV_SB(sb);
> -
> -	mark_buffer_dirty(sbi->s_bh1);
> -	if (sbi->s_bh1 !=3D sbi->s_bh2)
> -		mark_buffer_dirty(sbi->s_bh2);
> -}
> -
> -
> -/* ialloc.c */
> -extern struct sysv_inode *sysv_raw_inode(struct super_block *, unsigned,
> -			struct buffer_head **);
> -extern struct inode * sysv_new_inode(const struct inode *, umode_t);
> -extern void sysv_free_inode(struct inode *);
> -extern unsigned long sysv_count_free_inodes(struct super_block *);
> -
> -/* balloc.c */
> -extern sysv_zone_t sysv_new_block(struct super_block *);
> -extern void sysv_free_block(struct super_block *, sysv_zone_t);
> -extern unsigned long sysv_count_free_blocks(struct super_block *);
> -
> -/* itree.c */
> -void sysv_truncate(struct inode *);
> -int sysv_prepare_chunk(struct folio *folio, loff_t pos, unsigned len);
> -
> -/* inode.c */
> -extern struct inode *sysv_iget(struct super_block *, unsigned int);
> -extern int sysv_write_inode(struct inode *, struct writeback_control *wb=
c);
> -extern int sysv_sync_inode(struct inode *);
> -extern void sysv_set_inode(struct inode *, dev_t);
> -extern int sysv_getattr(struct mnt_idmap *, const struct path *,
> -			struct kstat *, u32, unsigned int);
> -extern int sysv_init_icache(void);
> -extern void sysv_destroy_icache(void);
> -
> -
> -/* dir.c */
> -struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct folio **)=
;
> -int sysv_add_link(struct dentry *, struct inode *);
> -int sysv_delete_entry(struct sysv_dir_entry *, struct folio *);
> -int sysv_make_empty(struct inode *, struct inode *);
> -int sysv_empty_dir(struct inode *);
> -int sysv_set_link(struct sysv_dir_entry *, struct folio *,
> -			struct inode *);
> -struct sysv_dir_entry *sysv_dotdot(struct inode *, struct folio **);
> -ino_t sysv_inode_by_name(struct dentry *);
> -
> -
> -extern const struct inode_operations sysv_file_inode_operations;
> -extern const struct inode_operations sysv_dir_inode_operations;
> -extern const struct file_operations sysv_file_operations;
> -extern const struct file_operations sysv_dir_operations;
> -extern const struct address_space_operations sysv_aops;
> -extern const struct super_operations sysv_sops;
> -
> -
> -enum {
> -	BYTESEX_LE,
> -	BYTESEX_PDP,
> -	BYTESEX_BE,
> -};
> -
> -static inline u32 PDP_swab(u32 x)
> -{
> -#ifdef __LITTLE_ENDIAN
> -	return ((x & 0xffff) << 16) | ((x & 0xffff0000) >> 16);
> -#else
> -#ifdef __BIG_ENDIAN
> -	return ((x & 0xff00ff) << 8) | ((x & 0xff00ff00) >> 8);
> -#else
> -#error BYTESEX
> -#endif
> -#endif
> -}
> -
> -static inline __u32 fs32_to_cpu(struct sysv_sb_info *sbi, __fs32 n)
> -{
> -	if (sbi->s_bytesex =3D=3D BYTESEX_PDP)
> -		return PDP_swab((__force __u32)n);
> -	else if (sbi->s_bytesex =3D=3D BYTESEX_LE)
> -		return le32_to_cpu((__force __le32)n);
> -	else
> -		return be32_to_cpu((__force __be32)n);
> -}
> -
> -static inline __fs32 cpu_to_fs32(struct sysv_sb_info *sbi, __u32 n)
> -{
> -	if (sbi->s_bytesex =3D=3D BYTESEX_PDP)
> -		return (__force __fs32)PDP_swab(n);
> -	else if (sbi->s_bytesex =3D=3D BYTESEX_LE)
> -		return (__force __fs32)cpu_to_le32(n);
> -	else
> -		return (__force __fs32)cpu_to_be32(n);
> -}
> -
> -static inline __fs32 fs32_add(struct sysv_sb_info *sbi, __fs32 *n, int d=
)
> -{
> -	if (sbi->s_bytesex =3D=3D BYTESEX_PDP)
> -		*(__u32*)n =3D PDP_swab(PDP_swab(*(__u32*)n)+d);
> -	else if (sbi->s_bytesex =3D=3D BYTESEX_LE)
> -		le32_add_cpu((__le32 *)n, d);
> -	else
> -		be32_add_cpu((__be32 *)n, d);
> -	return *n;
> -}
> -
> -static inline __u16 fs16_to_cpu(struct sysv_sb_info *sbi, __fs16 n)
> -{
> -	if (sbi->s_bytesex !=3D BYTESEX_BE)
> -		return le16_to_cpu((__force __le16)n);
> -	else
> -		return be16_to_cpu((__force __be16)n);
> -}
> -
> -static inline __fs16 cpu_to_fs16(struct sysv_sb_info *sbi, __u16 n)
> -{
> -	if (sbi->s_bytesex !=3D BYTESEX_BE)
> -		return (__force __fs16)cpu_to_le16(n);
> -	else
> -		return (__force __fs16)cpu_to_be16(n);
> -}
> -
> -static inline __fs16 fs16_add(struct sysv_sb_info *sbi, __fs16 *n, int d=
)
> -{
> -	if (sbi->s_bytesex !=3D BYTESEX_BE)
> -		le16_add_cpu((__le16 *)n, d);
> -	else
> -		be16_add_cpu((__be16 *)n, d);
> -	return *n;
> -}
> -
> -#endif /* _SYSV_H */
> diff --git a/include/linux/sysv_fs.h b/include/linux/sysv_fs.h
> deleted file mode 100644
> index 5cf77dbb8d86..000000000000
> --- a/include/linux/sysv_fs.h
> +++ /dev/null
> @@ -1,214 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _LINUX_SYSV_FS_H
> -#define _LINUX_SYSV_FS_H
> -
> -#define __packed2__	__attribute__((packed, aligned(2)))
> -
> -
> -#ifndef __KERNEL__
> -typedef u16 __fs16;
> -typedef u32 __fs16;
> -#endif
> -
> -/* inode numbers are 16 bit */
> -typedef __fs16 sysv_ino_t;
> -
> -/* Block numbers are 24 bit, sometimes stored in 32 bit.
> -   On Coherent FS, they are always stored in PDP-11 manner: the least
> -   significant 16 bits come last. */
> -typedef __fs32 sysv_zone_t;
> -
> -/* 0 is non-existent */
> -#define SYSV_BADBL_INO	1	/* inode of bad blocks file */
> -#define SYSV_ROOT_INO	2	/* inode of root directory */
> -
> -
> -/* Xenix super-block data on disk */
> -#define XENIX_NICINOD	100	/* number of inode cache entries */
> -#define XENIX_NICFREE	100	/* number of free block list chunk entries */
> -struct xenix_super_block {
> -	__fs16		s_isize; /* index of first data zone */
> -	__fs32		s_fsize __packed2__; /* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16		s_nfree;	/* number of free blocks in s_free, <=3D XENIX_NICFREE=
 */
> -	sysv_zone_t	s_free[XENIX_NICFREE]; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16		s_ninode; /* number of free inodes in s_inode, <=3D XENIX_NICIN=
OD */
> -	sysv_ino_t	s_inode[XENIX_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char		s_flock;	/* lock during free block list manipulation */
> -	char		s_ilock;	/* lock during inode cache manipulation */
> -	char		s_fmod;		/* super-block modified flag */
> -	char		s_ronly;	/* flag whether fs is mounted read-only */
> -	__fs32		s_time __packed2__; /* time of last super block update */
> -	__fs32		s_tfree __packed2__; /* total number of free zones */
> -	__fs16		s_tinode;	/* total number of free inodes */
> -	__fs16		s_dinfo[4];	/* device information ?? */
> -	char		s_fname[6];	/* file system volume name */
> -	char		s_fpack[6];	/* file system pack name */
> -	char		s_clean;	/* set to 0x46 when filesystem is properly unmounted */
> -	char		s_fill[371];
> -	s32		s_magic;	/* version of file system */
> -	__fs32		s_type;		/* type of file system: 1 for 512 byte blocks
> -								2 for 1024 byte blocks
> -								3 for 2048 byte blocks */
> -							=09
> -};
> -
> -/*
> - * SystemV FS comes in two variants:
> - * sysv2: System V Release 2 (e.g. Microport), structure elements aligne=
d(2).
> - * sysv4: System V Release 4 (e.g. Consensys), structure elements aligne=
d(4).
> - */
> -#define SYSV_NICINOD	100	/* number of inode cache entries */
> -#define SYSV_NICFREE	50	/* number of free block list chunk entries */
> -
> -/* SystemV4 super-block data on disk */
> -struct sysv4_super_block {
> -	__fs16	s_isize;	/* index of first data zone */
> -	u16	s_pad0;
> -	__fs32	s_fsize;	/* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16	s_nfree;	/* number of free blocks in s_free, <=3D SYSV_NICFREE *=
/
> -	u16	s_pad1;
> -	sysv_zone_t	s_free[SYSV_NICFREE]; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16	s_ninode;	/* number of free inodes in s_inode, <=3D SYSV_NICINOD=
 */
> -	u16	s_pad2;
> -	sysv_ino_t     s_inode[SYSV_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char	s_flock;	/* lock during free block list manipulation */
> -	char	s_ilock;	/* lock during inode cache manipulation */
> -	char	s_fmod;		/* super-block modified flag */
> -	char	s_ronly;	/* flag whether fs is mounted read-only */
> -	__fs32	s_time;		/* time of last super block update */
> -	__fs16	s_dinfo[4];	/* device information ?? */
> -	__fs32	s_tfree;	/* total number of free zones */
> -	__fs16	s_tinode;	/* total number of free inodes */
> -	u16	s_pad3;
> -	char	s_fname[6];	/* file system volume name */
> -	char	s_fpack[6];	/* file system pack name */
> -	s32	s_fill[12];
> -	__fs32	s_state;	/* file system state: 0x7c269d38-s_time means clean */
> -	s32	s_magic;	/* version of file system */
> -	__fs32	s_type;		/* type of file system: 1 for 512 byte blocks
> -								2 for 1024 byte blocks */
> -};
> -
> -/* SystemV2 super-block data on disk */
> -struct sysv2_super_block {
> -	__fs16	s_isize; 		/* index of first data zone */
> -	__fs32	s_fsize __packed2__;	/* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16	s_nfree;		/* number of free blocks in s_free, <=3D SYSV_NICFREE =
*/
> -	sysv_zone_t s_free[SYSV_NICFREE];	/* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16	s_ninode;		/* number of free inodes in s_inode, <=3D SYSV_NICINO=
D */
> -	sysv_ino_t     s_inode[SYSV_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char	s_flock;		/* lock during free block list manipulation */
> -	char	s_ilock;		/* lock during inode cache manipulation */
> -	char	s_fmod;			/* super-block modified flag */
> -	char	s_ronly;		/* flag whether fs is mounted read-only */
> -	__fs32	s_time __packed2__;	/* time of last super block update */
> -	__fs16	s_dinfo[4];		/* device information ?? */
> -	__fs32	s_tfree __packed2__;	/* total number of free zones */
> -	__fs16	s_tinode;		/* total number of free inodes */
> -	char	s_fname[6];		/* file system volume name */
> -	char	s_fpack[6];		/* file system pack name */
> -	s32	s_fill[14];
> -	__fs32	s_state;		/* file system state: 0xcb096f43 means clean */
> -	s32	s_magic;		/* version of file system */
> -	__fs32	s_type;			/* type of file system: 1 for 512 byte blocks
> -								2 for 1024 byte blocks */
> -};
> -
> -/* V7 super-block data on disk */
> -#define V7_NICINOD     100     /* number of inode cache entries */
> -#define V7_NICFREE     50      /* number of free block list chunk entrie=
s */
> -struct v7_super_block {
> -	__fs16 s_isize;        /* index of first data zone */
> -	__fs32 s_fsize __packed2__; /* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16 s_nfree;        /* number of free blocks in s_free, <=3D V7_NICF=
REE */
> -	sysv_zone_t s_free[V7_NICFREE]; /* first free block list chunk */
> -	/* the cache of free inodes: */
> -	__fs16 s_ninode;       /* number of free inodes in s_inode, <=3D V7_NIC=
INOD */
> -	sysv_ino_t      s_inode[V7_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux or V7: */
> -	char    s_flock;        /* lock during free block list manipulation */
> -	char    s_ilock;        /* lock during inode cache manipulation */
> -	char    s_fmod;         /* super-block modified flag */
> -	char    s_ronly;        /* flag whether fs is mounted read-only */
> -	__fs32  s_time __packed2__; /* time of last super block update */
> -	/* the following fields are not maintained by V7: */
> -	__fs32  s_tfree __packed2__; /* total number of free zones */
> -	__fs16  s_tinode;       /* total number of free inodes */
> -	__fs16  s_m;            /* interleave factor */
> -	__fs16  s_n;            /* interleave factor */
> -	char    s_fname[6];     /* file system name */
> -	char    s_fpack[6];     /* file system pack name */
> -};
> -/* Constants to aid sanity checking */
> -/* This is not a hard limit, nor enforced by v7 kernel. It's actually ju=
st
> - * the limit used by Seventh Edition's ls, though is high enough to assu=
me
> - * that no reasonable file system would have that much entries in root
> - * directory. Thus, if we see anything higher, we just probably got the
> - * endiannes wrong. */
> -#define V7_NFILES	1024
> -/* The disk addresses are three-byte (despite direct block addresses bei=
ng
> - * aligned word-wise in inode). If the most significant byte is non-zero=
,
> - * something is most likely wrong (not a filesystem, bad bytesex). */
> -#define V7_MAXSIZE	0x00ffffff
> -
> -/* Coherent super-block data on disk */
> -#define COH_NICINOD	100	/* number of inode cache entries */
> -#define COH_NICFREE	64	/* number of free block list chunk entries */
> -struct coh_super_block {
> -	__fs16		s_isize;	/* index of first data zone */
> -	__fs32		s_fsize __packed2__; /* total number of zones of this fs */
> -	/* the start of the free block list: */
> -	__fs16 s_nfree;	/* number of free blocks in s_free, <=3D COH_NICFREE */
> -	sysv_zone_t	s_free[COH_NICFREE] __packed2__; /* first free block list c=
hunk */
> -	/* the cache of free inodes: */
> -	__fs16		s_ninode;	/* number of free inodes in s_inode, <=3D COH_NICINOD=
 */
> -	sysv_ino_t	s_inode[COH_NICINOD]; /* some free inodes */
> -	/* locks, not used by Linux: */
> -	char		s_flock;	/* lock during free block list manipulation */
> -	char		s_ilock;	/* lock during inode cache manipulation */
> -	char		s_fmod;		/* super-block modified flag */
> -	char		s_ronly;	/* flag whether fs is mounted read-only */
> -	__fs32		s_time __packed2__; /* time of last super block update */
> -	__fs32		s_tfree __packed2__; /* total number of free zones */
> -	__fs16		s_tinode;	/* total number of free inodes */
> -	__fs16		s_interleave_m;	/* interleave factor */
> -	__fs16		s_interleave_n;
> -	char		s_fname[6];	/* file system volume name */
> -	char		s_fpack[6];	/* file system pack name */
> -	__fs32		s_unique;	/* zero, not used */
> -};
> -
> -/* SystemV/Coherent inode data on disk */
> -struct sysv_inode {
> -	__fs16 i_mode;
> -	__fs16 i_nlink;
> -	__fs16 i_uid;
> -	__fs16 i_gid;
> -	__fs32 i_size;
> -	u8  i_data[3*(10+1+1+1)];
> -	u8  i_gen;
> -	__fs32 i_atime;	/* time of last access */
> -	__fs32 i_mtime;	/* time of last modification */
> -	__fs32 i_ctime;	/* time of creation */
> -};
> -
> -/* SystemV/Coherent directory entry on disk */
> -#define SYSV_NAMELEN	14	/* max size of name in struct sysv_dir_entry */
> -struct sysv_dir_entry {
> -	sysv_ino_t inode;
> -	char name[SYSV_NAMELEN]; /* up to 14 characters, the rest are zeroes */
> -};
> -
> -#define SYSV_DIRSIZE	sizeof(struct sysv_dir_entry)	/* size of every dire=
ctory entry */
> -
> -#endif /* _LINUX_SYSV_FS_H */

Reviewed-by: Jeff Layton <jlayton@kernel.org>

