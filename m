Return-Path: <linux-fsdevel+bounces-41778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254CA36E47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 13:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18C8D18942B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Feb 2025 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913A1C6FF3;
	Sat, 15 Feb 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="cnZI0DCY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087B23BB;
	Sat, 15 Feb 2025 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739624390; cv=none; b=RS/sv8khdswtp7hL9cnLuqU8MU3HCk3BSTTzb/4AV3jDn/m67Z+9v36NwPilrkovCJMVVHDVhdwgAEXRDkwCz1CqiKtVMHy2bVlOX6Lm5yr555l6J79TNVIV9zVcJNyMQxBAnVSFVCCUHhlEXC7CniEugg1fCtLtnJnE2BHEE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739624390; c=relaxed/simple;
	bh=8jQAb/dYuoUScJoKwj2GKJdNAULQX5Y+wNeOURHJANs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rUVZ/7HA6D+Rr2mTMfFAGKDOg3JjzgTeLsY25QgkAR5vt0x8I6V8fjtVNhntHhrTOyGiFBwGUTE60i11yf79X/wq5PfOc+UBFmntqPkmOyoMgSGXtrenv9tpDZlFp35UPNapRBZz3ve0XnXrj2G6DtMx/saAqQ5GexvzTfVH93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=cnZI0DCY; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1739624340;
	bh=8jQAb/dYuoUScJoKwj2GKJdNAULQX5Y+wNeOURHJANs=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=cnZI0DCYAghlShLEPVptANHOV27CLqKQlh0HBWHVfVHa16z+scReRl5PHP6wEMcLJ
	 LhoJzEZxFNEydjAn6AH2tMG4RsjAIfayKHwi+EecA/lbEO9cuYyDXwcJEV4+cN/uCR
	 eOSlPShrpz15dornjRf6ofvtvhD9YR/Iofs5yuJ0=
X-QQ-mid: bizesmtpip2t1739624336tov8wgm
X-QQ-Originating-IP: wBmH7GpDkqmHc20Gc6BCNXbWq1Le3PuTW+x/Q6ZSN9M=
Received: from smtpclient.apple ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 15 Feb 2025 20:58:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2358419826102758231
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
In-Reply-To: <CAKYAXd8iNRT+Ff817QTrP-5BERiORx5DcwVzW8wJGbtupcxzKQ@mail.gmail.com>
Date: Sat, 15 Feb 2025 20:58:43 +0800
Cc: "Yuezhang.Mo" <Yuezhang.Mo@sony.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9267F80E-138A-4707-A3C4-637892DD2828@m.fudan.edu.cn>
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn>
 <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
 <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
 <C2EE930A-5B60-4DB7-861A-3CE836560E94@m.fudan.edu.cn>
 <CAKYAXd-6d2LCWJQkuc8=EdJbHi=gea=orvm_BmXTMXaQ2w8AHg@mail.gmail.com>
 <79CFA11A-DD34-46B4-8425-74B933ADF447@m.fudan.edu.cn>
 <CAKYAXd_ebG4L_mRwCqoGgt9kQ6BxcCf6M5UUJ1djnbMkBLUbgg@mail.gmail.com>
 <CBA1218B-888D-4FB1-A5CF-7B0541B37AA0@m.fudan.edu.cn>
 <CAKYAXd8iNRT+Ff817QTrP-5BERiORx5DcwVzW8wJGbtupcxzKQ@mail.gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQEcVJ+S+3/DTVz/oBBTlZOOuuIDp2T4Sg8vYkztIAckbqiQx1fGPvjr
	hModZazeQtVcCMF4vodjNxGec/fanxHyMy33/o402oAGVX4ey9DTj1Nf/mfPfGibAXZ2Kem
	c0vb7CjDjUPbtd6svyTnMQ4wcbJSZN85g09Y3/44IHp2fc5Pi2oYTKuNq+FPv64OapcSXGZ
	UYRYHUsWrtQ0dZGrUU+8kcJ8rKYH6rr6cpIFrCHC1kVJh3WalcYQejcXfC434AWIIBKebEe
	B5I5zaiqvgqeU96AM32Nm+idD9cOnnyQAeEvNkhWCjmPkV999hZ4poipc2wS3DsgZlBMvBF
	F4YPh9xXdP11lPmyWiWl6TGs7YfGTizPsEgPtHweEfoMI1b/Zh9hFCkEN3HysTKDHp9NSp6
	G986jNJkFcoYMTQKCp6ewn0hGErV3WZvlALTpIRAnQ1Cle8gI3D9PSPaxeHCY+mB/4+bojh
	sGO2uGaaak6t7khEX7alSj2jn+KUd8nBvsb2yqu6GN0BfmSic2w+A7JIw+0R+4d355sKuwb
	l5UhnVCohEY9I0LHIduJOAvrkrgpi0Z4YgQyvjIgIRpzgDrFDT69TPfeRpiTrW0Dl/0Jw4w
	7pVjhFAHWbkziYSz8/zMwJBT9iFKoTkGXNjck7LcphezA/61kBVsP5koV5X6E8ovmSvpBZJ
	phZvNv1wnpxZVrlEChUnAuXWzdnIikMMVKiOXxYCTuTt5S8L7tKH9eCNZk4PimPmv7BG2Lp
	YdxZSUoUtpzhd+UATz/tPIqsvGgrwA6PT2ykfXC8sUnNkW+f3Gt0LlrS2oxOEXW3+45vjH/
	1f20/gxZQ96LkNm1y3bBLBw1S8PJuhrsxHG90OMwG+o/WQvGYdouCNIyQ8lB7w1Nr+z4y3Y
	eoGUfcsC9OBWDjIvkHoGPZqgSBYjrk2gn8e+ua2W1FnaLj+TkzOPZsX9NLxfxfTPpEcHurm
	2DVD918jxIaAwUDL6bDeo+8i1YL7OGbfBqx4Art9QTJRtNO31Zc6qLq1HJ8VAg5jly6/JFf
	IkCuo02QwpF4LFN8/X75wAPt0A5bM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0


> The patch for this issue is in the exFAT dev queue. Additionally, I am
> waiting for a performance improvement patch from Yuezhang. I plan to
> send a PR along with that patch.
>=20
>=20

It=E2=80=99s great! Thanks for your time!

=E2=80=94=E2=80=94=E2=80=94=E2=80=94
Kun=

