Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D536A7964
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 05:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfIDDj6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 23:39:58 -0400
Received: from m13-11.163.com ([220.181.13.11]:57098 "EHLO m13-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbfIDDj6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=XfDaL
        fQ/9Xz3JC2Wwn0kvs3GX/v4d6KqTEa6TbrD8rg=; b=EpmuMXQAvIHA10Qs9K3Yo
        KODa1sPrN+EKrEJFRqQ5Z610UhjcEhXjkp4Nx8H9TFXFrPsgXr9k7o72QIsa41V2
        kzRHEttYd4v51Su6jY0lE2kZ0PgjAxFzGUeybWjafWvvoaaRmsPE0A7eigT6F3SE
        78mbXk/INaJWTA3G6W5GjQ=
Received: from yin-jianhong$163.com ( [119.254.120.66] ) by
 ajax-webmail-wmsvr11 (Coremail) ; Wed, 4 Sep 2019 11:24:13 +0800 (CST)
X-Originating-IP: [119.254.120.66]
Date:   Wed, 4 Sep 2019 11:24:13 +0800 (CST)
From:   =?GBK?B?0vy9o7rn?= <yin-jianhong@163.com>
To:     "Eric Sandeen" <sandeen@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsahlber@redhat.com, alexander198961@gmail.com,
        fengxiaoli0714@gmail.com, dchinner@redhat.com
Subject: Re:Re: [PATCH v2] xfsprogs: io/copy_range: cover corner case (fd_in
 == fd_out)
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 163com
In-Reply-To: <c2a1d20c-d6e9-1358-a189-a05a822cb22e@redhat.com>
References: <20190903111903.12231-1-yin-jianhong@163.com>
 <c2a1d20c-d6e9-1358-a189-a05a822cb22e@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <104d5a49.403d.16cfa4d1c09.Coremail.yin-jianhong@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: C8GowABH_tFdLm9dSiGtAA--.45229W
X-CM-SenderInfo: p1lqgyxldqx0lqj6il2tof0z/1tbiMA0mBFWBpYtLjAAAsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CkF0IDIwMTktMDktMDQgMDE6NTQ6MjEsICJFcmljIFNhbmRlZW4iIDxzYW5kZWVuQHJlZGhhdC5j
b20+IHdyb3RlOgo+T24gOS8zLzE5IDY6MTkgQU0sIEppYW5ob25nLllpbiB3cm90ZToKPj4gUmVs
YXRlZCBidWc6Cj4+ICAgY29weV9maWxlX3JhbmdlIHJldHVybiAiSW52YWxpZCBhcmd1bWVudCIg
d2hlbiBjb3B5IGluIHRoZSBzYW1lIGZpbGUKPj4gICBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5v
cmcvc2hvd19idWcuY2dpP2lkPTIwMjkzNQo+Cj50aGF0J3MgYSBDSUZTIGJ1ZyB0aG91Z2gsIG5v
dCByZWxhdGVkIHRvIGhvdyB4ZnNfaW8gb3BlcmF0ZXMsIGNvcnJlY3Q/CgpIaSBFcmljCgp0aGF0
J3MgcmlnaHQsIEkgdGhvdWdodCB0aGF0IHRoZSBjb25kaXRpb24gdG8gcmVwcm9kdWNlIHRoZSBi
dWcgbXVzdCBiZSBmZF9pbiA9PSBmZF9vdXQuCmJ1dCBub3cgSSBrbm93IHRoYXQncyBub3QgY29y
cmVjdC4gIHNyY19maWxlID09IGRzdF9maWxlIGlzIGVub3VnaC4KCgpidXQgdGhlcmUncyBhIGxp
dHRsZSBwcm9ibGVtLCBpZiBleGVjIGZvbGxvdyBjb21tYW5kICwgd2lsbCB0cnVuY2F0ZSBzcmNf
ZmlsZQogICAjIHhmc19pbyAtYyAiY29weV9yYW5nZSB0ZXN0ZmlsZSIgdGVzdGZpbGUKaXQncyBu
b3QgZXhwZWN0ZWQsIHdpbGwgc2VuZCBuZXcgcGF0Y2ggdG8gZml4IGl0LiBpZiB5b3UgYWdyZWUK
CkppYW5ob25nCgo+Cj5XaGF0IGlzIHRoZSBmYWlsaW5nIHhmc19pbyBjYXNlPyAgQmVjYXVzZSB0
aGlzIHNlZW1zIHRvIHdvcmsgZmluZSBoZXJlOgo+Cj4jIGZhbGxvY2F0ZSAtbCAxMjhtIHRlc3Rm
aWxlCj4jIHN0cmFjZSAtZW9wZW4sY29weV9maWxlX3JhbmdlIHhmc19pbyAtYyAiY29weV9yYW5n
ZSAtcyAxbSAtZCA4bSAtbCAybSB0ZXN0ZmlsZSIgdGVzdGZpbGUKPi4uLgo+b3BlbigidGVzdGZp
bGUiLCBPX1JEV1IpICAgICAgICAgICAgICAgID0gMwo+Li4uCj5vcGVuKCJ0ZXN0ZmlsZSIsIE9f
UkRPTkxZKSAgICAgICAgICAgICAgPSA0Cj5jb3B5X2ZpbGVfcmFuZ2UoNCwgWzEwNDg1NzZdLCAz
LCBbODM4ODYwOF0sIDIwOTcxNTIsIDApID0gMjA5NzE1Mgo+KysrIGV4aXRlZCB3aXRoIDAgKysr
Cj4KPnRoaXMgd29ya3MgdG9vOgo+Cj4jIHN0cmFjZSAtZW9wZW4sY29weV9maWxlX3JhbmdlIHhm
c19pbyAtYyAiY29weV9yYW5nZSB0ZXN0ZmlsZSIgdGVzdGZpbGUKPi4uLgo+b3BlbigidGVzdGZp
bGUiLCBPX1JEV1IpICAgICAgICAgICAgICAgID0gMwo+Li4uCj5vcGVuKCJ0ZXN0ZmlsZSIsIE9f
UkRPTkxZKSAgICAgICAgICAgICAgPSA0Cj5jb3B5X2ZpbGVfcmFuZ2UoNCwgWzBdLCAzLCBbMF0s
IDEzNDIxNzcyOCwgMCkgPSAwCj4rKysgZXhpdGVkIHdpdGggMCArKysKPgo+c28gY2FuIHlvdSBo
ZWxwIG1lIHVuZGVyc3RhbmQgd2hhdCBidWcgeW91J3JlIGZpeGluZz8KPgo+LUVyaWMKPgo+PiBp
ZiBhcmd1bWVudCBvZiBvcHRpb24gLWYgaXMgIi0iLCB1c2UgY3VycmVudCBmaWxlLT5mZCBhcyBm
ZF9pbgo+PiAKPj4gVXNhZ2U6Cj4+ICAgeGZzX2lvIC1jICdjb3B5X3JhbmdlIC1mIC0nIHNvbWVf
ZmlsZQo+PiAKPj4gU2lnbmVkLW9mZi1ieTogSmlhbmhvbmcgWWluIDx5aW4tamlhbmhvbmdAMTYz
LmNvbT4KPj4gLS0tCj4+ICBpby9jb3B5X2ZpbGVfcmFuZ2UuYyB8IDI3ICsrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvaW8vY29weV9maWxlX3JhbmdlLmMgYi9pby9j
b3B5X2ZpbGVfcmFuZ2UuYwo+PiBpbmRleCBiN2I5ZmQ4OC4uMmRkZThhMzEgMTAwNjQ0Cj4+IC0t
LSBhL2lvL2NvcHlfZmlsZV9yYW5nZS5jCj4+ICsrKyBiL2lvL2NvcHlfZmlsZV9yYW5nZS5jCj4+
IEBAIC0yOCw2ICsyOCw3IEBAIGNvcHlfcmFuZ2VfaGVscCh2b2lkKQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhdCBwb3NpdGlvbiAwXG5cCj4+ICAgJ2NvcHlfcmFuZ2UgLWYgMicgLSBj
b3BpZXMgYWxsIGJ5dGVzIGZyb20gb3BlbiBmaWxlIDIgaW50byB0aGUgY3VycmVudCBvcGVuIGZp
bGVcblwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgYXQgcG9zaXRpb24gMFxuXAo+PiAr
ICdjb3B5X3JhbmdlIC1mIC0nIC0gY29waWVzIGFsbCBieXRlcyBmcm9tIGN1cnJlbnQgb3BlbiBm
aWxlIGFwcGVuZCB0aGUgY3VycmVudCBvcGVuIGZpbGVcblwKPj4gICIpKTsKPj4gIH0KPj4gIAo+
PiBAQCAtMTE0LDExICsxMTUsMTUgQEAgY29weV9yYW5nZV9mKGludCBhcmdjLCBjaGFyICoqYXJn
dikKPj4gIAkJCX0KPj4gIAkJCWJyZWFrOwo+PiAgCQljYXNlICdmJzoKPj4gLQkJCXNyY19maWxl
X25yID0gYXRvaShhcmd2WzFdKTsKPj4gLQkJCWlmIChzcmNfZmlsZV9uciA8IDAgfHwgc3JjX2Zp
bGVfbnIgPj0gZmlsZWNvdW50KSB7Cj4+IC0JCQkJcHJpbnRmKF8oImZpbGUgdmFsdWUgJWQgaXMg
b3V0IG9mIHJhbmdlICgwLSVkKVxuIiksCj4+IC0JCQkJCXNyY19maWxlX25yLCBmaWxlY291bnQg
LSAxKTsKPj4gLQkJCQlyZXR1cm4gMDsKPj4gKwkJCWlmIChzdHJjbXAoYXJndlsxXSwgIi0iKSA9
PSAwKQo+PiArCQkJCXNyY19maWxlX25yID0gKGZpbGUgLSAmZmlsZXRhYmxlWzBdKSAvIHNpemVv
ZihmaWxlaW9fdCk7Cj4+ICsJCQllbHNlIHsKPj4gKwkJCQlzcmNfZmlsZV9uciA9IGF0b2koYXJn
dlsxXSk7Cj4+ICsJCQkJaWYgKHNyY19maWxlX25yIDwgMCB8fCBzcmNfZmlsZV9uciA+PSBmaWxl
Y291bnQpIHsKPj4gKwkJCQkJcHJpbnRmKF8oImZpbGUgdmFsdWUgJWQgaXMgb3V0IG9mIHJhbmdl
ICgwLSVkKVxuIiksCj4+ICsJCQkJCQlzcmNfZmlsZV9uciwgZmlsZWNvdW50IC0gMSk7Cj4+ICsJ
CQkJCXJldHVybiAwOwo+PiArCQkJCX0KPj4gIAkJCX0KPj4gIAkJCS8qIEV4cGVjdCBubyBzcmNf
cGF0aCBhcmcgKi8KPj4gIAkJCXNyY19wYXRoX2FyZyA9IDA7Cj4+IEBAIC0xNDcsMTAgKzE1Miwx
NCBAQCBjb3B5X3JhbmdlX2YoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQo+PiAgCQl9Cj4+ICAJCWxl
biA9IHN6Owo+PiAgCj4+IC0JCXJldCA9IGNvcHlfZHN0X3RydW5jYXRlKCk7Cj4+IC0JCWlmIChy
ZXQgPCAwKSB7Cj4+IC0JCQlyZXQgPSAxOwo+PiAtCQkJZ290byBvdXQ7Cj4+ICsJCWlmIChmZCAh
PSBmaWxlLT5mZCkgewo+PiArCQkJcmV0ID0gY29weV9kc3RfdHJ1bmNhdGUoKTsKPj4gKwkJCWlm
IChyZXQgPCAwKSB7Cj4+ICsJCQkJcmV0ID0gMTsKPj4gKwkJCQlnb3RvIG91dDsKPj4gKwkJCX0K
Pj4gKwkJfSBlbHNlIHsKPj4gKwkJCWRzdCA9IHN6Owo+PiAgCQl9Cj4+ICAJfQo+PiAgCj4+IAo=

