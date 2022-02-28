Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BB54C62A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 06:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbiB1Fn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 00:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiB1FnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:43:24 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15112626;
        Sun, 27 Feb 2022 21:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=ZarKmxo+ugXggNHBorwehSX+5pGd4hCfQ7JY95+wXEI=; b=ocZgmVNRz4UhLSI31zBjGwrXff
        FRXuCbcpR0g7OPLOwncqvBKP7FxOzrZL1qaDfC9xrwevGV4bqR0e8YWLWG776CvMaRUX2fdkPS4m9
        HmL+pXxZN6imPx9Z6cEvkez7rrTSEOsRoMml8anMQuU3GEt05TIFyXw3mRSD0OxD8APS8B/qGZF5w
        467T943XGoz4BCHAwan9360I3F/njMd+yQowFAUKrdYb83a38lAO7/E6RIZp73gekd9qCN/J1sJ2F
        nWkQy7fhKOdaNv251AHA3reQiRzwYEDGfKSPWOVSbbIVqHSKYUugw9myc6FbSEurM3T3/LPVkxVo8
        8nyV0hY3OHccr2Kmu/KrVgtX0ENX77tfspFEGUqBCTPGutZVgUOEVw9sVkgn6ymzk7KgBMYvBSOTZ
        JAyqLigrFFobqpFWSk2o7SNvUDujk6ZR3FKTQUEx7r57kG5VTnJRHmaMhTkDbwnGJ7gBBlwZq8uzG
        EMAiL7hP9uP4VosbEaPMxXNS;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1nOYnu-005nxf-3y; Mon, 28 Feb 2022 05:42:38 +0000
Message-ID: <d1b3419e-886c-d479-0c43-b4e64e5465a8@samba.org>
Date:   Mon, 28 Feb 2022 06:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Enabling change notification for
 network and cluster fs
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ioannis Angelakopoulos <jaggel@bu.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
 <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com> <YhjeX0HvXbED65IM@casper.infradead.org>
 <CAH2r5mt9EtTEJCKsHkvRctfhMv7LnT6XT_JEvAb7ji6-oYnTPg@mail.gmail.com>
 <YhkFZE8wUWhycwX2@redhat.com>
 <CAH2r5msPz1JZK4OWX_=+2HTzKTZE07ACxbEv3xM-1T0HTnVWMw@mail.gmail.com>
 <CAOQ4uxi+VJG56TPvcpOqoVAGgbb8gZQJEfvhXyGyB5VboRE2wA@mail.gmail.com>
From:   Ralph Boehme <slow@samba.org>
In-Reply-To: <CAOQ4uxi+VJG56TPvcpOqoVAGgbb8gZQJEfvhXyGyB5VboRE2wA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JEWlc3Q4btmHvqWa9vlw3Pbv"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JEWlc3Q4btmHvqWa9vlw3Pbv
Content-Type: multipart/mixed; boundary="------------L1f0AmtwKPzAH3rid24m0PNl";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: Amir Goldstein <amir73il@gmail.com>, Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>,
 samba-technical <samba-technical@lists.samba.org>,
 LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Ioannis Angelakopoulos <jaggel@bu.edu>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Message-ID: <d1b3419e-886c-d479-0c43-b4e64e5465a8@samba.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Enabling change notification for
 network and cluster fs
References: <CAH2r5mt9OfU+8PoKsmv_7aszhbw-dOuDCL6BOxb_2yRwc4HHCw@mail.gmail.com>
 <Yhf+FemcQQToB5x+@redhat.com>
 <CAH2r5mt6Sh7qorfCHWnZzc6LUDd-s_NzGB=sa-UDM2-ivzpmAQ@mail.gmail.com>
 <YhjYSMIE2NBZ/dGr@redhat.com> <YhjeX0HvXbED65IM@casper.infradead.org>
 <CAH2r5mt9EtTEJCKsHkvRctfhMv7LnT6XT_JEvAb7ji6-oYnTPg@mail.gmail.com>
 <YhkFZE8wUWhycwX2@redhat.com>
 <CAH2r5msPz1JZK4OWX_=+2HTzKTZE07ACxbEv3xM-1T0HTnVWMw@mail.gmail.com>
 <CAOQ4uxi+VJG56TPvcpOqoVAGgbb8gZQJEfvhXyGyB5VboRE2wA@mail.gmail.com>
In-Reply-To: <CAOQ4uxi+VJG56TPvcpOqoVAGgbb8gZQJEfvhXyGyB5VboRE2wA@mail.gmail.com>

--------------L1f0AmtwKPzAH3rid24m0PNl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW1pciwNCg0KT24gMi8yNi8yMiAxMToyMiwgQW1pciBHb2xkc3RlaW4gd3JvdGU6DQo+
IEkgZ3Vlc3MgU01CIHByb3RvY29sIGRvZXMgbm90IGFsbG93IGNsaWVudCBCIHRvIHJlcXVl
c3QgYSBOT1RJRlkgb24gY2hhbmdlDQo+IHdoZW4gY2xpZW50IEEgaGFzIGEgZGlyZWN0b3J5
IGxlYXNlLCBiZWNhdXNlIHJlcXVlc3RpbmcgTk9USUZZIHJlcXVpcmVzDQo+IGdldHRpbmcg
YSByZWFkIGZpbGUgaGFuZGxlIG9uIHRoZSBkaXI/DQpmd2l3LCB5b3UgZG9uJ3QgZ2V0IGEg
IlciIFNNQjMgZGlyZWN0b3J5IGxlYXNlLCBzbyB0aGlzIGlzIG5vdCBhIHByb2JsZW0uDQoN
Ci1zbG93DQo=

--------------L1f0AmtwKPzAH3rid24m0PNl--

--------------JEWlc3Q4btmHvqWa9vlw3Pbv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmIcYMwFAwAAAAAACgkQqh6bcSY5nkbN
khAAqRE+qx1Qbz8iS3db4Q568BEftRKDCQKnklyufG4iQ4ecGeIowtqJQpNNAgcdoV6OaMxB/+7j
89aZjdzC00Dis/xnC+bB13njUK2fEBb/XLq/UiHJSm0LQbeQRT7LAZiiXhaLsiOLSBY7rg/1J4kG
t4ewoM2sk4ynQO7hz7zxO3vZ4jS0gxZXtjBvjNmDJERsJ9mCPYmLFB9OfwfOyIf406xN7UHHhuou
x+95l0gA8CdulBXXqLuy/8tp08XLxNi2BC7M+JDR0Db1ak2vTEqQpBISkdEMBJt1g/dWceIv7tgs
MUGW/sCuEr2zDT7ipUYZiHg2B9p4RDxcin7CwsUx2/w/Ly8SOh9KRNH8GbNStOUTqBB7G0n7/mt9
WC1pMgcBsm+8VV0lhFmlt8/EwsXWhJuZdRl5yDmDdO2qM3jdpKuUcQvrb4SaYdE5F9l/ovhBfixe
WEl2Gk0sYwmShqYm3cHDBjv/wPKq9S0AteI8ngb33HH078w2YZIRUy3edK7KzaujPC/Cj2kY7kHK
KHQhp0Wg2eb4z5zSxRO6SJ+8zaMyhk5OYL+/9HSX5haCWdqQs+HRNB5w9tV7ayZo298e1AnP0zXB
fgl6bKibWJNz90gTQINFtQYBA4sIuH0QXvviX/In5aA+d1MBXEDdWiqW6vZ5X+gvn9AHATAGaOpu
/dw=
=ZJvZ
-----END PGP SIGNATURE-----

--------------JEWlc3Q4btmHvqWa9vlw3Pbv--
