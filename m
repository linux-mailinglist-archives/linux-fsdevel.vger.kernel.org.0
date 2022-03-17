Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8291B4DC1F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 09:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiCQIyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 04:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiCQIyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:54:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B8FB7C51
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 01:53:27 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b28so7852866lfc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 01:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simula-no.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references
         :content-language:from:organization:subject:in-reply-to;
        bh=Pn2D/XphWFQAwpS423iqLudPmYtfFoZr+7o3QGz3CKo=;
        b=kTDDGQYXXGfzsw8EoZ/vCu6OzYxTo9nOgNJ/FfYGdzQSec7CZTEq5iUvsEgbaP0rDT
         f6wLv9uifjGDusp1xgKgxlMAF6BwKbPsWtUbzkEaSTRL9Y2nvpIMpTFxtLOcjMs+BGc0
         KFf6cuDLJXV3ShVA5FnTgkSU2qEuwGmlfvdy/mXmowcfvuQ9wfOfW4hmkIA42zNWUUoZ
         tAmJEvhmbQmjj6yazqkt7cXUsFE99sgFZk4fN6jfZLpdu6jTsRzTERANIXx4Oe77TwWn
         sXv+N5G3pxytZgUmIgEw/tRy7h7JTnTAf2B6UlRCZycAjJK5hUXT/tdoRopqZtALwWwS
         HwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:content-language:from:organization:subject:in-reply-to;
        bh=Pn2D/XphWFQAwpS423iqLudPmYtfFoZr+7o3QGz3CKo=;
        b=tBlRB1F7NFxVM99a/K1WUWqRc+r+2S8bqFeRPy6kUIEBOviUdKZPYUp/K1FtRzlibs
         z/RTiFnSdLB9jsKCAVJ7jnvPTpJqyxhsME/DSpWS5YKKbgXwQu/j16UbFSYy2/3QkC1h
         JYmIxt2f3x2yGKNEe2N0ABYlhRkv6irtfJXW35X/3WRGdIkc86J2G6QTcdQrMaSD1BKD
         wEAIOIDun+12bqJfCXGbSq9k8h8u5lMT/JujMRK6mclj3FgbpxMmhWkALlQBYggk+FO/
         bAK41aGLq1+8wR1iqAGdckGWyjx0NfmzLkDOAsjlghu2IhzPh9HnHvgvaxS8za3Shue5
         53cA==
X-Gm-Message-State: AOAM533Guujulpjz1JZlqG7w271nDl7wpl8yIpD8nqVMMes3FerZgDZx
        5T107Xxq351Gdn8H5kowD9wb81IMg2DAoroN
X-Google-Smtp-Source: ABdhPJwSFyMCzN5mlk7yFiQLgcl/hTXM1xfoNpUwIVULzFD5cXl+9x9/YlTr5nDpfEuAL0sJF37qLQ==
X-Received: by 2002:ac2:54ad:0:b0:443:153e:97fc with SMTP id w13-20020ac254ad000000b00443153e97fcmr2278224lfk.252.1647507205884;
        Thu, 17 Mar 2022 01:53:25 -0700 (PDT)
Received: from ?IPV6:2001:700:702:c052:92e2:baff:fe48:bde1? ([2001:700:702:c052:92e2:baff:fe48:bde1])
        by smtp.googlemail.com with ESMTPSA id b2-20020a196442000000b00443c5b81ce0sm391970lfj.180.2022.03.17.01.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 01:53:25 -0700 (PDT)
Message-ID: <842c582a-ecb6-31a1-fad1-54a4e9c05b94@simula.no>
Date:   Thu, 17 Mar 2022 09:53:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     gandalf@winds.org
Cc:     david@fromorbit.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        willy@infradead.org
References: <1a5cd8ce-e7c7-5aa8-e475-ad7810e2f057@winds.org>
Content-Language: en-US
From:   Thomas Dreibholz <dreibh@simula.no>
Organization: Simula Research Laboratory
Subject: Re: Is it time to remove reiserfs?
In-Reply-To: <1a5cd8ce-e7c7-5aa8-e475-ad7810e2f057@winds.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lYU50J0IIPINxUeuakBpVoTc"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lYU50J0IIPINxUeuakBpVoTc
Content-Type: multipart/mixed; boundary="------------kHUxQknlySGba1WR4J6Hs01n";
 protected-headers="v1"
From: Thomas Dreibholz <dreibh@simula.no>
To: gandalf@winds.org
Cc: david@fromorbit.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
 willy@infradead.org
Message-ID: <842c582a-ecb6-31a1-fad1-54a4e9c05b94@simula.no>
Subject: Re: Is it time to remove reiserfs?
References: <1a5cd8ce-e7c7-5aa8-e475-ad7810e2f057@winds.org>
In-Reply-To: <1a5cd8ce-e7c7-5aa8-e475-ad7810e2f057@winds.org>

--------------kHUxQknlySGba1WR4J6Hs01n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkganVzdCBub3RpY2VkIHRoZSB0aHJlYWQgYWJvdXQgUmVpc2VyRlMgZGVwcmVj
YXRpb24uIFdlIGFyZSBjdXJyZW50bHkgDQpzdGlsbCB1c2luZyBSZWlzZXJGUyBvbiBjYS4g
NTAgcHJvZHVjdGlvbiBtYWNoaW5lcyBvZiB0aGUgTm9yTmV0IENvcmUgDQppbmZyYXN0cnVj
dHVyZSAoaHR0cHM6Ly93d3cubm50Yi5uby8pLiBXaGlsZSBuZXdlciBtYWNoaW5lcyB1c2Ug
QlRSRlMgDQppbnN0ZWFkLCB0aGUgb2xkZXIgbWFjaGluZXMgaGFkIFJlaXNlckZTIHVzZWQs
IGR1ZSB0byBpdHMgc3RhYmlsaXR5IGFuZCANCmJldHRlciBwZXJmb3JtYW5jZSBpbiBjb21w
YXJpc29uIHRvIGV4dDQuIEF0IHRoZWlyIGluc3RhbGxhdGlvbiB0aW1lLCB3ZSANCmRpZCBu
b3QgY29uc2lkZXIgQlRSRlMgYmVpbmcgbWF0dXJlIGVub3VnaC4gQSBkZXByZWNhdGlvbiBw
ZXJpb2Qgb2YgY2EuIA0KNSB5ZWFycyBmcm9tIG5vdyBzZWVtcyB0byBiZSByZWFzb25hYmxl
LCBhbHRob3VnaCBpdCB3b3VsZCBiZSBuaWNlIHRvIA0KaGF2ZSBhdCBsZWFzdCBhIHJlYWQt
b25seSBjYXBhYmlsaXR5IGF2YWlsYWJsZSBmb3Igc29tZSBsb25nZXIgdGltZSwgZm9yIA0K
dGhlIGNhc2UgaXQgYmVjb21lcyBuZWNlc3NhcnkgdG8gcmVhZCBhbiBvbGQgUmVpc2VyRlMg
ZmlsZSBzeXN0ZW0gb24gYSANCm5ld2VyIHN5c3RlbS4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMg
LyBNaXQgZnJldW5kbGljaGVuIEdyw7zDn2VuIC8gTWVkIHZlbm5saWcgaGlsc2VuDQoNCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQogIFRob21hcyBEcmVpYmhvbHoNCg0KICBTaW11bGFNZXQg4oCU
IFNpbXVsYSBNZXRyb3BvbGl0YW4gQ2VudHJlIGZvciBEaWdpdGFsIEVuZ2luZWVyaW5nDQog
IENlbnRyZSBmb3IgUmVzaWxpZW50IE5ldHdvcmtzIGFuZCBBcHBsaWNhdGlvbnMNCiAgUGls
ZXN0cmVkZXQgNTINCiAgMDE2NyBPc2xvLCBOb3J3YXkNCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQog
IEUtTWFpbDogICAgIGRyZWliaEBzaW11bGEubm8NCiAgSG9tZXBhZ2U6ICAgaHR0cDovL3Np
bXVsYS5uby9wZW9wbGUvZHJlaWJoDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQo=

--------------kHUxQknlySGba1WR4J6Hs01n--

--------------lYU50J0IIPINxUeuakBpVoTc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsd5BAABCAAjFiEEIUEmclGNiy0YYu/vXNXRKqCHe0kFAmIy9wIFAwAAAAAACgkQXNXRKqCHe0mi
aT/9FiQPt7sAQPq7cnCmHsLmmQ3c0+bYFgrSrPNMh3e+ZerzDa3Y+eRCFJUWwKm1co0qbxn7qNuP
Y5xmJhtx4i83QgZMBMnr3fxTIxvf3A2n+0FOpmbHxTLj4m8k1EjtZjBUU6DKRb206diNK0bcatVg
kv6uWmJphI4nvxxwlGnokZZhJNQJHYtQpQwBE0pg9y5qtb4NTJ2B1JRh/kgfQC4kVEgkXA/qsF2R
+Zd8l8wJSnwEaCZ3wzc+tcaby/0xyn37OkwJnCMwQOwrAXfUIk9QE+vdfAVv0LPpeZzXqq4Uh3fD
8uarxIHT5FWwCaru2GXkMmqbut+TaR2NB81KgTM7em0320giv7Y3ODXESbdxP70ppX6EPuW0mi/j
30PKFmrLLFxBNSv4aP/+WdMZan69q8RRYEdYJWG4METBShbJGOuJjSG0jgGHkSCPOHj45DoMTJLs
sBknNgnvu0FvkdpnlqqWHPCoAcIFJv72kJz6Hr0AGxWhHdXxhMPW7gIvz3AckbUAFqOhIZT7fkvy
xWfurme+9DOnf2ri39Ma3D2BYYCYMiBSNcF3wW3zHlSOdRGBXw/gxpVsSRlDb/qU5emg4Iy8ALy0
0bLwixV/t5Y2pBehThW1il2CJ0RcRTfumyF6x9WiM+OAJ30VP3FaXFrjyMXX+tOXfYiGDjMzcoF0
stjZxKMLOWwMWKWkMvszMOq6KREsU5nhIny8vEeobijkP5ADX9rxuv9F4TxnGBb9NbBdI0ojoxIj
nsJoECUQ8+LgaOaw8QYwE8805oFfy+NpDmtNWXWUpT79GcbFY1gMg21u7IXXselFogTRmVzW190a
M6gSvrV8N9vNKhuxSe4YXzj6BsJfAmHdSDqVFsKETlb6jyw/GNHR+a4kLmCTjlwigtrNvP96JVgK
7ca8LZObh21GkPlm+6eKq745zOzov9KJdqK3/eVpsFzHlypxg9MrZRXXpVrpUspst3lKinJpRaiz
UgAK5Kd1w/u2rOupwymVQOQnmKo+awFBvfQELOGlNhyIuRhlPqT9XxewkroxvyI/818vwZfMBCf1
WcQq3EQsI4oASUu7mU449FjG/ZWR1mJO/I40R0kZ9XwA77r7E/bgSM4+UI0hXrovfwmtFly9rOj0
q7nYOwIGQykGYUwLVYcxx2cduI5TfMCYu5xUN0AjGpVr5/diafjBsZbB+1MRSypos5/B6FLN0E9H
Bh5jFl8O7vx+aBBomZ3drRvxCYJ7PPdsGtXqDCs+UcT7B+PutNeaRMChq7Z6+zMYqWXJOeSCHUCB
GH6P7IT9QS+i7HGorTBlZJFLRRLRn+2cdZ8AQtoWswzGI4RsjIm/In+HKY7JkbDLJIuJxKD7zfpC
gq8BH4ohycXpi3JWhKG2h9qwTnhXeEHWRCNiYpmQX4ddfUe4R2cBlTKRsq02HuKsR/cjjqBMRxWL
G5BzpI0PIPWeLqCPIYH5OZmA6+emv0gROptBTHpAyXonIrRuTZIja6uWv7EHAUJwd2p87vPZfE9m
no0pi/r1zwXhGSr1ehPQpj02y2cWo6GnEfzcvC7q2M0T+OQbW02iuli69gP2OBPc3CryX7e+Mpdu
Hn7HE45dj2g/LNDH3fMYDCji1yDeTRUqEUlK1/rWbFc5zBMELywO3EsQ8S21PCJvdVoSN3BkFA4a
1Fs0+cSNAuCnbhOTY4xDbnodKR5skIhgx+c/EDdQeV4WijVqx6xJeO9sPyTtPmaycOdGcYY9/uz9
rHacR3Oc8GVXqHwQfuV58C93EMig3kFnBBbebfJzLIWt7Kwx82QK/9f2jZ6pImurpYNlU2wsKI+Y
Ox84MT/pz9mKMWZ70ijk2pfDCmYAPcCZEAFdxlsQtxDWendegW0D5lF5EYGkcVCUBBuzc7kMZTd9
Mwn7eFcsakA1IroGkVb0y2GKaTl6bJdXViuPZI8kMtAop8G2byw14w/iQCKdA6Ie78fgwXT9El9O
ljUZ7rAw/7XatbfYTqUQ8fNc5ocn4z0sSx8pwKt4zau7BP2Bz1bYKYSR2YtyQoBHFYZ8HVX2W7dM
2hGtf6AWvA29DwUm1Y5Wfp3JzA9W6OJVvRVHdGyB1FmEGYJ8aHqMb9yK+AcDWNFSidt9wp1SZYx+
orhL4bKbKevn4EIDcLZ3NtknXPWQqfC6bK2sbyqOeh3ltNKXi2aRkpOv3zt8mnnscSzajW8C+cWW
SyDlqfAlfxW0kXhK/siMqwkMvizm0/mKswmEguCo+cFpICqk2rBdyh7jFj5nz/jF9eVwVxkaUL07
Xod+YQ5Vv7TcnBrP8mqNET4RCK3dj35PJx6KY45nlLjBpLTxtYIlHY6/HVZaW3fV3Wt2Wj7G5SX4
AH1nph5IQo1c2+2RgdInDJLXZ0vebejGAvE6AXXFMkXWA+9iXCN9bsMsYJvr9ncFCdT8twQI9i9T
jvuAnA3bxc66nC5KRAKojhPqyZbCBVyo9M3ipIzejsDAPeYAcJUeOAAxPTbzDZqfHtN3B0JSEonC
RPYK+fRBcqqPMXXEWbeF6lMEECZZlG11Qhcmz8txdZiJhHa1XwMnQ8w8f61+kv8mY7113mv52FGp
nodNffjmczeN8sE2oF9BkpgOrWdfIVuePHY1uS8soXrUxVmVtNp+DgYMTPJAZjpaZdG32VfaV3pD
QFics2Z+M5h1xOX8eY7cn5NtzFn3jR7aMs0Cr5X7l2IyEo5tpevhLtyBIXZpqN/qci3H/+BJCyo=
=vaHh
-----END PGP SIGNATURE-----

--------------lYU50J0IIPINxUeuakBpVoTc--
