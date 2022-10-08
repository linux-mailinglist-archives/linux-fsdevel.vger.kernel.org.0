Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D475F8230
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 03:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJHB42 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJHB41 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 21:56:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69BBEAF0;
        Fri,  7 Oct 2022 18:56:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c3-20020a1c3503000000b003bd21e3dd7aso5491800wma.1;
        Fri, 07 Oct 2022 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtt8Sd1iGvBuE6r8qw66viAhLvTlUSClwTSyeRVy/5s=;
        b=MlnO6IzMqSsdHgJfSn9GuImG8SiiU8gEa577JRbAfC9M5MT+fV3LtYjofrrzC542qh
         SM17l9Y/FWKLhbVPZoK/voLcK41mEwlW9pW+ts6Blqhl1H/+tvtSRwrv8YCkKWt83G1/
         SZNal9HjHUgkCq+zkq2X4Sm3j+IZ4Bj3ZIXdbCcG3Lzbvk7sPLcFC2Y87r5WZlHGh4r3
         3jvTt7HuOiBSp/DOY/B04RoFUBYvmqnapONbzpBqKkDRIyscw+M3Mr6fF6bAY/UM1kpF
         ihSa7DtsnGDwJziaEP7e49+RVSUau/E4i+ETknql5kSXtbqY/ulmPOJ8yk7bXK12p1qD
         XYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gtt8Sd1iGvBuE6r8qw66viAhLvTlUSClwTSyeRVy/5s=;
        b=H4USI0e4yrdsB0J7LgM4xNur4CCxErm993ycu6jSwnCQP726IZtXO+VZSx7tI36wrX
         e1VaR/SAL4KajBhMtFzrfwPbulMERoU2cYHcXRxZtgRN7Cj7ZI8Tx/Cv9nCza44rOty7
         dhe058sEYgjYBOII8FA5fbUxGo+mCwpVslL8aIASMd0iKoBEj3vxMG3Mqr4quEHqGiHu
         oqKlKoRwLyvEh5NjjV41S2kuACQTUbQL57QMn8IAAqY/7B+0uoByrhsXpW1AT+8Q/F+2
         MfnUKmZON+KG7OMMhBsnVTBQ4m9SuOag11B6CkRrtDRhKGncc9FUPHEYx6mTC6OUHAed
         k2uA==
X-Gm-Message-State: ACrzQf3b0mBe1MbfDtuE5umqwru4S0BN7NmZFJ7sH5YAPywN2RdakyXn
        jrcZx6P3ScOhA1p/FyinZcXkOH3mSUQ=
X-Google-Smtp-Source: AMsMyM6HyGtxtWyy2bSr683HtwijJ2P4jcCtuTJjIlcmddwD3D8OauMqDtzRyaCGy96ZwITPylXXgw==
X-Received: by 2002:a7b:c341:0:b0:3c4:552d:2ea7 with SMTP id l1-20020a7bc341000000b003c4552d2ea7mr820449wmj.82.1665194184239;
        Fri, 07 Oct 2022 18:56:24 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id s4-20020adff804000000b00226dedf1ab7sm3299967wrp.76.2022.10.07.18.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 18:56:23 -0700 (PDT)
Message-ID: <26cafc28-e63a-6f13-df70-8ccec85a4ef0@gmail.com>
Date:   Sat, 8 Oct 2022 03:56:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [man-pages PATCH v3] statx.2, open.2: document STATX_DIOALIGN
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>, linux-man@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
References: <20221004174307.6022-1-ebiggers@kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20221004174307.6022-1-ebiggers@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------x4E24oHe3w0nvhvCysX22mSr"
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------x4E24oHe3w0nvhvCysX22mSr
Content-Type: multipart/mixed; boundary="------------NegtShqtP2zaLlI3tpK20uRp";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>, linux-man@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <26cafc28-e63a-6f13-df70-8ccec85a4ef0@gmail.com>
Subject: Re: [man-pages PATCH v3] statx.2, open.2: document STATX_DIOALIGN
References: <20221004174307.6022-1-ebiggers@kernel.org>
In-Reply-To: <20221004174307.6022-1-ebiggers@kernel.org>

--------------NegtShqtP2zaLlI3tpK20uRp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRXJpYywNCg0KT24gMTAvNC8yMiAxOTo0MywgRXJpYyBCaWdnZXJzIHdyb3RlOg0KPiBG
cm9tOiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+IA0KPiBEb2N1bWVu
dCB0aGUgU1RBVFhfRElPQUxJR04gc3VwcG9ydCBmb3Igc3RhdHgoKQ0KPiAoaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9saW51cy83MjU3MzdlN2MyMWQyZDI1KS4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBEYXJyaWNrIEouIFdvbmcgPGRqd29uZ0BrZXJuZWwub3JnPg0KPiBTaWduZWQtb2Zm
LWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQoNClBsZWFzZSBzZWUg
c29tZSBmb3JtYXR0aW5nIGNvbW1lbnRzIGJlbG93Lg0KDQo+IC0tLQ0KPiANCj4gSSdtIHJl
c2VuZGluZyB0aGlzIG5vdyB0aGF0IHN1cHBvcnQgZm9yIFNUQVRYX0RJT0FMSUdOIGhhcyBi
ZWVuIG1lcmdlZA0KPiB1cHN0cmVhbS4NCg0KVGhhbmtzLg0KDQpDaGVlcnMsDQpBbGV4DQoN
Cj4gDQo+IHYzOiB1cGRhdGVkIG1lbnRpb25zIG9mIExpbnV4IHZlcnNpb24sIGZpeGVkIHNv
bWUgcHVuY3R1YXRpb24sIGFuZCBhZGRlZA0KPiAgICAgIGEgUmV2aWV3ZWQtYnkNCj4gDQo+
IHYyOiByZWJhc2VkIG9udG8gbWFuLXBhZ2VzIG1hc3RlciBicmFuY2gsIG1lbnRpb25lZCB4
ZnMsIGFuZCB1cGRhdGVkDQo+ICAgICAgbGluayB0byBwYXRjaHNldA0KPiANCj4gICBtYW4y
L29wZW4uMiAgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tDQo+ICAgbWFuMi9zdGF0eC4yIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21hbjIvb3Blbi4yIGIvbWFuMi9vcGVuLjINCj4g
aW5kZXggZGViYTdlNGVhLi5iODYxN2UwZDIgMTAwNjQ0DQo+IC0tLSBhL21hbjIvb3Blbi4y
DQo+ICsrKyBiL21hbjIvb3Blbi4yDQo+IEBAIC0xNzMyLDIxICsxNzMyLDQyIEBAIG9mIHVz
ZXItc3BhY2UgYnVmZmVycyBhbmQgdGhlIGZpbGUgb2Zmc2V0IG9mIEkvT3MuDQo+ICAgSW4g
TGludXggYWxpZ25tZW50DQo+ICAgcmVzdHJpY3Rpb25zIHZhcnkgYnkgZmlsZXN5c3RlbSBh
bmQga2VybmVsIHZlcnNpb24gYW5kIG1pZ2h0IGJlDQo+ICAgYWJzZW50IGVudGlyZWx5Lg0K
PiAtSG93ZXZlciB0aGVyZSBpcyBjdXJyZW50bHkgbm8gZmlsZXN5c3RlbVwtaW5kZXBlbmRl
bnQNCj4gLWludGVyZmFjZSBmb3IgYW4gYXBwbGljYXRpb24gdG8gZGlzY292ZXIgdGhlc2Ug
cmVzdHJpY3Rpb25zIGZvciBhIGdpdmVuDQo+IC1maWxlIG9yIGZpbGVzeXN0ZW0uDQo+IC1T
b21lIGZpbGVzeXN0ZW1zIHByb3ZpZGUgdGhlaXIgb3duIGludGVyZmFjZXMNCj4gLWZvciBk
b2luZyBzbywgZm9yIGV4YW1wbGUgdGhlDQo+ICtUaGUgaGFuZGxpbmcgb2YgbWlzYWxpZ25l
ZA0KPiArLkIgT19ESVJFQ1QNCj4gK0kvT3MgYWxzbyB2YXJpZXM7IHRoZXkgY2FuIGVpdGhl
ciBmYWlsIHdpdGgNCj4gKy5CIEVJTlZBTA0KPiArb3IgZmFsbCBiYWNrIHRvIGJ1ZmZlcmVk
IEkvTy4NCj4gKy5QUA0KPiArU2luY2UgTGludXggNi4xLA0KPiArLkIgT19ESVJFQ1QNCj4g
K3N1cHBvcnQgYW5kIGFsaWdubWVudCByZXN0cmljdGlvbnMgZm9yIGEgZmlsZSBjYW4gYmUg
cXVlcmllZCB1c2luZw0KPiArLkJSIHN0YXR4ICgyKSwNCj4gK3VzaW5nIHRoZQ0KPiArLkIg
U1RBVFhfRElPQUxJR04NCj4gK2ZsYWcuDQo+ICtTdXBwb3J0IGZvcg0KPiArLkIgU1RBVFhf
RElPQUxJR04NCj4gK3ZhcmllcyBieSBmaWxlc3lzdGVtOyBzZWUNCj4gKy5CUiBzdGF0eCAo
MikuDQo+ICsuUFANCj4gK1NvbWUgZmlsZXN5c3RlbXMgcHJvdmlkZSB0aGVpciBvd24gaW50
ZXJmYWNlcyBmb3IgcXVlcnlpbmcNCj4gKy5CIE9fRElSRUNUDQo+ICthbGlnbm1lbnQgcmVz
dHJpY3Rpb25zLCBmb3IgZXhhbXBsZSB0aGUNCj4gICAuQiBYRlNfSU9DX0RJT0lORk8NCj4g
ICBvcGVyYXRpb24gaW4NCj4gICAuQlIgeGZzY3RsICgzKS4NCj4gKy5CIFNUQVRYX0RJT0FM
SUdODQo+ICtzaG91bGQgYmUgdXNlZCBpbnN0ZWFkIHdoZW4gaXQgaXMgYXZhaWxhYmxlLg0K
PiAgIC5QUA0KPiAtVW5kZXIgTGludXggMi40LCB0cmFuc2ZlciBzaXplcywgdGhlIGFsaWdu
bWVudCBvZiB0aGUgdXNlciBidWZmZXIsDQo+IC1hbmQgdGhlIGZpbGUgb2Zmc2V0IG11c3Qg
YWxsIGJlIG11bHRpcGxlcyBvZiB0aGUgbG9naWNhbCBibG9jayBzaXplDQo+IC1vZiB0aGUg
ZmlsZXN5c3RlbS4NCj4gLVNpbmNlIExpbnV4IDIuNi4wLCBhbGlnbm1lbnQgdG8gdGhlIGxv
Z2ljYWwgYmxvY2sgc2l6ZSBvZiB0aGUNCj4gLXVuZGVybHlpbmcgc3RvcmFnZSAodHlwaWNh
bGx5IDUxMiBieXRlcykgc3VmZmljZXMuDQo+IC1UaGUgbG9naWNhbCBibG9jayBzaXplIGNh
biBiZSBkZXRlcm1pbmVkIHVzaW5nIHRoZQ0KPiArSWYgbm9uZSBvZiB0aGUgYWJvdmUgaXMg
YXZhaWxhYmxlLCB0aGVuIGRpcmVjdCBJL08gc3VwcG9ydCBhbmQgYWxpZ25tZW50DQoNClBs
ZWFzZSB1c2Ugc2VtYW50aWMgbmV3bGluZXMuDQoNClNlZSBtYW4tcGFnZXMoNyk6DQogICAg
VXNlIHNlbWFudGljIG5ld2xpbmVzDQogICAgICAgIEluIHRoZSBzb3VyY2Ugb2YgYSBtYW51
YWwgcGFnZSwgbmV3IHNlbnRlbmNlcyAgc2hvdWxkICBiZQ0KICAgICAgICBzdGFydGVkIG9u
IG5ldyBsaW5lcywgbG9uZyBzZW50ZW5jZXMgc2hvdWxkIGJlIHNwbGl0IGludG8NCiAgICAg
ICAgbGluZXMgIGF0ICBjbGF1c2UgYnJlYWtzIChjb21tYXMsIHNlbWljb2xvbnMsIGNvbG9u
cywgYW5kDQogICAgICAgIHNvIG9uKSwgYW5kIGxvbmcgY2xhdXNlcyBzaG91bGQgYmUgc3Bs
aXQgYXQgcGhyYXNlIGJvdW5k4oCQDQogICAgICAgIGFyaWVzLiAgVGhpcyBjb252ZW50aW9u
LCAgc29tZXRpbWVzICBrbm93biAgYXMgICJzZW1hbnRpYw0KICAgICAgICBuZXdsaW5lcyIs
ICBtYWtlcyBpdCBlYXNpZXIgdG8gc2VlIHRoZSBlZmZlY3Qgb2YgcGF0Y2hlcywNCiAgICAg
ICAgd2hpY2ggb2Z0ZW4gb3BlcmF0ZSBhdCB0aGUgbGV2ZWwgb2YgaW5kaXZpZHVhbCBzZW50
ZW5jZXMsDQogICAgICAgIGNsYXVzZXMsIG9yIHBocmFzZXMuDQoNCg0KPiArcmVzdHJpY3Rp
b25zIGNhbiBvbmx5IGJlIGFzc3VtZWQgZnJvbSBrbm93biBjaGFyYWN0ZXJpc3RpY3Mgb2Yg
dGhlIGZpbGVzeXN0ZW0sDQo+ICt0aGUgaW5kaXZpZHVhbCBmaWxlLCB0aGUgdW5kZXJseWlu
ZyBzdG9yYWdlIGRldmljZShzKSwgYW5kIHRoZSBrZXJuZWwgdmVyc2lvbi4NCj4gK0luIExp
bnV4IDIuNCwgbW9zdCBibG9jayBkZXZpY2UgYmFzZWQgZmlsZXN5c3RlbXMgcmVxdWlyZSB0
aGF0IHRoZSBmaWxlIG9mZnNldA0KPiArYW5kIHRoZSBsZW5ndGggYW5kIG1lbW9yeSBhZGRy
ZXNzIG9mIGFsbCBJL08gc2VnbWVudHMgYmUgbXVsdGlwbGVzIG9mIHRoZQ0KPiArZmlsZXN5
c3RlbSBibG9jayBzaXplICh0eXBpY2FsbHkgNDA5NiBieXRlcykuDQo+ICtJbiBMaW51eCAy
LjYuMCwgdGhpcyB3YXMgcmVsYXhlZCB0byB0aGUgbG9naWNhbCBibG9jayBzaXplIG9mIHRo
ZSBibG9jayBkZXZpY2UNCj4gKyh0eXBpY2FsbHkgNTEyIGJ5dGVzKS4NCj4gK0EgYmxvY2sg
ZGV2aWNlJ3MgbG9naWNhbCBibG9jayBzaXplIGNhbiBiZSBkZXRlcm1pbmVkIHVzaW5nIHRo
ZQ0KPiAgIC5CUiBpb2N0bCAoMikNCj4gICAuQiBCTEtTU1pHRVQNCj4gICBvcGVyYXRpb24g
b3IgZnJvbSB0aGUgc2hlbGwgdXNpbmcgdGhlIGNvbW1hbmQ6DQo+IGRpZmYgLS1naXQgYS9t
YW4yL3N0YXR4LjIgYi9tYW4yL3N0YXR4LjINCj4gaW5kZXggMGQxYjQ1OTFmLi41MDM5NzA1
N2QgMTAwNjQ0DQo+IC0tLSBhL21hbjIvc3RhdHguMg0KPiArKysgYi9tYW4yL3N0YXR4LjIN
Cj4gQEAgLTYxLDcgKzYxLDEyIEBAIHN0cnVjdCBzdGF0eCB7DQo+ICAgICAgICAgIGNvbnRh
aW5pbmcgdGhlIGZpbGVzeXN0ZW0gd2hlcmUgdGhlIGZpbGUgcmVzaWRlcyAqLw0KPiAgICAg
ICBfX3UzMiBzdHhfZGV2X21ham9yOyAgIC8qIE1ham9yIElEICovDQo+ICAgICAgIF9fdTMy
IHN0eF9kZXZfbWlub3I7ICAgLyogTWlub3IgSUQgKi8NCj4gKw0KPiAgICAgICBfX3U2NCBz
dHhfbW50X2lkOyAgICAgIC8qIE1vdW50IElEICovDQo+ICsNCj4gKyAgICAvKiBEaXJlY3Qg
SS9PIGFsaWdubWVudCByZXN0cmljdGlvbnMgKi8NCj4gKyAgICBfX3UzMiBzdHhfZGlvX21l
bV9hbGlnbjsNCj4gKyAgICBfX3UzMiBzdHhfZGlvX29mZnNldF9hbGlnbjsNCj4gICB9Ow0K
PiAgIC5FRQ0KPiAgIC5pbg0KPiBAQCAtMjQ3LDYgKzI1Miw4IEBAIFNUQVRYX0JUSU1FCVdh
bnQgc3R4X2J0aW1lDQo+ICAgU1RBVFhfQUxMCVRoZSBzYW1lIGFzIFNUQVRYX0JBU0lDX1NU
QVRTIHwgU1RBVFhfQlRJTUUuDQo+ICAgCUl0IGlzIGRlcHJlY2F0ZWQgYW5kIHNob3VsZCBu
b3QgYmUgdXNlZC4NCj4gICBTVEFUWF9NTlRfSUQJV2FudCBzdHhfbW50X2lkIChzaW5jZSBM
aW51eCA1LjgpDQo+ICtTVEFUWF9ESU9BTElHTglXYW50IHN0eF9kaW9fbWVtX2FsaWduIGFu
ZCBzdHhfZGlvX29mZnNldF9hbGlnbg0KPiArCShzaW5jZSBMaW51eCA2LjE7IHN1cHBvcnQg
dmFyaWVzIGJ5IGZpbGVzeXN0ZW0pDQo+ICAgLlRFDQo+ICAgLmluDQo+ICAgLlBQDQo+IEBA
IC00MDcsNiArNDE0LDI4IEBAIFRoaXMgaXMgdGhlIHNhbWUgbnVtYmVyIHJlcG9ydGVkIGJ5
DQo+ICAgLkJSIG5hbWVfdG9faGFuZGxlX2F0ICgyKQ0KPiAgIGFuZCBjb3JyZXNwb25kcyB0
byB0aGUgbnVtYmVyIGluIHRoZSBmaXJzdCBmaWVsZCBpbiBvbmUgb2YgdGhlIHJlY29yZHMg
aW4NCj4gICAuSVIgL3Byb2Mvc2VsZi9tb3VudGluZm8gLg0KPiArLlRQDQo+ICsuSSBzdHhf
ZGlvX21lbV9hbGlnbg0KPiArVGhlIGFsaWdubWVudCAoaW4gYnl0ZXMpIHJlcXVpcmVkIGZv
ciB1c2VyIG1lbW9yeSBidWZmZXJzIGZvciBkaXJlY3QgSS9PDQo+ICsuQlIgIiIgKCBPX0RJ
UkVDVCApDQoNCi5SQiBhbmQgcmVtb3ZlIHRoZSAiIi4NCg0KPiArb24gdGhpcyBmaWxlLCBv
ciAwIGlmIGRpcmVjdCBJL08gaXMgbm90IHN1cHBvcnRlZCBvbiB0aGlzIGZpbGUuDQo+ICsu
SVANCj4gKy5CIFNUQVRYX0RJT0FMSUdODQo+ICsuSVIgIiIgKCBzdHhfZGlvX21lbV9hbGln
bg0KDQouUkkNCg0KPiArYW5kDQo+ICsuSVIgc3R4X2Rpb19vZmZzZXRfYWxpZ24gKQ0KPiAr
aXMgc3VwcG9ydGVkIG9uIGJsb2NrIGRldmljZXMgc2luY2UgTGludXggNi4xLg0KPiArVGhl
IHN1cHBvcnQgb24gcmVndWxhciBmaWxlcyB2YXJpZXMgYnkgZmlsZXN5c3RlbTsgaXQgaXMg
c3VwcG9ydGVkIGJ5IGV4dDQsDQo+ICtmMmZzLCBhbmQgeGZzIHNpbmNlIExpbnV4IDYuMS4N
Cj4gKy5UUA0KPiArLkkgc3R4X2Rpb19vZmZzZXRfYWxpZ24NCj4gK1RoZSBhbGlnbm1lbnQg
KGluIGJ5dGVzKSByZXF1aXJlZCBmb3IgZmlsZSBvZmZzZXRzIGFuZCBJL08gc2VnbWVudCBs
ZW5ndGhzIGZvcg0KPiArZGlyZWN0IEkvTw0KPiArLkJSICIiICggT19ESVJFQ1QgKQ0KPiAr
b24gdGhpcyBmaWxlLCBvciAwIGlmIGRpcmVjdCBJL08gaXMgbm90IHN1cHBvcnRlZCBvbiB0
aGlzIGZpbGUuDQo+ICtUaGlzIHdpbGwgb25seSBiZSBub256ZXJvIGlmDQo+ICsuSSBzdHhf
ZGlvX21lbV9hbGlnbg0KPiAraXMgbm9uemVybywgYW5kIHZpY2UgdmVyc2EuDQo+ICAgLlBQ
DQo+ICAgRm9yIGZ1cnRoZXIgaW5mb3JtYXRpb24gb24gdGhlIGFib3ZlIGZpZWxkcywgc2Vl
DQo+ICAgLkJSIGlub2RlICg3KS4NCj4gDQo+IGJhc2UtY29tbWl0OiBiYzI4ZDI4OWU1MDY2
ZmM2MjZkZjI2MGJhZmMyNDk4NDZhMGY2YWU2DQoNCi0tIA0KPGh0dHA6Ly93d3cuYWxlamFu
ZHJvLWNvbG9tYXIuZXMvPg0K

--------------NegtShqtP2zaLlI3tpK20uRp--

--------------x4E24oHe3w0nvhvCysX22mSr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNA2MYACgkQnowa+77/
2zK5kw//fXQx4S3OL/pT8fA6cPcGbkKppj3y8jm224xgNltGQMKb7Cak0stDmGKO
d2DKLfWtEAdWovBJcryyjjyLrHtsYbvUff4ulx74wiUAmxOMmTvFIbmvhK6DJDUe
PIswvZEb0/XkX9oOYvXf24ZTX3HcIpXGZYuCCgmTyCbEFYtBj/50YoScoffCW6DY
kYdQK92kixPFv2Dy8TtO9Eo+J7c7TuNuZWpU9/3HMT+gQavNfwtSR+wHoeZEur+M
wso6Ydm662Fm8hWzMddVPSV1wDYfbNShbQNYuTB0LBef+7X/rLDK2b3xcC8JPk1R
87i3LCdju4Byqpb9IhaMaNDE1zSowYst+wSg4ArGsCi5TJ9X2CSy0peewSW/sUqq
7YPXyTepTRSUoFGNpvAguhAqoYAkpxV0ZwrMZ2GhyeSUMQtZc2PB3px+87l8Zua9
+lL0BRttlGau7BbURhvvYqvlKDLzemqh0YXXMhtbCBD2YCQEtuCDEoC1fsbU5Ayn
XBXDDlxCX+fJ31MgW606xLgCgqPuzIHQPX04/fsRy4YdnC4u+A8r8R92mhoojVws
rC2z4qx9JB+UvcNZvyycP1YyBCZthMBYOj3PyBLCSRSCAWugC9x7TsO0I2GPjSej
vIEb4e9Q2WDQQCGVGMwtvqX/zPvrXMDEFQ0cZYL1FPPRFDGAMZc=
=xGWP
-----END PGP SIGNATURE-----

--------------x4E24oHe3w0nvhvCysX22mSr--
