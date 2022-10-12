Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C5D5FCD85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 23:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJLVvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 17:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJLVvG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:51:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4237B10B772;
        Wed, 12 Oct 2022 14:51:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so179359wmb.0;
        Wed, 12 Oct 2022 14:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9K8bjf1hdb9oZnjtcusr1Tlh0fJ5nR0ayR8oYE6/3E=;
        b=PzQIhimEEeKzpO8PVtjKrl7Eb9J4+KsCTK6gC+Ww4NKzJUv90uMf5kqn7hC37wpiJH
         A5BOJSOipLFmmt1DveN2jaPxOUac7AJdqMuEfJE+57FAUTFSlvJHSqSAXfec7ecXJwvC
         NuMGs3vLX5gq0oj7OvtYIYSV9mt+OGwAZc4Sp9eaKYDIPtXspR7IMEoGSnEVWhJ0d7ld
         YzUSsUrFFQK/LYfc67YMeGV9b7cDsgjM13cjSZRdUXZFsejAP4RKtS6HEqYWwRLincgf
         01/9UsP0O9+XbHCfvZKnWp5kHqfXvEQWPp1yWVrptGCE7pMWyxsEyhdHvYSKuJYg2He7
         gIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L9K8bjf1hdb9oZnjtcusr1Tlh0fJ5nR0ayR8oYE6/3E=;
        b=fI9S4uJP1IvUuDGS0oJUJHW2l6PRvmwDB6UkEQRI/D1uQGFZu5M6b09aJkSPQMtd/6
         jj04ZG4PD3UEuCaf5ia612GT2+4g124/WQshcRMmyfkA4U3fxHNqzyIVaOERvlymNaSZ
         4BvWELuvi9HSebGMD6NIqFa1+HmrwLt1LIqTzXzB2xBBL1nGJKd65/khV/fNOOucOTh3
         iWY/5QK1X+U3MXFdWjx384hAT7OlZ7Adw6mx7ZfqaONk4lKwl7gZTPWljZNP4NfZrxnf
         OzZuBPkrMCn5j0KrZyN7opiZhTi3NHh6qOLpMMH7ZueK+mnYx52lKYUcY+UofVOnDRl1
         87dg==
X-Gm-Message-State: ACrzQf0jTPjvR0E45o07IFsXv9AOh+l7u94aseh7Zdo/sPG3OtrSLbtE
        Ork6d4bP5DmY+UGbV+WHHS8=
X-Google-Smtp-Source: AMsMyM4OpTP7aToP6GPZUIjkvg91gmIuxKH29ipqOJ+DG2LLXuWIFmJnO69gFnZew04c2ugQZ1y4BA==
X-Received: by 2002:a05:600c:3ac3:b0:3c6:c7a3:3c6a with SMTP id d3-20020a05600c3ac300b003c6c7a33c6amr4198818wms.166.1665611462629;
        Wed, 12 Oct 2022 14:51:02 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id r10-20020a5d52ca000000b0022cd6e852a2sm778354wrv.45.2022.10.12.14.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 14:51:02 -0700 (PDT)
Message-ID: <87746167-2352-c4f5-bc63-38cb3e14759f@gmail.com>
Date:   Wed, 12 Oct 2022 23:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [man-pages PATCH v4] statx.2, open.2: document STATX_DIOALIGN
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-man@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>
References: <20221011225914.216344-1-ebiggers@kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20221011225914.216344-1-ebiggers@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tLEYIH49tlMSOP9PFLdByTme"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tLEYIH49tlMSOP9PFLdByTme
Content-Type: multipart/mixed; boundary="------------FXQEyNGG9pcr0LbtXX0Sw5Sx";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>, Christian Brauner
 <brauner@kernel.org>, linux-man@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>,
 Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <87746167-2352-c4f5-bc63-38cb3e14759f@gmail.com>
Subject: Re: [man-pages PATCH v4] statx.2, open.2: document STATX_DIOALIGN
References: <20221011225914.216344-1-ebiggers@kernel.org>
In-Reply-To: <20221011225914.216344-1-ebiggers@kernel.org>

--------------FXQEyNGG9pcr0LbtXX0Sw5Sx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRXJpYywNCg0KT24gMTAvMTIvMjIgMDA6NTksIEVyaWMgQmlnZ2VycyB3cm90ZToNCj4g
RnJvbTogRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Bnb29nbGUuY29tPg0KPiANCj4gRG9jdW1l
bnQgdGhlIFNUQVRYX0RJT0FMSUdOIHN1cHBvcnQgZm9yIHN0YXR4KCkNCj4gKGh0dHBzOi8v
Z2l0Lmtlcm5lbC5vcmcvbGludXMvNzI1NzM3ZTdjMjFkMmQyNSkuDQo+IA0KPiBSZXZpZXdl
ZC1ieTogRGFycmljayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Bnb29nbGUuY29tPg0KDQpQYXRjaCBhcHBs
aWVkLiAgUGx1cyBhIHBhaXIgb2YgbWlub3IgdHdlYWtzIChzZWUgYmVsb3cgMiBjb21tZW50
cyBpbmxpbmUgDQppZiB5b3UncmUgY3VyaW91cykuDQoNClRoYW5rcywNCg0KQWxleA0KDQpQ
LlMuOg0KVGhlIGxpbmUgYnJlYWtzIHdlcmUgZmluZS4gIEkgYXBwcmVjaWF0ZSBpdCB2ZXJ5
IG11Y2guICBPZiBjb3Vyc2UsIGlmIA0KdGhlcmUgaGFkIGJlZW4gbWlub3IgaXNzdWVzIHdp
dGggaXQsIEkgY291bGQgZml4IHRoZW0gaW4gYW4gYW1lbmQuIA0KSG93ZXZlciwgSSBwcmVm
ZXIgaWYgSSBkb24ndCBoYXZlIHRvIHJlZm9ybWF0IGVudGlyZWx5IGFsbCBvZiB0aGUgDQpw
YXRjaGVzIHRoYXQgSSByZXZpZXcuICBJIGhvcGUgeW91IHVuZGVyc3RhbmQgdGhhdCBpZiBJ
IHdlcmUgc3VwcG9zZWQgdG8gDQpkbyB0aGF0LCBJJ2QgcmVzaWduIHNvb24sIG9yIHNvbWVv
bmUgd291bGQgaGF2ZSB0byBwYXkgbWUgZm9yIGRvaW5nIGl0LiANCkl0J3MgYSBib3Jpbmcg
dGFzay4NCg0KVGhhdCdzIHdoeSBJIHRyeSB0byB0ZWFjaCBjb250cmlidXRvcnMsIGFuZCBl
c3BlY2lhbGx5IGtlcm5lbCANCm1haW50YWluZXJzIC0td2hpY2ggc2VuZCBtZSB0aGUgYmln
Z2VzdCBwYXRjaGVzIEkgaGF2ZSB0byByZXZpZXctLSBob3cgDQp0byBmb3JtYXQgdGV4dCBu
aWNlbHkgZnJvbSB0aGUgYmVnaW5uaW5nLiAgSSB1bmRlcnN0YW5kIHRoYXQgdGhlIGZpcnN0
IA0KZmV3IHRpbWVzIGl0J3MgZGlmZmljdWx0IHRvIHNlZSB0aGUgYmVuZWZpdCBjb21wYXJl
ZCB0byB0aGUgY29zdC4gIEkgY2FuIA0KdGVsbCB5b3UgdGhhdCBpdCBhZmZlY3RzIHNpZ25p
ZmljYW50bHkgdGhlIGFtb3VudCBvZiB3b3JrIEkgbmVlZCB0byBkby4NCg0KTWljaGFlbCBo
YWQgYSBtdWNoIGxlc3Mgc3RyaWN0IHBvbGljeSBpbiB0aGlzIHJlZ2FyZC4gIEhlIGJhc2lj
YWxseSANCnJlZm9ybWF0dGVkIGEgbG90IG9mIHN0dWZmIGFmdGVyd2FyZHMgaW4gYSBzZXBh
cmF0ZSBjb21taXQuICBJIGRvbid0IA0KbGlrZSB0aGF0IGFwcHJvYWNoIGZvciBzZXZlcmFs
IHJlYXNvbnM6DQotIElmIEkgZG9uJ3QgdGVsbCB5b3UgdGhhdCB0aGVyZSdzIGEgcHJvYmxl
bSwgeW91IGRvbid0IGV2ZW4ga25vdyANCnRoZXJlJ3MgYSBwcm9ibGVtLiAgVGhlIHByb2Js
ZW0gdGhlcmVmb3JlIHdpbGwgcGVyc2lzdC4NCi0gVGhlIGFtb3VudCBvZiB3b3JrIHJlcXVp
cmVkIGZvciB0aGF0IGlzIGluc2FuZSAoanVzdCBzZWFyY2ggdGhlIGdpdCANCmxvZzsgdGhl
cmUgYXJlIGh1bmRyZWRzIG9mIGNvbW1pdHMgZnJvbSBNaWNoYWVsIGJlaW5nIGFwcGxpZWQg
cmlnaHQgDQphZnRlciBhIHBhdGNoIGZpeGluZyB0aGUgZm9ybWF0dGluZykuICBIZSBtaWdo
dCBoYXZlIGJlZW4gd2lsbGluZyB0byBkbyANCml0OyBJJ20gbm90Lg0KLSBUaGVyZSBhcmUg
c29tZSBmaXhlcyB0aGF0IG1pZ2h0IG5vdCBiZSB3b3J0aCBmaXhpbmcgYWZ0ZXIgYXBwbHlp
bmcgYSANCmNvbW1pdCwgc29tZXRpbWVzIGZvciBmZWFyIG9mIGNodXJuLCBzb21ldGltZXMg
Zm9yIGxhemluZXNzLiAgQm90aCANCmF2b2lkaW5nIGNodXJuIGFuZCBsYXppbmVzcyBhcmUg
Z29vZCByZWFzb25zIHRvIGF2b2lkIGRvaW5nIHNvbWV0aGluZywgDQpkb24ndCBnZXQgbWUg
d3JvbmcuICBCdXQgdGhlIHJlc3VsdCBpcyB0aGF0IHRoZSBjb3JwdXMgb2YgdGhlIG1hbnVh
bCANCnBhZ2VzIGlzIHZlcnkgdGhlbiBpbmNvbnNpc3RlbnQuICBJIHByZWZlciBiZWluZyBh
IGJpdF5XXlcgcXVpdGUgbW9yZSANCnBpY2t5LCBzbyB0aGF0IHRoZSBwYWdlcyBoYXZlIGEg
dmVyeSBjb25zaXN0ZW50IGZvcm1hdCwgd2hpY2ggd2lsbCANCnRyaWdnZXIgYmV0dGVyIHBh
dGNoZXMganVzdCBieSBmb2xsb3dpbmcgZXhpc3Rpbmcgc3R5bGUuDQoNCkkgYWNrbm93bGVk
Z2UgdGhlIHByYWN0aWNlIGlzIGEgYml0IGFyYml0cmFyeSwgaW4gdGhhdCB0aGVyZSBhcmUg
c2V2ZXJhbCANCmVxdWFsbHktdmFsaWQgYnJlYWsgcG9pbnRzLCB3aGljaCBtYWtlcyBpdCBh
IGRpZmZpY3VsdCB0YXNrIChpdCdzIGVhc2llciANCndoZW4geW91IGRvbid0IG5lZWQgdG8g
ZGVjaWRlKS4gIEhvd2V2ZXIsIGl0IGhlbHBzIG1lIHNpZ25pZmljYW50bHkgdG8gDQpyZWFk
IHRoZSBwYXRjaGVzIHRoYXQgd2F5IChhbmQgbm90IG9ubHkgc21hbGwgcGF0Y2hlcyB0aGF0
IG1vZGlmeSBzb21lIA0KdGV4dCwgYnV0IGFsc28gdGhlIHBhdGNoIHRoYXQgYWRkcyB0aGUg
d2hvbGUgdGV4dCAtLWJ5IGJlaW5nIG9yZ2FuaXplZCANCndpdGggc29tZSBsb2dpYywgaXQn
cyBlYXNpZXIgZm9yIG1lIHRvIGZvbGxvdyBpdC0tKS4gIFdvcmQgZGlmZnMgbWlnaHQgDQpi
ZSBnb29kIGZvciAodmVyeSkgc21hbGwgcGF0Y2hlcywgYnV0IG5vdCBmb3IgKHJlbGF0aXZl
bHkpIGJpZyBvbmVzLiANCkhvd2V2ZXIsIHVzaW5nIHNlbWFudGljIG5ld2xpbmVzIGlzIGV2
ZW4gYmV0dGVyIHRoYW4gd29yZCBkaWZmcywgSU1PLg0KDQpCVFcsIEkgZG9uJ3QgZmluZCBp
dCBtb3JlIGFyYml0cmFyeSB0aGFuIGJlaW5nIGFibGUgdG8gdXNlICdnb3RvJyB2cyANCidl
bHNlJywgb3Igb3RoZXIgc2ltaWxhcmx5IGNvbnRyb3ZlcnRlZCBkZWNpc2lvbnMgaW4gcHJv
Z3JhbW1pbmcuIA0KTmVpdGhlciAnZ290bycgb3IgJ2Vsc2UnIGlzIF9hbHdheXNfIHRoZSB3
YXkgdG8gZ28gZm9yIGhhbmRsaW5nIHVudXN1YWwgDQpvciBlcnJvciBjYXNlczsgaXQncyB1
cCB0byB0aGUgZ29vZCB0YXN0ZSBvZiB0aGUgcHJvZ3JhbW1lciB0byBrbm93IA0Kd2hpY2gg
dG8gdXNlOyBzb21ldGltZXMgZWl0aGVyIGlzIGZpbmUgcmVhbGx5LiAgVGhlIHNhbWUgaGFw
cGVucyB3aXRoIA0KbGluZSBicmVha3M7IHNvbWV0aW1lcyBvbmUgcG9pbnQgaXMgdW5kb3Vi
dGVkbHkgYmV0dGVyIHRoYW4gb3RoZXJzIHRvIA0KYnJlYWsgYSBsaW5lOyBzb21ldGltZXMs
IHRoZXJlIGFyZSBzZXZlcmFsIGVxdWFsbHktZ29vZCBwb2ludHMsIGFuZCB5b3UgDQpjYW4g
Y2hvb3NlIGFueS4NCg0KQW5kIGFub3RoZXIgQlRXOiB0aGlzIGdvZXMgYmFjayB0byBLZXJu
aWdoYW46DQo8aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2RvY3MvbWFuLXBhZ2Vz
L21hbi1wYWdlcy5naXQvY29tbWl0P2lkPTZmZjZmNDNkNjgxNjRmOTlhOGMzZmI2NmY0NTI1
ZDE0NTU3MTMxMGM+Lg0KTWF5YmUgaGUgY2FuIGNvbnZpbmNlIHlvdSBiZXR0ZXIgdGhhbiBJ
IGRvIHRoYXQgdGhleSdyZSBhIGdyZWF0IHRoaW5nLg0KDQpDaHJpc3RpYW4sIEkgYWRkZWQg
eW91IGluIHRoaXMgbWFpbCBiZWNhdXNlIHdlIGhhZCB0aGlzIGlzc3VlIGEgbG9uZyANCnRp
bWUgYWdvIGFuZCBJIGRpZG4ndCByZWFsbHkgYW5zd2VyIHlvdSBiYWNrIHRoZW4sIElJUkMu
ICBQbGVhc2UgDQpjb25zaWRlciB0aGlzIHJhdGlvbmFsZS4NCg0KUGFyYXBocmFzaW5nIHRo
ZSBMaW51eCBrZXJuZWwgY29kaW5nIHN0eWxlOg0KDQpUaGlzIGlzIHRoZSBwcmVmZXJyZWQg
c3R5bGUgZm9yIHRoZSBsaW51eCBtYW4tcGFnZXMuIFN0eWxlIGlzIHZlcnkgDQpwZXJzb25h
bCwgYW5kIEkgd29u4oCZdCBmb3JjZSBteSB2aWV3cyBvbiBhbnlib2R5LCBidXQgdGhpcyBp
cyB3aGF0IGdvZXMgDQpmb3IgYW55dGhpbmcgdGhhdCBJIGhhdmUgdG8gYmUgYWJsZSB0byBt
YWludGFpbiwgYW5kIEnigJlkIHByZWZlciBpdCBmb3IgDQptb3N0IG90aGVyIHRoaW5ncyB0
b28uIFBsZWFzZSBhdCBsZWFzdCBjb25zaWRlciB0aGUgcG9pbnRzIG1hZGUgaGVyZS4NCg0K
UC5TLiAyOg0KDQpQbGVhc2UgYWRkIG1lIHRvICdUbzonIChvciBDYzogYXQgbGVhc3QpIGZv
ciBtYW4tcGFnZXMgcGF0Y2hlcywgc2luY2UgSSANCm1heSBtaXNzIGl0IG90aGVyd2lzZSAo
ZGVwZW5kaW5nIG9uIHRyYWZmaWMgdG8gdGhlIG1haWxpbmcgbGlzdHMgdGhhdCANCkknbSBz
dWJzY3JpYmVkKS4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCg0KPiAtLS0NCj4gDQo+IHY0OiBm
b3JtYXR0aW5nIHR3ZWFrcywgYXMgc3VnZ2VzdGVkIGJ5IEFsZWphbmRybw0KPiANCj4gdjM6
IHVwZGF0ZWQgbWVudGlvbnMgb2YgTGludXggdmVyc2lvbiwgZml4ZWQgc29tZSBwdW5jdHVh
dGlvbiwgYW5kIGFkZGVkDQo+ICAgICAgYSBSZXZpZXdlZC1ieQ0KPiANCj4gdjI6IHJlYmFz
ZWQgb250byBtYW4tcGFnZXMgbWFzdGVyIGJyYW5jaCwgbWVudGlvbmVkIHhmcywgYW5kIHVw
ZGF0ZWQNCj4gICAgICBsaW5rIHRvIHBhdGNoc2V0DQo+IA0KPiAgIG1hbjIvb3Blbi4yICB8
IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0NCj4gICBtYW4yL3N0YXR4LjIgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tYW4yL29wZW4uMiBiL21hbjIvb3Blbi4yDQo+
IGluZGV4IDU3YmViMzI0YS4uOGU0YTA2M2I0IDEwMDY0NA0KPiAtLS0gYS9tYW4yL29wZW4u
Mg0KPiArKysgYi9tYW4yL29wZW4uMg0KPiBAQCAtMTczMiwyMSArMTczMiw1MSBAQCBvZiB1
c2VyLXNwYWNlIGJ1ZmZlcnMgYW5kIHRoZSBmaWxlIG9mZnNldCBvZiBJL09zLg0KPiAgIElu
IExpbnV4IGFsaWdubWVudA0KPiAgIHJlc3RyaWN0aW9ucyB2YXJ5IGJ5IGZpbGVzeXN0ZW0g
YW5kIGtlcm5lbCB2ZXJzaW9uIGFuZCBtaWdodCBiZQ0KPiAgIGFic2VudCBlbnRpcmVseS4N
Cj4gLUhvd2V2ZXIgdGhlcmUgaXMgY3VycmVudGx5IG5vIGZpbGVzeXN0ZW1cLWluZGVwZW5k
ZW50DQo+IC1pbnRlcmZhY2UgZm9yIGFuIGFwcGxpY2F0aW9uIHRvIGRpc2NvdmVyIHRoZXNl
IHJlc3RyaWN0aW9ucyBmb3IgYSBnaXZlbg0KPiAtZmlsZSBvciBmaWxlc3lzdGVtLg0KPiAt
U29tZSBmaWxlc3lzdGVtcyBwcm92aWRlIHRoZWlyIG93biBpbnRlcmZhY2VzDQo+IC1mb3Ig
ZG9pbmcgc28sIGZvciBleGFtcGxlIHRoZQ0KPiArVGhlIGhhbmRsaW5nIG9mIG1pc2FsaWdu
ZWQNCj4gKy5CIE9fRElSRUNUDQo+ICtJL09zIGFsc28gdmFyaWVzOw0KPiArdGhleSBjYW4g
ZWl0aGVyIGZhaWwgd2l0aA0KPiArLkIgRUlOVkFMDQo+ICtvciBmYWxsIGJhY2sgdG8gYnVm
ZmVyZWQgSS9PLg0KPiArLlBQDQo+ICtTaW5jZSBMaW51eCA2LjEsDQo+ICsuQiBPX0RJUkVD
VA0KPiArc3VwcG9ydCBhbmQgYWxpZ25tZW50IHJlc3RyaWN0aW9ucyBmb3IgYSBmaWxlIGNh
biBiZSBxdWVyaWVkIHVzaW5nDQo+ICsuQlIgc3RhdHggKDIpLA0KPiArdXNpbmcgdGhlDQo+
ICsuQiBTVEFUWF9ESU9BTElHTg0KPiArZmxhZy4NCj4gK1N1cHBvcnQgZm9yDQo+ICsuQiBT
VEFUWF9ESU9BTElHTg0KPiArdmFyaWVzIGJ5IGZpbGVzeXN0ZW07DQo+ICtzZWUNCj4gKy5C
UiBzdGF0eCAoMikuDQo+ICsuUFANCj4gK1NvbWUgZmlsZXN5c3RlbXMgcHJvdmlkZSB0aGVp
ciBvd24gaW50ZXJmYWNlcyBmb3IgcXVlcnlpbmcNCj4gKy5CIE9fRElSRUNUDQo+ICthbGln
bm1lbnQgcmVzdHJpY3Rpb25zLA0KPiArZm9yIGV4YW1wbGUgdGhlDQo+ICAgLkIgWEZTX0lP
Q19ESU9JTkZPDQo+ICAgb3BlcmF0aW9uIGluDQo+ICAgLkJSIHhmc2N0bCAoMykuDQo+ICsu
QiBTVEFUWF9ESU9BTElHTg0KPiArc2hvdWxkIGJlIHVzZWQgaW5zdGVhZCB3aGVuIGl0IGlz
IGF2YWlsYWJsZS4NCj4gICAuUFANCj4gLVVuZGVyIExpbnV4IDIuNCwgdHJhbnNmZXIgc2l6
ZXMsIHRoZSBhbGlnbm1lbnQgb2YgdGhlIHVzZXIgYnVmZmVyLA0KPiAtYW5kIHRoZSBmaWxl
IG9mZnNldCBtdXN0IGFsbCBiZSBtdWx0aXBsZXMgb2YgdGhlIGxvZ2ljYWwgYmxvY2sgc2l6
ZQ0KPiAtb2YgdGhlIGZpbGVzeXN0ZW0uDQo+IC1TaW5jZSBMaW51eCAyLjYuMCwgYWxpZ25t
ZW50IHRvIHRoZSBsb2dpY2FsIGJsb2NrIHNpemUgb2YgdGhlDQo+IC11bmRlcmx5aW5nIHN0
b3JhZ2UgKHR5cGljYWxseSA1MTIgYnl0ZXMpIHN1ZmZpY2VzLg0KPiAtVGhlIGxvZ2ljYWwg
YmxvY2sgc2l6ZSBjYW4gYmUgZGV0ZXJtaW5lZCB1c2luZyB0aGUNCj4gK0lmIG5vbmUgb2Yg
dGhlIGFib3ZlIGlzIGF2YWlsYWJsZSwNCj4gK3RoZW4gZGlyZWN0IEkvTyBzdXBwb3J0IGFu
ZCBhbGlnbm1lbnQgcmVzdHJpY3Rpb25zDQo+ICtjYW4gb25seSBiZSBhc3N1bWVkIGZyb20g
a25vd24gY2hhcmFjdGVyaXN0aWNzIG9mIHRoZSBmaWxlc3lzdGVtLA0KPiArdGhlIGluZGl2
aWR1YWwgZmlsZSwNCj4gK3RoZSB1bmRlcmx5aW5nIHN0b3JhZ2UgZGV2aWNlKHMpLA0KPiAr
YW5kIHRoZSBrZXJuZWwgdmVyc2lvbi4NCj4gK0luIExpbnV4IDIuNCwNCj4gK21vc3QgYmxv
Y2sgZGV2aWNlIGJhc2VkIGZpbGVzeXN0ZW1zIHJlcXVpcmUgdGhhdA0KDQpJIChhY3R1YWxs
eSBJIGZvbGxvd2VkIGFkdmlzZSBmcm9tIHNvbWVvbmUgZWxzZTsgY3JlZGl0ZWQgaW4gdGhl
IGNvbW1pdCkgDQpyZXdvcmRlZCAiYmxvY2sgZGV2aWNlIGJhc2VkIGZpbGVzeXN0ZW1zIiB0
byAiZmlsZXN5c3RlbXMgYmFzZWQgb24gYmxvY2sgDQpkZXZpY2VzIiwgdG8gYXZvaWQgY29t
cGxleCBoeXBoZW5hdGlvbiBydWxlcy4gIElmIG5vdCByZXdvcmRlZCwgaXQgDQpzaG91bGQg
aGF2ZSBiZWVuIHNvbWV0aGluZyBsaWtlICJibG9jay1kZXZpY2VcW2VuXWJhc2VkIGZpbGVz
eXN0ZW1zIi4NCg0KPiArdGhlIGZpbGUgb2Zmc2V0IGFuZCB0aGUgbGVuZ3RoIGFuZCBtZW1v
cnkgYWRkcmVzcyBvZiBhbGwgSS9PIHNlZ21lbnRzDQo+ICtiZSBtdWx0aXBsZXMgb2YgdGhl
IGZpbGVzeXN0ZW0gYmxvY2sgc2l6ZQ0KPiArKHR5cGljYWxseSA0MDk2IGJ5dGVzKS4NCj4g
K0luIExpbnV4IDIuNi4wLA0KPiArdGhpcyB3YXMgcmVsYXhlZCB0byB0aGUgbG9naWNhbCBi
bG9jayBzaXplIG9mIHRoZSBibG9jayBkZXZpY2UNCj4gKyh0eXBpY2FsbHkgNTEyIGJ5dGVz
KS4NCj4gK0EgYmxvY2sgZGV2aWNlJ3MgbG9naWNhbCBibG9jayBzaXplIGNhbiBiZSBkZXRl
cm1pbmVkIHVzaW5nIHRoZQ0KPiAgIC5CUiBpb2N0bCAoMikNCj4gICAuQiBCTEtTU1pHRVQN
Cj4gICBvcGVyYXRpb24gb3IgZnJvbSB0aGUgc2hlbGwgdXNpbmcgdGhlIGNvbW1hbmQ6DQo+
IGRpZmYgLS1naXQgYS9tYW4yL3N0YXR4LjIgYi9tYW4yL3N0YXR4LjINCj4gaW5kZXggMmE4
NWJlN2MwLi44NGMzNWJkZjMgMTAwNjQ0DQo+IC0tLSBhL21hbjIvc3RhdHguMg0KPiArKysg
Yi9tYW4yL3N0YXR4LjINCj4gQEAgLTYxLDcgKzYxLDEyIEBAIHN0cnVjdCBzdGF0eCB7DQo+
ICAgICAgICAgIGNvbnRhaW5pbmcgdGhlIGZpbGVzeXN0ZW0gd2hlcmUgdGhlIGZpbGUgcmVz
aWRlcyAqLw0KPiAgICAgICBfX3UzMiBzdHhfZGV2X21ham9yOyAgIC8qIE1ham9yIElEICov
DQo+ICAgICAgIF9fdTMyIHN0eF9kZXZfbWlub3I7ICAgLyogTWlub3IgSUQgKi8NCj4gKw0K
PiAgICAgICBfX3U2NCBzdHhfbW50X2lkOyAgICAgIC8qIE1vdW50IElEICovDQo+ICsNCj4g
KyAgICAvKiBEaXJlY3QgSS9PIGFsaWdubWVudCByZXN0cmljdGlvbnMgKi8NCj4gKyAgICBf
X3UzMiBzdHhfZGlvX21lbV9hbGlnbjsNCj4gKyAgICBfX3UzMiBzdHhfZGlvX29mZnNldF9h
bGlnbjsNCj4gICB9Ow0KPiAgIC5FRQ0KPiAgIC5pbg0KPiBAQCAtMjQ3LDYgKzI1Miw4IEBA
IFNUQVRYX0JUSU1FCVdhbnQgc3R4X2J0aW1lDQo+ICAgU1RBVFhfQUxMCVRoZSBzYW1lIGFz
IFNUQVRYX0JBU0lDX1NUQVRTIHwgU1RBVFhfQlRJTUUuDQo+ICAgCUl0IGlzIGRlcHJlY2F0
ZWQgYW5kIHNob3VsZCBub3QgYmUgdXNlZC4NCj4gICBTVEFUWF9NTlRfSUQJV2FudCBzdHhf
bW50X2lkIChzaW5jZSBMaW51eCA1LjgpDQo+ICtTVEFUWF9ESU9BTElHTglXYW50IHN0eF9k
aW9fbWVtX2FsaWduIGFuZCBzdHhfZGlvX29mZnNldF9hbGlnbg0KPiArCShzaW5jZSBMaW51
eCA2LjE7IHN1cHBvcnQgdmFyaWVzIGJ5IGZpbGVzeXN0ZW0pDQo+ICAgLlRFDQo+ICAgLmlu
DQo+ICAgLlBQDQo+IEBAIC00MDcsNiArNDE0LDMwIEBAIFRoaXMgaXMgdGhlIHNhbWUgbnVt
YmVyIHJlcG9ydGVkIGJ5DQo+ICAgLkJSIG5hbWVfdG9faGFuZGxlX2F0ICgyKQ0KPiAgIGFu
ZCBjb3JyZXNwb25kcyB0byB0aGUgbnVtYmVyIGluIHRoZSBmaXJzdCBmaWVsZCBpbiBvbmUg
b2YgdGhlIHJlY29yZHMgaW4NCj4gICAuSVIgL3Byb2Mvc2VsZi9tb3VudGluZm8gLg0KPiAr
LlRQDQo+ICsuSSBzdHhfZGlvX21lbV9hbGlnbg0KPiArVGhlIGFsaWdubWVudCAoaW4gYnl0
ZXMpIHJlcXVpcmVkIGZvciB1c2VyIG1lbW9yeSBidWZmZXJzIGZvciBkaXJlY3QgSS9PDQo+
ICsuUkIgKCBPX0RJUkVDVCApDQo+ICtvbiB0aGlzIGZpbGUsDQo+ICtvciAwIGlmIGRpcmVj
dCBJL08gaXMgbm90IHN1cHBvcnRlZCBvbiB0aGlzIGZpbGUuDQo+ICsuSVANCj4gKy5CIFNU
QVRYX0RJT0FMSUdODQo+ICsuUkkgKCBzdHhfZGlvX21lbV9hbGlnbg0KPiArYW5kDQo+ICsu
SVIgc3R4X2Rpb19vZmZzZXRfYWxpZ24gKQ0KPiAraXMgc3VwcG9ydGVkIG9uIGJsb2NrIGRl
dmljZXMgc2luY2UgTGludXggNi4xLg0KPiArVGhlIHN1cHBvcnQgb24gcmVndWxhciBmaWxl
cyB2YXJpZXMgYnkgZmlsZXN5c3RlbTsNCj4gK2l0IGlzIHN1cHBvcnRlZCBieSBleHQ0LCBm
MmZzLCBhbmQgeGZzIHNpbmNlIExpbnV4IDYuMS4NCj4gKy5UUA0KPiArLkkgc3R4X2Rpb19v
ZmZzZXRfYWxpZ24NCj4gK1RoZSBhbGlnbm1lbnQgKGluIGJ5dGVzKSByZXF1aXJlZCBmb3Ig
ZmlsZSBvZmZzZXRzIGFuZCBJL08gc2VnbWVudCBsZW5ndGhzDQo+ICtmb3IgZGlyZWN0IEkv
Tw0KPiArLkJSICIiICggT19ESVJFQ1QgKQ0KDQpzLy5CUiAiIi8uUkIvDQoNCkkgZ3Vlc3Mg
eW91IGRpZG4ndCBzZWUgdGhpcyBvbmU7IGFzIElJUkMgeW91IGZpeGVkIG90aGVyIGlkZW50
aWNhbCBjYXNlcy4NCg0KPiArb24gdGhpcyBmaWxlLA0KPiArb3IgMCBpZiBkaXJlY3QgSS9P
IGlzIG5vdCBzdXBwb3J0ZWQgb24gdGhpcyBmaWxlLg0KPiArVGhpcyB3aWxsIG9ubHkgYmUg
bm9uemVybyBpZg0KPiArLkkgc3R4X2Rpb19tZW1fYWxpZ24NCj4gK2lzIG5vbnplcm8sIGFu
ZCB2aWNlIHZlcnNhLg0KPiAgIC5QUA0KPiAgIEZvciBmdXJ0aGVyIGluZm9ybWF0aW9uIG9u
IHRoZSBhYm92ZSBmaWVsZHMsIHNlZQ0KPiAgIC5CUiBpbm9kZSAoNykuDQo+IA0KPiBiYXNl
LWNvbW1pdDogYWI0NzI3OGYyNTIyNjJkZDliZDkwZjMzODZmZmQ3ZDg3MDBmYTI1YQ0KDQot
LSANCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------FXQEyNGG9pcr0LbtXX0Sw5Sx--

--------------tLEYIH49tlMSOP9PFLdByTme
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNHNr0ACgkQnowa+77/
2zKeKA/9Hb26DvP7JCbVgdtSUSHeo5W42EEqsPRVs7g56PMoV6eeEwFed4Uay7uN
jBFjLFBCiNtqAXljjvhDlJyievrrkliM/3Y2axgOjWdBIt7Y04/M5ZnSbLuOYZre
J0fS9yhMJFCTb/hGBhDmL/qEJYk75kfo2qZW2YyivlLBqEPWCyazKOIsNyAujRfx
e963GpgZq2QwQP3rW0PmkGYkTeC5EndvRC2tRccxh41/1Cjnd9WgyBV5P2K+dDqr
hfHpGEej2LxroTLkkODpXEUHQM0jJgAUJalMZ7UvMZlxylqhn8yi9YvH/8+oRvVZ
Jt+sYpSgcj803xW4peLmsZ8NGgG24hPezd1+CRYmnHjNNDztzWUmZ874CZhbtlK7
itUz6TDdzdnD/XjPxi6XZcL8OgS86d5f+UocV1Ip3ZwzUbrgbfR2mRzjpPTNirkX
+MdCVPR3xCZtbQoULpvfLv9ZT4Q5USlHCMGxMo9kPLdODBeoH+v+0wQrvh7pv8w/
GaU9NE0IMBHrlBRcNvkqPlyHKdGXDvQtfE6ylr8LfU/fqdhtA9qS1UNdZKpAYQ2x
KmkB2xZomWYyRDYtyHTi2eYRH883aLlCQVK77V3ow5tr7qiC1jgBK3MWoJnXNuyV
r9cz8VAOGtXBiOvc6SlwG6R0aJ+BOeM5hf5QBZSXA8JTVICbTsc=
=uBlm
-----END PGP SIGNATURE-----

--------------tLEYIH49tlMSOP9PFLdByTme--
