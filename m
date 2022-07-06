Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65435695E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 01:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiGFXeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 19:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiGFXeB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:34:01 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4792C659;
        Wed,  6 Jul 2022 16:34:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h124-20020a1c2182000000b003a2cc290135so143929wmh.2;
        Wed, 06 Jul 2022 16:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=7uN3TE8ciXjwyj/aKbdVrzNi/l8vH7QLww5nXKltScc=;
        b=ZZ4Vg2f3kof5p10myWSb6sMMJptDWOGNC6AJqq9uQcgL/bFi3Te1xWGot+mTDGBnEm
         DEpoTfXb4QuBxEQ/cEoYxyt9VCJXgQvF4F7/10S+L1UrbbshiRnYm51S+fbOwQL7G6Rc
         76wJOJUfJBVflidv9Lys3yqSJJTHxDpLs4Rxykm+IqCxQFJeN1eG77IKzp5oE+iobGpP
         lwJpjikXWAx7DF5h9Id+GT7Rcxuk6eCEObVcvy9RAwDZKUFJO47p8fOeGe9u+wFBBQcp
         dB/HEERbhnVuRURd2fnGP772RVqsszmnPfhUQmxvo9RSlUM8tD6k9BFNE4A8lUdBt0Z3
         JRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=7uN3TE8ciXjwyj/aKbdVrzNi/l8vH7QLww5nXKltScc=;
        b=4iVW11MwtqVowcpZ1dJgs7DQsMa2z9tP0jgHREpcaVPLp7uf/Skpg5BuNTgumwJ8Bi
         nOdNB3s0lkHyUI+u40oyRt4NCYxkdqAlJy8EsUDqLUVOLiXZ+rzleVXK6moSET+/CLKH
         rQxrlGQYaL3TGXXyNJE69PNc+2sXxCxCgr9IN1LGVD1Pwj/0CTS/ZYvWAgrgzhe04/qA
         FV9Oouz4+mYHdN7sa8Srq9VXDMIe2dddLEXQOa+5Qg7BMIa2FJfuwtOnAgZi5zdIK/lT
         dEA8nLUAQoUVJBE5iWBMVehd5s7MMFP6GLtnPUK6n4My72pJON0u/FkrYs87Y7jkjg8o
         RwOg==
X-Gm-Message-State: AJIora/hwhkal/L/TOtX5ifThEDecauKj4FczaJNCe8ryDNJCMabg8us
        X38CwRysf7LJaKe2L26iCNI8jXNbWj0=
X-Google-Smtp-Source: AGRyM1sok8vZz5A8KZrE56sZGKm1R7jMzGgrhxa5kuaW8tnFdbdVLjGXLJ5WAdJcDxNRZXsvwW9Kqw==
X-Received: by 2002:a05:600c:1548:b0:3a1:95fc:aa42 with SMTP id f8-20020a05600c154800b003a195fcaa42mr1070776wmg.189.1657150439311;
        Wed, 06 Jul 2022 16:33:59 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id f2-20020a7bcd02000000b003a0499df21asm28248741wmj.25.2022.07.06.16.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 16:33:58 -0700 (PDT)
Message-ID: <b932fe32-b35f-66de-503e-6dd558139c45@gmail.com>
Date:   Thu, 7 Jul 2022 01:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [man-pages PATCH RESEND] statx.2: correctly document STATX_ALL
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
References: <20220705183614.16786-1-ebiggers@kernel.org>
 <YsS58QJf4jQ4r3QM@magnolia>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YsS58QJf4jQ4r3QM@magnolia>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GYgA4A5i0Gr9ZEqPjS0ELgTg"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GYgA4A5i0Gr9ZEqPjS0ELgTg
Content-Type: multipart/mixed; boundary="------------OXuvrFPMUb95oRm0KY4sWL6B";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, Andreas Dilger <adilger@dilger.ca>
Message-ID: <b932fe32-b35f-66de-503e-6dd558139c45@gmail.com>
Subject: Re: [man-pages PATCH RESEND] statx.2: correctly document STATX_ALL
References: <20220705183614.16786-1-ebiggers@kernel.org>
 <YsS58QJf4jQ4r3QM@magnolia>
In-Reply-To: <YsS58QJf4jQ4r3QM@magnolia>

--------------OXuvrFPMUb95oRm0KY4sWL6B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk9uIDcvNi8yMiAwMDoyMywgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPiBPbiBU
dWUsIEp1bCAwNSwgMjAyMiBhdCAxMTozNjoxNEFNIC0wNzAwLCBFcmljIEJpZ2dlcnMgd3Jv
dGU6DQo+PiBGcm9tOiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+Pg0K
Pj4gU2luY2Uga2VybmVsIGNvbW1pdCA1ODE3MDFiN2VmZDYgKCJ1YXBpOiBkZXByZWNhdGUg
U1RBVFhfQUxMIiksDQo+PiBTVEFUWF9BTEwgaXMgZGVwcmVjYXRlZC4gIEl0IGRvZXNuJ3Qg
aW5jbHVkZSBTVEFUWF9NTlRfSUQsIGFuZCBpdCB3b24ndA0KPj4gaW5jbHVkZSBhbnkgZnV0
dXJlIGZsYWdzLiAgVXBkYXRlIHRoZSBtYW4gcGFnZSBhY2NvcmRpbmdseS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQoNClRo
YW5rcyBmb3IgdGhlIHBhdGNoISAgQXBwbGllZC4NCj4gDQo+IEFzIHRoZSBsYXN0IGlkaW90
IHRvIHRyaXAgb3ZlciB0aGlzLA0KPiBSZXZpZXdlZC1ieTogRGFycmljayBKLiBXb25nIDxk
andvbmdAa2VybmVsLm9yZz4NCg0KQW5kIHRoYW5rcyBmb3IgdGhlIHJldmlld3MsIEFuZHJl
YXMgYW5kIERhcnJpY2ssIEkgYWRkZWQgYm90aCBvZiB5b3VyIHRhZ3MuDQoNCkNoZWVycywN
Cg0KQWxleA0KDQo+IA0KPiAtLUQNCj4gDQo+PiAtLS0NCj4+ICAgbWFuMi9zdGF0eC4yIHwg
MyArKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9tYW4yL3N0YXR4LjIgYi9tYW4yL3N0YXR4LjIN
Cj4+IGluZGV4IGE4NjIwYmU2Zi4uNTYxZTY0ZjdiIDEwMDY0NA0KPj4gLS0tIGEvbWFuMi9z
dGF0eC4yDQo+PiArKysgYi9tYW4yL3N0YXR4LjINCj4+IEBAIC0yNDQsOCArMjQ0LDkgQEAg
U1RBVFhfU0laRQlXYW50IHN0eF9zaXplDQo+PiAgIFNUQVRYX0JMT0NLUwlXYW50IHN0eF9i
bG9ja3MNCj4+ICAgU1RBVFhfQkFTSUNfU1RBVFMJW0FsbCBvZiB0aGUgYWJvdmVdDQo+PiAg
IFNUQVRYX0JUSU1FCVdhbnQgc3R4X2J0aW1lDQo+PiArU1RBVFhfQUxMCVRoZSBzYW1lIGFz
IFNUQVRYX0JBU0lDX1NUQVRTIHwgU1RBVFhfQlRJTUUuDQo+PiArICAgICAgICAgCVRoaXMg
aXMgZGVwcmVjYXRlZCBhbmQgc2hvdWxkIG5vdCBiZSB1c2VkLg0KPj4gICBTVEFUWF9NTlRf
SUQJV2FudCBzdHhfbW50X2lkIChzaW5jZSBMaW51eCA1LjgpDQo+PiAtU1RBVFhfQUxMCVtB
bGwgY3VycmVudGx5IGF2YWlsYWJsZSBmaWVsZHNdDQo+PiAgIC5URQ0KPj4gICAuaW4NCj4+
ICAgLlBQDQo+Pg0KPj4gYmFzZS1jb21taXQ6IDg4NjQ2NzI1MTg3NDU2ZmFkNmYxNzU1MmU5
NmM1MGM5M2JkMzYxZGMNCj4+IC0tIA0KPj4gMi4zNy4wDQo+Pg0KDQotLSANCkFsZWphbmRy
byBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQo=

--------------OXuvrFPMUb95oRm0KY4sWL6B--

--------------GYgA4A5i0Gr9ZEqPjS0ELgTg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmLGG+UACgkQnowa+77/
2zKwXg//UsVmzTSlPCAK8tDZHr68w8HOMrQRGS8fo3Dm7u0wnG4Ic4/b1ibTXk0Y
MoMDPXLEUTKNEarCyPobceWO00kbgLLgG/dSpblI1+qng5Wc4J1zwk25/RPoV0ph
syWpTgvBJ+H/fX2HTh9Ou46DIRKcRyQAzCOiB56zXaXP+GXL9bIVJuq6cNHfyMH2
GZ7oiCAjV2oC7R99y0sehnNyxGpV18DTGRnDDs8Bh3bgu4gpoFupaEl/sxPbokUm
/iKztVLag3xBoxqW5DFmTwLEyC4T61XkrCmbnIFBDLHjTmpff4aV2h+AbFfsmB+H
mZmxFbafjBhaaF5hmKuK9CwbCoZL7Q6Yhm9jIX+H04G8C+chyGysdYzzZLHfgikY
7TLUJCyD2ZWDSEhUQx4y5eQmWVG2L+aLzlYceJXyA+E5Kfgv27xnTWr4oQnT5xH+
y8oBUoAsNBxyF2yEzQoelEQ8xqkR1y1dJCcMLAas2aX7aClpo1tRBu66Vube+o8F
C88r+jNdgKYzFZM4wVo4RuADHilXAPKHRAdYunjLKGNnQu/7jPKCp1eSCcTFwuf4
OF1VACXzm1MCraM6Oe06L3XVyWu/nux+hdV9SAYZ80PTMLiN3FD66XXFDq5ZujtY
p5cStGKsbFVfUMqPj3ph5OZi6gaEcugXERALRVSAbckXkSe33TY=
=Ob1q
-----END PGP SIGNATURE-----

--------------GYgA4A5i0Gr9ZEqPjS0ELgTg--
