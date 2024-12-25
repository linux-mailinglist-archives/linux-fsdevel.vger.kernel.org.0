Return-Path: <linux-fsdevel+bounces-38125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1269FC60F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 17:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABAA188362A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C2C190486;
	Wed, 25 Dec 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Ro9tOIV6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99907256D;
	Wed, 25 Dec 2024 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735144457; cv=none; b=DAzVg9FN3ZErCdOkwGheLEQ9rhqmOT/GaAYVSPJDAbkIGOnm79/jlvzuR/Nadm+oPmo3v8JNGp3mpmhkHsngSbd6myTfw1WRlf6g1+zbbHcYFvgwaf6ZhLvnO6tY2KNtdtXjn5mefzTvPxZU303FNB6moqOjdDaPfhrGSlswjH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735144457; c=relaxed/simple;
	bh=Dnys7ZVUzOtHvtiFH+372P5/wEX3fXv/9pa6/QM5b7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFv8Qc4TjG+DczdtZS1lf1eDX5dR7nF0UmdVT7hKUj2zdC9UGSzRR+cX2ZvOiQLrQGeNUPZw4m/v8OGSa07baKB8YGH4k7gzbVzvswoo8MHOr2ak0FOGojUrglD4A65D6GP/RL2sNRfWNaryHpQpIv1O2q3zHAoV83IHGkLLQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Ro9tOIV6; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735144371;
	bh=Dnys7ZVUzOtHvtiFH+372P5/wEX3fXv/9pa6/QM5b7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ro9tOIV64G8VyVCOZvhjTKwlCvXhRtfsKrWncDze5ZUdlx7fF08L5ybpF3fiteWd5
	 H7EQaK4WkPieT4q7E065zOgEoKW/gZfg50BtMRXXe4aE4MbW79cjT8RG/EGjydwl9S
	 T6tjJYhkRwpG+cVyokyww/+7JvFHYSh/Z2FK2JXo=
X-QQ-mid: bizesmtpip3t1735144362tvzn72c
X-QQ-Originating-IP: vitl/tlWRAEBxEhvqBXxikQXMXxpKjWHPTvIwMQykU8=
Received: from [IPV6:240e:36c:db8:f700:b213:b0 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Dec 2024 00:32:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18155974535894652939
Message-ID: <9B33A2E79ADF512B+c7748c58-9b1c-4759-8131-1007c08e9f46@uniontech.com>
Date: Thu, 26 Dec 2024 00:32:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Willy Tarreau <w@1wt.eu>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <D7FF3455CE14824B+a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
 <20241225160017.GA10283@1wt.eu>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <20241225160017.GA10283@1wt.eu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------34rL0FuPgjrzm1Deesqq0wK8"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N10XyoOyIIl0ZvBqTXlLh+4eM5K/7hXXxJ28gUrnYt7ApzlPUD5EIe4r
	yW0o8eIYymaEpLIHz3PQ59swtxw8rfUqsPST9wl9wn/iRSeRleeLyK/XcF5kq+V0oDRCirM
	Q7UDc4nvAbghhM0AFy0J81jzMuBekosi5TOpdxxs0ay20JBbQGxYzhOFt7yb5vTOIz7c+Z7
	uzPNlPatE18OP+V+fc9dvYh1b919kax3SqpjJmmAEV9YMrZ/2qYa9PZURilq4BBC4ZVYFr7
	iDtAbWJD+H7oeQkRnM2Ht2aeR1uwTNx9N2AXKXU+3zVI6CXC9gKsoeoL9UZIQqjV9ORwlRW
	tmAJ6HUuhQX5U4tpmIBdy+UJXZxRXBRLmGwdGuvpJUaHSVANJPUWpEhjsIbuV3M32Ng/wz3
	FnfIfzKh9cSp/pu/g+YtNog9/SwI/hGDDdxGLd9Kiq1kT593RFIzNLhpjpMeicb1x9LW58G
	Ccor1FmKTdYPa9UjAz5eIk2dGqCqbLXAEU0raBFXfKY4l4d0Q2vlYgIsp9saW+I/WsUmyJl
	FWV0dHdCIkUrIDiTZ+vaNH63uqFVnklB2olYXSm4+44bRsbmo6CtkOVnMqwn6QkNC7ofF0S
	D/3xSvgjhLRDZz8hF/Hp+CwdeG40zWC/A0hpS9GBKVmI7ShgS65FWWzMiaP6K96HNljClH/
	cuvQn5lyBXIVZnTVZ9NRR/VRvF73IxaXdEL1CZNSabfco+2tffmy3YYUfUXMvHkN0TN2iwH
	c3BRg6H08LPdMwhV24xp+kJcrifjlAUvHYuQpDxtBEg2Y2+N1SBohcn8sdq0Sn+OlL0XG58
	MNmRUNpeyqoU/sWXQedC8vMqs9WwYwdwwWB2eWlXFtNxvtqju4fA7iu7bBMVgZaUEDDqr1c
	XJO02rtFnc1cCHyVl86a4WmHiOSvWVwUhYKw6MRfvsXGQ0IrzEhmrreMXVCQisF2qkkgoAg
	m1DxT7obfpLQfwd9C0zWW5PpFZztp5a6ddXl/ThG1j48yutmVk2me1agh0K5Jq6th9IQgE6
	hVndwqXHx9ccovloBY4Ws9VbyBSYHisY/rTP9AILHtBOfrrg/l
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------34rL0FuPgjrzm1Deesqq0wK8
Content-Type: multipart/mixed; boundary="------------qj7797PtQLxdLe07DfDq0uPL";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kent Overstreet <kent.overstreet@linux.dev>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <c7748c58-9b1c-4759-8131-1007c08e9f46@uniontech.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
 <D7FF3455CE14824B+a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
 <20241225160017.GA10283@1wt.eu>
In-Reply-To: <20241225160017.GA10283@1wt.eu>

--------------qj7797PtQLxdLe07DfDq0uPL
Content-Type: multipart/mixed; boundary="------------w2HAYU2UhlsBF459js0WFhaM"

--------------w2HAYU2UhlsBF459js0WFhaM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkndmUgcmV2aWV3ZWQgdGhlIENvbnRyaWJ1dG9yIENvdmVuYW50IGFuZCB0aGUg
TGludXggS2VybmVsIENvbnRyaWJ1dG9yIA0KQ292ZW5hbnQgQ29kZSBvZiBDb25kdWN0IElu
dGVycHJldGF0aW9uLCBhbmQgSSBjb3VsZG4ndCBmaW5kIGFueXRoaW5nIA0Kc3VnZ2VzdGlu
ZyB0aGF0IENDaW5nIGEgbGFyZ2UgbnVtYmVyIG9mIHBlb3BsZSBpcyAidW5mcmllbmRseSIu
DQoNCkFuZCB3aGlsZSBJIGRvbid0IGJlbGlldmUgbXkgYWN0aW9ucyB3ZXJlIG1hbGljaW91
cywgSSB1bmRlcnN0YW5kIHlvdXIgDQpjb25jZXJuLg0KDQpHb2luZyBmb3J3YXJkLCBJJ2xs
IGJlIG1vcmUgY29uc2lkZXJhdGUgb2YgdGhlIHJlY2lwaWVudHMgd2hlbiBzZW5kaW5nIA0K
ZW1haWxzIGFuZCB3aWxsIGF2b2lkIENDaW5nIG1vcmUgdGhhbiBhIGh1bmRyZWQgcGVvcGxl
IGF0IG9uY2UgaW4gDQpzaW1pbGFyIHNpdHVhdGlvbnMuDQoNCg0KT24gMjAyNC8xMi8yNiAw
MDowMCwgV2lsbHkgVGFycmVhdSB3cm90ZToNCg0KPiAoLi4uKQ0KPg0KPiBTb3JyeSwgYnV0
IGJ5IENDaW5nIDE5MSByYW5kb20gYWRkcmVzc2VzIGxpa2UgdGhpcywNCg0KSSB0aGluayB0
aGVyZSBtYXkgYmUgYSBtaXN1bmRlcnN0YW5kaW5nLg0KDQpUaGVzZSBhbGwgcmVjaXBpZW50
cyBjYW4gYmUgZm91bmQgaW4gdGhlIGdpdCBoaXN0b3J5IG9mIGZzL3BpcGUuYy4NCg0KPiB0
aGF0J3MgdGhlIGJlc3Qgd2F5DQo+IHRvIGJlIGFkZGVkIHRvIC5wcm9jbWFpbHJjIGFuZCBi
ZSBjb21wbGV0ZWx5IGlnbm9yZWQgYnkgZXZlcnlvbmUuIEF0IHNvbWUNCj4gcG9pbnQgb25l
IHNob3VsZCB3b25kZXIgd2hldGhlciB0aGF0J3MgYSBjb21tb24gcHJhY3RpY2Ugb3IgaWYg
c3VjaA0KPiBiZWhhdmlvcnMgd2lsbCBiZSBjb25zaWRlcmVkIG9mZmVuc2l2ZSBieSB0aGUg
bWFqb3JpdHkuIGdldF9tYWludGFpbmVyLnBsDQo+IG9ubHkgbGlzdHMgdGhlIDIgbGlzdHMg
YW5kIDMgYWRkcmVzc2VzIEkgbGVmdCBpbiBDQyAoYWZ0ZXIgS2VudCBhbmQgQW5keQ0KPiB3
aG9tIEkgbGVmdCBzaW5jZSB0aGV5IHJlcGxpZWQgdG8geW91KS4NCj4NCj4+IFRoaXMgcGF0
Y2gsIGZvciBleGFtcGxlLCBoYXMgYmVlbiBzdWJtaXR0ZWQgbXVsdGlwbGUgdGltZXMgd2l0
aG91dCByZWNlaXZpbmcNCj4+IGFueSByZXNwb25zZSwgdW5mb3J0dW5hdGVseS4NCj4gSXQg
Y2FuIGhhcHBlbiwgYnV0IHNlbmRpbmcgdG8gdGhlIHJpZ2h0IHBlb3BsZSBhbmQgcG9zc2li
bHkgcmVzZW5kaW5nIGlmDQo+IGl0IGdldHMgbG9zdCBpcyB1c3VhbGx5IHN1ZmZpY2llbnQg
dG8gYXR0cmFjdCBhdHRlbnRpb24uIFNlbmRpbmcgdG8gdGhhdA0KPiBtYW55IHBlb3BsZSBt
YWtlIHlvdSBsb29rIGxpa2Ugc29tZW9uZSBmZWVsaW5nIHNvIGltcG9ydGFudCB0aGV5IG5l
ZWQgdG8NCj4gc2hvdXQgaW4gYSBsb3Vkc3BlYWtlciB0byBzZW5kIG9yZGVycyB0byBldmVy
eW9uZS4NClNpbmNlcmVseSBob3BlIHRoYXQncyB0aGUgY2FzZS4NCj4gICBQbGVhc2UgcmVm
cmFpbiBmcm9tDQo+IGRvaW5nIHRoaXMgaW4gdGhlIGZ1dHVyZS4NCkFzIGFib3ZlLg0KDQpU
aGFua3MsDQotLSANCldhbmdZdWxpDQo=
--------------w2HAYU2UhlsBF459js0WFhaM
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------w2HAYU2UhlsBF459js0WFhaM--

--------------qj7797PtQLxdLe07DfDq0uPL--

--------------34rL0FuPgjrzm1Deesqq0wK8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ2wzowUDAAAAAAAKCRDF2h8wRvQL7mdZ
APoCHqQiuyt0CufG4TWpaozdhyMY9GrdG74RW8oC/iuCIAEAxLDzNShe6kz+pgvm0C97s7DIKhnV
aLw55wkdvj9fKAM=
=Pid3
-----END PGP SIGNATURE-----

--------------34rL0FuPgjrzm1Deesqq0wK8--


