Return-Path: <linux-fsdevel+bounces-22843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37AF91D762
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 07:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0A9B23461
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 05:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6B6381C4;
	Mon,  1 Jul 2024 05:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HYeQbzVa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39052433D2;
	Mon,  1 Jul 2024 05:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811330; cv=none; b=DLIXegA/9Xbtm2BIyelhGigZx1+rsBO868vHtKTmXFvmsOiPNjzNT7RzdiGURBTnqpOgoOLBH9MLqJlXsP1NHqtm233qN5VC78fw2ugRj2ozNbFE5tI00sK0ucUIfBo4HQODa3AM16eF/fzbXRzY3PhpzTAKsy6CCEL5cfWgFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811330; c=relaxed/simple;
	bh=IMGIXZ6HdrFRPSbcEmA5t2KXTtvIr3dl+wW5RM+jytI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hSDzYhY6WRwgtdQULIQegW2MkmrR1fROJicBO8H4kqM1if2qcTKB+AdV3EzURITv52pA0WxlEyXkt+SXPYo+oa2XmlZr9E3gbJCUhDWH8U3or1KZnq/ZSbwBLUsfOvQncwwoufMhMiClbJOxtnyRUj3uK5+mOZWnx93JKYc2eHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HYeQbzVa; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719811295; x=1720416095; i=markus.elfring@web.de;
	bh=IMGIXZ6HdrFRPSbcEmA5t2KXTtvIr3dl+wW5RM+jytI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HYeQbzVacYIAEj2A0UPV/THk+x4OLgwhDHkd7U3gRfli1Ib3wX0oAhIyUFL26az0
	 ZS0fiPQTUCFgYYs4lSHKtjNWXQrRN2Y4zcFZyT9UrtCy+z//xD1NT7he62dkvEh9a
	 psRHen+/FG/qBeRJ17fsOmXWsdnxBDGSWzLUrNm5gTntVquGuKP84xRbi7jjQMIgy
	 gCHUGTxyL5vcjHMTaDleOrxeswCiM5sVRVS9E93Y+odF+GXuw0jqg26faJN4UYcZM
	 7V9JTRGvpxSM2GXGtksGtb4H+0y7Q0kEc43jHgtDCmij37hf9BwaxRktrDYXDNBoM
	 cuOpWcr9cFcDV9C9GA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwJO-1rpdfs3oec-00ln7o; Mon, 01
 Jul 2024 07:21:34 +0200
Message-ID: <8ced519f-47f2-4a74-be6d-4be5958009ba@web.de>
Date: Mon, 1 Jul 2024 07:21:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [v2 2/5] rosebush: Add new data structure
To: Matthew Wilcox <willy@infradead.org>, kernel-janitors@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Johannes Berg <johannes.berg@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Uladzislau Rezki <urezki@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20240625211803.2750563-3-willy@infradead.org>
 <52d370b2-d82a-4629-918a-128fc7bf7ff8@web.de>
 <ZoIHLiTvNm0IE0CD@casper.infradead.org>
Content-Language: en-GB
In-Reply-To: <ZoIHLiTvNm0IE0CD@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UX+yfozCovUOm1nP0B4sPqw6v0GncWxcDhx/WTSrO86UU6cPV96
 wkrtHU+lntN1gR1IY6k2WV9FajaXj/y36jiqB7AxzUBvVlyO7FLxsIXSV85SBvEZOLWRt5b
 TbUM7ivrT/tiyhmLwKdR3IZBRxeYDBZbBCzf4Uh8Si93d8JyZty4eyWDaUmOjXD6T2HgzOJ
 sTiU0NvL2ntkXCAunRyoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rTh91dUTLFs=;RJyIXwVaTwSFBMHklihzmdWsonH
 L6vlbDQDW2aPB+JXmXF20qa2FpvnEqnxSRbngoZqT/w+V6bEhSzLAq7tjoukGJpDzsWGlaNgZ
 xAIXE3vWJyikUBB7niMyEzU2vLxpczFfA9RQTOmZZJHZiP9Wfsqm+QSnv5EttT3WUQhs/nL6P
 H5AicN/YjQokwYT0ThjYI+Gp+G/H8Os66lxZTuYCjHTAlArAks9NEkmbCkZhjREI/Qjc2TQsC
 YcyBW2iTStwMEdaBfUkZ1DEme2BEMhoZhMR4Z+kes25TipOiBdUq9laPFmimLowdUxoS9xoZV
 iTesXWViE/HrOUyYVn5gyAx3Xcd9k20i2/KBotYlROt6sjtJbEzwmL3qtie128Xd9DWrb9npy
 1I+iQg0oza0z3YFaPWcVF55AIT0RGrnbfbH9PFxc1C0OH4o4WGs3I33UY3p0kJuh1D86bGBQB
 klRBn1asu9p3hiqZrXcaci72V5zznSBnoTU+vdvaB7E5sDQIPfr3DxZyltTB/EVmqQEiSgRH3
 zJr1GF2VAKyz8b3pdedbYjRp1X5Cp95sAwzgV2XC25R5Xx5nomOPfY1q+zY5rHeZTGIA8tmG+
 e/crKXfxY8u1s1hI/fqq45FzpaJOMiICEZ8ZAaRLo00Gv9sydsNMSB4LNZ0pAJZfl4mkvWbG8
 bc5SEG6IRBSP/OLHgMBnO6rY2Pf0F/+herdmrYmcLJdj9xsXCFt+ypNXY8E191V7Ajd/eKOfO
 e8OxI0/iJko6EKN0S/wh4IhGbmqG++WXX79zob6wW8WTnaQwKi4UHITcs5LhF3TvdajkcSHOA
 +ZjJEBCMAHvpBBtX20Hrxy3pjQ7jB6h6uSciJmtVSeHSQ=

>> Under which circumstances would you become interested to apply a statem=
ent
>> like =E2=80=9Cguard(rcu)();=E2=80=9D?
>
> Under no circumstances.

I imagine that further contributors would like to discuss collateral evolu=
tion
also according to the support for applications of scope-based resource man=
agement.
https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/rcupdate.h=
#L1093

See also the commit 80cd613a9ae091dbf52e27a409d58da988ffc8f3 ("rcu:
Mollify sparse with RCU guard") from 2024-04-15.

Regards,
Markus

