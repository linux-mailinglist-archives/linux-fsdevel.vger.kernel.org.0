Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A0215CC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgGFRNh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 13:13:37 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:45967 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgGFRNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:13:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id 4B0sbh0618z7t8v;
        Mon,  6 Jul 2020 17:13:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qZ-uHme1hea8; Mon,  6 Jul 2020 17:13:35 +0000 (UTC)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 4B0sbg6bfhz3wZ6;
        Mon,  6 Jul 2020 17:13:35 +0000 (UTC)
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 6 Jul 2020 17:13:35 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1497.000; Mon, 6 Jul 2020 17:13:35 +0000
From:   Nicolas Viennot <Nicolas.Viennot@twosigma.com>
To:     Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry Safonov" <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        "Kamil Yurtsever" <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH v4 3/3] prctl: Allow ptrace capable processes to change
 /proc/self/exe
Thread-Topic: [PATCH v4 3/3] prctl: Allow ptrace capable processes to change
 /proc/self/exe
Thread-Index: AQHWT3Pec4M4ip1q2kWWALZu7qCiaaj0zUiAgAAMHwCABfYCYA==
Date:   Mon, 6 Jul 2020 17:13:35 +0000
Message-ID: <a2b4deacfc7541e3adea2f36a6f44262@EXMBDFT11.ad.twosigma.com>
References: <20200701064906.323185-1-areber@redhat.com>
 <20200701064906.323185-4-areber@redhat.com>
 <20200702211647.GB3283@mail.hallyn.com>
 <CAHC9VhQZ=cwiOay6OMMdM1UHm69wDaga9HBkyTbx8-1OU=aBvA@mail.gmail.com>
In-Reply-To: <CAHC9VhQZ=cwiOay6OMMdM1UHm69wDaga9HBkyTbx8-1OU=aBvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.189.128]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+IFRoaXMgaXMgc2NhcnkuICBCdXQgSSBiZWxpZXZlIGl0IGlzIHNhZmUuDQo+ID4NCj4gPiBS
ZXZpZXdlZC1ieTogU2VyZ2UgSGFsbHluIDxzZXJnZUBoYWxseW4uY29tPg0KPiA+DQo+ID4gSSBh
bSBhIGJpdCBjdXJpb3VzIGFib3V0IHRoZSBpbXBsaWNhdGlvbnMgb2YgdGhlIHNlbGludXggcGF0
Y2guDQo+ID4gSUlVQyB5b3UgYXJlIHVzaW5nIHRoZSBwZXJtaXNzaW9uIG9mIHRoZSB0cmFjaW5n
IHByb2Nlc3MgdG8gZXhlY3V0ZQ0KPiA+IHRoZSBmaWxlIHdpdGhvdXQgdHJhbnNpdGlvbiwgc28g
dGhpcyBpcyBhIHdheSB0byB3b3JrIGFyb3VuZCB0aGUNCj4gPiBwb2xpY3kgd2hpY2ggbWlnaHQg
cHJldmVudCB0aGUgdHJhY2VlIGZyb20gZG9pbmcgc28uDQo+ID4gR2l2ZW4gdGhhdCBTRUxpbnV4
IHdhbnRzIHRvIGJlIE1BQywgSSdtIG5vdCAqcXVpdGUqIHN1cmUgdGhhdCdzDQo+ID4gY29uc2lk
ZXJlZCBrb3NoZXIuICBZb3UgYWxzbyBhcmUgc2tpcHBpbmcgdGhlIFBST0NFU1NfX1BUUkFDRSB0
bw0KPiA+IFNFQ0NMQVNTX1BST0NFU1MgY2hlY2sgd2hpY2ggc2VsaW51eF9icHJtX3NldF9jcmVk
cyBkb2VzIGxhdGVyIG9uLg0KPiA+IEFnYWluIEknbSBqdXN0IG5vdCBxdWl0ZSBzdXJlIHdoYXQn
cyBjb25zaWRlcmVkIG5vcm1hbCB0aGVyZSB0aGVzZQ0KPiA+IGRheXMuDQo+ID4NCj4gPiBQYXVs
LCBkbyB5b3UgaGF2ZSBpbnB1dCB0aGVyZT8NCj4NCj4gSSBhZ3JlZSwgdGhlIFNFTGludXggaG9v
ayBsb29rcyB3cm9uZy4gIEJ1aWxkaW5nIG9uIHdoYXQgQ2hyaXN0aWFuIHNhaWQsIHRoaXMgbG9v
a3MgbW9yZSBsaWtlIGEgcHRyYWNlIG9wZXJhdGlvbiB0aGFuIGFuIGV4ZWMgb3BlcmF0aW9uLg0K
DQpTZXJnZSwgUGF1bCwgQ2hyaXN0aWFuLA0KDQpJIG1hZGUgYSBQb0MgdG8gZGVtb25zdHJhdGUg
dGhlIGNoYW5nZSBvZiAvcHJvYy9zZWxmL2V4ZSB3aXRob3V0IENBUF9TWVNfQURNSU4gdXNpbmcg
b25seSBwdHJhY2UgYW5kIGV4ZWN2ZS4NCllvdSBtYXkgZmluZCBpdCBoZXJlOiBodHRwczovL2dp
dGh1Yi5jb20vbnZpZW5ub3QvcnVuX2FzX2V4ZQ0KDQpXaGF0IGRvIHlvdSByZWNvbW1lbmQgdG8g
cmVsYXggdGhlIHNlY3VyaXR5IGNoZWNrcyBpbiB0aGUga2VybmVsIHdoZW4gaXQgY29tZXMgdG8g
Y2hhbmdpbmcgdGhlIGV4ZSBsaW5rPw0KDQogICAgTmljbw0K
