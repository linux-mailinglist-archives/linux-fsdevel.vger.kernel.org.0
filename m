Return-Path: <linux-fsdevel+bounces-74673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN3yDHm/b2kOMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:46:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7C48CDB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 18:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30669983BA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9856244CAEE;
	Tue, 20 Jan 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+UIexV2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EB743CEDF;
	Tue, 20 Jan 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919969; cv=none; b=gA0c6OVXO0d2+2JLi+Kz1WWGQSIstzVzHV9viNPESTXRqpBP+v8K5JFXzyWjP62h4QLE5UqUwC43ys9tI4xlMZNvKrDHnx6W8bWxdbqDKT1uhJkFdcK0pVq4ocvaovg8T2AjpiFCnIQ2iOqSAOhs/SSoaoT3h5Mt+sigaBX37mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919969; c=relaxed/simple;
	bh=CeS53p/iUF6ZIAmtlaJKzUvodYe28myupJNz66J3YlM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZWERCP5DQmBx4acY/3dilDY5P9A0D34w8kM7fYjMpZ6DtZ4jFKuW23fcwNTOXidDFPsPijCCxGtpGv2TBaDv0X3OkdS9LT821Ckl7gBjIiwlhLMFY7NoEgom3MLY4+TugHkOaZ4R1ujmS2numtk6ErDPbppjwvf1bRqR14QnjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+UIexV2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585BEC16AAE;
	Tue, 20 Jan 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919968;
	bh=CeS53p/iUF6ZIAmtlaJKzUvodYe28myupJNz66J3YlM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N+UIexV2/jJKOKht4ULYWMWi45vTee39rk1V1qhn1NUA2GTyOLjoXsOjAIaG4mqwN
	 E9A/4K4CRsJBiWApsUQmDFfNw6wGlKBdvWjyuGic9FbvWA+L4cZBEySz0BNHvxAEut
	 Me8fXTLiV8f+PKsCckBiHEv26Mf1XxUY69z07cufRj9asSuGfTOx39BrNMykZ7Jq+m
	 +m3VQ71xPUfrNa9nY7wieJYhUfz70LqbSJ0nd60hc6ZDed1LDqdJ2zz5dcWmw1xrth
	 SzaOtyjBwfo1sqMarS+jaHPRqhlBTJjSOW0KlIdScig1OYkzSD3/aHglku7X4dacQG
	 VYYKcuZs2CLJg==
Message-ID: <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const,
 man/man2/fcntl.2: Document F_SETDELEG and F_GETDELEG
From: Jeff Layton <jlayton@kernel.org>
To: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Date: Tue, 20 Jan 2026 09:39:27 -0500
In-Reply-To: <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
	 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
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
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-74673-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: AFD7C48CDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-01-18 at 16:42 +0100, Alejandro Colomar wrote:
> From: Jeff Layton <jlayton@kernel.org>
>=20
> With Linux 6.19, userland will be able to request a delegation on a file
> or directory.  These new objects act a lot like file leases, but are
> based on NFSv4 file and directory delegations.
>=20
> Add new F_GETDELEG and F_SETDELEG manpages to document them.
>=20
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> [alx: minor tweaks]
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  man/man2/fcntl.2                |   5 +
>  man/man2const/F_GETDELEG.2const | 265 ++++++++++++++++++++++++++++++++
>  man/man2const/F_SETDELEG.2const |   1 +
>  3 files changed, 271 insertions(+)
>  create mode 100644 man/man2const/F_GETDELEG.2const
>  create mode 100644 man/man2const/F_SETDELEG.2const
>=20
> diff --git a/man/man2/fcntl.2 b/man/man2/fcntl.2
> index 7f34e332e..f05d559da 100644
> --- a/man/man2/fcntl.2
> +++ b/man/man2/fcntl.2
> @@ -78,6 +78,11 @@ .SS Leases
>  .BR F_SETLEASE (2const)
>  .TQ
>  .BR F_GETLEASE (2const)
> +.SS Delegations
> +.TP
> +.BR F_SETDELEG (2const)
> +.TQ
> +.BR F_GETDELEG (2const)
>  .SS File and directory change notification (dnotify)
>  .TP
>  .BR F_NOTIFY (2const)
> diff --git a/man/man2const/F_GETDELEG.2const b/man/man2const/F_GETDELEG.2=
const
> new file mode 100644
> index 000000000..e4d98feed
> --- /dev/null
> +++ b/man/man2const/F_GETDELEG.2const
> @@ -0,0 +1,265 @@
> +.\" Copyright, the authors of the Linux man-pages project
> +.\"
> +.\" SPDX-License-Identifier: Linux-man-pages-copyleft
> +.\"
> +.TH F_GETDELEG 2const (date) "Linux man-pages (unreleased)"
> +.SH NAME
> +F_GETDELEG,
> +F_SETDELEG
> +\-
> +delegations
> +.SH LIBRARY
> +Standard C library
> +.RI ( libc ,\~ \-lc )
> +.SH SYNOPSIS
> +.nf
> +.B #define _GNU_SOURCE
> +.B #include <fcntl.h>
> +.P
> +.BI "int fcntl(int " fd ", F_SETDELEG, const struct delegation *" deleg =
);
> +.BI "int fcntl(int " fd ", F_GETDELEG, struct delegation *" deleg );
> +.fi
> +.P
> +.EX
> +struct delegation {
> +	__u32  d_flags;
> +	__u16  d_type;
> +	__u16  __pad;
> +};
> +.EE
> +.SH DESCRIPTION
> +.B F_SETDELEG
> +and
> +.B F_GETDELEG
> +are used to establish a new delegation,
> +and retrieve the current delegation,
> +on the open file description referred to by the file descriptor
> +.IR fd .
> +.P
> +A file delegation is a mechanism whereby
> +the process holding the delegation (the "delegation holder")
> +is notified (via delivery of a signal)
> +when a process (the "delegation breaker")
> +tries to
> +.BR open (2)
> +or
> +.BR truncate (2)
> +the file referred to by that file descriptor,
> +or tries to
> +.BR unlink (2)
> +or
> +.BR rename (2)
> +the dentry that was originally opened for the file.
> +.P
> +Delegations can also be set on directory file descriptors.
> +The holder of a directory delegation will be notified if there is a
> +create, delete, or rename of a dirent within the directory.
> +.TP
> +.B F_SETDELEG
> +Set or remove a file or directory delegation according to the
> +value specified in
> +.IR deleg->d_type :
> +.RS
> +.TP
> +.B F_RDLCK
> +Establish a read delegation.
> +This will cause the calling process to be notified
> +when the file is
> +opened for writing,
> +or is truncated, unlinked or renamed.
> +A read delegation can be placed
> +only on a file descriptor that is opened read-only.
> +.IP
> +If
> +.I fd
> +refers to a directory,
> +then the calling process will be notified
> +if there are changes to filenames within the directory,
> +or when the directory itself is renamed.
> +.TP
> +.B F_WRLCK
> +Establish a write delegation.
> +This will cause the caller to be notified when the file is opened for re=
ading or writing,
> +or is truncated, renamed or unlinked.
> +A write delegation may be placed on a file only if there are no other op=
en file descriptors for the file.
> +The file must be opened for write in order to set a write delegation on =
it.
> +Write delegations cannot be set on directory file descriptors.
> +.TP
> +.B F_UNLCK
> +Remove our delegation from the file.
> +.RE
> +.P
> +Like leases,
> +delegations are associated with an open file description
> +(see
> +.BR open (2)).
> +This means that duplicate file descriptors
> +(created by, for example,
> +.BR fork (2)
> +or
> +.BR dup (2))
> +refer to the same delegation,
> +and this delegation may be modified or released
> +using any of these descriptors.
> +Furthermore,
> +the delegation is released by either an explicit
> +.B F_UNLCK
> +operation on any of these duplicate file descriptors,
> +or when all such file descriptors have been closed.
> +.P
> +An unprivileged process may establish a delegation
> +only on a file whose UID (owner) matches the filesystem UID of the proce=
ss.
> +A process with the
> +.B CAP_LEASE
> +capability may establish delegations on arbitrary files and directories.
> +.TP
> +.B F_GETDELEG
> +Indicates what type of delegation is associated with the file descriptor
> +.I fd
> +by setting
> +.I deleg->d_type
> +to either
> +.BR F_RDLCK ,
> +.BR F_WRLCK ,
> +or
> +.BR F_UNLCK ,
> +indicating, respectively,
> +a read delegation, a write delegation, or no delegation.
> +.P
> +When a process (the "delegation breaker")
> +performs an activity that conflicts with a delegation
> +established via
> +.BR F_SETDELEG ,
> +the system call is blocked by the kernel
> +and the kernel notifies the delegation holder by sending it a signal
> +.RB ( SIGIO
> +by default).
> +The delegation holder should respond to receipt of this signal
> +by doing whatever cleanup is required
> +in preparation for the file to be
> +accessed by another process
> +(e.g., flushing cached buffers)
> +and then either remove or downgrade its delegation.
> +A delegation is removed by performing an
> +.B F_SETDELEG
> +operation specifying
> +.I deleg->d_type
> +as
> +.BR F_UNLCK .
> +If the delegation holder currently holds
> +a write delegation on the file,
> +and the delegation breaker
> +is opening the file for reading,
> +then it is sufficient for the delegation holder to
> +downgrade the delegation to a read delegation.
> +This is done by performing an
> +.B F_SETDELEG
> +operation specifying
> +.I deleg->d_type
> +as
> +.BR F_RDLCK .
> +.P
> +If the delegation holder
> +fails to downgrade or remove the delegation
> +within the number of seconds specified in
> +.IR /proc/sys/fs/lease\-break\-time ,
> +then the kernel
> +forcibly removes or downgrades the delegation holder's delegation.
> +.P
> +Once a delegation break has been initiated,
> +.B F_GETDELEG
> +returns the target delegation type in the
> +.I deleg->d_type
> +(either
> +.B F_RDLCK
> +or
> +.BR F_UNLCK ,
> +depending on what would be compatible with the delegation breaker)
> +until the delegation holder voluntarily downgrades or removes the delega=
tion
> +or the kernel forcibly does so after the delegation break timer expires.
> +.P
> +Once the delegation has been voluntarily or forcibly removed or downgrad=
ed,
> +and assuming the delegation breaker has not unblocked its system call,
> +the kernel permits the delegation breaker's system call to proceed.
> +.P
> +If the delegation breaker's blocked system call
> +is interrupted by a signal handler,
> +then the system call fails with the error
> +.BR EINTR ,
> +but the other steps still occur as described above.
> +If the delegation breaker is killed by a signal while blocked in
> +.BR open (2)
> +or
> +.BR truncate (2),
> +then the other steps still occur as described above.
> +If the delegation breaker specifies the
> +.B O_NONBLOCK
> +flag when calling
> +.BR open (2),
> +then the call immediately fails with the error
> +.BR EWOULDBLOCK ,
> +but the other steps still occur as described above.
> +.P
> +The default signal used to notify the delegation holder is
> +.BR SIGIO ,
> +but this can be changed using
> +.BR F_SETSIG (2const).
> +If a
> +.BR F_SETSIG (2const)
> +operation is performed
> +(even one specifying
> +.BR SIGIO ),
> +and the signal
> +handler is established using
> +.BR SA_SIGINFO ,
> +then the handler will receive a
> +.I siginfo_t
> +structure as its second argument,
> +and the
> +.I si_fd
> +field of this argument will hold
> +the file descriptor of the file with the delegation
> +that has been accessed by another process.
> +(This is useful if the caller holds delegations against multiple files.)
> +.SH NOTES
> +Delegations were designed to implement NFSv4 delegations for the Linux N=
FS server.
> +.SH RETURN VALUE
> +On success zero is returned.
> +On error, \-1 is returned, and
> +.I errno
> +is set to indicate the error.
> +A successful
> +.B F_GETDELEG
> +call will also update the
> +.I deleg->d_type
> +field.
> +.SH ERRORS
> +See
> +.BR fcntl (2).
> +These operations can also return the following errors:
> +.TP
> +.B EAGAIN
> +The file was held open in a way that
> +conflicts with the requested delegation.
> +.TP
> +.B EINVAL
> +The caller tried to set a
> +.B F_WRLCK
> +delegation and
> +.I fd
> +represents a directory.
> +.TP
> +.B EINVAL
> +.I fd
> +doesn't represent a file or directory.
> +.TP
> +.B EINVAL
> +The underlying filesystem doesn't support delegations.
> +.SH STANDARDS
> +Linux,
> +IETF\ RFC\ 8881.
> +.SH HISTORY
> +Linux 6.19.
> +.SH SEE ALSO
> +.BR fcntl (2) ,
> +.BR F_SETLEASE (2const)
> diff --git a/man/man2const/F_SETDELEG.2const b/man/man2const/F_SETDELEG.2=
const
> new file mode 100644
> index 000000000..acabdfc13
> --- /dev/null
> +++ b/man/man2const/F_SETDELEG.2const
> @@ -0,0 +1 @@
> +.so man2const/F_GETDELEG.2const
>=20
> base-commit: f17241696722c472c5fcd06ee3b7af7afc3f1082


This all looks great to me. Did you need me to make any other changes?
Thanks for doing the cleanup! FWIW:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

