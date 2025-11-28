Return-Path: <linux-fsdevel+bounces-70098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FEC90875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1485B34EF05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74630220F2C;
	Fri, 28 Nov 2025 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BdwkTuoy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA241E3DE5;
	Fri, 28 Nov 2025 01:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294434; cv=none; b=tU0CAhF6ckAmXV8BfObGur3hHeFbipGv5RM7xUtWwg1QU2b5jh78TilsQ3xav+eJVdywv2rubJdeY6Yg26jckHnMAqpdx/rl4xGPs3rxb+Q21XP4iA18qDZSVvhQyAuw+e+sCpdjpv1isZ5mmG3Cx3UMdy7iyqPirbWncFk1JJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294434; c=relaxed/simple;
	bh=PUrMKcVIb3gY9DX/X6vLOgRm8gYV1jy6fnBiePp0+Go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmiLiP/9G74Pp2+A+UFx5y/I9ZUh3+NpoRPukKVi5x2Nb1yDs575+2hqwu64PRs0eV0hR6AyCG/dJsokFnEKfA9ELJ3jJ/rTcpkVFtq36fBTYw5y2FpMxCFy1GSwPMnTJ16UCxEVp8qHLIs7F2x2EUJSiqq0u2fRwn/nAGIC28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BdwkTuoy; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1764294416;
	bh=PUrMKcVIb3gY9DX/X6vLOgRm8gYV1jy6fnBiePp0+Go=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=BdwkTuoyj7+csKLlMCC0PkqgoESWaWed5m0tFEjfz2NQ0OhLr4omapaars4BUsf4j
	 x7N1JMvgnP/PTo/ciWkhXF+R6asRh4SBX/l69WF95wLonL8/2067JXHF3Ako6/NVek
	 RpeIBAFXc3DHsALJ75dAHlIgILBepir2bU/Su/Gs=
X-QQ-mid: zesmtpip4t1764294409td5a2973d
X-QQ-Originating-IP: tD26oQMyu5n8Q06G8HAmuPzEBbMa+G97t2+PGk6FNBM=
Received: from winn-pc ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 28 Nov 2025 09:46:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3025559261156433474
Date: Fri, 28 Nov 2025 09:46:44 +0800
From: Winston Wen <wentao@uniontech.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, hch@infradead.org,
 hch@lst.de, tytso@mit.edu, willy@infradead.org, jack@suse.cz,
 djwong@kernel.org, josef@toxicpanda.com, sandeen@sandeen.net,
 rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, pali@kernel.org,
 ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com,
 gunho.lee@lge.com
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <85070A96ED55AF8F+20251128094644.060dd48e@winn-pc>
In-Reply-To: <20251127045944.26009-1-linkinjeon@kernel.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
Organization: Uniontech
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: MACXe2l6e7j9622u85/Obf5Ai8b1MnNro+mcGY74dNOssyyffkCHYVQq
	QwykNErNeF+VHQoCqZDwRMzvyplsj+IhiuCFjsn49MvBInyIe0ZISPr81Wv00hlskIRAhLt
	+03HUptcd1aLr2+fLawP625Q3TGjXigYcjNL4r2lJltlI2btGwExFafDTYL5FWPpjhpmYzL
	dG71kugQqJlEv9cRuRSAlP6nikP7Dp6/VF2FGW8OgkeZVp59cd/30rxrZmEBm4LaSdkIF1s
	uDwd5mAKYGe69H11VpWt/PGv8YtDCMH0XFjgvS0CurDu5hUvMl/5c0o7NHG4gJJbk7NiLhM
	Y23GX5QtqLjeLG0aEsy+24HjRkKcbAuoxZUp66TNN/ozLKXOaFdV7ANpNzLOpJntJgdmYfC
	q8+cmZN5zEJbe/M5/g/i+9nvkQkNo+YNPj3iZJI/ybVr3BI/CGOlAuSGa1GVQxyXOo+ratQ
	svYgKSLIQEVykE7KI2V9YqVtIWggrKdbIAyrGLHu/QoDnp8Ab+qDw6URmQZxAHJWVps0EA0
	59PW+1wndNf51fOOwNrUtdLip7VThNrxCHoMRqTLlzQS5CVGJ6p7RLdA5SWgUlBtpucKPkM
	kKNfhRg4/aeP5g9RP9JrHBjHYevh7e49ma4gMAgv6Y0+1K1gFLOuwwmbyc6A9Cp+4OVOLBb
	J2gTD3nS7Mdo/9sxpP1zldGasFZi6tQqwTE+SN+g94hQZwhK+TgxUFHWfRXygeB06R3xsOy
	ZUaaqyneWGHj+fAumedLcsNJ1JbGaWcmxYrPe5CUidixBSWVPV2VB5v0oH55pGRR56Zxckl
	ACPypuAShK78lNYYmbUcrfCSEV6bDQpWG2kzDM57FGSFpI2oR6iwwvjhfPv1eFuSrFZwwMr
	ZdbWdn8hj80YlaMs8hUdRZ50mQjl+b9+oZEy89gsNNgN+aMn9L0vMm1RUfasZ5QVbShaTcB
	4vdYbOsDM8ZKDJGTabNsRUYSqCdhK+b0bUwzTPMIRSd/B/kndcxA0jziC
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Thu, 27 Nov 2025 13:59:33 +0900
Namjae Jeon <linkinjeon@kernel.org> wrote:

Hello Namjae,

Thank you for posting this patchset. We are very interested in the
development of ntfsplus.

In our production environment, we have been relying on the out-of-tree
ntfs-3g driver for NTFS read-write support. However, it comes with
several limitations regarding performance and integration. While we
have been closely monitoring the in-kernel ntfs3 driver, we feel that
features like full journaling support and a robust fsck utility are
critical for our use cases, and we have been waiting for these to
mature.

Given your proven track record with the exfat driver upstreaming and
maintenance, we are confident in the quality and future of this
ntfsplus initiative. We are hopeful that it will address the
long-standing gaps we've observed.

We are eagerly following the progress of ntfsplus. Once it reaches a
stable and feature-complete state=E2=80=94especially with reliable journali=
ng
and fsck=E2=80=94we would seriously consider deploying it to replace ntfs-3=
g in
our production systems.

> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The NTFS filesystem[1] still remains the default filesystem for
> Windows and The well-maintained NTFS driver in the Linux kernel
> enhances interoperability with Windows devices, making it easier for
> Linux users to work with NTFS-formatted drives. Currently, ntfs
> support in Linux was the long-neglected NTFS Classic (read-only),
> which has been removed from the Linux kernel, leaving the poorly
> maintained ntfs3. ntfs3 still has many problems and is poorly
> maintained, so users and distributions are still using the old legacy
> ntfs-3g.
>=20

--=20
Thanks,
Winston


