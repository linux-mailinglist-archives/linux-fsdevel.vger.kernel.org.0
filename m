Return-Path: <linux-fsdevel+bounces-39291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DCA12493
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674823A3F68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 13:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2523F27F;
	Wed, 15 Jan 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="tzQcu3/B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12F27726;
	Wed, 15 Jan 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947004; cv=none; b=g7vWuYHSmISWg37DYynRh62FGe0UgdYMudo/7f7KQh+L/I/5fpbe6fahJ4Q0uT3ygzmNllkGOeJjpKdOHw63GOMguaj9qSR/SMxZ1mqWRGfzmhewJH22l2FgwNqdExKvoWaOA9Y4AOYaKNms8rMpYrCZFIXVfVQtb2OQYb5fqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947004; c=relaxed/simple;
	bh=82XhqjygfjZYGe54tpJLFGt9UIHx/TY+i3EBQdaXKOM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AKuT0acQtLP84sVBRzcK3tMNmd/HjUkNkT3vfgdRLWMcmRmwhYpf30u2tj6FhWhj3bzMU0t4R9fRIeoSVf2QLSKCNaFClS7sRpextT00j2tJt/JtEsUKvxAZmyotv2WFgrAaOAeYFiHyFPstJInjTPX+a5fUXqLFlaKM/AtmFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=tzQcu3/B; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736946958;
	bh=82XhqjygfjZYGe54tpJLFGt9UIHx/TY+i3EBQdaXKOM=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=tzQcu3/BQfE4bTxCnSRLey5f3QA4GIMyykRZzhkR/exkPncu7OyxDxPCwxtPyFzlf
	 l9+UwvThBDqNT9fAMhQDFwffnCah8qnSJeHOg+UFJkioswAQ9zToUorrFTo6rAJrqM
	 HZvxlZZN/9GQgss1wnRY68tCwE9fCkEgkI3dTjEM=
X-QQ-mid: bizesmtpip2t1736946952tcubs62
X-QQ-Originating-IP: vwLl+j1iGrwuzOKHztXQkbketxkLJUlAQYwfd47sNOE=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Jan 2025 21:15:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3564918218073159881
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
Date: Wed, 15 Jan 2025 21:15:40 +0800
Cc: sj1557.seo@samsung.com,
 yuezhang.mo@sony.com,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
 <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
 <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MZukwSs1MH20X+WYfya7JRxNpKq6dZHNiMuoAuTtxUsDQKO4cvhZw5jY
	Lg3fy8pMNZWW6jyVF+gbLDFcshrNLZPuoYZPixhbKo26Wo4Idol1LPgQN8sj8Dqq7VsA2SX
	VcOi3p96z/e+JpzCUgwIXimJygaVcx3bVLwHoAuK/30FTqKxUr1PLJjDRTMqB46NZvuf/eg
	cmdpibor5eEsYzDDXVDiSbnNoKk+sA6lCuLvnstHUHNomfwfoXl0gJQPOObnNBwE2AKdgD9
	R9IufiMQqoppIC8nvLHZROl9Db+XkUCljBLT+LoDXU+/16W9QcmObk2NTqUSzz6s//Rkk7n
	8u4PDDjAXMNfDd+p/7NjraGpoqWPzBPyciN3NatRSKX23uDFNLN1UOziwgg2GIKTNOanUPs
	PXGo2Kfan0vBbq4iRy8Io2CKzmIrHut7M7PcaGCg2j9gsRplKn7G68Vk1lilvikjS3AzNCd
	I7XZGSkbGXLAhqBPT5Y3S1Z9dERA2tEErMUy3D/hEFWstk1mivSL4yJ5TF4ZnQ1wQfxv9gL
	/Coo59EnGb7n0pMeBKWUV2PmbjmrkR54LFEwvFyDdDr/tMDzMxB79hvEhNUe9oteUUcXMb5
	HFO0iYn7GKeRj5C5ZnVhoOslWEAhU2PIcqqpHWjg/1n+j04jbYUWpIY8tddEjHK40YvHTeG
	gF0x3Ydvuh5+PwEMYmGVOb9fT95V78maQGopfMWxpWa4g3jl1uQa+D0Ua7Zju1L5yZLaj7J
	hKRelPUSaHEFWvr6jZelC3UJ6dSVfhNH6o5ZIVdL9DZD3tWv0IvQFXBRpjaJdSJxAj1IvkU
	mSmNmba5EIq/O/WrlxCDtfnu6TDuuqO9QByQNwoQ+LBd524DcZuSQHQTqjydUSIrodiztAh
	i3+t/XVvow9t0LnBLYUuiWatB1GI8TDrlSmJu9Q57dhbuQNQbIW1kG8JPQPrO96QvgBeDxn
	sEqB1u2hvyf7LDgzSuzXBzasx6xfqk6PYUq1RppaScGHWVA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0


> This is an already known issue and the relevant patch has been =
applied.
> Please make sure that the following patch is applied to the kernel you =
tested.
>=20
> a5324b3a488d exfat: fix the infinite loop in __exfat_free_cluster()
>=20
> or try to reproduce it with linux-6.13-rc7.

Hi Namjae,

We still successfully reproduced it on the v6.13-rc7. Firstly, I =
apologize for taking up your time, I=E2=80=99m not sure if this is a =
significant issue since from the reproducer it kind of looks like it=E2=80=
=99s caused via fault injection.


The syz_mount_image in the syscall reproducer mounts a randomly =
generated image and also has the potential to trigger an abnormal path =
to the file system. Specifically, the . /file0 file is crafted to =
contain invalid FAT table or bitmap information, it is possible to cause =
abnormal cyclic behavior in __exfat_free_cluster.

Because p_chain->size is artificially constructed, if it has a large =
value, then exfat_clear_bitmap will be called frequently. As the call =
stack shows, the program eventually deadlocks in the loop in =
__exfat_free_cluster.

This link is a link to our crash log in the rc7 kernel tree:

Link: =
https://github.com/pghk13/Kernel-Bug/blob/main/0103_6.13rc5_%E6%9C%AA%E6%8=
A%A5%E5%91%8A/%E6%9C%89%E7%9B%B8%E4%BC%BC%E6%A3%80%E7%B4%A2%E8%AE%B0%E5%BD=
%95/39-BUG_%20soft%20lockup%20in%20sys_unlink/crashlog0115_rc7.txt

As I said earlier, I'm still consistently reporting the crash I found to =
you guys now because I'm not sure if this issue is useful to you. If it =
is not useful, please ignore it. I hope it doesn't take up too much of =
your time.

=E2=80=94=E2=80=94=E2=80=94
Kun Hu



