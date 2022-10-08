Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB535F8241
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 04:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJHCDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 22:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHCDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 22:03:06 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D5B100BD0;
        Fri,  7 Oct 2022 19:03:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv10so5985828wrb.4;
        Fri, 07 Oct 2022 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVrtfBiEok2By1YIncR+5ppG0aBiojutuj10uIdb4M8=;
        b=DtUlgsVTI94TVF+azXhBuIzMpBoVGf87QqLogKz+XIk0Xc0LKoFnflrS0tqsZhoSgw
         CGv0bQXoJVlA01cjWnatu1JdI52M/pTctEwqYcropsFH69fSZr47681j4LpeS22G0eeO
         R7jMWRu7qBEulLr7BCoMfkng6DVtHlYX/1NdLXivfqjTxLbuI3q3MlpVvM5AHfYLyWig
         A584PGP1teSF6O57A/kP2Q62gQndZW1eZWG8MojONMY3GPeDJSBcRcr5t0mKvgTuK7xo
         K7zum5jKZ468WmSgfdkIN6amLjeLfmUruSNdK6qnqd1NONlhwIGok/0GJX7b7wWEqZDN
         8sDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dVrtfBiEok2By1YIncR+5ppG0aBiojutuj10uIdb4M8=;
        b=FvdbD8odFsn3mjDx7PVaYw59J5K77lhjr/bh/Cko9u3hNC/Gxe/ApE7peH3RZ/xHV4
         SepMoFzrdPxyq8uiw2XMg++HCzjONsTBwdZ8y5LZel57G7+BLO6eR1xPDv8jR7qmgz3n
         4kbuEpEuuDJMp1cFhKjr9EjFw6a66dMfBjas5alzUn+6tjU21vanDrX4LwwFYZb0urn1
         kaQhH70qCW9d77Zrk9J1y3jQ2ZWmM9HA7Q2BcrKS8Oqa7VQddgV+oWLhXrtIwqJl7rio
         0vCF7nmJNg1QdeqGATKH7vK6NkKh5M2GnDz+swgF5VEEreaIy3OqTQQ7H0a23AboVWv+
         d6sA==
X-Gm-Message-State: ACrzQf2S3+eu/greD4tfXhklfU3ai1DtglVo8LmcV7JhJtlDTtiy1SeE
        Yw8N7AvfGXjR6vb4P3qFaVA=
X-Google-Smtp-Source: AMsMyM6yTeWS5OLFiRyKOPBpK4qCxPMvKUXSNWN4CAUIrTxHzLZovPp/3sLYVDqR5fcypEYrhPqOog==
X-Received: by 2002:a05:6000:1cf:b0:22e:3ef1:a268 with SMTP id t15-20020a05600001cf00b0022e3ef1a268mr4879464wrx.43.1665194583163;
        Fri, 07 Oct 2022 19:03:03 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id bp15-20020a5d5a8f000000b0022cbf4cda62sm4326101wrb.27.2022.10.07.19.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 19:03:02 -0700 (PDT)
Message-ID: <1099b005-4268-95cb-452c-57156f1cf7b7@gmail.com>
Date:   Sat, 8 Oct 2022 04:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [man-pages RFC PATCH v6] statx, inode: document the new
 STATX_VERSION field
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
        trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
        zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
        lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org,
        brauner@kernel.org, fweimer@redhat.com, linux-man@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20220928134200.28741-1-jlayton@kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20220928134200.28741-1-jlayton@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IfMxZBOO7OlMGKOKWQtFmv0v"
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IfMxZBOO7OlMGKOKWQtFmv0v
Content-Type: multipart/mixed; boundary="------------qHqb3fVMZ8DmKM0eA1TeMiZj";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Jeff Layton <jlayton@kernel.org>, tytso@mit.edu,
 adilger.kernel@dilger.ca, djwong@kernel.org, david@fromorbit.com,
 trondmy@hammerspace.com, neilb@suse.de, viro@zeniv.linux.org.uk,
 zohar@linux.ibm.com, xiubli@redhat.com, chuck.lever@oracle.com,
 lczerner@redhat.com, jack@suse.cz, bfields@fieldses.org, brauner@kernel.org,
 fweimer@redhat.com, linux-man@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <1099b005-4268-95cb-452c-57156f1cf7b7@gmail.com>
Subject: Re: [man-pages RFC PATCH v6] statx, inode: document the new
 STATX_VERSION field
References: <20220928134200.28741-1-jlayton@kernel.org>
In-Reply-To: <20220928134200.28741-1-jlayton@kernel.org>

--------------qHqb3fVMZ8DmKM0eA1TeMiZj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmVmZiwNCg0KT24gOS8yOC8yMiAxNTo0MiwgSmVmZiBMYXl0b24gd3JvdGU6DQo+IEkn
bSBwcm9wb3NpbmcgdG8gZXhwb3NlIHRoZSBpbm9kZSBjaGFuZ2UgYXR0cmlidXRlIHZpYSBz
dGF0eCBbMV0uIERvY3VtZW50DQo+IHdoYXQgdGhpcyB2YWx1ZSBtZWFucyBhbmQgd2hhdCBh
biBvYnNlcnZlciBjYW4gaW5mZXIgZnJvbSBpdCBjaGFuZ2luZy4NCj4gDQo+IE5COiB0aGlz
IHdpbGwgcHJvYmFibHkgaGF2ZSBjb25mbGljdHMgd2l0aCB0aGUgU1RBVFhfRElPQUxJR04g
ZG9jDQo+IHBhdGNoZXMsIGJ1dCB3ZSBzaG91bGQgYmUgYWJsZSB0byByZXNvbHZlIHRob3Nl
IGJlZm9yZSBtZXJnaW5nIGFueXRoaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmVmZiBM
YXl0b24gPGpsYXl0b25Aa2VybmVsLm9yZz4NCj4gDQo+IFsxXTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtbmZzLzIwMjIwODI2MjE0NzAzLjEzNDg3MC0xLWpsYXl0b25Aa2Vy
bmVsLm9yZy9ULyN0DQoNClRoYW5rcyEgUGxlYXNlIHNlZSBzb21lIGZvcm1hdHRpbmcgY29t
bWVudHMgYmVsb3cuDQoNCkNoZWVycywNCg0KQWxleA0KDQo+IC0tLQ0KPiAgIG1hbjIvc3Rh
dHguMiB8IDEzICsrKysrKysrKysrKysNCj4gICBtYW43L2lub2RlLjcgfCAzNiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ5
IGluc2VydGlvbnMoKykNCj4gDQo+IHY2OiBpbmNvcnBvcmF0ZSBOZWlsJ3Mgc3VnZ2VzdGlv
bnMNCj4gICAgICBjbGFyaWZ5IGhvdyB3ZWxsLWJlaGF2ZWQgZmlsZXN5c3RlbXMgc2hvdWxk
IG9yZGVyIHRoaW5ncw0KPiANCj4gZGlmZiAtLWdpdCBhL21hbjIvc3RhdHguMiBiL21hbjIv
c3RhdHguMg0KPiBpbmRleCAwZDFiNDU5MWY3NGMuLmVlNzAwNTMzNGEyZiAxMDA2NDQNCj4g
LS0tIGEvbWFuMi9zdGF0eC4yDQo+ICsrKyBiL21hbjIvc3RhdHguMg0KPiBAQCAtNjIsNiAr
NjIsNyBAQCBzdHJ1Y3Qgc3RhdHggew0KPiAgICAgICBfX3UzMiBzdHhfZGV2X21ham9yOyAg
IC8qIE1ham9yIElEICovDQo+ICAgICAgIF9fdTMyIHN0eF9kZXZfbWlub3I7ICAgLyogTWlu
b3IgSUQgKi8NCj4gICAgICAgX191NjQgc3R4X21udF9pZDsgICAgICAvKiBNb3VudCBJRCAq
Lw0KPiArICAgIF9fdTY0IHN0eF92ZXJzaW9uOyAgICAgLyogSW5vZGUgY2hhbmdlIGF0dHJp
YnV0ZSAqLw0KPiAgIH07DQo+ICAgLkVFDQo+ICAgLmluDQo+IEBAIC0yNDcsNiArMjQ4LDcg
QEAgU1RBVFhfQlRJTUUJV2FudCBzdHhfYnRpbWUNCj4gICBTVEFUWF9BTEwJVGhlIHNhbWUg
YXMgU1RBVFhfQkFTSUNfU1RBVFMgfCBTVEFUWF9CVElNRS4NCj4gICAJSXQgaXMgZGVwcmVj
YXRlZCBhbmQgc2hvdWxkIG5vdCBiZSB1c2VkLg0KPiAgIFNUQVRYX01OVF9JRAlXYW50IHN0
eF9tbnRfaWQgKHNpbmNlIExpbnV4IDUuOCkNCj4gK1NUQVRYX1ZFUlNJT04JV2FudCBzdHhf
dmVyc2lvbiAoRFJBRlQpDQo+ICAgLlRFDQo+ICAgLmluDQo+ICAgLlBQDQo+IEBAIC00MDcs
MTAgKzQwOSwxNiBAQCBUaGlzIGlzIHRoZSBzYW1lIG51bWJlciByZXBvcnRlZCBieQ0KPiAg
IC5CUiBuYW1lX3RvX2hhbmRsZV9hdCAoMikNCj4gICBhbmQgY29ycmVzcG9uZHMgdG8gdGhl
IG51bWJlciBpbiB0aGUgZmlyc3QgZmllbGQgaW4gb25lIG9mIHRoZSByZWNvcmRzIGluDQo+
ICAgLklSIC9wcm9jL3NlbGYvbW91bnRpbmZvIC4NCj4gKy5UUA0KPiArLkkgc3R4X3ZlcnNp
b24NCj4gK1RoZSBpbm9kZSB2ZXJzaW9uLCBhbHNvIGtub3duIGFzIHRoZSBpbm9kZSBjaGFu
Z2UgYXR0cmlidXRlLiBTZWUNCg0KUGxlYXNlIHVzZSBzZW1hbnRpYyBuZXdsaW5lcy4NCg0K
U2VlIG1hbi1wYWdlcyg3KToNCiAgICBVc2Ugc2VtYW50aWMgbmV3bGluZXMNCiAgICAgICAg
SW4gdGhlIHNvdXJjZSBvZiBhIG1hbnVhbCBwYWdlLCBuZXcgc2VudGVuY2VzICBzaG91bGQg
IGJlDQogICAgICAgIHN0YXJ0ZWQgb24gbmV3IGxpbmVzLCBsb25nIHNlbnRlbmNlcyBzaG91
bGQgYmUgc3BsaXQgaW50bw0KICAgICAgICBsaW5lcyAgYXQgIGNsYXVzZSBicmVha3MgKGNv
bW1hcywgc2VtaWNvbG9ucywgY29sb25zLCBhbmQNCiAgICAgICAgc28gb24pLCBhbmQgbG9u
ZyBjbGF1c2VzIHNob3VsZCBiZSBzcGxpdCBhdCBwaHJhc2UgYm91bmTigJANCiAgICAgICAg
YXJpZXMuICBUaGlzIGNvbnZlbnRpb24sICBzb21ldGltZXMgIGtub3duICBhcyAgInNlbWFu
dGljDQogICAgICAgIG5ld2xpbmVzIiwgIG1ha2VzIGl0IGVhc2llciB0byBzZWUgdGhlIGVm
ZmVjdCBvZiBwYXRjaGVzLA0KICAgICAgICB3aGljaCBvZnRlbiBvcGVyYXRlIGF0IHRoZSBs
ZXZlbCBvZiBpbmRpdmlkdWFsIHNlbnRlbmNlcywNCiAgICAgICAgY2xhdXNlcywgb3IgcGhy
YXNlcy4NCg0KDQo+ICsuQlIgaW5vZGUgKDcpDQo+ICtmb3IgZGV0YWlscy4NCj4gICAuUFAN
Cj4gICBGb3IgZnVydGhlciBpbmZvcm1hdGlvbiBvbiB0aGUgYWJvdmUgZmllbGRzLCBzZWUN
Cj4gICAuQlIgaW5vZGUgKDcpLg0KPiAgIC5cIg0KPiArLlRQDQoNCldoeT8gIC5UUCBpcyB1
c2VkIHRvIHN0YXJ0IHRhZ2dlZCBwYXJhZ3JhcGhzLiAgQnV0IC5TUyBpcyB1c2VkIHRvIHN0
YXJ0IA0Kc3Vic2VjdGlvbnMuDQoNCj4gICAuU1MgRmlsZSBhdHRyaWJ1dGVzDQo+ICAgVGhl
DQo+ICAgLkkgc3R4X2F0dHJpYnV0ZXMNCj4gQEAgLTQ4OSw2ICs0OTcsMTEgQEAgd2l0aG91
dCBhbiBleHBsaWNpdA0KPiAgIFNlZQ0KPiAgIC5CUiBtbWFwICgyKQ0KPiAgIGZvciBtb3Jl
IGluZm9ybWF0aW9uLg0KPiArLlRQDQo+ICsuQlIgU1RBVFhfQVRUUl9WRVJTSU9OX01PTk9U
T05JQyAiIChzaW5jZSBMaW51eCA2Lj8pIg0KPiArVGhlIHN0eF92ZXJzaW9uIHZhbHVlIG1v
bm90b25pY2FsbHkgaW5jcmVhc2VzIG92ZXIgdGltZSBhbmQgd2lsbCBuZXZlciBhcHBlYXIN
Cj4gK3RvIGdvIGJhY2t3YXJkLCBldmVuIGluIHRoZSBldmVudCBvZiBhIGNyYXNoLiBUaGlz
IGNhbiBhbGxvdyBhbiBhcHBsaWNhdGlvbiB0bw0KPiArbWFrZSBhIGJldHRlciBkZXRlcm1p
bmF0aW9uIGFib3V0IG9yZGVyaW5nIHdoZW4gdmlld2luZyBkaWZmZXJlbnQgdmVyc2lvbnMu
DQo+ICAgLlNIIFJFVFVSTiBWQUxVRQ0KPiAgIE9uIHN1Y2Nlc3MsIHplcm8gaXMgcmV0dXJu
ZWQuDQo+ICAgT24gZXJyb3IsIFwtMSBpcyByZXR1cm5lZCwgYW5kDQo+IGRpZmYgLS1naXQg
YS9tYW43L2lub2RlLjcgYi9tYW43L2lub2RlLjcNCj4gaW5kZXggOWIyNTVhODkwNzIwLi5l
OGFkYjYzYjFmNmEgMTAwNjQ0DQo+IC0tLSBhL21hbjcvaW5vZGUuNw0KPiArKysgYi9tYW43
L2lub2RlLjcNCj4gQEAgLTE4NCw2ICsxODQsMTIgQEAgTGFzdCBzdGF0dXMgY2hhbmdlIHRp
bWVzdGFtcCAoY3RpbWUpDQo+ICAgVGhpcyBpcyB0aGUgZmlsZSdzIGxhc3Qgc3RhdHVzIGNo
YW5nZSB0aW1lc3RhbXAuDQo+ICAgSXQgaXMgY2hhbmdlZCBieSB3cml0aW5nIG9yIGJ5IHNl
dHRpbmcgaW5vZGUgaW5mb3JtYXRpb24NCj4gICAoaS5lLiwgb3duZXIsIGdyb3VwLCBsaW5r
IGNvdW50LCBtb2RlLCBldGMuKS4NCj4gKy5UUA0KPiArSW5vZGUgdmVyc2lvbiAodmVyc2lv
bikNCj4gKyhub3QgcmV0dXJuZWQgaW4gdGhlIFxmSXN0YXRcZlAgc3RydWN0dXJlKTsgXGZJ
c3RhdHguc3R4X3ZlcnNpb25cZlANCg0KUGxlYXNlIHVzZSAuSSBhbmQgLkIgbWFjcm9zIGlu
c3RlYWQgb2YgaW5saW5lIGZvcm1hdHRpbmcuICBUaGUgYWJvdmUgDQpsaW5lIGNvdWxkIGJl
IHJld3JpdHRlbiBhczoNCg0KKG5vdCByZXR1cm5lZCBpbiB0aGUNCi5JIHN0YXQNCnN0cnVj
dHVyZSk7DQouSSBzdGF0eC5zdHhfdmVyc2lvbg0KDQoNCj4gKy5JUA0KPiArVGhpcyBpcyB0
aGUgaW5vZGUgY2hhbmdlIGNvdW50ZXIuIFNlZSB0aGUgZGlzY3Vzc2lvbiBvZg0KPiArXGZC
dGhlIGlub2RlIHZlcnNpb24gY291bnRlclxmUCwgYmVsb3cuDQo+ICAgLlBQDQo+ICAgVGhl
IHRpbWVzdGFtcCBmaWVsZHMgcmVwb3J0IHRpbWUgbWVhc3VyZWQgd2l0aCBhIHplcm8gcG9p
bnQgYXQgdGhlDQo+ICAgLklSIEVwb2NoICwNCj4gQEAgLTQyNCw2ICs0MzAsMzYgQEAgb24g
YSBkaXJlY3RvcnkgbWVhbnMgdGhhdCBhIGZpbGUNCj4gICBpbiB0aGF0IGRpcmVjdG9yeSBj
YW4gYmUgcmVuYW1lZCBvciBkZWxldGVkIG9ubHkgYnkgdGhlIG93bmVyDQo+ICAgb2YgdGhl
IGZpbGUsIGJ5IHRoZSBvd25lciBvZiB0aGUgZGlyZWN0b3J5LCBhbmQgYnkgYSBwcml2aWxl
Z2VkDQo+ICAgcHJvY2Vzcy4NCj4gKy5TUyBUaGUgaW5vZGUgdmVyc2lvbiBjb3VudGVyDQo+
ICsuUFANCg0KLlBQIHNob3VsZCBub3QgYmUgdXNlZCBhZnRlciAuU1MuICBXZSB1c2UgaXQg
dG8gc2VwYXJhdGUgcGFyYWdyYXBocyANCmJldHdlZW4gdGhlbXNlbHZlcywgYnV0IFtzdWJd
c2VjdGlvbiB0aXRsZXMgYXJlIHB1dCBuZXh0IHRvIHRoZSBmaXJzdCANCnBhcmFncmFwaC4N
Cg0KPiArVGhlIFxmSXN0YXR4LnN0eF92ZXJzaW9uXGZQIGZpZWxkIGlzIHRoZSBpbm9kZSBj
aGFuZ2UgY291bnRlci4gQW55IG9wZXJhdGlvbg0KPiArdGhhdCBjb3VsZCByZXN1bHQgaW4g
YSBjaGFuZ2UgdG8gXGZJc3RhdHguc3R4X2N0aW1lXGZQIG11c3QgcmVzdWx0IGluIGFuDQo+
ICtpbmNyZWFzZSB0byB0aGlzIHZhbHVlLiBTb29uIGFmdGVyIGEgY2hhbmdlIGhhcyBiZWVu
IG1hZGUsIGFuIHN0eF92ZXJzaW9uIHZhbHVlDQo+ICtzaG91bGQgYXBwZWFyIHRvIGJlIGxh
cmdlciB0aGFuIHByZXZpb3VzIHJlYWRpbmdzLiBUaGlzIGlzIHRoZSBjYXNlIGV2ZW4NCj4g
K3doZW4gYSBjdGltZSBjaGFuZ2UgaXMgbm90IGV2aWRlbnQgZHVlIHRvIGNvYXJzZSB0aW1l
c3RhbXAgZ3JhbnVsYXJpdHkuDQo+ICsuUFANCj4gK0FuIG9ic2VydmVyIGNhbm5vdCBpbmZl
ciBhbnl0aGluZyBmcm9tIGFtb3VudCBvZiBpbmNyZWFzZSBhYm91dCB0aGUNCj4gK25hdHVy
ZSBvciBtYWduaXR1ZGUgb2YgdGhlIGNoYW5nZS4gSW4gZmFjdCwgYSBzaW5nbGUgaW5jcmVt
ZW50IGNhbiByZWZsZWN0DQo+ICttdWx0aXBsZSBkaXNjcmV0ZSBjaGFuZ2VzIGlmIHRoZSB2
YWx1ZSB3YXMgbm90IGNoZWNrZWQgd2hpbGUgdGhvc2UgY2hhbmdlcw0KPiArd2VyZSBiZWlu
ZyBwcm9jZXNzZWQuDQo+ICsuUFANCj4gK0NoYW5nZXMgdG8gc3R4X3ZlcnNpb24gYXJlIG5v
dCBuZWNlc3NhcmlseSBhdG9taWMgd2l0aCB0aGUgY2hhbmdlIGl0c2VsZiwgYnV0DQo+ICt3
ZWxsLWJlaGF2ZWQgZmlsZXN5c3RlbXMgc2hvdWxkIGluY3JlbWVudCBzdHhfdmVyc2lvbiBh
ZnRlciBhIGNoYW5nZSBoYXMgYmVlbg0KPiArbWFkZSB2aXNpYmxlIHRvIG9ic2VydmVycyBy
YXRoZXIgdGhhbiBiZWZvcmUuIFRoaXMgaXMgZXNwZWNpYWxseSBpbXBvcnRhbnQgZm9yDQo+
ICtyZWFkLWNhY2hpbmcgYWxnb3JpdGhtcyB3aGljaCBjb3VsZCBiZSBmb29sZWQgaW50byBh
c3NvY2lhdGluZyBhIG5ld2VyDQo+ICtzdHhfdmVyc2lvbiB3aXRoIGFuIG9sZGVyIHZlcnNp
b24gb2YgZGF0YS4gTm90ZSB0aGF0IHRoaXMgZG9lcyBsZWF2ZSBhIHdpbmRvdw0KPiArb2Yg
dGltZSB3aGVyZSBhIGNoYW5nZSBtYXkgYmUgdmlzaWJsZSwgYnV0IHRoZSBvbGQgc3R4X3Zl
cnNpb24gaXMgc3RpbGwgYmVpbmcNCj4gK3JlcG9ydGVkLg0KPiArLlBQDQo+ICtJbiB0aGUg
ZXZlbnQgb2YgYSBzeXN0ZW0gY3Jhc2gsIHRoaXMgdmFsdWUgY2FuIGFwcGVhciB0byBnbyBi
YWNrd2FyZCBpZiBpdCB3YXMNCj4gK3F1ZXJpZWQgYmVmb3JlIGV2ZXIgYmVpbmcgd3JpdHRl
biB0byB0aGUgYmFja2luZyBzdG9yZS4gQXBwbGljYXRpb25zIHRoYXQNCj4gK3BlcnNpc3Qg
c3R4X3ZlcnNpb24gdmFsdWVzIGFjcm9zcyBhIHJlYm9vdCBzaG91bGQgdGFrZSBjYXJlIHRv
IG1pdGlnYXRlIHRoaXMuDQo+ICtJZiB0aGUgZmlsZXN5c3RlbSByZXBvcnRzIFxmSVNUQVRY
X0FUVFJfVkVSU0lPTl9NT05PVE9OSUNcZlAgaW4NCj4gK1xmSXN0YXR4LnN0eF9hdHRyaWJ1
dGVzXGZQLCB0aGVuIGl0IGlzIG5vdCBzdWJqZWN0IHRvIHRoaXMgcHJvYmxlbS4NCj4gKy5Q
UA0KPiArVGhlIHN0eF92ZXJzaW9uIGlzIGEgTGludXggZXh0ZW5zaW9uIGFuZCBpcyBub3Qg
c3VwcG9ydGVkIGJ5IGFsbCBmaWxlc3lzdGVtcy4NCj4gK1RoZSBhcHBsaWNhdGlvbiBtdXN0
IHZlcmlmeSB0aGF0IHRoZSBcZklTVEFUWF9WRVJTSU9OXGZQIGJpdCBpcyBzZXQgaW4gdGhl
DQo+ICtyZXR1cm5lZCBcZklzdGF0eC5zdHhfbWFza1xmUCBiZWZvcmUgcmVseWluZyBvbiB0
aGlzIGZpZWxkLg0KPiAgIC5TSCBTVEFOREFSRFMNCj4gICBJZiB5b3UgbmVlZCB0byBvYnRh
aW4gdGhlIGRlZmluaXRpb24gb2YgdGhlDQo+ICAgLkkgYmxrY250X3QNCg0KLS0gDQo8aHR0
cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5lcy8+DQo=

--------------qHqb3fVMZ8DmKM0eA1TeMiZj--

--------------IfMxZBOO7OlMGKOKWQtFmv0v
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNA2lQACgkQnowa+77/
2zLH3Q//QRl0WDTzRO7oTBxlEU3vHvGgyE+fux97KBJBdZ7srm1XRdeY8ZCLiR7V
c2ezn2PtAAO9eqqWEh2JuvcYCk9dUPidEuoAEi1+0MFceJ+8U4eF7doFJAxwqR8I
3hdLqhc1fXY32nkXNWU91ch3mdESAM+ZI1xKhcM/yfK0gXU65iARWwaZfR8fhS4k
N8C+YsLRz5iudNOlrv58lg90kRGOvCx/6yC7v/IguVPsguESQ83cKor27g1ZWLbt
kjgPCxKXpot80lH4veYhuRxmrqDDjOvo7gDU69uXo1ShsRK6lNWgRCtMUzHOuQe5
FWAqs0f0qDxwmuJLrkEUZZ/gPkJDiTqHCnzcMtO7GiqsdpuAiagWSzEFhnAyocRo
6HrmAd5aZNb8gaP+Nzp1IUIm0Kx96GtSE8H8FPdxA6vD1qtvkvDDYsg3/zKt4A0N
SZ5z6dCVcsy+0d15xdbaH1b5COU9ZidviEuIYGMpFkLor4LDwpA4yS+9LHsMyI/B
aU6c5wpCbJcnt4RySQuEIwEit8VxtEjzCiiyqEBeQHcrZmKc4L4cKBEPJO/VPRXc
yteeNl6n1iZ86OcL7dbOA66lt/NOMznGX4LyWjTbOsGdnlPSwhN2Sh/VugpJyxFO
gKcZz0x7anMAuArYxrZ9FG2x28+bCAhCcEiH+7ksREd4Lu61YuQ=
=0c3d
-----END PGP SIGNATURE-----

--------------IfMxZBOO7OlMGKOKWQtFmv0v--
