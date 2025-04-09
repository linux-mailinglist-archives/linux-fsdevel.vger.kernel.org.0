Return-Path: <linux-fsdevel+bounces-46109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8BEA82A53
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E434A678A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF1726770E;
	Wed,  9 Apr 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEa6mCyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E1586250;
	Wed,  9 Apr 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212217; cv=none; b=O+2LtYMF4+jZpoMiKEPx+l5VK6vdhx9F1hXQ78MVSwlejZk/lfNTVgZilFV2eKMp5bh+m7OLbeQ8+zzWTfnQ/voA90h2CEzGMjSnLfOVFEUet6wGoKbm9D4UMU/2gGiZt56jQAo0EIIbOwE6e3+oSvQP3ii9R8cdxoXUHKIHkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212217; c=relaxed/simple;
	bh=Yd4d+GMPZ+nzX6Iy4mYzwx5xpsh9IiXZoxGEhdlfbw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW0j3GNWGMBF5Ny9cYElPiW91OUO9NIHZofLXuE3zeBw6caPK5pqhsIJaKxZW24Z6+M+/OyqpJSDez3CBLBFMvF2eVN0rRBLMtC6QFpgwgFsMDCEIcC6+n4DkoxIg5aXuFEd93dGUeE8ZPyhbZGAYRr++bAXktgU8ThD+9zbekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEa6mCyy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c30d9085aso4236264f8f.1;
        Wed, 09 Apr 2025 08:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744212214; x=1744817014; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Yd4d+GMPZ+nzX6Iy4mYzwx5xpsh9IiXZoxGEhdlfbw8=;
        b=dEa6mCyyfrLaOkTfWX7AsQ+EORdlk8i1Q1tFtXHBrOiy9vbdgiv2fMy8IntRXUruD3
         yCxxAFbTUi1RxQPuNRl5/y78YNsD7iMGoBOP3ZaQGk006ZrQPHQ5dY/Q77kVsMrflAjz
         7/0XMVvKWqEyowpjX6CY0jAG94GNmBgP21a4QiuIGhbSxC07/DN7UfC+34Au9o1wFg+i
         PfYbzPEM6vjfNfyCBcA3hymkkIqev4ddU73jvcHrC8jIw5xB/I9/tkJZn4Qgz4GONaXb
         qP0w5Em1UbHonX1ei/Ng15GRLrnG0GGqB+GXyP2M+UxttcuqsPuJ7BPGT26AwHOMjXM+
         fiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744212214; x=1744817014;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yd4d+GMPZ+nzX6Iy4mYzwx5xpsh9IiXZoxGEhdlfbw8=;
        b=GKeqskqtyhCXxsIXCknk3hmTG4qgqUdZxtCKHbSPau+JjnUOl1iOP5NPwh9o8LmmHD
         gpfgW0pgrgvDPjI1oihodfKxjU2PFkthcwLM+NQbQYwfLlrrG1T3ckJwfR6qWdWeYeDa
         OzKuqhUV3o22OLWv3Aja1LOWd6xoekHmzxC5MFSmBifXWjqPJhRfEJxyze3X/X+EAIXt
         DW1m191JbxOLdL4sOn4lwv6UP165U8n1Y6lf3u2/KRXuU1XAj55X9IKNyOiEqntnkh4i
         PheHrajEZrXmAdM/pmZDBxGMIkVZQBJ8lzOjYoE+sLl/8yCEzDOk916nuRyoffwhFqy4
         m26Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIVY/QtmkO/RhIQ6PeIvsCMR/oGJ0Fp+i61fLU9eCp3SVYC0evDEGarOTwkRdKWqSDNmDMGJbq7NNovlt7mlE=@vger.kernel.org, AJvYcCXQZ4JCCNkhXxTyJJvqYRrjfxzfHkDR7jjFYlCOmCAgwRepfuQF/E7pQuu2l1IDFZV0HR2dJkVTW/vAb0YMmw==@vger.kernel.org, AJvYcCXio/f1KsV0+krFQei4PljJ+xwVXu56jAZZOPiljGpA8qStM1gBnwk4t5LR6t7FAk/TfXtXg5ZjiwKakqmU@vger.kernel.org
X-Gm-Message-State: AOJu0YzUrCTnv/WUl+Y6YZpCORY3OTckO3HPb585kMhupczSnKMID+K0
	vFy3cYx3p9ak01e86J1jKlmKM+rp+A59R0ap8owv7d4TqEvUkAwV
X-Gm-Gg: ASbGnctoWWzg2KNB+rH4QYhU8nly1fKwQjHDSAYBKRrhJVAkXMqp5fBnEiKC5/OPFLt
	TnbQIGVjXRHu/ZFxKHKFuGzpO/NbShgSgR3Y651aXCibNA1lzTADUq9Rn0uDkKZrUaTHMuwgV90
	IbS5YBqYPX3HT9FL1bbd5VAY6SYGEM/aNV5JW9rnTCBLEHWAaq1nr/lDA36FBuc5h9j0lxFjof4
	SLbEYfS/+tgtn/HW3E8QHM4+WQlsEd5SpaBHYwLv5/iMb3ED/B/Fq2FZIRD+8Z/rTvYphYnScg/
	ZqKkCWtf2j3Z8dj75dJc6cKFjYlUREqCvv9yX5FI5PiOMGp/xLORF2EGmwip
X-Google-Smtp-Source: AGHT+IHivNwYXH57W796lgTtN8zxsAdAwQCgNtagPsCrc331I48wXUqbXnaLu3p1O+Mg2iKNzknawA==
X-Received: by 2002:a5d:5f93:0:b0:39c:3122:ad55 with SMTP id ffacd0b85a97d-39d885314d7mr2841148f8f.18.1744212213942;
        Wed, 09 Apr 2025 08:23:33 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.58])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43f20a0bf4esm11614055e9.1.2025.04.09.08.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:23:33 -0700 (PDT)
Message-ID: <1862386e-fca2-470e-929c-0205a56c0f2f@gmail.com>
Date: Wed, 9 Apr 2025 16:23:28 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] select: do_pollfd: add unlikely branch hint return path
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250409143138.568173-1-colin.i.king@gmail.com>
 <llt32u2qdjyu3giwhxesrahsh5a2ks6behzzkjky7fe7k6xync@pvixqbom73il>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <llt32u2qdjyu3giwhxesrahsh5a2ks6behzzkjky7fe7k6xync@pvixqbom73il>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xjfS5MZHQOSGuRl6miITax6a"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xjfS5MZHQOSGuRl6miITax6a
Content-Type: multipart/mixed; boundary="------------GPuC2C7xKpvRv76J47q7sdLc";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1862386e-fca2-470e-929c-0205a56c0f2f@gmail.com>
Subject: Re: [PATCH] select: do_pollfd: add unlikely branch hint return path
References: <20250409143138.568173-1-colin.i.king@gmail.com>
 <llt32u2qdjyu3giwhxesrahsh5a2ks6behzzkjky7fe7k6xync@pvixqbom73il>
In-Reply-To: <llt32u2qdjyu3giwhxesrahsh5a2ks6behzzkjky7fe7k6xync@pvixqbom73il>

--------------GPuC2C7xKpvRv76J47q7sdLc
Content-Type: multipart/mixed; boundary="------------dKjX1xErmt3N50ocZNpiWX86"

--------------dKjX1xErmt3N50ocZNpiWX86
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDkvMDQvMjAyNSAxNjoxOCwgTWF0ZXVzeiBHdXppayB3cm90ZToNCj4gT24gV2VkLCBB
cHIgMDksIDIwMjUgYXQgMDM6MzE6MzhQTSArMDEwMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6
DQo+PiBBZGRpbmcgYW4gdW5saWtlbHkoKSBoaW50IG9uIHRoZSBmZCA8IDAgY29tcGFyaXNv
biByZXR1cm4gcGF0aCBpbXByb3Zlcw0KPj4gcnVuLXRpbWUgcGVyZm9ybWFuY2Ugb2YgdGhl
IG1pbmNvcmUgc3lzdGVtIGNhbGwuIGdjb3YgYmFzZWQgY292ZXJhZ2UNCj4+IGFuYWx5c2lz
IHNob3dzIHRoYXQgdGhpcyBwYXRoIHJldHVybiBwYXRoIGlzIGhpZ2hseSB1bmxpa2VseS4N
Cj4+DQo+PiBCZW5jaG1hcmtpbmcgb24gYW4gRGViaWFuIGJhc2VkIEludGVsKFIpIENvcmUo
VE0pIFVsdHJhIDkgMjg1SyB3aXRoDQo+PiBhIDYuMTUtcmMxIGtlcm5lbCBhbmQgYSBwb2xs
IG9mIDEwMjQgZmlsZSBkZXNjcmlwdG9ycyB3aXRoIHplcm8gdGltZW91dA0KPj4gc2hvd3Mg
YW4gY2FsbCByZWR1Y3Rpb24gZnJvbSAzMjgxOCBucyBkb3duIHRvIDMyNjM1IG5zLCB3aGlj
aCBpcyBhIH4wLjUlDQo+PiBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudC4NCj4+DQo+PiBSZXN1
bHRzIGJhc2VkIG9uIHJ1bm5pbmcgMjUgdGVzdHMgd2l0aCB0dXJibyBkaXNhYmxlZCAodG8g
cmVkdWNlIGNsb2NrDQo+PiBmcmVxIHR1cmJvIGNoYW5nZXMpLCB3aXRoIDMwIHNlY29uZCBy
dW4gcGVyIHRlc3QgYW5kIGNvbXBhcmluZyB0aGUgbnVtYmVyDQo+PiBvZiBwb2xsKCkgY2Fs
bHMgcGVyIHNlY29uZC4gVGhlICUgc3RhbmRhcmQgZGV2aWF0aW9uIG9mIHRoZSAyNSB0ZXN0
cw0KPj4gd2FzIDAuMDglLCBzbyByZXN1bHRzIGFyZSByZWxpYWJsZS4NCj4+DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIGFkZGluZyBhIGJyYW5jaCBoaW50IHdhcnJhbnRzIGJlbmNobWFya2lu
ZyBvZiB0aGUgc29ydC4NCj4gDQo+IEluc3RlYWQgdGhlIHRoaW5nIHRvIGRvIGlzIHRvIGNo
ZWNrIGlmIHRoZSBwcmVkaWN0aW9uIG1hdGNoZXMgcmVhbCB3b3JsZA0KPiB1c2VzLg0KPiAN
Cj4gV2hpbGUgaXQgaXMgaW1wb3NzaWJsZSB0byBjaGVjayB0aGlzIGZvciBhbGwgcHJvZ3Jh
bXMgb3V0IHRoZXJlLCBpdA0KPiBzaG91bGQgbm90IGJlIGEgc2lnbmlmaWNhbnQgdGltZSBp
bnZlc3RtZW50IHRvIGxvb2sgdG8gY2hlY2sgc29tZSBvZiB0aGUNCj4gcG9wdWxhciBvbmVz
IG91dCB0aGVyZS4gTm9ybWFsbHkgSSB3b3VsZCBkbyBpdCB3aXRoIGJwZnRyYWNlLCBidXQg
dGhpcw0KPiBjb21lcyBmcm9tIGEgdXNlci1iYWNrZWQgYXJlYSBpbnN0ZWFkIG9mIGZ1bmMg
YXJncywgc28gaW52b2x2ZWQgaGFja2VyeQ0KPiBtYXkgYmUgbmVlZGVkIHdoaWNoIGlzIG5v
dCB3YXJyYW50ZWQgdGhlIGNoYW5nZS4gUGVyaGFwcyBydW5uaW5nIHN0cmFjZQ0KPiBvbiBh
IGJ1bmNoIG9mIG5ldHdvcmsgcHJvZ3Mgd291bGQgYWxzbyBkbyBpdCAoc3NoLCBicm93c2Vy
PykuDQo+IA0KPiBJIGhhdmUgdG8gc2F5IEkgZGlkIG5vdCBldmVuIGtub3cgb25lIGNhbiBs
ZWdhbGx5IHBhc3MgYSBmZCA8IDAgdG8gcG9sbA0KPiBhbmQgSSBuZXZlciBzZWVuIGl0IGlu
IGFjdGlvbiwgc28gSSBkb24ndCBleHBlY3QgbWFueSB1c2Vycy4gOykNCg0KSSBkaWQgY2hl
Y2sgdGhpcyBiYXNlZCBvbiBnY292IGNvdmVyYWdlIChtZW50aW9uZWQgaW4gdGhlIGNvbW1p
dCANCm1lc3NhZ2UpIGFuZCB0aGlzIGlzIGJhc2VkIG9uIHJ1bm5pbmcgZ2NvdiBkYXRhIGZy
b20gcnVubmluZyBzdHJlc3MtbmcgDQphbmQga2VybmVsIGJ1aWxkcyBhbmQgSSd2ZSBiZWVu
IGxvb2tpbmcgZm9yIGJyYW5jaCBoaW50IHBlcmZvcm1hbmNlIHdpbnMNCmJhc2VkIG9uIHRo
ZSB0b3AgMjUwIGlmIHN0YXRlbWVudHMgdGhhdCBhcmUgbm90IGFscmVhZHkgaGludGVkIHVz
aW5nIA0KbGlrZWx5L3VubGlrZWx5Lg0KDQpDb2xpbg0KDQo=
--------------dKjX1xErmt3N50ocZNpiWX86
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------dKjX1xErmt3N50ocZNpiWX86--

--------------GPuC2C7xKpvRv76J47q7sdLc--

--------------xjfS5MZHQOSGuRl6miITax6a
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmf2kPAFAwAAAAAACgkQaMKH38aoAiYq
sQ/+NxAeLXlfBoFhElB/y76C4ZIZMW2QphHN6gLinnsMoimuFvFQ9oceEXrQNDAxc1bdT5GkD2mU
t5fpafSJT5WSAbJoa2e0AEYjUDy7+KTcGJE1THVQKYjQPGUoCgxLaFyvMfNKfYdJRDHYJ2HhwudV
uOV6s9c0kTBTY9YCe3jOcorfBY1t+D+hsaUQKn2N+Ob5cN040GtVnxcTWFRUxdYPwVuiM7fKY/mT
uBxPTZuJCw2kgSjSvZh2DkLKaWRHws+aOUWWE2w/0EoZYOQ1qyvhccVWryEI5EHLdDX9LHe5SInZ
e78txEG/kI6QMHmPq7C2qF1LHvsqQoW48Bzb5MGpr5Kud5OmgGO0cdYzIyJ6asOcrPXekiH++3kk
mulWeSJkgCjZAmSjcbd+WpZH9aMwjljZYezuwD5VHFaeUamqZcLqMBcjTweyF1X+7tbZ1muUMYc8
Q6uv/z3VJzCe4uyuoKDCQThtY0yozzf7DzOmiulCWB56kYgxh51WyPFawtm6kjjkRRN0e+tfaK5u
CfHSZiG3C2AWqn9I4u3lPY1zNP+56g9qmio11Qw01QvmpAS+hZgKPjM+GU/fk+fF+5vzOG1Tubkp
8zv8sJ6usGxEcUVRCjCiMljW6k+mmKqeT7N3JZSZ7J9AKNa4U80S18OaRDZEXNDFzyKiSj/qHKrV
MeY=
=DEGR
-----END PGP SIGNATURE-----

--------------xjfS5MZHQOSGuRl6miITax6a--

