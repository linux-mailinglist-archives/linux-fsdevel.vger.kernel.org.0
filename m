Return-Path: <linux-fsdevel+bounces-66859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D7531C2E0F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 21:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9777A34823B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 20:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29822C11EA;
	Mon,  3 Nov 2025 20:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="nbQwCV+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E074F147C9B;
	Mon,  3 Nov 2025 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762202828; cv=none; b=mpqMuZpw0CbwODMUy6EL+x385VEyk/MnvKsqR7WukdOhd/7pH6YmNJCB3ZPZtIC7KDBOuf+jNV5wVMV9VZpi5objm5Fy1/MOT7YPHgyWcifHs8iVzGggtOO1OJ//scaOL5yY7z+K2HXd78caEOR7pEF+o5v/MVeulxT11ASMW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762202828; c=relaxed/simple;
	bh=V+VBSE++JDI8Cf+5Seq50uryUZNwPTyezVB/oX13llU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iKiWd1tgmiJ+GZBp3HM/Y59nrELuK4e204EkRII4dicR9yPJ0brLcy4mg++/hQQbv9JKQV+VWrhmh2hDOVOACa5kuyFWPZO6z43tmZycjQTjSeiA72vg9F9/qlO9tiQ72BgQ+W+PmalnYp07I/c7TUFGd5mmuhfDF6n68qw8gms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=nbQwCV+r; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762202818; x=1762807618; i=quwenruo.btrfs@gmx.com;
	bh=skRrPF1XL46YafwaYy6dY+UYgcBaCZtmKL5EbviFXLQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nbQwCV+rC7THUf4+WP9peMSZRCHD3kn7rXoX8osOaQqeOQKjYWJpMFsbR3j+44fH
	 gGIw3AI+YRuQxLBOk9E9LRA0UMnDs2d5n4B3R6C8V2TwZutAfJlPiut+q1pm2dHA8
	 z8GyaHDSNCCGXaXE/zBmBctSmVePsmH/ufSVK7cESyYBEiJgQ1WMwUdQ+cw/jCkkv
	 kAP4Heo7aZ2EluHYtVPWQPRnNlGHzUi9AIYUr3HkNWH8B7LPR3276TcLN/jOJOuH1
	 T2jS8DUpsj+ZRSnjbxHGe9c9XxaT1Gwk6FT/85kBoOukp03PKHYaOby2K4OZuuczk
	 NCdxXYl+ehpepQ4WuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MStCY-1vfypz3RXS-00TUF8; Mon, 03
 Nov 2025 21:46:58 +0100
Message-ID: <5f7590e5-1c18-4e48-a643-c0ab1350c6a7@gmx.com>
Date: Tue, 4 Nov 2025 07:16:53 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] fs: fully sync all fses even for an emergency
 sync
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 Askar Safin <safinaskar@gmail.com>
References: <cover.1762142636.git.wqu@suse.com>
 <7b7fd40c5fe440b633b6c0c741d96ce93eb5a89a.1762142636.git.wqu@suse.com>
 <aQiYZqX5aGn-FW56@infradead.org> <aQiaXVkz1QYkMsWA@infradead.org>
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
In-Reply-To: <aQiaXVkz1QYkMsWA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wxBPBudUmHfZ+k9uc3yQmx8KMOHVJU5Ai09qyz24IoanPduL8TP
 Y8Fv7ZbZAzng7aV7Xj5OiCmyJ/3+3MgjGTMr4Q/BLbs971VF8pZkpqbNS/9JHjFr4nOoGnZ
 +udbqn49MCVDEEOJVdJ2gDU3oGqUaWpRpKUEv0efxOavxgdw9NiHvjJhxRH9To98XbgmTtF
 sWwayvYC8zNdRwmS68kXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+wTi5eiGj+U=;JYoOP7ozz9SRUhENVUM4zVOVnKW
 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
 WOwJydg303+1qrltcSqTHx6TTBScv4aUl2c=



=E5=9C=A8 2025/11/3 22:34, Christoph Hellwig =E5=86=99=E9=81=93:
> Forgot to add, but I think the main issue here is that btrfs clears the
> writeback flag on the folio before commiting the metadata for the
> writeback.

During my debug runs, the metadata are properly written back to storage,=
=20
during the sync_inodes_one_sb() calls.

So that doesn't seem to be the problem.

>  I tried to fix this a few years ago, and IIRC Josef tried
> again a few month ago.  If that is fixed, even a non-blocking writeback
> will commit all the updates it actually kicked off, just like for other
> file systems. (It will also sort out all kinds of annoying locking
> issues)

The problem is still there, even if all new metadata are committed, the=20
super block is still not, thus after a power loss we are still seeing=20
the old metadata, not the newer ones.

Thanks,
Qu

