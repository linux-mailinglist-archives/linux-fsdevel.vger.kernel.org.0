Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BACF505
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfJHI2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 04:28:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:41018 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728104AbfJHI2y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:28:54 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 730C73D0F908E7FA7B9E;
        Tue,  8 Oct 2019 16:28:52 +0800 (CST)
Received: from dggeme764-chm.china.huawei.com (10.3.19.110) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 8 Oct 2019 16:28:52 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme764-chm.china.huawei.com (10.3.19.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 8 Oct 2019 16:28:51 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Tue, 8 Oct 2019 16:28:51 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
CC:     "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "christian@brauner.io" <christian@brauner.io>,
        Mingfangsen <mingfangsen@huawei.com>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] proc:fix confusing macro arg name
Thread-Topic: [PATCH] proc:fix confusing macro arg name
Thread-Index: AdV9sJtGS5V1IJ1hQmaaEj6tyX7o5A==
Date:   Tue, 8 Oct 2019 08:28:51 +0000
Message-ID: <5c66196346aa47d7a252a8c0dd67ae84@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.184.189.20]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQpPbiAyMDE5LzEwLzggMTU6MDUsIEF1YnJleSB3cm90ZToNCj4+IE9uIDIwMTkvMTAvOCAxNDo0
NCwgbGlubWlhb2hlIHdyb3RlOg0KPj4gIHN0YXRlX3NpemUgYW5kIG9wcyBhcmUgaW4gdGhlIHdy
b25nIHBvc2l0aW9uLCBmaXggaXQuDQo+PiANCj4gDQo+IEdvb2QgY2F0Y2ghDQo+IA0KPiBUaGlz
IGlzIGludGVyZXN0aW5nLCBJIHNhdyB0aGlzIGludGVyZmFjZSBoYXMgNTArIGNhbGxlcnMsIEhv
dyBkaWQgdGhleSB3b3JrIGJlZm9yZT8gOykNCj4NCg0KVGhpcyBjb25mdXNlZCBtZSB0b28uIFRo
ZSBhcmdzIG9mIGZ1bmN0aW9uIHByb2NfY3JlYXRlX25ldF9zaW5nbGUgaXMgY29uc2lzdGVudCB3
aXRoDQp0aGUgY2FsbGVycywgc28gaXQgd29ya3MuIEJ1dCB0aGUgd3JvbmcgYXJncyBuYW1lIGlu
IG1hY3JvIHByb2NfY3JlYXRlX25ldCBtYWtlcw0KaXQgY29uZnVzaW5nLg0KDQpUaGFua3MsIGhh
dmUgYSBuaWNlIGRheSENCg0KPiBUaGFua3MsDQo+IC1BdWJyZXkNCj4NCg0K
