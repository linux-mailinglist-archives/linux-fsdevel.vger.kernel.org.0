Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D647349AF9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 10:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456740AbiAYJMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 04:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454669AbiAYJAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 04:00:24 -0500
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Jan 2022 00:29:43 PST
Received: from mail.valdk.tel (mail.valdk.tel [IPv6:2a02:e00:ffe7:c::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7FC061A7F;
        Tue, 25 Jan 2022 00:29:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D20D630E0B2;
        Tue, 25 Jan 2022 11:19:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valdikss.org.ru;
        s=msrv; t=1643098785;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-language:in-reply-to:references;
        bh=ajetHMusOMv5MjA4FqtJV4K6Rv1DXIf2A7NFybvtOBg=;
        b=ujOBqSM7nDajeMukRW01MApD5VpGTge2NqZpuKjf7kAjIrteoat/HGOSFYNQByv+8bPA5j
        ULKcEcPKEP7QTt37CN4Y/BddHVubhMOe2Gjv7nnFX0y4cmGmc5WRVMeKEcHda+WLD8a44k
        kAfn/L1rKTpijAgjCPNNRf2vF6wZGODGl9lhjLI5vaf9rndD4mmECcV9a4z5gTKoabPETB
        pCVQEuDjvF9HMsshVfXKxxdCB/U1UaKbxYXzcb1P8LvjM7xmilrtTBZxJvinQmwvTpxnwY
        tHhzQYrvxeGL387sUUFgL+ilSsT0vf0h8ndDWmezp1axkqYL0OVJzrBZqCXhOg==
Message-ID: <f6a335b7-9cd8-eb02-69b3-bdf15ebf69fa@valdikss.org.ru>
Date:   Tue, 25 Jan 2022 11:19:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.5.0) Gecko/20100101,
 Thunderbird/78.5.0
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>
Cc:     Alexey Avramov <hakavlad@inbox.lv>, Linux-MM <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>, yzaikin@google.com,
        oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
        hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>
References: <20211130201652.2218636d@mail.inbox.lv>
 <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <CAGsJ_4zMoV6UJGC_X-VRM7p8w68a0Q8sLVfS3sRFxuQUtHoASw@mail.gmail.com>
From:   ValdikSS <iam@valdikss.org.ru>
In-Reply-To: <CAGsJ_4zMoV6UJGC_X-VRM7p8w68a0Q8sLVfS3sRFxuQUtHoASw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------060fOdz280xaOYH35TqyCEYA"
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------060fOdz280xaOYH35TqyCEYA
Content-Type: multipart/mixed; boundary="------------GpvSgEWNSIxnhxGEHv7X0t4X";
 protected-headers="v1"
From: ValdikSS <iam@valdikss.org.ru>
To: Barry Song <21cnbao@gmail.com>
Cc: Alexey Avramov <hakavlad@inbox.lv>, Linux-MM <linux-mm@kvack.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 mcgrof@kernel.org, Kees Cook <keescook@chromium.org>, yzaikin@google.com,
 oleksandr@natalenko.name, kernel@xanmod.org, aros@gmx.com,
 hakavlad@gmail.com, Yu Zhao <yuzhao@google.com>
Message-ID: <f6a335b7-9cd8-eb02-69b3-bdf15ebf69fa@valdikss.org.ru>
Subject: Re: [PATCH] mm/vmscan: add sysctl knobs for protecting the working
 set
References: <20211130201652.2218636d@mail.inbox.lv>
 <2dc51fc8-f14e-17ed-a8c6-0ec70423bf54@valdikss.org.ru>
 <CAGsJ_4zMoV6UJGC_X-VRM7p8w68a0Q8sLVfS3sRFxuQUtHoASw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zMoV6UJGC_X-VRM7p8w68a0Q8sLVfS3sRFxuQUtHoASw@mail.gmail.com>

--------------GpvSgEWNSIxnhxGEHv7X0t4X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTIuMjAyMSAxMTozOCwgQmFycnkgU29uZyB3cm90ZToNCj4gT24gVHVlLCBEZWMg
NywgMjAyMSBhdCA1OjQ3IEFNIFZhbGRpa1NTIDxpYW1AdmFsZGlrc3Mub3JnLnJ1PiB3cm90
ZToNCj4+DQo+PiBUaGlzIHBhdGNoc2V0IGlzIHN1cnByaXNpbmdseSBlZmZlY3RpdmUgYW5k
IHZlcnkgdXNlZnVsIGZvciBsb3ctZW5kIFBDDQo+PiB3aXRoIHNsb3cgSERELCBzaW5nbGUt
Ym9hcmQgQVJNIGJvYXJkcyB3aXRoIHNsb3cgc3RvcmFnZSwgY2hlYXAgQW5kcm9pZA0KPj4g
c21hcnRwaG9uZXMgd2l0aCBsaW1pdGVkIGFtb3VudCBvZiBtZW1vcnkuIEl0IGFsbW9zdCBj
b21wbGV0ZWx5IHByZXZlbnRzDQo+PiB0aHJhc2hpbmcgY29uZGl0aW9uIGFuZCBhaWRzIGlu
IGZhc3QgT09NIGtpbGxlciBpbnZvY2F0aW9uLg0KPj4NCj4gDQo+IENhbiB5b3UgcGxlYXNl
IHBvc3QgeW91ciBoYXJkd2FyZSBpbmZvcm1hdGlvbiBsaWtlIHdoYXQgaXMgdGhlIGNwdSwg
aG93IG11Y2gNCj4gbWVtb3J5IHlvdSBoYXZlIGFuZCBhbHNvIHBvc3QgeW91ciBzeXNjdGwg
a25vYnMsIGxpa2UgaG93IGRvIHlvdSBzZXQNCj4gdm0uYW5vbl9taW5fa2J5dGVzLCAgdm0u
Y2xlYW5fbG93X2tieXRlcyBhbmQgdm0uY2xlYW5fbWluX2tieXRlcz8NCg0KSSBoYXZlIGEg
dHlwaWNhbCBvZmZpY2UgY29tcHV0ZXIgb2YgeWVhciAyMDA3Og0KDQoqIE1vdGhlcmJvYXJk
OiBHaWdhYnl0ZSBHQS05NDVHQ00tUzJMIChlYXJseSBMR0E3NzUgc29ja2V0LCBHTUE5NTAg
DQppbnRlZ3JhdGVkIGdyYXBoaWNzLCBTZXB0ZW1iZXIgMjAwNykNCiogMiBjb3JlIDY0IGJp
dCBDUFU6IEludGVswq4gQ29yZeKEojIgRHVvIEU0NjAwICgyIGNvcmVzLCAyLjQgR0h6LCBs
YXRlIDIwMDcpDQoqIDIgR0Igb2YgUkFNIChERFIyIDY2NyBNSHosIHNpbmdsZSBtb2R1bGUp
DQoqIFZlcnkgb2xkIGFuZCBzbG93IDE2MCBHQiBIYXJkIERpc2s6IFNhbXN1bmcgSEQxNjFI
SiAoU0FUQSBJSSwgSnVuZSAyMDA3KToNCiogTm8gZGlzY3JldGUgZ3JhcGhpY3MgY2FyZA0K
DQpJIHVzZWQgdm0uY2xlYW5fbG93X2tieXRlcz0zODQwMDAgKDM4NCBNQikgdG8ga2VlcCBt
b3N0IG9mIGZpbGUgY2FjaGUgaW4gDQptZW1vcnksIGJlY2F1c2UgdGhlIEhERCBpcyBzbG93
IGFuZCBldmVyeSBkYXRhIHJlLXJlYWQgbGVhZHMgdG8gDQp1bmNvbWZvcnRhYmxlIGZyZWV6
ZXMgYW5kIHNsb3cgd29yay4NCg0KTW9yZSBpbmZvcm1hdGlvbiwgaW5jbHVkaW5nIHRoZSB2
aWRlbywgaXMgaGVyZTogDQpodHRwczovL25vdGVzLnZhbGRpa3NzLm9yZy5ydS9saW51eC1m
b3Itb2xkLXBjLWZyb20tMjAwNy9lbi8NCg0KPiANCj4+IFRoZSBzaW1pbGFyIGZpbGUtbG9j
a2luZyBwYXRjaCBpcyB1c2VkIGluIENocm9tZU9TIGZvciBuZWFybHkgMTAgeWVhcnMNCj4+
IGJ1dCBub3Qgb24gc3RvY2sgTGludXggb3IgQW5kcm9pZC4gSXQgd291bGQgYmUgdmVyeSBi
ZW5lZmljaWFsIGZvcg0KPj4gbG93ZXItcGVyZm9ybWFuY2UgQW5kcm9pZCBwaG9uZXMsIFNC
Q3MsIG9sZCBQQ3MgYW5kIG90aGVyIGRldmljZXMuDQo+Pg0KPiANCj4gQ2FuIHlvdSBwb3N0
IHRoZSBsaW5rIG9mIHRoZSBzaW1pbGFyIGZpbGUtbG9ja2luZyBwYXRjaD8NCg0KSGVyZSdz
IGEgcGF0Y2g6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDEwLzEwLzI4LzI4OQ0KSGVyZSdz
IG1vcmUgaW4tZGVwdGggZGVzY3JpcHRpb246IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDEw
LzExLzEvMjANCg0KUGxlYXNlIGFsc28gbm90ZSB0aGF0IGFub3RoZXIgR29vZ2xlIGRldmVs
b3BlciwgWXUgWmhhbywgaGFzIGFsc28gbWFkZSBhIA0KbW9kZXJuIHZlcnNpb24gb2YgdGhp
cyAoQ2hyb21pdW1PUykgcGF0Y2ggY2FsbGVkIE1HTFJVLCB0aGUgZ29hbCBvZiANCndoaWNo
IGlzIHF1aXRlIHNpbWlsYXIgdG8gbGU5ICh0aGUgcGF0Y2ggd2UncmUgZGlzY3Vzc2luZyBo
ZXJlKSwgYnV0IA0Kd2l0aCAibW9yZSBicmFpbnMiOg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDIyMDEwNDIwMjI0Ny4yOTAzNzAyLTEteXV6aGFvQGdvb2dsZS5jb20vVC8j
bThmZDJhMjliYzU1N2QyN2QxMDAwZjgzN2Y2NWI2YzkzMGVlZjlkZmYNCg0KUGxlYXNlIHRh
a2UgYSBtb21lbnQgYW5kIHJlYWQgdGhlIGluZm9ybWF0aW9uIGluIHRoZSBsaW5rIGFib3Zl
LiBZdSBaaGFvIA0KZGV2ZWxvcHMgdGhpcyBwYXRjaCBmb3IgYWxtb3N0IHR3byB5ZWFycyBh
bmQga25vd3MgdGhlIGlzc3VlIGJldHRlciB0aGFuIA0KbWUsIGEgY2FzdWFsIHVzZXIuDQoN
Cg0KPiANCj4+IFdpdGggdGhpcyBwYXRjaCwgY29tYmluZWQgd2l0aCB6cmFtLCBJJ20gYWJs
ZSB0byBydW4gdGhlIGZvbGxvd2luZw0KPj4gc29mdHdhcmUgb24gYW4gb2xkIG9mZmljZSBQ
QyBmcm9tIDIwMDcgd2l0aCBfX29ubHkgMkdCIG9mIFJBTV9fDQo+PiBzaW11bHRhbmVvdXNs
eToNCj4+DQo+PiAgICAqIEZpcmVmb3ggd2l0aCAzNyBhY3RpdmUgdGFicyAoYWxsIGRhdGEg
aW4gUkFNLCBubyB0YWIgdW5sb2FkaW5nKQ0KPj4gICAgKiBEaXNjb3JkDQo+PiAgICAqIFNr
eXBlDQo+PiAgICAqIExpYnJlT2ZmaWNlIHdpdGggdGhlIGRvY3VtZW50IG9wZW5lZA0KPj4g
ICAgKiBUd28gUERGIGZpbGVzICgxNCBhbmQgNDcgbWVnYWJ5dGVzIGluIHNpemUpDQo+Pg0K
Pj4gQW5kIHRoZSBQQyBkb2Vzbid0IGNyYXdsIGxpa2UgYSBzbmFpbCwgZXZlbiB3aXRoIDIr
IEdCIGluIHpyYW0hDQo+PiBXaXRob3V0IHRoZSBwYXRjaCwgdGhpcyBQQyBpcyBiYXJlbHkg
dXNhYmxlLg0KPj4gUGxlYXNlIHdhdGNoIHRoZSB2aWRlbzoNCj4+IGh0dHBzOi8vbm90ZXMu
dmFsZGlrc3Mub3JnLnJ1L2xpbnV4LWZvci1vbGQtcGMtZnJvbS0yMDA3L2VuLw0KPj4NCj4g
DQo+IFRoZSB2aWRlbyB3YXMgY2FwdHVyZWQgYmVmb3JlIHVzaW5nIHRoaXMgcGF0Y2g/IHdo
YXQgdmlkZW8gc2F5cw0KPiAidGhlIHJlc3VsdCBvZiB0aGUgdGVzdCBjb21wdXRlciBhZnRl
ciB0aGUgY29uZmlndXJhdGlvbiIsIHdoYXQgZG9lcw0KPiAidGhlIGNvbmZpZ3VyYXRpb24i
IG1lYW4/DQoNClRoZSB2aWRlbyB3YXMgY2FwdHVyZWQgYWZ0ZXIgdGhlIHBhdGNoLiBCZWZv
cmUgdGhlIHBhdGNoLCBpdCdzIGJhc2ljYWxseSANCm5vdCBwb3NzaWJsZSB0byB1c2UgRmly
ZWZveCBvbmx5IHdpdGggMjArIHRhYnMgYmVjYXVzZSB0aGUgUEMgZW50ZXJzIA0KdGhyYXNo
aW5nIGNvbmRpdGlvbiBhbmQgcmVhY3RzIHNvIHNsb3cgdGhhdCBldmVuIG1vdXNlIGN1cnNv
ciBmcmVlemVzIA0KZnJlcXVlbnRseS4gVGhlIFBDIGlzIGFic29sdXRlbHkgdW51c2FibGUg
Zm9yIGFueSBkZWNlbnQgd29yayB3aXRob3V0IA0KdGhlIHBhdGNoLCByZWdhcmRsZXNzIG9m
IHN3YXBwaW5lc3MsIHZtLm1pbl9mcmVlX2tieXRlcyBvciBhbnkgb3RoZXIgDQp0dW5hYmxl
cy4NCg0KVGhlIGNvbmZpZ3VyYXRpb24gaXMgdGhpcyBwYXRjaCB3aXRoIHZtLmNsZWFuX2xv
d19rYnl0ZXM9Mzg0MDAwIGFuZCAxNTAlIA0KenJhbS4gTW9yZSBpbmZvcm1hdGlvbiBpcyBw
cm92aWRlZCBvbiB0aGUgd2Vic2l0ZS4NCg0KPiANCj4gVGhhbmtzDQo+IEJhcnJ5DQo=

--------------GpvSgEWNSIxnhxGEHv7X0t4X--

--------------060fOdz280xaOYH35TqyCEYA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEMiogvXcpmS32v71gXNcgLu+I93IFAmHvsowFAwAAAAAACgkQXNcgLu+I93LM
VA/8CoW/5xkgx7D1CDH+ZGLAq+5TFsxMpWEkBZcx3DPiU4wnbtgbL/IwT5ro0Xo/VQQ9TOudB90M
zfnpsnlIaO5cVqFcE6vh6mHkVmlOCXod4WJ9P6B87ipd4BQ4pXRQVBBbDSGAexBILjG61/SZuF87
bsoyb4n9+9ZubAVlm6V596hyrRfTqvSbUS1j8TdruOmzEIssiXlCYXuATxdvjTA3QssFz5F8Gw1C
rQvIJUcxiZN8kPPCPIH55mZBvv5cwm18pd9s7ZFvJ2i4Cn0+h11/WIDnCopn9ko0wJsBL0CIFfuY
WtQQOfBsJx2Egd22slfMUpnM+uG96Cm5R55d0dt2OTjHuIpV46aYwSp1wrVF5kLavKibI1ob9j5W
ChHE9qgfUjTWd/4LyT6V83AqRsyrVlsUX0nWhHZor2Wh/T+51X2Dvc2j8wqUiNokJWsRtQYlrvFc
7ZGtf1fz62VJhipW1kYO/ZirhM9lseCQWhS6lHrxy7309qaBoCXeQWTqNLwmkW6DPP0XqnrIQUyK
ZKj8436GMw+2xgF9VIwE1BsfJGkD5Y2PMPP2Ww6tM64iT15/wq9rNEGKQ+GJoYD3wX9MqL4YzoEx
2WCrphjY2Dlhwdqaf/suW6ikVf38uk0cNwEjJ8vrTsvdrzjuYC9uvnRgSbPjhMISfXfHrfE/mlyp
Foc=
=u7UI
-----END PGP SIGNATURE-----

--------------060fOdz280xaOYH35TqyCEYA--
