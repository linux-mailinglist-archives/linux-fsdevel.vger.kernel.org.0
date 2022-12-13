Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1F64C062
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Dec 2022 00:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbiLMXSV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 18:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbiLMXST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:18:19 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788D7183BC;
        Tue, 13 Dec 2022 15:18:18 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so9202042wmb.2;
        Tue, 13 Dec 2022 15:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vacqH88FUNan5uc11twtF4/03DcXtDAgTvsUlY31Oqo=;
        b=eR7ZRZjcjawKY/quLRcZfwuVsIKzRJ5eEOuVOppODGf78KPbGGF/TO8DtF9mfh13Vd
         AjV8AdieZh7TAlQLGb+QPXKWJHZM6XwGsWelMvxIfczcBhOljR5HiF/GcdU9ZL+3mkKU
         dIAvf9WW941Z3vzxp4H360NsXIn/rjWcQjZjXrc99cghAIFGOLGyfS+0UbKmIkRD3HHz
         Q4d658n59aYEeZUYo0w1x3TV/utiggEeD9sG+3day2zd/DPj/7d/Hieg4Tg5wYo7EEJT
         GuU0GHCvoOHwKDVDTC5XcIrMXTQ0vK1m3JGvUcxPTfW4XLrvThwn++CbA+obE2xTStzE
         p1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vacqH88FUNan5uc11twtF4/03DcXtDAgTvsUlY31Oqo=;
        b=CKxKreJySj/mLVsOWyAltL2J16sHqM5DLifyWvHx1qvycqxlawEpUaq30ThM0SxoNY
         OtdvPvXRjXTzFxxsqLDeTyO/Ocofxc4oV+fZRUbXFbjgVHKdG4YJTu7ewztW84oQ5wJZ
         IA5+UTNFZxT3KXEUn2942qnKH5cC71io0L9V3PJl/GHfUS6vt5moaQZg2F4HZUiY1fy6
         5eLL5Jx1LVirVaaxMKuzIR0xj2MyYILhurHURaAgYAElQwK124lI0/Nz0Y0IZfYkig7/
         k/8tSeUAwMfGJoXJaokgKnydV95woJbK0TyvYQgf2yFDx1CfkcCbjLRtx0yEnHchMg71
         WQbA==
X-Gm-Message-State: ANoB5pkER6wKggCJKNmz82t//2LdlmReSmeVXAzFaLxI2IE5q78Tr9iy
        0cggVdaXTXk2McAJdCX63yU=
X-Google-Smtp-Source: AA0mqf4kgZha2gHVU7MLwZB62SKj0eMi4wj4Z+pv68CTlQQOVpfBi9I1vMSJpWJZh/44/iIq75jMfw==
X-Received: by 2002:a05:600c:538f:b0:3d0:2485:c046 with SMTP id hg15-20020a05600c538f00b003d02485c046mr16995380wmb.27.1670973496924;
        Tue, 13 Dec 2022 15:18:16 -0800 (PST)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id e5-20020a05600c254500b003c6d21a19a0sm200001wma.29.2022.12.13.15.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 15:18:16 -0800 (PST)
Message-ID: <0c932ff1-1b5f-3a3b-1b81-1bbe710e1994@gmail.com>
Date:   Wed, 14 Dec 2022 00:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] copy_file_range.2: Fix wrong kernel version information
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
References: <20221213120834.948163-1-amir73il@gmail.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20221213120834.948163-1-amir73il@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xtHd3hDnYkhSZtbe3z0aiKB3"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xtHd3hDnYkhSZtbe3z0aiKB3
Content-Type: multipart/mixed; boundary="------------v7Hkknm2ucdki00UKWnrTv4z";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Luis Henriques <lhenriques@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org
Message-ID: <0c932ff1-1b5f-3a3b-1b81-1bbe710e1994@gmail.com>
Subject: Re: [PATCH] copy_file_range.2: Fix wrong kernel version information
References: <20221213120834.948163-1-amir73il@gmail.com>
In-Reply-To: <20221213120834.948163-1-amir73il@gmail.com>

--------------v7Hkknm2ucdki00UKWnrTv4z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW1pciwNCg0KT24gMTIvMTMvMjIgMTM6MDgsIEFtaXIgR29sZHN0ZWluIHdyb3RlOg0K
PiBjb21taXQgZDdiYTYxMmQwICgiY29weV9maWxlX3JhbmdlLjI6IFVwZGF0ZSBjcm9zcy1m
aWxlc3lzdGVtIHN1cHBvcnQNCj4gZm9yIDUuMTIiKSBwcmVtYXR1cmVseSBkb2N1bWVudGVk
IGtlcm5lbCA1LjEyIGFzIHRoZSB2ZXJzaW9uIHRoYXQNCj4gY2hhbmdlcyB0aGUgY3Jvc3Mt
ZnMgY29weV9maWxlX3JhbmdlKCkgYmVoYXZpb3IsIGJ1dCB0aGF0IGJlaGF2aW9yDQo+IGNo
YW5nZSB3YXMgb25seSBtZXJnZWQgaW4ga2VybmVsIHZlcnNpb24gNS4xOS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+DQoNClRo
YW5rcyEgIFBhdGNoIGFwcGxpZWQuDQoNCkNoZWVycywNCg0KQWxleA0KDQo+IC0tLQ0KPiAg
IG1hbjIvY29weV9maWxlX3JhbmdlLjIgfCAxNyArKysrKysrKysrKy0tLS0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL21hbjIvY29weV9maWxlX3JhbmdlLjIgYi9tYW4yL2NvcHlfZmlsZV9y
YW5nZS4yDQo+IGluZGV4IGFjNzRkOWEwNy4uMjUxNDZhMWRkIDEwMDY0NA0KPiAtLS0gYS9t
YW4yL2NvcHlfZmlsZV9yYW5nZS4yDQo+ICsrKyBiL21hbjIvY29weV9maWxlX3JhbmdlLjIN
Cj4gQEAgLTE1Miw3ICsxNTIsOCBAQCBPdXQgb2YgbWVtb3J5Lg0KPiAgIC5CIEVOT1NQQw0K
PiAgIFRoZXJlIGlzIG5vdCBlbm91Z2ggc3BhY2Ugb24gdGhlIHRhcmdldCBmaWxlc3lzdGVt
IHRvIGNvbXBsZXRlIHRoZSBjb3B5Lg0KPiAgIC5UUA0KPiAtLkJSIEVPUE5PVFNVUFAgIiAo
c2luY2UgTGludXggNS4xMikiDQo+ICsuQlIgRU9QTk9UU1VQUCAiIChzaW5jZSBMaW51eCA1
LjE5KSINCj4gKy5cIiBjb21taXQgODY4ZjlmMmY4ZTAwNGJmZTBkMzkzNWIxOTc2ZjYyNWIy
OTI0ODkzYg0KPiAgIFRoZSBmaWxlc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgdGhpcyBvcGVy
YXRpb24uDQo+ICAgLlRQDQo+ICAgLkIgRU9WRVJGTE9XDQo+IEBAIC0xNzEsMTEgKzE3Miwx
MyBAQCBvcg0KPiAgIHJlZmVycyB0byBhbiBhY3RpdmUgc3dhcCBmaWxlLg0KPiAgIC5UUA0K
PiAgIC5CUiBFWERFViAiIChiZWZvcmUgTGludXggNS4zKSINCj4gKy5cIiBjb21taXQgNWRh
ZTIyMmE1ZmYwYzI2OTczMDM5MzAxOGE1NTM5Y2M5NzBhNDcyNg0KPiAgIFRoZSBmaWxlcyBy
ZWZlcnJlZCB0byBieQ0KPiAgIC5JUiBmZF9pbiAiIGFuZCAiIGZkX291dA0KPiAgIGFyZSBu
b3Qgb24gdGhlIHNhbWUgZmlsZXN5c3RlbS4NCj4gICAuVFANCj4gLS5CUiBFWERFViAiIChz
aW5jZSBMaW51eCA1LjEyKSINCj4gKy5CUiBFWERFViAiIChzaW5jZSBMaW51eCA1LjE5KSIN
Cj4gKy5cIiBjb21taXQgODY4ZjlmMmY4ZTAwNGJmZTBkMzkzNWIxOTc2ZjYyNWIyOTI0ODkz
Yg0KPiAgIFRoZSBmaWxlcyByZWZlcnJlZCB0byBieQ0KPiAgIC5JUiBmZF9pbiAiIGFuZCAi
IGZkX291dA0KPiAgIGFyZSBub3Qgb24gdGhlIHNhbWUgZmlsZXN5c3RlbSwNCj4gQEAgLTE5
MSwxMyArMTk0LDE1IEBAIGVtdWxhdGlvbiB3aGVuIGl0IGlzIG5vdCBhdmFpbGFibGUuDQo+
ICAgQSBtYWpvciByZXdvcmsgb2YgdGhlIGtlcm5lbCBpbXBsZW1lbnRhdGlvbiBvY2N1cnJl
ZCBpbiBMaW51eCA1LjMuDQo+ICAgQXJlYXMgb2YgdGhlIEFQSSB0aGF0IHdlcmVuJ3QgY2xl
YXJseSBkZWZpbmVkIHdlcmUgY2xhcmlmaWVkIGFuZCB0aGUgQVBJIGJvdW5kcw0KPiAgIGFy
ZSBtdWNoIG1vcmUgc3RyaWN0bHkgY2hlY2tlZCB0aGFuIG9uIGVhcmxpZXIga2VybmVscy4N
Cj4gLUFwcGxpY2F0aW9ucyBzaG91bGQgdGFyZ2V0IHRoZSBiZWhhdmlvdXIgYW5kIHJlcXVp
cmVtZW50cyBvZiA1LjMga2VybmVscy4NCj4gICAuUFANCj4gLVNpbmNlIExpbnV4IDUuMTIs
DQo+ICtTaW5jZSBMaW51eCA1LjE5LA0KPiAgIGNyb3NzLWZpbGVzeXN0ZW0gY29waWVzIGNh
biBiZSBhY2hpZXZlZA0KPiAgIHdoZW4gYm90aCBmaWxlc3lzdGVtcyBhcmUgb2YgdGhlIHNh
bWUgdHlwZSwNCj4gICBhbmQgdGhhdCBmaWxlc3lzdGVtIGltcGxlbWVudHMgc3VwcG9ydCBm
b3IgaXQuDQo+IC1TZWUgQlVHUyBmb3IgYmVoYXZpb3IgcHJpb3IgdG8gTGludXggNS4xMi4N
Cj4gK1NlZSBCVUdTIGZvciBiZWhhdmlvciBwcmlvciB0byBMaW51eCA1LjE5Lg0KPiArLlBQ
DQo+ICtBcHBsaWNhdGlvbnMgc2hvdWxkIHRhcmdldCB0aGUgYmVoYXZpb3VyIGFuZCByZXF1
aXJlbWVudHMgb2YgNS4xOSBrZXJuZWxzLA0KPiArdGhhdCB3YXMgYWxzbyBiYWNrcG9ydGVk
IHRvIGVhcmxpZXIgc3RhYmxlIGtlcm5lbHMuDQo+ICAgLlNIIFNUQU5EQVJEUw0KPiAgIFRo
ZQ0KPiAgIC5CUiBjb3B5X2ZpbGVfcmFuZ2UgKCkNCj4gQEAgLTIyMyw3ICsyMjgsNyBAQCBz
dWNoIGFzIHRoZSB1c2Ugb2YgcmVmbGlua3MgKGkuZS4sIHR3byBvciBtb3JlIGlub2RlcyB0
aGF0IHNoYXJlDQo+ICAgcG9pbnRlcnMgdG8gdGhlIHNhbWUgY29weS1vbi13cml0ZSBkaXNr
IGJsb2NrcykNCj4gICBvciBzZXJ2ZXItc2lkZS1jb3B5IChpbiB0aGUgY2FzZSBvZiBORlMp
Lg0KPiAgIC5TSCBCVUdTDQo+IC1JbiBMaW51eCA1LjMgdG8gTGludXggNS4xMSwNCj4gK0lu
IExpbnV4IDUuMyB0byBMaW51eCA1LjE4LA0KPiAgIGNyb3NzLWZpbGVzeXN0ZW0gY29waWVz
IHdlcmUgaW1wbGVtZW50ZWQgYnkgdGhlIGtlcm5lbCwNCj4gICBpZiB0aGUgb3BlcmF0aW9u
IHdhcyBub3Qgc3VwcG9ydGVkIGJ5IGluZGl2aWR1YWwgZmlsZXN5c3RlbXMuDQo+ICAgSG93
ZXZlciwgb24gc29tZSB2aXJ0dWFsIGZpbGVzeXN0ZW1zLA0KDQotLSANCjxodHRwOi8vd3d3
LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------v7Hkknm2ucdki00UKWnrTv4z--

--------------xtHd3hDnYkhSZtbe3z0aiKB3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmOZCDAACgkQnowa+77/
2zLA+g//Q+oHUl8d2gKeL6+vuxcv/k9MFjznTKfxMGqfnzHb2Irn8O2Oz9vsGfKL
pM10UpIoNq71/ACaDb+/bwzKraCGtFdyf6sbEBJ/TdvDKOC7ZtpDiuu49YuSc+Ko
p/L14c/IG3rWMOgCP82Zhu/uQGr9q/pj80v1bCjp0Q3Dr0yHfwximqVWxokwCFbU
yLB1SK63VUr5dT5POcD74/wkfMqzn/iFNiNgjDbgCqpp+b0t8XsibTH1Mzs9KdF6
iTd8Px/4rCDhmv+p5+NSPjx1HPfXbB2jSKu7YXcajXz9rffW0cYXz3bltuDR6tn0
68jd9jekaw+UhN/rdtRJD7FS1lhLflRKFnKCgOYg8zuauOkTQmvtah9rKbjfZu9J
kuzlo4wmfwBl0R1OF9HCrHKgMOKsiLSwcL6fpahup4qpM1uytCe+D3J6pwe7fT5D
64m/UmKM6nc+Ks9DwdO8hBjYpfgamf82fM69bagvtHnb1vKiY/qycFrq/qeh1G4B
B98UAa6QBzXuy+TsFwEafiqR5Zrru10ON1Y1nOjiZGQsiK/zdmV8T1vxJnji30rS
uq0dYwDINKOND5Ben3Mf8gBgQLz3U76zkCir7dP0EV9s5CClpn7YYYuvudGnqwb3
k1Tv3W3g0+voBmISNJjF+g4a3gLFRxATohmWrHu4ECKUUR7LQDg=
=s6Uy
-----END PGP SIGNATURE-----

--------------xtHd3hDnYkhSZtbe3z0aiKB3--
