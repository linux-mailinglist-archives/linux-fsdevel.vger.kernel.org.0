Return-Path: <linux-fsdevel+bounces-52476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56103AE34CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 07:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56FC188EAE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 05:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E041C84CD;
	Mon, 23 Jun 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dnb3T78r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D56187FEC;
	Mon, 23 Jun 2025 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750656913; cv=none; b=Zhv/owr6/U99pNIRktbiKx2Ez4+aVMcg+qpp8J6LgGMdxWsOLn0AoRo7gJHzXY0ukwSQYQoohmwFKZ80LCiP/ZegomynTkq8xBe/SBLgJ4lND/CQ1vfsGT6sZp8flN+qSQ779FlpgA535EHwmGNMzJpGsPKUkPH6fSgAyuHuPSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750656913; c=relaxed/simple;
	bh=pqb5W54VQ7RGht3XVkgccw2KsKsBrFrTMKUWyfLiDhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEXB0qQyj5paN5d68vMAWqCWS+JDEFI48zIzBWgWnCYW58jkZubcLMHQ6PO38J/MuDOatuiTPT7lIBXvHvJzHMQjZFtKEZsz3Ny6A0i1F8RyErmRqouXverx0Vapsbum/ebvEHDh4E5cwRGq7GiW4SNTT17zoE790Y44ysR8nHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dnb3T78r; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750656898; x=1751261698; i=quwenruo.btrfs@gmx.com;
	bh=7YTlshQ2gCmIGsHFUVFSCd34bvKabICD+/kFnyh8IIY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dnb3T78rpHUT6IZhdHAtcmmmx4Cy10oVD/ThI2sHnFIbxE0UxyhRDD8iy5Wq9O5l
	 OXLAGPUXotL9/MmZ4YpdRdky/Nz7Zsmmm36yCh+Qt81mQ2jEud9zwLJU7MJLFMVHn
	 bzh8BedT4T0sQ4GaGyqfNmiKIUXDY3n7E5w9IhrAYzd7ZVJOSPSUn9V0vS+wNmheY
	 T2OvvzA2V73gw5qdu1yw7aqOW581B/V4DSnx5i4Nsyo9wjSaPli+ybRyIR+Oox8YI
	 WCrsh+nhRJ+vS7hLRV2eTuP2OYQ2SlVegZuquMslGYY4jFarMp7H0UOcHp++Vnk3M
	 LJDB9kwdho2e9khz9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63RQ-1unA1x1hou-00yaT1; Mon, 23
 Jun 2025 07:34:57 +0200
Message-ID: <1882d73e-b287-4c73-abcf-52e10b43edea@gmx.com>
Date: Mon, 23 Jun 2025 15:04:51 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: introduce a shutdown_bdev super block
 operation
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
References: <cover.1750397889.git.wqu@suse.com>
 <ef624790b57b76be25720e4a8021d7f5f03166cb.1750397889.git.wqu@suse.com>
 <wmvb4bnsz5bafoyu5mp33csjk4bcs63jemzi2cuqjzfy3rwogw@4t6fizv5ypna>
 <aFji5yfAvEeuwvXF@infradead.org>
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
In-Reply-To: <aFji5yfAvEeuwvXF@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sotkFt4E5KFSia9dvfxTIQxcHOzsr6+8xabPOpZ048/WBp96uVI
 re4TLaisOLeXJRX+EwJsM8aKC+PqoxgvbYCwx8KAkUup5oGVwco6e2j9amnRc5Bwo4YPCe0
 tdiRn8wxPmD6lZFBU2/DCmvjDl6cNCMf+wmNbs6dnCICoglLoN2CUwB3hT9PouyvHtC/1Wi
 VlkE/LiqwSjLvZw0EdSyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ddTYm4EhR4I=;qW3Y9hFpfxLN1BHXlSmMB6qgxyX
 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
 hW6VUGVd6G1csNyf



=E5=9C=A8 2025/6/23 14:45, Christoph Hellwig =E5=86=99=E9=81=93:
> On Fri, Jun 20, 2025 at 05:36:52PM +0200, Jan Kara wrote:
>> On Fri 20-06-25 15:17:28, Qu Wenruo wrote:
>>> Currently we already have the super_operations::shutdown() callback,
>>> which is called when the block device of a filesystem is marked dead.
>>>
>>> However this is mostly for single(ish) block device filesystems.
>>>
>>> For multi-device filesystems, they may afford a missing device, thus m=
ay
>>> continue work without fully shutdown the filesystem.
>>>
>>> So add a new super_operation::shutdown_bdev() callback, for mutli-devi=
ce
>>> filesystems like btrfs and bcachefs.
>>>
>>> For now the only user is fs_holder_ops::mark_dead(), which will call
>>> shutdown_bdev() if supported.
>>> If not supported then fallback to the original shutdown() callback.
>>>
>>> Btrfs is going to add the usage of shutdown_bdev() soon.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>
>> Thanks for the patch. I think that we could actually add 'bdev' that
>> triggered shutdown among arguments ->shutdown takes instead of introduc=
ing
>> a new handler.
>=20
> I don't really think that's a good idea as-is.  The current ->shutdown
> callback is called ->shutdown because it is expected to shut the file
> system down.  That's why I suggested to Qu to add a new devloss callback=
,
> to describe that a device is lost.  In a file system with built-in
> redundancy that is not a shutdown.  So Qu, please add a devloss
> callback.  And maybe if we have no other good use for the shutdown
> callback we can remove it in favor of the devloss one.  But having
> something named shutdown take the block device and not always shutting
> the file system down is highly confusing.

OK, I got the point of the name "devloss" now, didn't notice the naming=20
itself is important at that timing.

And in fact a new callback is much easier on me, no need to modify the=20
code of other fses.

@Jan, would this be acceptable for a new devloss() callback instead?

Thanks,
Qu

