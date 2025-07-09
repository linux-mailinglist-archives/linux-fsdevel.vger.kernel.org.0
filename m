Return-Path: <linux-fsdevel+bounces-54339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE01AFE389
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A571C24945
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C418D283151;
	Wed,  9 Jul 2025 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="SkoQt1Ur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57478F36;
	Wed,  9 Jul 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051908; cv=none; b=BlYcayKMcHC7zINgUJ7bJ0ZSXLPP7WvFzzKL7bb4lk1wzQ1yl+w0m4BUwhtbfG8s1Ddfcen7vc6xoTAzWC+scwhgaAKOXAFkUIi9DTpW2CwIylMWJRAgLJ8DAJwb2oGfbQHt7kybm9ddYrlZHFj1iOYDqChc6+giNqd2HoJPf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051908; c=relaxed/simple;
	bh=naos+ztsM462dlUt3nnLFc74Mtmx6bRL1OC1kvlTzF0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=owZ/RRbEAwlb67QX+1zW/GiPe156GeuzIi9V/7ss4+aCPK19vSABKSvYUuH77Iz90JyFeWVT+EhgBuF7za6vdOKtRBUCXOOa+HZhpHHS9RZJctC917NB6GD4U58MGA6/iKNd2N1yupqhgVi/hNPHJnERh0yVBPgOkIu/VIHbMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=SkoQt1Ur; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752051903; x=1752656703; i=quwenruo.btrfs@gmx.com;
	bh=t4+CgnpsKZh4/GcF8WEpqmkQtOZhdGm5Eecfk+/kx7k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SkoQt1UrCmEe/v3R9esyEoQdU8sxEWp6SJo80QeNZC4u6yDUDl3lOBYqbx5Qjo5j
	 5t4pZh8zsq4s5YhrYH7Chfq6p2GXWIY3KiJFXtRFXk7pL/RuOJng2mQvQ8pCq8wgA
	 e+etCUytDi6hgJDxPahTTqEyhescHXpqx3ME2VR/t4A84qlTz71UfKSJIhJcrZu+0
	 tB61PbWdFRaj/NLJ8oFMAIRedZy4fRvF6GOgdiP7DDFZcjtiWh8pvDFWHQht/4dfF
	 dK2EScHuLQObPu1/Q6k3lUwVCYI+h4jb2dzrZtHnIZWn0lgK1MN8D8FzoKzqHjSKD
	 k/wX0O12J448WeR/qQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1vBmQ40N9D-00qDTK; Wed, 09
 Jul 2025 11:05:03 +0200
Message-ID: <5459cd6d-3fdb-4a4e-b5c7-00ef74f17f7d@gmx.com>
Date: Wed, 9 Jul 2025 18:35:00 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 Matthew Wilcox <willy@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Why a lot of fses are using bdev's page cache to do super block
 read/write?
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NMqfGCd5DuW+6E9+fcb0Yb4wonnLM6P8Yb90GJcq5vVAM64T+qp
 /NehyB5mHUqgv/fbohhagjsizuLxEsJ4S6H7MDqfuXL1DDCKjQLMUqbngH6z8O55GfYVl9v
 +RAzhsyNu0fXGtZrNoQoTTx7WKXMW++67YvcuvNONC+VfRg/2gXRJpbbkGWSbevG3fi5pxe
 FsyKfgj2az3dz3WnyyqNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UYaz9elAtTQ=;/zSFRBJ4zDk9KQB7sq8I2uL3poy
 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

Hi,

Recently I'm trying to remove direct bdev's page cache usage from btrfs=20
super block IOs.

And replace it with common bio interface (mostly with bdev_rw_virt()).

However I'm hitting random generic/492 failure where sometimes blkid=20
failed to detect any useful super block signature of btrfs.


This leads more digging, and to my surprise using bdev's page cache to=20
do superblock IOs is not an exception, in fact f2fs is doing exactly the=
=20
same thing.


This makes me wonder:

- Should a fs use bdev's page cache directly?
   I thought a fs shouldn't do this, and bio interface should be
   enough for most if not all cases.

   Or am I wrong in the first place?

- What is keeping fs super block update from racing with user space
   device scan?

   I guess it's the regular page/folio locking of the bdev page cache.
   But that also means, pure bio based IO will always race with buffered
   read of a block device.

- If so, is there any special bio flag to prevent such race?
   So far I am unable to find out such flag.

Thanks,
Qu

