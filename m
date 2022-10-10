Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C45FA1AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiJJQP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 12:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiJJQP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:15:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A45C37F;
        Mon, 10 Oct 2022 09:15:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso8855925wma.1;
        Mon, 10 Oct 2022 09:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b/H3b682Cs4auGqv8ODOX5sEwhRHiu4vm1CpnCyMBU=;
        b=CLMvVxR0R9+iokJ1SXPR4KCiF/PkXiyxAU5cMCPBFjKjUZ+JAtavKliaG7v5KK5UnF
         izYk+6gQoN/8RJXVBzSDBwkO5znRb9BowlHYsShOkcCpvyK5TlDX3zqF9EqFCP20Bqy5
         anWP0EN+32g0kisnPx8cBq4XztFSwhD+Mz6yy0+SuFksrI1ddE0GdAUEcNOQ8GyvyilE
         iH3qnrE/OCEjIbV1GpqrngYpiDYQah8WszNrxie41Uzv3qf8I8lfJ67JUgMw6/jDkBPN
         SRY/VGUk+H6h/HidUJLfdRGuiLqAfcdbZ8cDYLT8MP1euSNghIBbBlkhPZTmN24P4kdU
         djeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3b/H3b682Cs4auGqv8ODOX5sEwhRHiu4vm1CpnCyMBU=;
        b=u1x+jKttyRmDA6ZuBAEWtqWFiqPXcrNPM17685Zo7foAURkIpVTg7OaP3Ox1NgcEt/
         7icCVyemrSTt1KRjUdZEct6Zjzj1ltxwMDAAXl81nYA2p94JBZebI/ecMcvVQHTWbize
         dMLM5uSVwO7STf2SIbkRZXXe8NRj2JeP1E+mQOc0Z8VOeF75ISY9bdtpolNc/Btfxjsz
         PvLMSMTOTNdd/0MTBm4bhR91H8QU0CufYvcqjEa6qNIczqKRVcG9rmKOgx2HIViJ4Re7
         dnOUIeHrQQoigTZ+46eeqp5HJPYXx6zkQ2LnkdobQ0IV5cf76RxLR0c/L/OA5mQtsE7D
         4EGw==
X-Gm-Message-State: ACrzQf3s7347uODmTiBAgLupClGy1kAaIVwTPrLR4CWIhi3BuRBeY9xN
        KZLX/6l3jOCN61oodBSIIDQ=
X-Google-Smtp-Source: AMsMyM5TvkeRbhpgyV7CoGtBE8xB2bAQsT0XL9iNLrlc7mFh/04EBX4FUH2CLHbV5qpYp8bGFSs9jQ==
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:5547 with SMTP id iv16-20020a05600c549000b003b48db05547mr13112572wmb.77.1665418552586;
        Mon, 10 Oct 2022 09:15:52 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id k4-20020adff5c4000000b00228dff8d975sm8986985wrp.109.2022.10.10.09.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 09:15:51 -0700 (PDT)
Message-ID: <23596caf-db1a-0c22-70a5-6ff409282fd1@gmail.com>
Date:   Mon, 10 Oct 2022 18:15:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Semantic newlines (was: [man-pages PATCH v3] statx.2, open.2:
 document STATX_DIOALIGN)
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
References: <20221004174307.6022-1-ebiggers@kernel.org>
 <26cafc28-e63a-6f13-df70-8ccec85a4ef0@gmail.com> <Y0Q4m9mj3DUZEkrW@magnolia>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <Y0Q4m9mj3DUZEkrW@magnolia>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FLnbu1X71N4cWPrqt0YiFtO0"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FLnbu1X71N4cWPrqt0YiFtO0
Content-Type: multipart/mixed; boundary="------------QDGjJfjSqcau0rYuUmoIyW5q";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-man@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
 "G. Branden Robinson" <g.branden.robinson@gmail.com>
Message-ID: <23596caf-db1a-0c22-70a5-6ff409282fd1@gmail.com>
Subject: Semantic newlines (was: [man-pages PATCH v3] statx.2, open.2:
 document STATX_DIOALIGN)
References: <20221004174307.6022-1-ebiggers@kernel.org>
 <26cafc28-e63a-6f13-df70-8ccec85a4ef0@gmail.com> <Y0Q4m9mj3DUZEkrW@magnolia>
In-Reply-To: <Y0Q4m9mj3DUZEkrW@magnolia>

--------------QDGjJfjSqcau0rYuUmoIyW5q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGFycmljaywNCg0KT24gMTAvMTAvMjIgMTc6MjIsIERhcnJpY2sgSi4gV29uZyB3cm90
ZToNCj4gDQo+IEknbSBub3Qgc28gZmFtaWxpYXIgd2l0aCBzZW1hbnRpYyBuZXdsaW5lcy0t
IGlzIHRoZXJlIGFuIGF1dG9tYXRlZA0KDQpUaGUgZm9sbG93aW5nIGNvbW1pdCBjb250YWlu
cyBpbnRlcmVzdGluZyBkZXRhaWxzIGFib3V0IHRoZW0gYW5kIHRoZWlyIA0Kb3JpZ2luczoN
Cg0KPGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kb2NzL21hbi1wYWdlcy9tYW4t
cGFnZXMuZ2l0L2NvbW1pdD9pZD02ZmY2ZjQzZDY4MTY0Zjk5YThjM2ZiNjZmNDUyNWQxNDU1
NzEzMTBjPg0KDQo+IHJlZmxvdyBwcm9ncmFtIHRoYXQgZml4ZXMgdGhlc2UgcHJvYmxlbXMg
bWVjaGFuaWNhbGx5LCBvciBpcyB0aGlzDQo+IGV4cGVjdGVkIHRvIGJlIHBlcmZvcm1lZCBt
YW51YWxseSBieSBtYW5wYWdlIGF1dGhvcnM/DQoNCkkgZG9uJ3Qga25vdyBvZiBhIHJlZmxv
dyBwcm9ncmFtIHRoYXQgZml4ZXMgdGhpcy4NClRoZSBiaWdnZXN0IGlzc3VlIGlzIHRoYXQN
CnBhcnNpbmcgbmF0dXJhbCBsYW5ndWFnZSBpcyBub3QgZXhhY3RseSBlYXN5Lg0KDQpTbywg
aXQgaXMgZXhwZWN0ZWQgdG8gYmUgcGVyZm9ybWVkIG1hbnVhbGx5IGJ5IGF1dGhvcnMuDQoN
Cj4gDQo+IElmIG1hbnVhbGx5LCBkbyB0aGUgaXRlbXMgaW4gYSBjb21tYS1zZXBhcmF0ZWQg
bGlzdCBjb3VudCBhcyBjbGF1c2VzPw0KDQpJdCBkZXBlbmRzLg0KUGVkYW50aWNhbGx5LCB5
ZXM7DQpidXQgd2UgZXZhbHVhdGUgaXQgY2FzZSBieSBjYXNlLA0KZGVwZW5kaW5nIG9uIHRo
ZSBsZW5ndGggb2YgZWFjaCBzZW50ZW5jZQ0KYW5kIHRoZSBleGlzdGVuY2Ugb2Ygc3Vib3Jk
aW5hdGUgY2xhdXNlcy4NClNvIGF1dGhvciB0YXN0ZSBpcyBpbXBvcnRhbnQgdGhlcmUgYW5k
IHJlc3BlY3RlZC4NCg0KPiANCj4gV291bGQgdGhlIG5leHQgdHdvIHBhcmFncmFwaHMgb2Yg
dGhpcyBlbWFpbCByZWZvcm1hdCBpbnRvIHNlbWFudGljDQo+IG5ld2xpbmVzIGxpa2Ugc28/
DQo+IA0KPiAJSW4gdGhlIHNvdXJjZSBvZiBhIG1hbnVhbCBwYWdlLA0KPiAJbmV3IHNlbnRl
bmNlcyBzaG91bGQgIGJlIHN0YXJ0ZWQgb24gbmV3IGxpbmVzLA0KPiAJbG9uZyBzZW50ZW5j
ZXMgc2hvdWxkIGJlIHNwbGl0IGludG8gbGluZXMgYXQgY2xhdXNlIGJyZWFrcw0KPiAJKGNv
bW1hcywgc2VtaWNvbG9ucywgY29sb25zLCBhbmQgc28gb24pLA0KPiAJYW5kIGxvbmcgY2xh
dXNlcyBzaG91bGQgYmUgc3BsaXQgYXQgcGhyYXNlIGJvdW5kYXJpZXMuDQo+IAlUaGlzIGNv
bnZlbnRpb24sDQo+IAlzb21ldGltZXMga25vd24gYXMgInNlbWFudGljIG5ld2xpbmVzIiwN
Cj4gCW1ha2VzIGl0IGVhc2llciB0byBzZWUgdGhlIGVmZmVjdCBvZiBwYXRjaGVzLA0KPiAJ
d2hpY2ggb2Z0ZW4gb3BlcmF0ZSBhdCB0aGUgbGV2ZWwgb2YgaW5kaXZpZHVhbCBzZW50ZW5j
ZXMsIGNsYXVzZXMsIG9yIHBocmFzZXMuDQo+IA0KID4NCiA+IC0tRA0KID4NCiA+Pj4gK0lm
IG5vbmUgb2YgdGhlIGFib3ZlIGlzIGF2YWlsYWJsZSwgdGhlbiBkaXJlY3QgSS9PIHN1cHBv
cnQgYW5kIA0KYWxpZ25tZW50DQogPj4NCiA+PiBQbGVhc2UgdXNlIHNlbWFudGljIG5ld2xp
bmVzLg0KID4+DQogPj4gU2VlIG1hbi1wYWdlcyg3KToNCiA+PiAgICAgVXNlIHNlbWFudGlj
IG5ld2xpbmVzDQogPj4gICAgICAgICBJbiB0aGUgc291cmNlIG9mIGEgbWFudWFsIHBhZ2Us
IG5ldyBzZW50ZW5jZXMgIHNob3VsZCAgYmUNCiA+PiAgICAgICAgIHN0YXJ0ZWQgb24gbmV3
IGxpbmVzLCBsb25nIHNlbnRlbmNlcyBzaG91bGQgYmUgc3BsaXQgaW50bw0KID4+ICAgICAg
ICAgbGluZXMgIGF0ICBjbGF1c2UgYnJlYWtzIChjb21tYXMsIHNlbWljb2xvbnMsIGNvbG9u
cywgYW5kDQogPj4gICAgICAgICBzbyBvbiksIGFuZCBsb25nIGNsYXVzZXMgc2hvdWxkIGJl
IHNwbGl0IGF0IHBocmFzZSBib3VuZOKAkA0KID4+ICAgICAgICAgYXJpZXMuICBUaGlzIGNv
bnZlbnRpb24sICBzb21ldGltZXMgIGtub3duICBhcyAgInNlbWFudGljDQogPj4gICAgICAg
ICBuZXdsaW5lcyIsICBtYWtlcyBpdCBlYXNpZXIgdG8gc2VlIHRoZSBlZmZlY3Qgb2YgcGF0
Y2hlcywNCiA+PiAgICAgICAgIHdoaWNoIG9mdGVuIG9wZXJhdGUgYXQgdGhlIGxldmVsIG9m
IGluZGl2aWR1YWwgc2VudGVuY2VzLA0KID4+ICAgICAgICAgY2xhdXNlcywgb3IgcGhyYXNl
cy4NCiA+Pg0KID4+DQogPj4+ICtyZXN0cmljdGlvbnMgY2FuIG9ubHkgYmUgYXNzdW1lZCBm
cm9tIGtub3duIGNoYXJhY3RlcmlzdGljcyBvZiB0aGUgDQpmaWxlc3lzdGVtLA0KID4+PiAr
dGhlIGluZGl2aWR1YWwgZmlsZSwgdGhlIHVuZGVybHlpbmcgc3RvcmFnZSBkZXZpY2Uocyks
IGFuZCB0aGUgDQprZXJuZWwgdmVyc2lvbi4NCiA+Pj4gK0luIExpbnV4IDIuNCwgbW9zdCBi
bG9jayBkZXZpY2UgYmFzZWQgZmlsZXN5c3RlbXMgcmVxdWlyZSB0aGF0IHRoZSANCmZpbGUg
b2Zmc2V0DQogPj4+ICthbmQgdGhlIGxlbmd0aCBhbmQgbWVtb3J5IGFkZHJlc3Mgb2YgYWxs
IEkvTyBzZWdtZW50cyBiZSBtdWx0aXBsZXMgDQpvZiB0aGUNCiA+Pj4gK2ZpbGVzeXN0ZW0g
YmxvY2sgc2l6ZSAodHlwaWNhbGx5IDQwOTYgYnl0ZXMpLg0KID4+PiArSW4gTGludXggMi42
LjAsIHRoaXMgd2FzIHJlbGF4ZWQgdG8gdGhlIGxvZ2ljYWwgYmxvY2sgc2l6ZSBvZiB0aGUg
DQpibG9jayBkZXZpY2UNCiA+Pj4gKyh0eXBpY2FsbHkgNTEyIGJ5dGVzKS4NCiA+Pj4gK0Eg
YmxvY2sgZGV2aWNlJ3MgbG9naWNhbCBibG9jayBzaXplIGNhbiBiZSBkZXRlcm1pbmVkIHVz
aW5nIHRoZQ0KID4+PiAgICAuQlIgaW9jdGwgKDIpDQogPj4+ICAgIC5CIEJMS1NTWkdFVA0K
ID4+PiAgICBvcGVyYXRpb24gb3IgZnJvbSB0aGUgc2hlbGwgdXNpbmcgdGhlIGNvbW1hbmQ6
DQogPj4+IGRpZmYgLS1naXQgYS9tYW4yL3N0YXR4LjIgYi9tYW4yL3N0YXR4LjINCiA+Pj4g
aW5kZXggMGQxYjQ1OTFmLi41MDM5NzA1N2QgMTAwNjQ0DQogPj4+IC0tLSBhL21hbjIvc3Rh
dHguMg0KID4+PiArKysgYi9tYW4yL3N0YXR4LjINCiA+Pj4gQEAgLTYxLDcgKzYxLDEyIEBA
IHN0cnVjdCBzdGF0eCB7DQogPj4+ICAgICAgICAgICBjb250YWluaW5nIHRoZSBmaWxlc3lz
dGVtIHdoZXJlIHRoZSBmaWxlIHJlc2lkZXMgKi8NCiA+Pj4gICAgICAgIF9fdTMyIHN0eF9k
ZXZfbWFqb3I7ICAgLyogTWFqb3IgSUQgKi8NCiA+Pj4gICAgICAgIF9fdTMyIHN0eF9kZXZf
bWlub3I7ICAgLyogTWlub3IgSUQgKi8NCiA+Pj4gKw0KID4+PiAgICAgICAgX191NjQgc3R4
X21udF9pZDsgICAgICAvKiBNb3VudCBJRCAqLw0KID4+PiArDQogPj4+ICsgICAgLyogRGly
ZWN0IEkvTyBhbGlnbm1lbnQgcmVzdHJpY3Rpb25zICovDQogPj4+ICsgICAgX191MzIgc3R4
X2Rpb19tZW1fYWxpZ247DQogPj4+ICsgICAgX191MzIgc3R4X2Rpb19vZmZzZXRfYWxpZ247
DQogPj4+ICAgIH07DQogPj4+ICAgIC5FRQ0KID4+PiAgICAuaW4NCiA+Pj4gQEAgLTI0Nyw2
ICsyNTIsOCBAQCBTVEFUWF9CVElNRQlXYW50IHN0eF9idGltZQ0KID4+PiAgICBTVEFUWF9B
TEwJVGhlIHNhbWUgYXMgU1RBVFhfQkFTSUNfU1RBVFMgfCBTVEFUWF9CVElNRS4NCiA+Pj4g
ICAgCUl0IGlzIGRlcHJlY2F0ZWQgYW5kIHNob3VsZCBub3QgYmUgdXNlZC4NCiA+Pj4gICAg
U1RBVFhfTU5UX0lECVdhbnQgc3R4X21udF9pZCAoc2luY2UgTGludXggNS44KQ0KID4+PiAr
U1RBVFhfRElPQUxJR04JV2FudCBzdHhfZGlvX21lbV9hbGlnbiBhbmQgc3R4X2Rpb19vZmZz
ZXRfYWxpZ24NCiA+Pj4gKwkoc2luY2UgTGludXggNi4xOyBzdXBwb3J0IHZhcmllcyBieSBm
aWxlc3lzdGVtKQ0KID4+PiAgICAuVEUNCiA+Pj4gICAgLmluDQogPj4+ICAgIC5QUA0KID4+
PiBAQCAtNDA3LDYgKzQxNCwyOCBAQCBUaGlzIGlzIHRoZSBzYW1lIG51bWJlciByZXBvcnRl
ZCBieQ0KID4+PiAgICAuQlIgbmFtZV90b19oYW5kbGVfYXQgKDIpDQogPj4+ICAgIGFuZCBj
b3JyZXNwb25kcyB0byB0aGUgbnVtYmVyIGluIHRoZSBmaXJzdCBmaWVsZCBpbiBvbmUgb2Yg
dGhlIA0KcmVjb3JkcyBpbg0KID4+PiAgICAuSVIgL3Byb2Mvc2VsZi9tb3VudGluZm8gLg0K
ID4+PiArLlRQDQogPj4+ICsuSSBzdHhfZGlvX21lbV9hbGlnbg0KID4+PiArVGhlIGFsaWdu
bWVudCAoaW4gYnl0ZXMpIHJlcXVpcmVkIGZvciB1c2VyIG1lbW9yeSBidWZmZXJzIGZvciAN
CmRpcmVjdCBJL08NCiA+Pj4gKy5CUiAiIiAoIE9fRElSRUNUICkNCiA+Pg0KID4+IC5SQiBh
bmQgcmVtb3ZlIHRoZSAiIi4NCiA+Pg0KID4+PiArb24gdGhpcyBmaWxlLCBvciAwIGlmIGRp
cmVjdCBJL08gaXMgbm90IHN1cHBvcnRlZCBvbiB0aGlzIGZpbGUuDQogPj4+ICsuSVANCiA+
Pj4gKy5CIFNUQVRYX0RJT0FMSUdODQogPj4+ICsuSVIgIiIgKCBzdHhfZGlvX21lbV9hbGln
bg0KID4+DQogPj4gLlJJDQogPj4NCiA+Pj4gK2FuZA0KID4+PiArLklSIHN0eF9kaW9fb2Zm
c2V0X2FsaWduICkNCiA+Pj4gK2lzIHN1cHBvcnRlZCBvbiBibG9jayBkZXZpY2VzIHNpbmNl
IExpbnV4IDYuMS4NCiA+Pj4gK1RoZSBzdXBwb3J0IG9uIHJlZ3VsYXIgZmlsZXMgdmFyaWVz
IGJ5IGZpbGVzeXN0ZW07IGl0IGlzIHN1cHBvcnRlZCANCmJ5IGV4dDQsDQogPj4+ICtmMmZz
LCBhbmQgeGZzIHNpbmNlIExpbnV4IDYuMS4NCiA+Pj4gKy5UUA0KID4+PiArLkkgc3R4X2Rp
b19vZmZzZXRfYWxpZ24NCiA+Pj4gK1RoZSBhbGlnbm1lbnQgKGluIGJ5dGVzKSByZXF1aXJl
ZCBmb3IgZmlsZSBvZmZzZXRzIGFuZCBJL08gc2VnbWVudCANCmxlbmd0aHMgZm9yDQogPj4+
ICtkaXJlY3QgSS9PDQogPj4+ICsuQlIgIiIgKCBPX0RJUkVDVCApDQogPj4+ICtvbiB0aGlz
IGZpbGUsIG9yIDAgaWYgZGlyZWN0IEkvTyBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMgZmls
ZS4NCiA+Pj4gK1RoaXMgd2lsbCBvbmx5IGJlIG5vbnplcm8gaWYNCiA+Pj4gKy5JIHN0eF9k
aW9fbWVtX2FsaWduDQogPj4+ICtpcyBub256ZXJvLCBhbmQgdmljZSB2ZXJzYS4NCiA+Pj4g
ICAgLlBQDQogPj4+ICAgIEZvciBmdXJ0aGVyIGluZm9ybWF0aW9uIG9uIHRoZSBhYm92ZSBm
aWVsZHMsIHNlZQ0KID4+PiAgICAuQlIgaW5vZGUgKDcpLg0KID4+Pg0KID4+PiBiYXNlLWNv
bW1pdDogYmMyOGQyODllNTA2NmZjNjI2ZGYyNjBiYWZjMjQ5ODQ2YTBmNmFlNg0KID4+DQog
Pj4gLS0NCiA+PiA8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQogPg0KID4N
CiA+DQpZZXMsIHRoYXQgd291bGQgYmUgY29ycmVjdDsNCmluIGZhY3QsDQp5b3UgYWxtb3N0
IG1hdGNoZWQgdGhlIGFjdHVhbCBzb3VyY2UgY29kZSBvZiB0aGUgbWFudWFsIHBhZ2UuDQpU
aGVyZSBhcmUgdHdvIGRpZmZlcmVuY2VzOg0Kb25lIGNvbW1hIGF0IHdoaWNoIHdlIGRvbid0
IGJyZWFrIChidXQgd2UgY291bGQpLA0KYW5kIGFsc28gd2UgYnJlYWsgdGhlIGxhc3QgbGlu
ZSBiZWZvcmUgdGhlIGxpc3QuDQoNClNlZSB0aGUgc291cmNlIGNvZGUgaGVyZToNCjxodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZG9jcy9tYW4tcGFnZXMvbWFuLXBhZ2VzLmdp
dC90cmVlL21hbjcvbWFuLXBhZ2VzLjcjbjYxMj4NCg0KPiBEbyB3ZSBzdGlsbCBsaW5lLXdy
YXAgYXQgNzJeVzc0Xlc3OF5XODAgY29sdW1ucz8NCg0KWWVzLCA4MCBpcyBhIHN0cm9uZyBs
aW1pdC4NCg0KTm9ybWFsbHksDQpicmVha2luZyBhdCB0aGUgbGV2ZWwgb2YgY2xhdXNlcw0K
d2lsbCBsZWF2ZSB2ZXJ5IGZldyBsaW5lcyBwYXNzaW5nIHRoYXQgbGltaXQuDQpXaGVuIHRo
ZXJlJ3Mgc3VjaCBhIGNhc2UsDQp5b3UgY2FuIGJyZWFrIGZ1cnRoZXIgYXQgdGhlIGxldmVs
IG9mIHBocmFzZXMsDQphbmQgSSBkb3VidCBhbnkgbGluZSB3aWxsIHBhc3MgdGhlIDgwLWNv
bCBib3VuZGFyeSBhZnRlciB0aGF0Lg0KDQo+IA0KPiBhbmQgd291bGQgdGhlIHByb3Bvc2Vk
IG1hbnBhZ2UgdGV4dCByZWFkOg0KPiANCj4gCUlmIG5vbmUgb2YgdGhlIGFib3ZlIGlzIGF2
YWlsYWJsZSwNCj4gCXRoZW4gZGlyZWN0IEkvTyBzdXBwb3J0IGFuZCBhbGlnbm1lbnQgcmVz
dHJpY3Rpb25zIGNhbiBvbmx5IGJlIGFzc3VtZWQNCj4gCWZyb20ga25vd24gY2hhcmFjdGVy
aXN0aWNzIG9mIHRoZSBmaWxlc3lzdGVtLA0KPiAJdGhlIGluZGl2aWR1YWwgZmlsZSwNCj4g
CXRoZSB1bmRlcmx5aW5nIHN0b3JhZ2UgZGV2aWNlKHMpLA0KPiAJYW5kIHRoZSBrZXJuZWwg
dmVyc2lvbi4NCj4gCUluIExpbnV4IDIuNCwNCj4gCW1vc3QgYmxvY2sgZGV2aWNlIGJhc2Vk
IGZpbGVzeXN0ZW1zIHJlcXVpcmUgdGhhdCB0aGUgZmlsZSBvZmZzZXQgYW5kIHRoZQ0KDQpi
bG9jayBkZXZpY2UgYmFzZWQgd291bGQgbmVlZCBzb21lICctJyBhcyBpdCdzIGEgY29tcG91
bmQgYWRqZWN0aXZlIChJIA0KZG9uJ3Qga25vdyB0aGUgZXhhY3QgcnVsZXMgaW4gRW5nbGlz
aCB3aGVuIHRoZXJlIGFyZSBtb3JlIHRoYW4gdHdvIHdvcmRzIA0KZm9ybWluZyBzdWNoIGFu
IGFkamVjdGl2ZSwgcGxlYXNlIGNoZWNrKS4NCg0KSSB3b3VsZCBicmVhayBhZnRlciAncmVx
dWlyZSB0aGF0Jy4NCg0KPiAJbGVuZ3RoIGFuZCBtZW1vcnkgYWRkcmVzcyBvZiBhbGwgSS9P
IHNlZ21lbnRzIGJlIG11bHRpcGxlcyBvZiB0aGUNCg0KQW5kIHJpZ2h0IGJlZm9yZSAnYmUn
LCBJIHRoaW5rLg0KDQo+IAlmaWxlc3lzdGVtIGJsb2NrIHNpemUNCj4gCSh0eXBpY2FsbHkg
NDA5NiBieXRlcykuDQo+IAlJbiBMaW51eCAyLjYuMCwNCj4gCXRoaXMgd2FzIHJlbGF4ZWQg
dG8gdGhlIGxvZ2ljYWwgYmxvY2sgc2l6ZSBvZiB0aGUgYmxvY2sgZGV2aWNlDQo+IAkodHlw
aWNhbGx5IDUxMiBieXRlcykuDQo+IAlBIGJsb2NrIGRldmljZSdzIGxvZ2ljYWwgYmxvY2sg
c2l6ZSBjYW4gYmUgZGV0ZXJtaW5lZCB1c2luZyB0aGUNCj4gCS5CUiBpb2N0bCAoMikNCj4g
CS5CIEJMS1NTWkdFVA0KPiAJb3BlcmF0aW9uIG9yIGZyb20gdGhlIHNoZWxsIHVzaW5nIHRo
ZSBjb21tYW5kOg0KDQpCdXQgbW9zdGx5IGxvb2tzIGdvb2QuDQoNCkNoZWVycywNCg0KQWxl
eA0KDQotLSANCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------QDGjJfjSqcau0rYuUmoIyW5q--

--------------FLnbu1X71N4cWPrqt0YiFtO0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNERS4ACgkQnowa+77/
2zKj7A//aKQdZfQ6EpJ/XAWi+TPnghN4kxWqXEI401BOlj0xLosNPhLSc/grsWB4
Ydsw286mZChBMYuYbnTrcpTyvHZXnaFSbNAoRKpSPAEn2Sc7Bx2ppZY4gGIQy51o
O4zAZd1/cGQLc1f90nq5XCKaMjv5H9+20SHIUVAYu3BYYWuGAnYUBI5y7BTKp8Mj
ZmctVJEh9Zk3DvrbHKnT1kiM2VZ+SPpZFgJpNkON18Dy1EUdHVos6yo1yL+YBNEj
6cTdnM6opOkYMCA9mxgoxE0ADXD0c/b32ctz67BT+Q04AeBxzelt0ZlUPN8i2vWn
eGEkarSOwTMd4ftRWO/5LpBQpXkIZYl5h9slhewTcnFcw0YQI1g1wWF0hO/mOxNE
uGDNS9/Xp5/BkSe2fmE2d7aCvs64Wm+ybv6c1F0wm0SF/leZuQVwtl8KJ1GQUIIn
g/idOzXvNjlGlL4Buc++4DAIChceOAGCifJG87zEozx6swfdAZpMe3I8apklbvZN
tZdTcxBPIXxjo73x3RAy52AIh9vYwMbAYQa+99CzImPxZakMwo1QebvQEW0mjh9r
vfmfGrCUs2z1LCmK5f713S5KYdV6ahiVBLaMHaj+RZXUs2ZhQziqZYsV4fdoG+CP
hAWQM6MHw6o9Jsx42D7qZAXeHRJQdF86BuAl6jvRh+uUsnPT380=
=cEgx
-----END PGP SIGNATURE-----

--------------FLnbu1X71N4cWPrqt0YiFtO0--
