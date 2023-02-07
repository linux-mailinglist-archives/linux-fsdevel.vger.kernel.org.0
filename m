Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540B568DA0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 15:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBGODY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 09:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBGODX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:03:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ACF44B6;
        Tue,  7 Feb 2023 06:03:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9774938B13;
        Tue,  7 Feb 2023 14:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675778599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqWjYHqVE8IvaN3952TdpK0BSSvIahWB7+QeuDQju0E=;
        b=Z+sNqKMBUcr9PbS8JeE5I2eNwQCHKlA7YsRnX1vfF9u9qVANR71qfA6hfqriiyCLd+A2Er
        7w/L+SecSxDsWrc9hzFu3BvqbVocAAFx2nOjyaMPiYKyFPRgoFrUSKvuu2VGQyq6qSezaO
        59vLyZ33Nzgx+F2rcVJL5N1Xtxok7JM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15351139ED;
        Tue,  7 Feb 2023 14:03:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E93JAyda4mNlAwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 14:03:19 +0000
Message-ID: <e5ca6ffa-ccc1-06a0-4382-2b6cf4f75548@suse.com>
Date:   Tue, 7 Feb 2023 15:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>, xen-devel@lists.xenproject.org
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maobibo <maobibo@loongson.cn>,
        Matthew Wilcox <willy@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr> <Y+EupX1jX1c5BAHv@kadam>
 <Y+JUIl64UDmdkboh@kadam>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: xen: sleeping in atomic warnings
In-Reply-To: <Y+JUIl64UDmdkboh@kadam>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8Cy4GAJEf0mO30TJKVjHugHL"
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8Cy4GAJEf0mO30TJKVjHugHL
Content-Type: multipart/mixed; boundary="------------ISvi0mubQ4jvNED1SOA4tE7c";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Dan Carpenter <error27@gmail.com>, xen-devel@lists.xenproject.org
Cc: Julia Lawall <julia.lawall@inria.fr>, Luis Chamberlain
 <mcgrof@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Hongchen Zhang <zhanghongchen@loongson.cn>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 maobibo <maobibo@loongson.cn>, Matthew Wilcox <willy@infradead.org>,
 Sedat Dilek <sedat.dilek@gmail.com>
Message-ID: <e5ca6ffa-ccc1-06a0-4382-2b6cf4f75548@suse.com>
Subject: Re: xen: sleeping in atomic warnings
References: <20230129060452.7380-1-zhanghongchen@loongson.cn>
 <CAHk-=wjw-rrT59k6VdeLu4qUarQOzicsZPFGAO5J8TKM=oukUw@mail.gmail.com>
 <Y+EjmnRqpLuBFPX1@bombadil.infradead.org>
 <4ffbb0c8-c5d0-73b3-7a4e-2da9a7b03669@inria.fr> <Y+EupX1jX1c5BAHv@kadam>
 <Y+JUIl64UDmdkboh@kadam>
In-Reply-To: <Y+JUIl64UDmdkboh@kadam>

--------------ISvi0mubQ4jvNED1SOA4tE7c
Content-Type: multipart/mixed; boundary="------------iyE4cjBPZ5UxfPZspDcYBu0a"

--------------iyE4cjBPZ5UxfPZspDcYBu0a
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDIuMjMgMTQ6MzcsIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IFRoZXNlIGFyZSBz
dGF0aWMgY2hlY2tlciB3YXJuaW5ncyBmcm9tIFNtYXRjaC4gIFRoZSBsaW5lIG51bWJlcnMg
YXJlDQo+IGJhc2VkIG9uIG5leHQtMjAyMzAyMDcuICBUbyByZXByb2R1Y2UgdGhlc2Ugd2Fy
bmluZ3MgdGhlbiB5b3UgbmVlZCB0bw0KPiBoYXZlIHRoZSBsYXRlc3QgU21hdGNoIGZyb20g
Z2l0IGFuZCB5b3UgbmVlZCB0byByZWJ1aWxkIHRoZSBjcm9zcw0KPiBmdW5jdGlvbiBwcm9i
YWJseSBmb3VyIHRpbWVzLiAgSSBoYXZlIHJldmlld2VkIG1vc3Qgb2YgdGhlc2UgYW5kIHRo
ZXkNCj4gYWxsIHNlZW0gdmFsaWQgdG8gbWUuICBJIHJlbWVtYmVyIEkgcmVwb3J0ZWQgc29t
ZSBhIHdoaWxlIGJhY2sgYnV0IG5ldmVyDQo+IGhlYXJkIGJhY2suICBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMTA4MDIxNDQwMzcuR0EyOTU0MEBraWxpLw0KPiANCj4gcmVn
YXJkcywNCj4gZGFuIGNhcnBlbnRlcg0KPiANCj4gYXJjaC94ODYveGVuL3AybS5jOjE4OSBh
bGxvY19wMm1fcGFnZSgpIHdhcm46IHNsZWVwaW5nIGluIGF0b21pYyBjb250ZXh0DQo+IHhl
bl9jcmVhdGVfY29udGlndW91c19yZWdpb24oKSA8LSBkaXNhYmxlcyBwcmVlbXB0DQo+IHhl
bl9kZXN0cm95X2NvbnRpZ3VvdXNfcmVnaW9uKCkgPC0gZGlzYWJsZXMgcHJlZW1wdA0KPiAt
PiB4ZW5fcmVtYXBfZXhjaGFuZ2VkX3B0ZXMoKQ0KPiAgICAgLT4gc2V0X3BoeXNfdG9fbWFj
aGluZSgpDQo+ICAgICAgICAtPiB4ZW5fYWxsb2NfcDJtX2VudHJ5KCkNCj4gICAgICAgICAg
IC0+IGFsbG9jX3AybV9wbWQoKQ0KPiB4ZW5fYWxsb2NfcDJtX2VudHJ5KCkgPGR1cGxpY2F0
ZT4NCj4gICAgICAgICAgICAgIC0+IGFsbG9jX3AybV9wYWdlKCkNCg0KVGhvc2UgYWxsb2Nh
dGlvbnMgY2FuJ3QgYmUgcmVhY2hlZCBhZnRlciBlYXJseSBib290Lg0KDQo+IGRyaXZlcnMv
eGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jOjEyMTMgYmluZF9ldnRjaG5fdG9faXJxX2NoaXAo
KSB3YXJuOiBzbGVlcGluZyBpbiBhdG9taWMgY29udGV4dA0KPiBwdmNhbGxzX2Zyb250X2Nv
bm5lY3QoKSA8LSBkaXNhYmxlcyBwcmVlbXB0DQo+IHB2Y2FsbHNfZnJvbnRfYWNjZXB0KCkg
PC0gZGlzYWJsZXMgcHJlZW1wdA0KPiAtPiBjcmVhdGVfYWN0aXZlKCkNCj4gICAgIC0+IGJp
bmRfZXZ0Y2huX3RvX2lycWhhbmRsZXIoKQ0KPiAgICAgICAgLT4gYmluZF9ldnRjaG5fdG9f
aXJxaGFuZGxlcl9jaGlwKCkNCj4gICAgICAgICAgIC0+IGJpbmRfZXZ0Y2huX3RvX2lycV9j
aGlwKCkNCg0KWWVzLCB0aGF0IG9uZSBsb29rcyB2ZXJ5IHN1c3BpY2lvdXMuIEJhc2ljYWxs
eSB0aGUgc2FtZSBwcm9ibGVtIGFzIGFsbA0KdGhlIG90aGVyIHB2Y2FsbHMgaXNzdWVzIGJl
bG93Lg0KDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L3Fsb2dpYy9uZXR4ZW4vbmV0eGVuX25p
Y19ody5jOjMwMyBuZXR4ZW5fcGNpZV9zZW1fbG9jaygpIHdhcm46IHNsZWVwaW5nIGluIGF0
b21pYyBjb250ZXh0DQo+IG5ldHhlbl9uaWNfaHdfd3JpdGVfd3hfMk0oKSA8LSBkaXNhYmxl
cyBwcmVlbXB0DQo+IG5ldHhlbl9uaWNfaHdfcmVhZF93eF8yTSgpIDwtIGRpc2FibGVzIHBy
ZWVtcHQNCj4gLT4gbmV0eGVuX3BjaWVfc2VtX2xvY2soKQ0KDQpUaGlzIGlzIG5vdCBYZW4g
cmVsYXRlZC4NCg0KPiBkcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jOjExMCBw
Y2lzdHViX2RldmljZV9yZWxlYXNlKCkgd2Fybjogc2xlZXBpbmcgaW4gYXRvbWljIGNvbnRl
eHQNCj4gcGNpc3R1Yl9nZXRfcGNpX2Rldl9ieV9zbG90KCkgPC0gZGlzYWJsZXMgcHJlZW1w
dA0KPiBwY2lzdHViX2dldF9wY2lfZGV2KCkgPC0gZGlzYWJsZXMgcHJlZW1wdA0KPiAtPiBw
Y2lzdHViX2RldmljZV9nZXRfcGNpX2RldigpDQo+ICAgICAtPiBwY2lzdHViX2RldmljZV9w
dXQoKQ0KPiAgICAgICAgLT4gcGNpc3R1Yl9kZXZpY2VfcmVsZWFzZSgpDQoNClNlZW1zIHRv
cCBiZSBwcm9ibGVtYXRpYywgdG9vLg0KDQo+IGRyaXZlcnMveGVuL3hlbi1zY3NpYmFjay5j
OjEwMTYgX19zY3NpYmFja19kZWxfdHJhbnNsYXRpb25fZW50cnkoKSB3YXJuOiBzbGVlcGlu
ZyBpbiBhdG9taWMgY29udGV4dA0KPiBzY3NpYmFja19kZWxfdHJhbnNsYXRpb25fZW50cnko
KSA8LSBkaXNhYmxlcyBwcmVlbXB0DQo+IHNjc2liYWNrX3JlbGVhc2VfdHJhbnNsYXRpb25f
ZW50cnkoKSA8LSBkaXNhYmxlcyBwcmVlbXB0DQo+IC0+IF9fc2NzaWJhY2tfZGVsX3RyYW5z
bGF0aW9uX2VudHJ5KCkNCg0KTmVlZHMgZml4aW5nIChzYW1lIGZpeCBhcyB0aGUgb3RoZXIg
c2NzaWJhY2sgaXNzdWUpLg0KDQpUaGFua3MgZm9yIHRoZSByZXBvcnRzLA0KDQoNCkp1ZXJn
ZW4NCg==
--------------iyE4cjBPZ5UxfPZspDcYBu0a
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------iyE4cjBPZ5UxfPZspDcYBu0a--

--------------ISvi0mubQ4jvNED1SOA4tE7c--

--------------8Cy4GAJEf0mO30TJKVjHugHL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPiWiYFAwAAAAAACgkQsN6d1ii/Ey/x
Hgf+P2Hd8pWhpiMwq3X+xYM/xtj+fvlGoOrT0aNfmaplCixttNBdSZw/MuMAIkqodiNp6uHap9tk
2/Jfcf9JwTgNRcdr23SNSMPGh86R3JKF/qaCMfM8wifYktD/meNw0Vs1ZW5xw8QZOCwqe9jqv3Hz
CQKBeHTEeH9uDb4wql8A6gao/2tnusvveVESAF98OoP1cPv7vuB4ylG+4kyjOp5WqvfT37xrmP6R
mhfe9AdX3MLEAFefFXDmxMHbxaRk5ZMCt5Y3HKiUpIJEPWPzXmJyVMY2DhHMKwm6WYVH5fFnGs8T
y/UMp78Wic3f7u3tNzjylhrnaKthkCrhwKVmmxTGkg==
=qKRH
-----END PGP SIGNATURE-----

--------------8Cy4GAJEf0mO30TJKVjHugHL--
