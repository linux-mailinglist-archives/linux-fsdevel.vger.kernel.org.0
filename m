Return-Path: <linux-fsdevel+bounces-66426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3303EC1E9B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 07:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F67422144
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 06:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4454932E68D;
	Thu, 30 Oct 2025 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="a3ExQIdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B632D450;
	Thu, 30 Oct 2025 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761806278; cv=none; b=eCUVin9/4YnijDQRzoGORar89pRxe+hdgOfmJYftaY87ojXS8+Jr0LvxNZBGo26uV6KULP4ky378xzD/zGJYII4lRC5JDE59OozOdFdWHyQxI8Ri77rFwzLUWvqJl5J2J7ZZmMUr1KDQ7zDFPEzchzuXdqUB0xhaX+UIFnrSQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761806278; c=relaxed/simple;
	bh=B7rg0Q92wgbEQhUX9lZDvvqeWMD2GWCRxOwQw/mGgwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/OKOqj+AadvIYc9CFjX9tB2dnNbnV6hkCvU8zpvEOrvj9OPFcxdBigS4iG5AeMDXWdKdzN4F6XaiFy3EZuocPM1YNasnG19SQBVHOgtrP9xMEmGlCMKxUQxelyOEi+kAyBaPUOPeK5JUze2iOqjdfqJ6J2c7I33R3msnEhE7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=a3ExQIdp; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1761806272; x=1762411072; i=quwenruo.btrfs@gmx.com;
	bh=B7rg0Q92wgbEQhUX9lZDvvqeWMD2GWCRxOwQw/mGgwo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=a3ExQIdpT66CeKAVKMvFMH2YMo27rGBpT9dP6jvPtlW8lxjLLWqkkOg2QjYnSl5U
	 znTdn5czAbo1JxnCnoM4GqAL6m7rLbs6hI0bil7HpUMCsLqJxXZgicE8UGmosXTU7
	 s5vCH6au2Vz3IUpijQ+VRf8H4qGlU8cRCSVdTnq+mbBIICe3XljbSuOT74zDAQwBk
	 GUhSxHgAaylFwE0JW2lhQw0VQsTkyaYwYt/5e+vFJZkR4RVh2D3ER0NxaM5siLs4a
	 ywtOABJg1PNS8Ldb0VqGB2WRLJQrLIrJ27lb9vHp7fMu3I9sioepzA7rAJp/Ga/Th
	 Qu5ydZQhDC6rojs+yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M4axq-1vEtzN1ZV0-006fWp; Thu, 30
 Oct 2025 07:37:51 +0100
Message-ID: <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com>
Date: Thu, 30 Oct 2025 17:07:44 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de>
 <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
 <20251030055851.GA12703@lst.de>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20251030055851.GA12703@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qUU+cjd5CfDRYqLxm3mbuDFdfbrbbboiMPcIjo79WCImhvDHyc3
 6oJWqKe1HaeXJ0rxK1oZ7l36zVzXaIfodEtTPOK/syojdyRvu797z+CuJlsV0o+v4RmAjKR
 Tx7ofiVf4YH3Su6OoEntwBMTYoVwgxeZk2aKFyIakZnQJ8Z8yy0cpiVJVQ5gMSPVCpiZVxP
 wCgmB/KC2rxAxQTyYJJDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q5AABkRtplU=;Mt1yAnbWc+Dq9VpCi5+OhOg6Ggs
 iLwto0cp63q5MG0gKkkJMB4CnHPWKxGlEYZO/I7qXglTbzSU1VczyJCMtUMJXJeWAwReH21b0
 pnF4snlTAfq3/i4/3wiLrdhajaDkQXARD/SRVrI9PCfuw7YurLXgLkk6CGlGdGTnj6YH6RVl7
 4CTBG48gk9wTHWz3u/15GZuNWWsamjbVjbJzAMxXYKVKfD6fu4KcDalLs+XlLiopyOEaCP8dB
 WI2v5dbUzFnmeZp32Ovc3pUPx9mRQd7zx2uc1Tx+EXWaYooLl2vKGwhY/QkUQA5dckZh44T4A
 j+SRVZy7tORPb+Pf5YwSRldnGajsJanVvSxBH3RfXwyEx5jdM8SmTp1FmzTTNBql5b+m8xmo0
 8NkaIWjStUwgsYHgyJNlx5AIuH4SHbqzRMr9mFqArowGF8VIB1nMOgLUkf6rdpzDW1O16DK6I
 +f2QqpJv8MKtzOLJD+z+PpqbqZzrl5mhuNlA3bTGm3GS/JHhb/7rdQpEfNW/WUI8qfOYXCytD
 3ll/37Hy59x8oqncpByLjdBwFZh4aVF8UAvziKcD7cNgTyq5uzH9AzgibCoguj6uu+/qaPDNk
 jq2EnbEgynDtwUdUgK7jbuqHRYmXpnpzfGFDt+IQo5ELfR9Xy0kAbd8yuYUzk7RWrR1TXQC/I
 9p+eToSBHbJNx6vAuQSq6FCbcRRahlpSxl7NHqzq28Fh2Uleci13Ct6rNlOeclHOVlknODpbT
 pBEq+nhpgtQi6W4bpdMEfCmtJEOR2HMQpzXd9T/61pa6YRBreM59I8RO0uuN4Xf6sPhlqVIgO
 Gw3uiqk6G/n5fwrZoUeAIEMKPMWp+7Mamx/atjJsyH1sjX6OZtl9CZ1RcJcs+eaKyPXy4PH85
 EBcnFjtaKczCGbTZtAMq0H1d3iFiIQpFJdxKifVxUi3sjwpyN26wIQTUU8i08azkmVz2MkCHJ
 GQuVgYf02gD4ANJuNxu7BEj0A5O1jwGhu9l25PVctGk6NoI4zNXYKsc7AP4HYL0l3eLEFHAFf
 fa0OveXShHPsywfJGiX6lp/7a0bsoZLPACVvm7VL0QeK5Q9WiQ1x+dK/vtONYjZX48SsbNCM2
 Qfaos6j3fo0lVKE1qzWxC2DCo8Ygfg8YkOulbM3IAbW6MNRGnTSkG8c8nVpwApSaXxBhiUe1l
 GWS+d3solFH8o9Txxu5V5U4Jr/6xYfdjiLRVtBmayhYZpG5c8sQYUt5JEr+Fnpts8nUZWyq7k
 67WzIrjUfE7N2o4kEHoOgrBCMdJTLP601bxzI049dvscf4tQlsccU0spm7XHnr3C4vRBLNegs
 YGVRf4GqjI2Y3FOt9yiX6afOzJgQ5BThR0jmVmT/0zE3N/w8X7K31FtyMX/XVl58YGgSiOsrD
 bX731CR4QHAj8jWDVhvupZncJQjivPG0giwB1UF4DjpF0nYggvNjpZWSPoJmvdkzOZ/WdcrS4
 CpQLQAvQQ1bAGQ0k9yD29uJ6bVmaoK5lmc29DDUKSTNUprJPb6qBs2USr9HdK9GvjgNjPog7O
 Bm/xt0nkGvfHAzRcSCJe/ijhJm9nEP+8Yeu9iSvhvzoPVuwNCGYU2/wQpBDWynBxGCwNpekKV
 o2s7EbJLOEYCh3uiO4urC0llzA36fGAfHRLJ8f4zN2N1JoiAjIUG5n2d6ZW5Dh7GZrnMDqKGS
 RWEqyiWD3xrz6FLnQnq+G2aYYZ9isXqOnQ6KKjVi2EB+nB8o7yizJqQN4Ubh0DQOgo7z5zx8l
 afVvzugOOtGZVcATVjnpmGpEfWSLZ7m39AjZ92cjarsc9NiBY9/76eNe1un1Eu5ZRZBth+r0L
 fSyYl0jdVNhtUItIduigAxx39J1sfPIe8Y8Ox0+gxHET3b41aH3VVxGbYcf3RIpH3qy1bE2J8
 vpauLgT/QJJ/3hJdNAMFztL8FYhPcxm9MFvFkiaYc05kzmEEOiQ3XRGFYxOF9afHxD1K+zZfK
 LJBzqHKsUIwnjE7jAeAxcP/aFSJxXMATRz/TsptCyxddt/LSeeJ7thudVwpogH88qXxZMyy6A
 QylXP0twfWidBpu8mUmzxQOoytg2C5Uj1v3EH1pcl7UuMjBcNkQwSz3avTSIp5ozMHxN01vTt
 rhnBj8SvN98soJ1bDeqX9uzmHxIPjUzfJRgABAM5ExXy+RezUcOQ6N1qAyQdZbaUz558w9Ftm
 rhz8zrXB7w3rQzoZ4XIPCqNgSRXvthSNEArZs0A7oPx6U1/BJ7gyhIycbKs/dUxt0Dgd3ixjJ
 a1om84Q5S+NXzaanvtUw5HKl7XDwMGjaWlwhLroDDJwlYVjx5V2bLB4reTI1itQIYYFvyBRdg
 a+lHBnHiuIRd6owD0Pywe4+XtE6ViYVP1QR+PvN322rq6E25uIfqyGalM6uL6X6Zmcgak9lyX
 k06vr7baAcikr3Df1FPmc0cM5exBDMcb8GdbE7KcarLgpb5vTHzRxG2jYJ1OGVJuoLbaEEllV
 fcVXW1PcUsqalpY6jVxVq3fEjWVuRWiNUSP6C7SSggt+x6TVXG1VA9ewc/nSzl/508Gf9omKy
 n8NEzgyIGe91Jq+K2mdvE7/GCN6ECJ6jUzyz4sgcl2vVw6WzFHA4BgS4jF35PeTdK2iC9FoQ/
 ap5jqcY62czjDXt97t1geppFAID9XZsdQa6gipK3ncotuyE9aDuwZrepR4dWFbF4IJyeohSIk
 iEM623ScNjn2r29MCZJABHG51rR0CEq98upWr3vYGdr5zehkqFYzFsuW7OO7Y3dlhtDSKLx0q
 03tT2f+dAuwe1Ucjoz0sktI7DOeBNtyrYuAn2FqFaf27T06GuKuUgppBuA5yj6zKEe919nIlH
 GAebPY6mkVG9kDhceQa9cnL3NM/fgJGvFdkCZL4gAGzRkC/KHjgjdqWnQYe8YxM8xgQ5vvfFd
 n62SW18pSajlfskXvjceRFxiDq7Q27Ovttw6WXCNjST/H0Swv0PLwNNHhukcIS6UctxgMG8MT
 BiIIAPl6oRHI9qb0hosq971phSU2arhX+7bApqEQi2KNzfTefwP0M6HONd0uWsfzxRfIq1l5f
 N3LpshCydlwUUfKoLch+rNhJmuV3DUB9P3yICmCIAJjziBH6qHh12Jy1W2A4uS+hRnPXVu/8P
 oAGeEmX3y3dfN4LD3JqidyujN0JNhXaClMVMin8/jEDq6IzJlRabCRipaoWkaEni8Y/cKLPU3
 si76y7d9VABLmBU5oX+V5Knyd8AvbbGNyWrj+RumVM5Mb8UajSoN6SlUSt2e6hqdimyUQJq8X
 pnd7PNXvU4TBpRHukB01oJfa76COflKTpW+qQgJJByQpeiYpK8kSewZjSgFY/n9iO/56UkcAi
 2scILdtY6J79a0oadKJaVguCzGId/xaHjzVQv7xFc5HCpWmg2Luij4W51y03Y7eHhdXVMY72k
 fYsYuHZ9ZX5l/SbFDnG4qRxiaUk/IO4nX9Weikw4GSbW0KLjZVox7LlTR3zLFQw4o1ZSKRRXH
 WPbYba26VrAXqbGzUXdWUHLABz5eNo1NY8IE0C1K2eX47+0RFmHRZXj2/aC++LXkJmN/kivar
 Tl0axJ5bvsWnmef33SBCFJLDXqg2333SHRfOxcfsEVBAg9hMPF6nQxFyE5d2He8vwIBNV1S+t
 sJ72mUAs9GDxiI2+h/4anpq7OWN6TcFN3rn1rQeLlEXXVIHSoWavYo3CExpP2ckpcwz5qcNfh
 2GAPk7+tK/wAm0TEZQ8VRDKu1hIVMzMbGPLFyE2sxujCnRW0eowst1MHbr1ZhIlN2Ad+SW0/U
 E7IcrnBvUC7290dzUukntvihPdkE73/EclxlZ/FdF9M7ZaUWwOsa9EpNJ9nGN32M+kJna9zGN
 Ok9UvTFkZzoIwZjgDW4ApBrIqIhuYiVmGd6ek1SUK1n8lWdROtLjkX32ln/8tRn8MB+HxLFXS
 tcZ2lGD0VpYo/NmIIKg4mK5dWJKVnNytCJrAj+iLsIpmbUekXz5y3ykLhCWrVC/4ASSidIEKO
 cMqj24KwInDAdnMnmQ4FhQViwGYTcxUnmynPTlM5yVWepst87uOhxad2qpiDQKp8eDftBHerf
 MFXTwzWzgy6SmRjyJhUC6zjtkoSsbf6Dl1WpwhnzFPo6GkDJxYszB+3fKydqbM+4HSY9DTYta
 eB685j2pdeo1wszM4JlHJfyzkfACLqjcssZxJpaYWVqHu0KMSnrkphTqpcs31mMMcRS+8b9NH
 FgRjijfqlUwehFAtzEsDEg5VKs95bH4iNxMFhMv1IDfMJbuJx0PNaleTwiRuh5aM7PhBF+I9M
 B5xmOqMKEogbQ1ubx59SzJ127d6pScvRCq4eURSb8exXT8dgFrnWZ3690SS2rTyh7tdHnEpA8
 5PyJz46ZL0Z5Nw0oheX/eNnrdiwtksKUpGiMvBveRYcZ4/v2njV0gVgLpC1t51aVTIdSq2p+a
 cx2WzQwZFHYIJSwyuI+O7KvRvwKh8wkoEStApF3O9TUWQlwHg26RKjGkDf76U+yJWcVr6WeO+
 /QER0nLFY67mNyiW7JAG5nVpUf3kI3waSRJp9MQ/m38WptBfJxnL60oTISZlX8L/veknhzuZB
 fk3YLHRosOnCOR77FJA0UnYFjdnL160JPx0IUWphJ6nWJ+Jb+CQrPpksN/i1nXiLLpmQMoLd5
 QSl6NBnlb8ghJ9iuBvimJar+ZIXw8Ut+65wFpOkm3yCL0BRonJXtobIn5FvLZQpPdeWCPgtS1
 h8zAlghdVAE4tss76LTAU8OvhraDdwKZ4+3H7M0Mrd7mKq1tk6JQSMiFYOE3AqHZAUGIdhn0p
 i5o3scBDNDdM5VotO7tLtA+wGuDgxncXMmvKdo/mbe1C+tNEbHVYBavBkcc9qfxv/VCU4Begt
 ITX4mBORW0eBSFnJco7s4HxVMFtrmwstlwY867pjbvD/7EAr9/hMZbGBjDbLZw9gQ0bByz3km
 cfIWHRJXwtjvBgORVpbbPfxIRfA/EpnfPW842PJXD1Jy/gUDcobNlOEHvqnzMkv5N3qTJjyHg
 dV2cv4oxSeE77hpQMb7sn1eOjepd9OuZIxZaQ+r6bMJFTCTLYh5gU6dk85bV2K5mM3RL698/e
 IvQTWYmeMI9wfzkXTYurDoereSv3iyAHt+J5JqllizhK2OP



=E5=9C=A8 2025/10/30 16:28, Christoph Hellwig =E5=86=99=E9=81=93:
[...]
>> It will be much straightforward if there is some flag allowing us to re=
turn
>> error directly if true zero-copy direct IO can not be executed.
>=20
> I don't really understand this part.

I mean some open flag like O_DIRECT_NO_FALLBACK, then we can directly=20
reutrn -ENOBLK without falling back to buffered IO (and no need to=20
bother the warning of falling back).

This will provide the most accurate, true zero-copy for those programs=20
that really require zero-copy.

And we won't need to bother falling back to buffered IO, it will be=20
something for the user space to bother.

Thanks,
Qu

