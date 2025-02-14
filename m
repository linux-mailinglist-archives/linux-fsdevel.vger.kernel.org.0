Return-Path: <linux-fsdevel+bounces-41695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707EBA35479
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 03:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B17D1891019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97008151999;
	Fri, 14 Feb 2025 02:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="q5swNu0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE341126BEE;
	Fri, 14 Feb 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739498772; cv=none; b=lkcG4J7fW4Fin6ixwx1HmgqTEpImF9UjRWfiVA2mupeyIJItXw9B5kTJMN4C4p3ZpQKWDKewyegsIK4ViBMYgR0VRzW7MrES40u7s+X7POJ4aOovd4bFsk4LNgatNCrY+KPd6EJit7nrHb9Ykbn9esBbQRmLbhWR1gqbTnaojl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739498772; c=relaxed/simple;
	bh=I5A39rRdIEdif+htKjOHj0m3hqmcStlag2vRHdns/TM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pvCFHYfwyBrCDiQGcu5FYhH3Al6AM8eQ9b421AOFCuZAhTusNHAm1LTFs9xAGsvUGXNy0WWCuQBDEwlmCx+nS1psfSXm/5/9mHIRgJdT5ks0yuM8FYEX/uSxfilahUhDJH7ghxMJXTC8PxdFIY1t8H65oOfZTBJOEHCugt4H8lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=q5swNu0S; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1739498740;
	bh=I5A39rRdIEdif+htKjOHj0m3hqmcStlag2vRHdns/TM=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=q5swNu0SjJ1weNu54dewwq4NSyd+sLRMUiFFGjL7j5gbQ1mZTbB3hzacAtwp8fr8b
	 8N4sLvESymMmmEb2V/Z2jTK+x4TLQ+1PEXkuD3oLxg/zX9yanOcv6/lYWWoPH0glrn
	 Q1x3xsdvv4V10yJMWG/aOuqRKgVS94hbPMULv4oM=
X-QQ-mid: bizesmtp91t1739498736tz94mo8k
X-QQ-Originating-IP: ND9pomjWmHA7BFDTY6/KfICPqiZAgIOklb3boywnPHo=
Received: from smtpclient.apple ( [202.120.235.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Feb 2025 10:05:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5653935482848465832
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
In-Reply-To: <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
Date: Fri, 14 Feb 2025 10:05:23 +0800
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBA1218B-888D-4FB1-A5CF-7B0541B37AA0@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
 <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
 <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
 <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
 <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Occa2ms7+ZuOAcYC/SKwbnMsBiHGI47hYkVT3ruVorr3GGdU9hFLocM5
	2nT16zki2rKFOxKAvoSx4Ohef8U6BCBBDAJo4nd2311MzkwuqUdG8E1QbAaaJVE10IfC7fF
	LHeMF2yC60IqBRxTxFifQHIDlPEGckdNG3yuuVZWgFKqd2/73KYdNmewPuNmBOX9mCAkTLM
	PEYFwlfy+W2dls3uDfKdlbx1GFOSnqJnlfjtLAH8Ipv2dWEQrWYeOdC8hKHu4xx5wrumxA9
	RleHwfWxl1PUufDqgvGiJqj7tDt346fx7qQTzSAV7vT1MhcI1wtt1BHtb8eCZEXH467/srF
	dVhprNAGE7li0iX/FcTdBVrdyXoxBRMFOHJt2k3QVWX+HB0YOQ+2sjWqCKsKIxEfgZOWlaX
	aLS4PPP3F9vqsjR4i2a+ti67ZoJ6vH6YhPeYyzzBg6dXjgWQC9vW5sM1jFNpW6PU6fneprr
	rJLq4Vycyie7heBN59LJVDz9lG9bWu34RsPGQpmlBDXKiGQR590AoJEzQuKaCjOABeqrZbs
	Hvz+OomBEGWAstFJORYraBpVnvJT+f0saGr6UJEEo/YrMb3ArCh+mU3jTdXHyquoyO308Pk
	t1MBtLv9TAN/jE9knFDuxTmb2jgv40PSl/frHbgon/01tgJGl5I9a6SJMrzFvQwgTznUc3V
	Y+Ah/fVtCpGPXcB8tRp9RKsYHg61/VdSszbYBPR1xK8+GOk7A/vkQxomNhzcGftKUPNm5eZ
	OyBGL1j9HI4NW8KJTNSmE3dVJzC6KAgehmkQp6zbJUQUlL+KZJJCJwmlniZaWgXtyWVTous
	9b1bLNJyjFResoOx2MxGLQ47aumYV0UiqkxlU7ejK08lhv3plo20wwGsBOMFWufxH4cp9iI
	cx2esNxXJofg41+2TgVC0JwRpBvc9zXaNAV+YWOHXJYKzESdVD7BnrBF/G3oyHIkj0Er6Py
	yX/f/6dVHOXKo9Kna3bROxv2wIR9D57fp3REuE+cR0WcAdmHTSN1WLnp8H7mazwTAo44=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0


> Can you check an attached patch ?
>=20
>=20
Hi Namjae,

I wanted to follow up as I haven=E2=80=99t yet seen the fix you =
provided, titled =E2=80=9C0001-exfat-fix-infinite-loop.patch,=E2=80=9D =
in the kernel tree. Could you kindly confirm if this resolves the issue =
we=E2=80=99ve been discussing? Additionally, I would greatly appreciate =
it if you could share any updates regarding the resolution of this =
matter.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Thanks=EF=BC=8C
Kun Hu=

