Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105FF1E7E09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 15:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE2NIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 09:08:44 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:60485 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgE2NIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 09:08:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-161-wf7UIPeDN4i-o46VjjC7yA-1; Fri, 29 May 2020 14:08:38 +0100
X-MC-Unique: wf7UIPeDN4i-o46VjjC7yA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 29 May 2020 14:08:37 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 29 May 2020 14:08:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Casey Schaufler' <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        "Ian Kent" <raven@themaw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Subject: RE: clean up kernel_{read,write} & friends v2
Thread-Topic: clean up kernel_{read,write} & friends v2
Thread-Index: AQHWNTXe+VR+bJMIqUC4MAVNRYcECKi/CPyQ
Date:   Fri, 29 May 2020 13:08:37 +0000
Message-ID: <3aea7a1c10e94ea2964fa837ae7d8fe2@AcuMS.aculab.com>
References: <CAHk-=wj3iGQqjpvc+gf6+C29Jo4COj6OQQFzdY0h5qvYKTdCow@mail.gmail.com>
 <20200528054043.621510-1-hch@lst.de>
 <22778.1590697055@warthog.procyon.org.uk>
 <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
In-Reply-To: <f89f0f7f-83b4-72c6-7d08-cb6eaeccd443@schaufler-ca.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQ2FzZXkgU2NoYXVmbGVyDQo+IFNlbnQ6IDI4IE1heSAyMDIwIDIyOjIxDQo+IEl0J3Mg
dHJ1ZSwgbm9ib2R5IHVzZXMgYSBUVFkzMyBhbnltb3JlLiBUaG9zZSBvZiB1cyB3aG8gaGF2ZSBk
b25lIHNvDQo+IHVuZGVyc3RhbmQgaG93ICJ7IiBpcyBwcmVmZXJhYmxlIHRvICJCRUdJTiIgYW5k
IHdoeSB0YWJzIGFyZSBiZXR0ZXIgdGhhbg0KPiBtdWx0aXBsZSBzcGFjZXMuIEEgbmFycm93ICJ0
ZXJtaW5hbCIgcmVxdWlyZXMgbGVzcyBuZWNrIGFuZCBtb3VzZSBtb3ZlbWVudC4NCj4gQW55IHdp
ZHRoIGxpbWl0IGlzIGFyYml0cmFyeSwgc28gdG8gdGhlIGV4dGVudCBhbnlvbmUgbWlnaHQgY2Fy
ZSwgSSBhZHZvY2F0ZQ0KPiA4MCBmb3JldmVyLg0KDQpBIHdpZGUgbW9uaXRvciBpcyBmb3IgbG9v
a2luZyBhdCBsb3RzIG9mIGZpbGVzLg0KTm90IGRlYWQgc3BhY2UgYmVjYXVzZSBvZiBkZWVwIGlu
dGVudHMgYW5kIHZlcnkgbG9uZyB2YXJpYWJsZSBuYW1lcy4NCg0KQWx0aG91Z2ggaSBkb24ndCB1
bmRlcnN0YW5kIHRoZSAnaW5kZW50IGNvbnRpbnVhdGlvbnMgdW5kZXIgIigiJyBydWxlLg0KSXQg
aGlkZXMgc29tZSBpbmRlbnRzIGFuZCBtYWtlcyBvdGhlciBleGNlc3NpdmUuDQpBIHNpbXBsZSAn
ZG91YmxlIGluZGVudCcgKG9yIGhhbGYgaW5kZW50KSBtYWtlcyBjb2RlIG1vcmUgcmVhZGFibGUu
DQoNCkEgZGlmZmVyZW50IHJ1bGUgZm9yIGZ1bmN0aW9uIGRlZmluaXRpb25zIHdvdWxkIG1ha2Ug
cmVhbCBzZW5zZS4NClRoZXkgb25seSBuZWVkIGEgc2luZ2xlIGluZGVudCAtIHRoZSAneycgbWFy
a3MgdGhlIGVuZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

