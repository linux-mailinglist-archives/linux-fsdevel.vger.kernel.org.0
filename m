Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489442211AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGOPuA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 11:50:00 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:33369 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgGOPt7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:49:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 4B6MK15sZ8z8snW;
        Wed, 15 Jul 2020 15:49:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oLC619_nSHwc; Wed, 15 Jul 2020 15:49:57 +0000 (UTC)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4B6MK15CHXz8snK;
        Wed, 15 Jul 2020 15:49:57 +0000 (UTC)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 15 Jul 2020 15:49:57 +0000
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 EXMBDFT10.ad.twosigma.com (172.23.127.159) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Jul 2020 15:49:57 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1497.000; Wed, 15 Jul 2020 15:49:57 +0000
From:   Nicolas Viennot <Nicolas.Viennot@twosigma.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Adrian Reber <areber@redhat.com>
CC:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        "Kamil Yurtsever" <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v5 5/6] prctl: Allow checkpoint/restore capable processes
 to change exe link
Thread-Topic: [PATCH v5 5/6] prctl: Allow checkpoint/restore capable processes
 to change exe link
Thread-Index: AQHWWrd9MS4DKBjnuUS3UVyYGQIobKkIwW2AgAAGAfA=
Date:   Wed, 15 Jul 2020 15:49:57 +0000
Message-ID: <ba55d8b160e541429dc0c823d3240eb3@EXMBDFT11.ad.twosigma.com>
References: <20200715144954.1387760-1-areber@redhat.com>
 <20200715144954.1387760-6-areber@redhat.com>
 <20200715152011.whdeysy3ztqrnocn@wittgenstein>
In-Reply-To: <20200715152011.whdeysy3ztqrnocn@wittgenstein>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.118.104]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBXZWQsIEp1bCAxNSwgMjAyMCBhdCAwNDo0OTo1M1BNICswMjAwLCBBZHJpYW4gUmViZXIg
d3JvdGU6DQo+ID4gRnJvbTogTmljb2xhcyBWaWVubm90IDxOaWNvbGFzLlZpZW5ub3RAdHdvc2ln
bWEuY29tPg0KPiA+IA0KPiA+IEFsbG93IENBUF9DSEVDS1BPSU5UX1JFU1RPUkUgY2FwYWJsZSB1
c2VycyB0byBjaGFuZ2UgL3Byb2Mvc2VsZi9leGUuDQo+ID4gDQo+ID4gVGhpcyBjb21taXQgYWxz
byBjaGFuZ2VzIHRoZSBwZXJtaXNzaW9uIGVycm9yIGNvZGUgZnJvbSAtRUlOVkFMIHRvIA0KPiA+
IC1FUEVSTSBmb3IgY29uc2lzdGVuY3kgd2l0aCB0aGUgcmVzdCBvZiB0aGUgcHJjdGwoKSBzeXNj
YWxsIHdoZW4gDQo+ID4gY2hlY2tpbmcgY2FwYWJpbGl0aWVzLg0KPiBJIGFncmVlIHRoYXQgRUlO
VkFMIHNlZW1zIHdlaXJkIGhlcmUgYnV0IHRoaXMgaXMgYSBwb3RlbnRpYWxseSB1c2VyIHZpc2li
bGUgY2hhbmdlLiBNaWdodCBiZSBuaWNlIHRvIGhhdmUgdGhlIEVJTlZBTC0+RVBFUk0gY2hhbmdl
IGJlIGFuIGFkZGl0aW9uYWwgcGF0Y2ggb24gdG9wIGFmdGVyIHRoaXMgb25lIHNvIHdlIGNhbiBy
ZXZlcnQgaXQgaW4gY2FzZSBpdCBicmVha3Mgc29tZW9uZSAodW5saWtlbHkgdGhvdWdoKS4gSSBj
YW4gc3BsaXQgdGhpcyBvdXQgbXlzZWxmIHRob3VnaCBzbyBubyBuZWVkIHRvIHJlc2VuZCBmb3Ig
dGhhdCBhbG9uZS4NCj4gV2hhdCBJIHdvdWxkIGFsc28gcHJlZmVyIGlzIHRvIGhhdmUgc29tZSBo
aXN0b3J5IGluIHRoZSBjb21taXQgbWVzc2FnZSB0YmguIFRoZSByZWFzb24gaXMgdGhhdCB3aGVu
IHdlIHN0YXJ0ZWQgZGlzY3Vzc2luZyB0aGF0IHNwZWNpZmljIGNoYW5nZSBJIGhhZCB0byBodW50
IGRvd24gdGhlIGhpc3Rvcnkgb2YgY2hhbmdpbmcgL3Byb2Mvc2VsZi9leGUgYW5kIGhhZCB0byBk
aWcgdXAgYW5kIHJlYWQgdGhyb3VnaCBhbmNpZW50IHRocmVhZHMgb24gbG9yZSB0byBjb21lIHVw
IHdpdGggdGhlIGV4cGxhbmF0aW9uIHdoeSB0aGlzIGlzIHBsYWNlZCB1bmRlciBhIGNhcGFiaWxp
dHkuIFRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQgdGhlbiBhbHNvIG1lbnRpb24gdGhhdCB0aGVy
ZSBhcmUgb3RoZXIgd2F5cyB0byBjaGFuZ2UgdGhlIC9wcm9jL3NlbGYvZXhlIGxpbmsgdGhhdCBk
b24ndCByZXF1aXJlIGNhcGFiaWxpdGllcyBhbmQgdGhhdCAvcHJvYy9zZWxmL2V4ZSBpdHNlbGYg
aXMgbm90IHNvbWV0aGluZyB1c2Vyc3BhY2Ugc2hvdWxkIHJlbHkgb24gZm9yIHNlY3VyaXR5LiBN
YWlubHkgc28gdGhhdCBpbiBhIGZldyBtb250aHMveWVhcnMgd2UgY2FuIHJlYWQgdGhyb3VnaCB0
aGF0IGNvbW1pdCBtZXNzYWdlIGFuZCBnbyAiV2VpcmQsIGJ1dCBvay4iLiA6KQ0KPiBCdXQgbWF5
YmUgSSBjYW4ganVzdCByZXdyaXRlIHRoaXMgbXlzZWxmIHNvIHlvdSBkb24ndCBoYXZlIHRvIGdv
IHRocm91Z2ggdGhlIHRyb3VibGUuIFRoaXMgaXMgcmVhbGx5IG5vdCBwZWRhbnRyeSBpdCdzIGp1
c3QgdGhhdCBpdCdzIGEgbG90IG9mIHdvcmsgZGlnZ2luZyB1cCB0aGUgcmVhc29ucyBmb3IgYSBw
aWVjZSBvZiBjb2RlIGV4aXN0aW5nIHdoZW4gaXQncyByZWFsbHkgbm90IG9idmlvdXMuIDopDQoN
CkhlbGxvIENocmlzdGlhbiwNCg0KSSBhZ3JlZS4NClRoYW5rIHlvdSBmb3Igc3VnZ2VzdGluZyBk
b2luZyB0aGUgd29yaywgYnV0IHlvdSd2ZSBkb25lIHBsZW50eSBhbHJlYWR5LiBTbyB3ZSdsbCBj
b21lIGJhY2sgdG8geW91IHdpdGg6DQoxKSBBIHNlcGFyYXRlIGNvbW1pdCBmb3IgRUlOVkFMLT5F
UEVSTQ0KMikgQSBmdWxsIGhpc3Rvcnkgb2YgZGlzY3Vzc2lvbnMgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlIHJlbGF0ZWQgdG8gL3Byb2Mvc2VsZi9leGUgY2FwYWJpbGl0eSBjaGVjaw0KDQpUaGFua3Ms
DQpOaWNvDQo=
